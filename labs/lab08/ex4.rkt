#lang racket
(define (get-a l)
  (cond ((empty? l) #f)
        ((list? l) (or (get-a (car l)) (get-a (cdr l))))
        ((equal? l 'a) l)
        (else #f)))