#lang racket
; Assignment 2 - Question 4
; Francisco Trindade - 7791605
(define (children nodeval t)
  (sort
   (let traverse ([t t])
     (cond
       [(null? t) #f]
       [(and (not (list? (car t))) (eq? nodeval (car t))) (getChildren (cdr t))]
       [(not (list? (car t))) (traverse (cdr t))]
       [else (or (traverse (car t)) (traverse (cdr t)))]))
   >))

; Helper function  that follows the same logic but will return the values
(define (getChildren t)
  (let traverse ([t t])
      (cond
        [(null? t) '()]
        [(list? (car t)) (cons (car (car t)) (traverse (cdr t)))])))
    
; Tree given in question
 (define atree '(10
 (2 (4 (9 (3))
 (12 (1 (2)))
 (16)))
 (5 (7)
 (21))
 (6)))
