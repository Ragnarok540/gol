#lang racket

(struct conway (rows columns grid))

(define (make-conway rows columns)
    (conway rows columns (make-vector (* rows columns) 0)))

;; (conway-rows c)
;; (conway-grid c)
;; (define (assign grid x y width v)
;;    (vector-set! grid (+ x (* width y)) v))

;; run with https://download.racket-lang.org/
