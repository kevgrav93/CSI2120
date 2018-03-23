#lang racket
; CSI2120 Assignment 2 - Assignment 1
; Francisco Trindade - 7791605

(define (degtorad deg)
  (* pi (/ deg 180)))

(define (innerpart x1 x2)
  (expt (sin (/ (- x1 x2) 2)) 2))

(define (distanceGPS lat1 lon1 lat2 lon2)
  (let (
        [latrad1 (degtorad lat1)]
        [lonrad1 (degtorad lon1)]
        [latrad2 (degtorad lat2)]
        [lonrad2 (degtorad lon2)])
    (* 2 6371.0 (asin (sqrt (+ (innerpart latrad1 latrad2) (* (cos latrad1) (cos latrad2) (innerpart lonrad1 lonrad2))))))))