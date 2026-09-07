# minimal test runner for quest-tool.
#
# run with:
#   janet app/test.janet
# or:
#   ./scripts/check.sh

(import ./main :as app)

(var failures 0)

(defn check
  [name expected actual]
  (if (= expected actual)
    (print "ok   - " name)
    (do
      (print "FAIL - " name " (expected " expected ", got " actual ")")
      (++ failures))))

(check "greeting returns a hello message" "hello, Brian" (app/greeting "Brian"))
(check "the-answer is 42" 42 (app/the-answer))

(print)
(if (> failures 0)
  (do
    (print failures " test(s) failed.")
    (os/exit 1))
  (print "all tests passed."))
