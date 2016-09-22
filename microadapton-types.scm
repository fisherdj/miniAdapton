(define-record-type adapton
  (adapton-cons thunk result sub super clean?)
  adapton?
  (thunk adapton-thunk)
  (result adapton-result adapton-result-set!)
  (sub adapton-sub adapton-sub-set!)
  (super adapton-super adapton-super-set!)
  (clean? adapton-clean? adapton-clean?-set!))
