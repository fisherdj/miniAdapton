(library (memoization)
  (export memoize lambda-memo define-memo)
  (import (rnrs (6))
          (rnrs mutable-pairs (6))))

(define (make-kv-store) (list '()))
(define (add-kv-store! s k v)
  (set-car! s `((,k . ,v) . ,(car s))))
(define (lookup-kv-store s k)
  (assoc k (car s)))

(define (memoize f)
  (let ((s (make-kv-store)))
    (lambda x
      (let ((k/v (lookup-kv-store s x)))
        (if k/v
            (cdr k/v)
            (let ((result (apply f x)))
              (add-kv-store! s x result)
              result))))))

(define-syntax lambda-memo
  (syntax-rules ()
    ((_ (args ...) body ...)
     (let ((f* (memoize (lambda (args ...) body ...))))
       (lambda (args ...) (f* args ...))))))

(define-syntax define-memo
  (syntax-rules ()
    ((_ (f args ...) body ...)
     (define f (lambda-memo (args ...) body ...)))))
