(define-library (microadapton)
  (export adapton? make-athunk adapton-add-dcg-edge! adapton-del-dcg-edge!
          adapton-compute adapton-ref adapton-ref-set!)
  (import (scheme base) (set))
  (include "microadapton-types.scm")
  (include "microadapton-impl.scm"))
