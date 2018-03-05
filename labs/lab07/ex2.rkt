#lang racket
(define (lettergrade x)
  (cond
    [(>= x 90) "A+"]
    [(>= x 85) "A"]
    [(>= x 80) "A-"]
))