#lang racket
; a)
(define (divideIt x) (if (= x 0) +inf.0 (/ (+ (* 5 x) (* 3 (* x x)) 2) x)))
; b)
(let ((a 2) (b 5)) (* 6 (- 10 b) (+ a (* b (- 4 (* a b))))))
; c)
(+ (* 1 1) (* 2 2) (* 3 3) (* 4 4))

((lambda (x) (* x x)) ) 