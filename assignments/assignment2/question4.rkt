#lang racket
(define (children nodeval t)
  (sort
   (let traverse ([t t])
     (cond
       [(null? t) #f]
       [(and (not (list? (car t))) (eq? nodeval (car t))) (getChildren (cdr t))]
       [(not (list? (car t))) (traverse (cdr t))]
       [else (or (traverse (car t)) (traverse (cdr t)))]))
   >))

(define (getChildren t)
  (let traverse ([t t])
      (cond
        [(null? t) '()]
        [(not (list? (car t))) (cons (car t) (traverse (cdr t)))]
        [else (append (traverse (car t)) (traverse (cdr t)))])))
    

 (define atree '(10
 (2 (4 (9 (3))
 (12 (1 (2)))
 (16)))
 (5 (7)
 (21))
 (6)))
    
  