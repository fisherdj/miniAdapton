
(define adapton-force
  (let ((currently-adapting #f))
    (lambda (a)
      (let ((prev-adapting
             currently-adapting))
        (set! currently-adapting a)
        (let ((result (adapton-compute a)))
          (set! currently-adapting
                prev-adapting)
          (when currently-adapting
                (adapton-add-dcg-edge!
                 currently-adapting
                 a))
          result)))))

(define-syntax adapt
  (syntax-rules ()
    ((_ expr)
     (make-athunk (lambda () expr)))))

(define (adapton-memoize-l f)
  (memoize (lambda x (adapt (apply f x)))))

(define (adapton-memoize f)
  (let ((f* (adapton-memoize-l f)))
    (lambda x (adapton-force (apply f* x)))))

(define-syntax lambda-amemo-l
  (syntax-rules ()
    ((_ (args ...) body ...)
     (let ((f* (adapton-memoize-l
                (lambda (args ...)
                  body ...))))
       (lambda (args ...) (f* args ...))))))

(define-syntax lambda-amemo
  (syntax-rules ()
    ((_ (args ...) body ...)
     (let ((f* (adapton-memoize
                (lambda (args ...)
                  body ...))))
       (lambda (args ...) (f* args ...))))))

(define-syntax define-amemo-l
  (syntax-rules ()
    ((_ (f args ...) body ...)
     (define f (lambda-amemo-l (args ...)
                 body ...)))))

(define-syntax define-amemo
  (syntax-rules ()
    ((_ (f args ...) body ...)
     (define f (lambda-amemo (args ...)
                 body ...)))))

(define-syntax define-avar
  (syntax-rules ()
    ((_ name expr)
     (define name
             (adapton-ref (adapt expr))))))

(define (avar-get v)
  (adapton-force (adapton-force v)))

(define-syntax avar-set!
  (syntax-rules ()
    ((_ v expr)
     (adapton-ref-set! v (adapt expr)))))
