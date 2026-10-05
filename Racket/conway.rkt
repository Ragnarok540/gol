#lang racket

(struct conway (rows columns grid))

(define (make-conway rows columns)
    (conway rows columns (make-vector (* rows columns) 0)))

(define (assign c row column value)
    (vector-set! (conway-grid c) (+ column (* (conway-columns c) row)) value))

(define (print-conway c)
    (for ([i (conway-rows c)])
        (for ([j (conway-columns c)])
            (display (vector-ref (conway-grid c) (+ j (* (conway-columns c) i)))))
        (display "\n")))

(define c (make-conway 10 20))
(assign c 0 3 1)
(assign c 1 4 1)
(assign c 2 2 1)
(assign c 2 3 1)
(assign c 2 4 1)
(print-conway c)

;; run with https://download.racket-lang.org/
