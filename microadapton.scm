(library (microadapton)
  (export adapton? make-athunk adapton-add-dcg-edge! adapton-del-dcg-edge!
          adapton-compute adapton-ref adapton-ref-set!)
  (import (rnrs (6))
          (set)
          (include))
  (define-record-type (adapton adapton-cons adapton?)
    (fields thunk
            (mutable result)
            (mutable sub)
            (mutable super)
            (mutable clean?)))
  (include "microadapton-impl.scm"))
