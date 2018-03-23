#lang racket
; Asignment 2 - Question 3
; Francisco Trindade - 7791605

(define (duplicatePair list)
  (let dup ([acc '()]
            [curr (car list)]
            [rest (cdr list)])
    (cond
      [(null? rest) '()]
      [(not (member curr acc)) (cons (cons curr (numDuplicates curr list)) (dup (cons curr acc) (car rest) (cdr rest)))]
      [else (dup (cons curr acc) (car rest) (cdr rest))])))

(define (duplicateList list)
  (let dup ([acc '()]
            [curr (car list)]
            [rest (cdr list)])
    (cond
      [(null? rest) '()]
      [(not (member curr acc)) (cons (cons curr (cons (numDuplicates curr list) '())) (dup (cons curr acc) (car rest) (cdr rest)))]
      [else (dup (cons curr acc) (car rest) (cdr rest))])))

(define (duplicateListSorted list)
  (sort
   (let dup ([acc '()]
             [curr (car list)]
             [rest (cdr list)])
     (cond
       [(null? rest) '()]
       [(not (member curr acc)) (cons (cons curr (cons (numDuplicates curr list) '())) (dup (cons curr acc) (car rest) (cdr rest)))]
       [else (dup (cons curr acc) (car rest) (cdr rest))]))
   (lambda (x y) (> (car (cdr x)) (car (cdr y))))))

; Helper function that finds the nubmer of an element 'el' in the list 'list'
(define (numDuplicates el list)
  (cond
    [(null? list) 0]
    [(equal? (car list) el) (+ 1 (numDuplicates el (cdr list)))]
    [else (+ 0 (numDuplicates el (cdr list)))]))

      
    
