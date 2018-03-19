#lang racket
(define (delete-nth l n i)
  (cond ((null? l) '())
        ((= i n) (delete-nth (cdr l) n 1))
        (else (cons (car l) (delete-nth (cdr l) n (+ i 1))))))
(define (drop l n)
  (delete-nth l n 1))
  