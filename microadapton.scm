(library (microadapton)
  (export adapton? make-athunk adapton-add-dcg-edge! adapton-del-dcg-edge!
          adapton-compute adapton-ref adapton-ref-set!)
  (import (rnrs (6))
          (set)))

(define-record-type (adapton adapton-cons adapton?)
  (fields thunk (mutable result) (mutable sub) (mutable super) (mutable clean?)))

(define (make-athunk thunk)
  (adapton-cons thunk 'empty empty-set empty-set #f))

(define (adapton-add-dcg-edge! a-super a-sub)
  (adapton-sub-set! a-super (set-cons a-sub (adapton-sub a-super)))
  (adapton-super-set! a-sub (set-cons a-super (adapton-super a-sub))))

(define (adapton-del-dcg-edge! a-super a-sub)
  (adapton-sub-set! a-super (set-rem a-sub (adapton-sub a-super)))
  (adapton-super-set! a-sub (set-rem a-super (adapton-super a-sub))))

(define (adapton-compute a)
  (if (adapton-clean? a)
      (adapton-result a)
      (begin
        (set-for-each (lambda (x) (adapton-del-dcg-edge! a x))
                      (adapton-sub a))
        (adapton-clean?-set! a #t)
        (adapton-result-set! a ((adapton-thunk a)))
        (adapton-compute a))))

(define (adapton-dirty! a)
  (when (adapton-clean? a)
        (adapton-clean?-set! a #f)
        (set-for-each adapton-dirty! (adapton-super a))))

(define (adapton-ref val)
  (letrec ((a (adapton-cons
               (lambda () (adapton-result a))
               val
               empty-set
               empty-set
               #t)))
    a))

(define (adapton-ref-set! a val)
  (adapton-result-set! a val)
  (adapton-dirty! a))
