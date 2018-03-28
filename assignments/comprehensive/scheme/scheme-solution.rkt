#lang racket
; Take in file name return sorted pools West -> East
(define (sortedPools filename)
  (sort
   (call-with-input-file filename
     (lambda (input-port)
       (let loop ([line (read-line input-port)])
         (if (not (eof-object? line))
             (let ([splitline (string-split line ",")])
               (cons
                (list (car splitline) (string->number (list-ref splitline 1)) (string->number (list-ref splitline 2)))
                (loop (read-line input-port))))
             '()))))
   (lambda (x y) (< (cadr x) (cadr y)))))

; Makes the tree based on the pool list
(define (makeTree l)
  (let loop ([acc (list (car l))]
             [curr (cadr l)]
             [rest (cddr l)]
             [tree (list (car l))])
    (if (null? rest)
        (appendNode (getClosest curr acc) curr tree)
        (loop (cons curr acc) (car rest) (cdr rest) (appendNode (getClosest curr acc) curr tree)))))

;Append a node to a tree t        
(define (appendNode parent node t)
  (let traverse ([t t])
    (cond
      [(null? t) '()]
      [(and (string? (caar t)) (string=? (caar t) (car parent))) (cons (car t) (append (cdr t) (list (list node))))]
      [(string? (caar t)) (cons (car t) (traverse (cdr t)))]
      [else (cons (traverse (car t)) (traverse (cdr t)))])))
              
; Get the closest pool
(define (getClosest pool poollist)
  (car (sort poollist (lambda (x y) (< (distancePools x pool) (distancePools y pool))))))

; Distance Calculations
(define (degtorad deg)
  (* pi (/ deg 180)))

(define (innerpart x1 x2)
  (expt (sin (/ (- x1 x2) 2)) 2))

(define (distancePools poolA poolB)
  (let (
        [latrad1 (degtorad (cadr poolA))]
        [lonrad1 (degtorad (caddr poolA))]
        [latrad2 (degtorad (cadr poolB))]
        [lonrad2 (degtorad (caddr poolB))])
    (* 2 6371.0 (asin (sqrt (+ (innerpart latrad1 latrad2) (* (cos latrad1) (cos latrad2) (innerpart lonrad1 lonrad2))))))))

;Traverse the tree and spit out the results
(define (traverseTree t)
  (let traverse ([t t])
    (cond
      [(null? t) '()]
      [(string? (caar t)) (cons (car t) (traverse (cdr t)))]
      [else (append (traverse (car t)) (traverse (cdr t)))])))

(define (traversePath l)
  (let traverse ([rest (cdr l)]
                 [curr (car l)]
                 [prev (car l)]
                 [total 0])
    (let ([total (+ total (distancePools curr prev))])
      (if (null? rest)
          (cons (list (car curr) total) '())
          (cons (list (car curr) total) (traverse (cdr rest) (car rest) curr total))))))

(define (findroute file)
  (traversePath (traverseTree (makeTree (sortedPools file)))))

(define (saveroute solution file)
  (let ([outfile (open-output-file file #:exists 'append)])
    (let printrow ([solution solution])
      (unless (null? solution)
        (display (string-join (map ~a (car solution)) " ") outfile)
        (display "\n" outfile)
        (printrow (cdr solution))))))
