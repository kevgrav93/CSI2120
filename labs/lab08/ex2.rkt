#lang racket
(define (range i k)
  (if (< i k)
      (cons i (range (+ i 1) k))
      (cons k '())))