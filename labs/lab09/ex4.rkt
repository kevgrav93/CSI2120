#lang racket
; Calculating 2^5
(let ([a 5] [b 2])
  (let pow ([k a] [p b])
    (if (= k 1)
        p
        (pow (- k 1) (* b p)))))
