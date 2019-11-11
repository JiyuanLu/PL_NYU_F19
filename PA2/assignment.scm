;;; Problem 1: (count-numbers L)
;;; L: a list
;;; Base Case: L is empty, return 0
;;; Assumption: (count-numbers M) returns a count of the numbers in M, for
;;;             any list M smaller than L (including (car L) and (cdr L)).
;;; Step: If (car L) is a list, then return the sum of the count of the
;;;       numbers in (car L) and the count of the numbers in (cdr L).
;;;       if (car L) is a number, return 1 plus the count ofthe numbers in
;;;       (cdr L). Otherwise, return the count of the numbers in (cdr L).
(define (count-numbers L)
  (cond ((null? L) 0)
        ((list? (car L)) (+ (count-numbers (car L)) (count-numbers (cdr L))))
        ((number? (car L)) (+ 1 (count-numbers (cdr L))))
        (else (count-numbers (cdr L)))))
;;; Test Case:
;;; (count-numbers '(11 (22 (a 33 44) 55) (6 (b 7 8 (9 c) 100 d))))
;;; (count-numbers '())


;;; Problem 2: (insert x L)
;;; x: a number
;;; L: a sorted list of numbers in increasing order
;;; Base Case: L is empty, return a list containing only one element x, or
;;;            x < (car L), prepend x to L
;;; Assumption: (insert x M) returns a new sorted list containing x and all the
;;;             elements in M, for any list M smaller than L, (including (cdr L)).
;;; Step: If x < (car L), prepend x to L.
;;;       Otherwise, prepend (car L) to the result of the recursive call
;;;       (insert x (cdr L)).
(define (insert x L)
  (cond ((null? L) (cons x '()))
        ((< x (car L)) (cons x L))
        (else (cons (car L) (insert x (cdr L))))))
;;; Test Case:
;;; (insert 5 '(1 2 3 4 6 7 8))
;;; (insert 5 '())
;;; (insert 5 '(3 4 4 5 5 5 5 6 8))

;;; Problem 3: (insert-all L M)
;;; L: a list of numbers
;;; M: a sorted list of numbers
;;; Base Case: L is empty, return M
;;; Assumption: (insert-all A M) returns a sorted list containing all the elements
;;;              of A and all the elements of M, for any list A smaller than L,
;;;             (including (cdr L)).
;;; Step: Insert (car L) into M and get a new sorted list N. Then recursively call
;;;       (insert-all (cdr L) N).
(define (insert-all L M)
  (cond ((null? L) M)
  (else (insert-all (cdr L) (insert (car L) M)))))
;;; Test Case:
;;; (insert-all '(2 4) '(1 3 5))
;;; (insert-all '(3 6 1 5 2 7 4) '())

;;; Problem 4: (sort L)
;;; L: an unsorted list of numbers
;;; Base Case: L is empty, return the empty list, i.e., '()
;;; Assumption: (sort M) sorts M correctly, for any list M smaller than L,
;;;             (including (cdr L)).
;;; Step: Sorts (cdr L) recursively, then insert (car L) into the right place.
;;; Note: We can define a nested procedure (insert x L) that inserts a number x into
;;;       the sorted list L.
;;; An implementation using (insert x L) defined above:
;;;(define (sort L)
;;;  (cond ((null? L) '())
;;;        (else (insert (car L) (sort (cdr L))))))
;;;
(define (sort L)
  (cond ((null? L) '())
        (else (letrec ((insert (lambda (x M)
                  (cond ((null? M) (cons x '()))
                        ((< x (car M)) (cons x M))
                        (else (cons (car M) (insert x (cdr M))))))))
                (insert (car L) (sort (cdr L)))))))
;;; Test Case:
;;;(sort '(3 6 1 5 2 7 4))
;;;(sort '())

;;; Problem 5: (translate op)
(define (translate op)
  (cond ((eq? op '+) +)
        ((eq? op '-) -)
        ((eq? op '*) *)
        ((eq? op '/) /)))
;;; Test Case:
;;; (translate '-)
;;; ((translate '*) 3 4)

;;; Problem 6: (postfix-eval exp)
;;; Base Case: exp is a number or an operator, return exp, or
;;;            exp is an operator, return (translate exp)
;;; Assumption: (postfix-eval e) returns the result of evaluating e, for any e
;;;             smaller than exp, including (car exp), (cadr exp) and (caddr exp)
;;; Step: exp is a list of the form (arg1 arg2 op), return
;;;      ((postfix-eval op) (postfix-eval arg1) (postfix-eval arg2))
(define (postfix-eval exp)
  (cond ((list? exp) ((postfix-eval (caddr exp)) (postfix-eval (car exp)) (postfix-eval (cadr exp))))
        ((number? exp) exp)
        (else (translate exp))))
;;; Test Case:
;;;(postfix-eval '((16 12 *) ((2 6 +) (9 1 -) *) /))
;;;(postfix-eval 4)

;;; Problem 7: (powerset L)
;;; Base Case: L is empty, return the set containing the empty set, i.e., '(()).
;;; Assumption: (powerset M) returns the powerset of M, for any set M smaller than L,
;;;             (including (cdr L)).
;;; Step: (powerset L) can be obtained from (powerset (cdr L)) by appending a list A
;;;       to (powerset (cdr L)), where A is obtained by prepending (car L) to each of
;;;       the nested list in (powerset (cdr L))
(define (powerset L)
  (cond ((null? L) '(()))
        (else (append (powerset (cdr L)) (map (lambda (elt) (cons (car L) elt)) (powerset(cdr L)))))))
;;; Test Case:
;;;(powerset '())
;;;(powerset '(1 2 3))
;;;(powerset '(1 2 3 4))