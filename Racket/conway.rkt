#lang racket

(require racket/gui/base)

(struct conway (rows columns grid))

(define (make-conway rows columns)
    (conway rows columns (make-vector (* rows columns) 0)))

(define (assign c row column value)
    (vector-set! (conway-grid c) (+ column (* (conway-columns c) row)) value))

(define (query c row column)
    (define mrow (modulo row (conway-rows c)))
    (define mcol (modulo column (conway-columns c)))
    (vector-ref (conway-grid c) (+ mcol (* (conway-columns c) mrow))))

(define (print-conway c)
    (for ([i (conway-rows c)])
        (for ([j (conway-columns c)])
            (display (vector-ref (conway-grid c) (+ j (* (conway-columns c) i)))))
        (display "\n")))

(define (count-neighbors c row column)
    (define n  (query c (+ row 1)    column   ))
    (define ne (query c (+ row 1) (+ column 1)))
    (define e  (query c    row    (+ column 1)))
    (define se (query c (- row 1) (+ column 1)))
    (define s  (query c (- row 1)    column   ))
    (define sw (query c (- row 1) (- column 1)))
    (define w  (query c    row    (- column 1)))
    (define nw (query c (+ row 1) (- column 1)))
    (apply + (list n ne e se s sw w nw)))

(define (game-logic state neighbors)
    (if (= state 1)
        (if (or (< neighbors 2) (> neighbors 3)) 0 state)
        (if (= neighbors 3) 1 state)))

(define (step-cell c row column)
    (define state (query c row column))
    (define neighbors (count-neighbors c row column))
    (game-logic state neighbors))

(define (simulate c)
    (define new-c (make-conway (conway-rows c) (conway-columns c)))
    (for ([i (conway-rows c)])
        (for ([j (conway-columns c)])
            (define next-state (step-cell c i j))
            (assign new-c i j next-state)))
    new-c)

(define (run-simulation c)
    (print-conway c)
    (sleep/yield 0.5)
    ;; clear screen
    (define new-c (simulate c))
    (run-simulation new-c))

(define c (make-conway 10 20))
(assign c 0 3 1)
(assign c 1 4 1)
(assign c 2 2 1)
(assign c 2 3 1)
(assign c 2 4 1)

(run-simulation c)

;; run with https://download.racket-lang.org/
