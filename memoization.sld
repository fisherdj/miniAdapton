(define-library (memoization)
  (export memoize lambda-memo define-memo)
  (import (scheme base))
  (include "memoization-impl.scm"))
