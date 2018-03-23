#lang racket
; Assignment 2 - Question 2
; Francisco Trindade - 7791605

(define (absDiffA listA listB)
  (cond
    [(and (not (null? listA)) (not (null? listB))) (cons (abs (- (car listA) (car listB))) (absDiffA (cdr listA) (cdr listB)))]
    [(and (null? listA) (not (null? listB))) (cons (car listB) (absDiffA listA (cdr listB)))]
    [(and (not (null? listA)) (null? listB)) (cons (car listA) (absDiffA (cdr listA) listB))]
    [else '()]))

(define (absDiffB listA listB)
  (cond
    [(and (not (null? listA)) (not (null? listB))) (cons (abs (- (car listA) (car listB))) (absDiffB (cdr listA) (cdr listB)))]
    [else '()]))