(library (set)
  (export empty-set set-mem set-cons set-rem
          set-union set-intersect set-diff
          set-for-each set->list)
  (import (rnrs (6))))

(define empty-set '())
(define (set-mem e s)
  (memv e s))
(define (set-cons e s)
  (if (set-mem e s) s (cons e s)))
(define (set-rem e s)
  (filter (lambda (x) (not (eqv? e x))) s))
(define (set-union s1 s2)
  (fold-left set-cons s2 s1))
(define (set-intersect s1 s2)
  (fold-left set-rem s2 s1))
(define set-for-each for-each)
(define set->list (lambda (x) x))
