(define-library (set)
  (export empty-set set-mem set-cons set-rem
          set-union set-intersect
          set-for-each set->list)
  (import (scheme base)
          (rename (srfi 1) (fold fold-left)))
  (include "set-impl.scm"))
