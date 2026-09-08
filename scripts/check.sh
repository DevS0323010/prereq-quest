#!/usr/bin/env bash
# Prerequisite Quest - local checker.
#
# Runs every check that doesn't require an external SSH server. Safe to
# run repeatedly; makes no changes to your repository.
#
# Usage:
#   ./scripts/check.sh

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

FAILURES=0
WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/quest-check.XXXXXX" 2>/dev/null || echo "${TMPDIR:-/tmp}")"
JANET_LOG="$WORK_DIR/quest-janet-test.log"
DOCKER_BUILD_LOG="$WORK_DIR/quest-docker-build.log"
DOCKER_RUN_LOG="$WORK_DIR/quest-docker-run.log"

ok()   { printf '[ok]   %s\n' "$1"; }
fail() { printf '[fail] %s\n' "$1"; FAILURES=$((FAILURES + 1)); }
skip() { printf '[skip] %s\n' "$1"; }
info() { printf '[info] %s\n' "$1"; }

# Extract the value following a "Label:" line in a markdown answers file.
# Accepts the value on the same line ("Label: foo") or on the next
# non-blank line, and stops at the next heading or "Label:" line.
# Surrounding backticks and emphasis markers are stripped: wrapping a
# path in `backticks` is a markdown habit, not a wrong answer.
extract_field() {
  local file="$1" label="$2"
  awk -v label="$label" '
    function clean(s) {
      gsub(/^[ \t]+/, "", s)
      gsub(/[ \t]+$/, "", s)
      gsub(/^[`*_]+/, "", s)
      gsub(/[`*_]+$/, "", s)
      gsub(/^[ \t]+/, "", s)
      gsub(/[ \t]+$/, "", s)
      return s
    }
    BEGIN { found = 0 }
    {
      line = $0
      gsub(/\r$/, "", line)
      if (found == 0) {
        if (index(line, label) == 1) {
          rest = clean(substr(line, length(label) + 1))
          if (rest != "") { print rest; exit }
          found = 1
          next
        }
      } else {
        trimmed = clean(line)
        if (trimmed == "") next
        if (trimmed ~ /^#/) exit
        if (trimmed ~ /:$/) exit
        print trimmed
        exit
      }
    }
  ' "$file"
}

# Print the body text of a "## Heading" section (up to the next "## "
# heading or end of file), excluding the heading line itself.
extract_section() {
  local file="$1" heading="$2"
  awk -v heading="$heading" '
    index($0, heading) == 1 { flag = 1; next }
    /^## / { flag = 0 }
    flag { print }
  ' "$file"
}

# Length of a section's content with whitespace, "...", and "-" stripped -
# a cheap way to tell "answered" apart from "still just the placeholder".
meaningful_length() {
  printf '%s' "$1" | tr -d '[:space:].-' | wc -c | tr -d ' '
}

find_answers_file() {
  ls answers/*.md 2>/dev/null \
    | grep -v -E '/(README|TEMPLATE)\.md$' \
    | sort \
    | head -n1
}

echo "Prerequisite Quest Checks"
echo

# --- Mission 0: profile -----------------------------------------------
ANSWERS_FILE="$(find_answers_file)"
if [ -z "$ANSWERS_FILE" ]; then
  fail "profile: no answers/<github-username>.md file found (see answers/README.md)"
else
  missing=""
  for heading in "## Environment" "## Things I have done before" \
                 "## Mission 01" "## Mission 04" "## Mission 05" "## Mission 06"; do
    grep -q "^$heading" "$ANSWERS_FILE" || missing="$missing; missing '$heading'"
  done

  OS_VAL="$(extract_field "$ANSWERS_FILE" "OS:")"
  SHELL_VAL="$(extract_field "$ANSWERS_FILE" "Shell:")"
  BUILT_LEN="$(meaningful_length "$(extract_section "$ANSWERS_FILE" "## Something I built")")"
  UNDERSTAND_LEN="$(meaningful_length "$(extract_section "$ANSWERS_FILE" "## Something I want to understand better")")"

  if [ -n "$missing" ]; then
    fail "profile: $ANSWERS_FILE${missing}"
  elif [ -z "$OS_VAL" ] || [ -z "$SHELL_VAL" ]; then
    fail "profile: $ANSWERS_FILE is missing Environment details (OS / Shell)"
  elif [ "$BUILT_LEN" -lt 5 ] || [ "$UNDERSTAND_LEN" -lt 5 ]; then
    fail "profile: $ANSWERS_FILE has unfilled free-response sections"
  else
    ok "profile ($ANSWERS_FILE)"
  fi
fi

# --- Mission 01: Linux --------------------------------------------------
if [ -z "$ANSWERS_FILE" ]; then
  skip "linux mission: no answers file to check yet"
else
  ACTUAL_PATH="$(grep -rlw "THE_PENGUIN_WAS_HERE" missions/01-linux/files 2>/dev/null | head -n1)"
  ACTUAL_COUNT="$(grep -c "ERROR" missions/01-linux/server.log 2>/dev/null || echo 0)"

  STUDENT_PATH="$(extract_field "$ANSWERS_FILE" "Path:")"
  STUDENT_COUNT="$(extract_field "$ANSWERS_FILE" "Count:")"
  STUDENT_COUNT_DIGITS="$(printf '%s' "$STUDENT_COUNT" | grep -o '[0-9]\+' | head -n1)"

  # A leading "./" is the same path; accept it rather than failing on style.
  STUDENT_PATH="${STUDENT_PATH#./}"

  path_ok=0
  if [ -n "$STUDENT_PATH" ] && [ -f "$STUDENT_PATH" ] && grep -qw "THE_PENGUIN_WAS_HERE" "$STUDENT_PATH"; then
    path_ok=1
  fi

  count_ok=0
  if [ -n "$STUDENT_COUNT_DIGITS" ] && [ "$STUDENT_COUNT_DIGITS" = "$ACTUAL_COUNT" ]; then
    count_ok=1
  fi

  if [ "$path_ok" -eq 1 ] && [ "$count_ok" -eq 1 ]; then
    ok "linux mission"
  else
    detail=""
    [ "$path_ok" -eq 0 ] && detail="$detail Task A path is wrong or missing (give it relative to the repository root, e.g. missions/01-linux/files/..., not an absolute path)."
    [ "$count_ok" -eq 0 ] && detail="$detail Task B count is wrong or missing (expected a number)."
    fail "linux mission:$detail"
  fi
fi

# --- Mission 05: Janet tests --------------------------------------------
if command -v janet >/dev/null 2>&1; then
  if janet app/test.janet >"$JANET_LOG" 2>&1; then
    ok "janet tests"
  else
    fail "janet tests (run 'janet app/test.janet' to see why)"
  fi
else
  skip "janet tests: janet is not installed (see scripts/doctor.sh, or rely on CI)"
fi

# --- Mission 04: Docker ---------------------------------------------------
if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
  IMAGE_TAG="prereq-quest-check:local"
  if docker build -q -t "$IMAGE_TAG" . >"$DOCKER_BUILD_LOG" 2>&1; then
    OUTPUT="$(docker run --rm "$IMAGE_TAG" 2>"$DOCKER_RUN_LOG")"
    EXPECTED="hello, world
42"
    if [ "$OUTPUT" = "$EXPECTED" ]; then
      ok "docker output"
    else
      fail "docker output (got: $(printf '%s' "$OUTPUT" | tr '\n' '|'))"
    fi
  else
    fail "docker build failed (see $DOCKER_BUILD_LOG)"
  fi
else
  skip "docker: docker is not available locally (see scripts/doctor.sh, or rely on CI)"
fi

# --- Mission 03: SSH -------------------------------------------------------
SSH_HOST="$(grep '^QUEST_SSH_HOST=' missions/03-ssh/server.env 2>/dev/null | cut -d= -f2-)"
if [ -z "$SSH_HOST" ]; then
  skip "ssh: no course server configured (fallback mode, self-reported)"
else
  skip "ssh: verifying a live session isn't automated by this repository (self-reported)"
fi

# --- Mission 02: Git conflict resolution -----------------------------------
LOG_FILE="missions/02-git/quest-log.md"
if [ -f "$LOG_FILE" ]; then
  if grep -q '^<<<<<<<\|^=======\r\{0,1\}$\|^>>>>>>>' "$LOG_FILE"; then
    fail "git conflict resolution: leftover conflict markers in $LOG_FILE"
  elif grep -q "torch-bearer: left a spare torch by the door" "$LOG_FILE" \
       && ! grep -q "add your entry here" "$LOG_FILE"; then
    ok "git conflict resolution"
  else
    fail "git conflict resolution: merge upstream/challenge-conflict and resolve $LOG_FILE"
  fi
else
  fail "git conflict resolution: $LOG_FILE is missing"
fi

# --- Mission 06: Improve something -----------------------------------------
if [ -z "$ANSWERS_FILE" ]; then
  skip "improve mission: no answers file to check yet"
else
  MISSION06_FILE="$WORK_DIR/mission06-section.md"
  extract_section "$ANSWERS_FILE" "## Mission 06" > "$MISSION06_FILE"
  CHANGED_VAL="$(extract_field "$MISSION06_FILE" "What I changed:")"
  WHY_VAL="$(extract_field "$MISSION06_FILE" "Why:")"
  CHANGED_LEN="$(meaningful_length "$CHANGED_VAL")"
  WHY_LEN="$(meaningful_length "$WHY_VAL")"
  if [ "$CHANGED_LEN" -ge 10 ] && [ "$WHY_LEN" -ge 10 ]; then
    ok "improve mission"
  else
    fail "improve mission: explain what you changed and why in $ANSWERS_FILE"
  fi
fi

# --- Informational: commit count -------------------------------------------
# Counts commits you authored, by excluding the scaffold's authors. Forks
# don't reliably carry tags, and the scaffold commits (plus the one the
# challenge-conflict merge brings in) would otherwise inflate the count.
SCAFFOLD_AUTHORS="iceice666@outlook.com syankuan@gmail.com"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  COMMITS="$(git log --format='%ae' 2>/dev/null \
    | grep -v -x -F "$(printf '%s\n' $SCAFFOLD_AUTHORS)" \
    | wc -l | tr -d ' ')"
  info "your commits: $COMMITS (aim for several small commits, not one giant one)"
fi

echo
if [ "$FAILURES" -eq 0 ]; then
  echo "All automated checks pass."
  exit 0
else
  echo "$FAILURES check(s) still failing."
  exit 1
fi
