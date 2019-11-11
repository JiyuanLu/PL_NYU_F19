Control.Print.printDepth := 100;
Control.Print.printLength := 100;

(* "Function definition for Q1"; *)
(*
    merge L1 L2 => int list
    L1, L2: sorted lists of integers in ascending order.
    Returns: a sorted list containing the elements in L1 and L2.
*)
fun merge [] L2 = L2
|   merge L1 [] = L1
|   merge (a::b) (c::d) = if a < c then a :: (merge b (c::d)) else
                                    c :: (merge (a::b) d);
(* test cases *)
(*
"Test cases for Q1";
merge [] [];
merge [] [2, 4, 6, 8, 10];
merge [1, 3, 5, 7, 9] [];
merge [1, 3, 5, 7, 9] [2, 4, 6, 8, 10];
merge [1, 7, 10] [2, 8, 11];
*)

(* "Function definition for Q2"; *)
(*
    split L => int list * int list
    L: a list of integers
    Returns: a tuple of two lists, (L1, L2), such that half the elements of
    L are in L1 and half are in L2, in alternating order.
*)
fun split [] = ([], [])
|   split (a::[]) = ([a], [])
|   split (a::b::c) = (a :: (fn (x, y) => x) (split c), b:: (fn (x, y) => y) (split c));
(* test cases *)
(*
"Test cases for Q2";
split [];
split [1];
split [1, 2];
split [1, 4, 2, 6, 8, 3, 9, 5, 4];
*)

(* "Function definition for Q3"; *)
(*
    mergeSort L => int list
    L: a list of integers
    Returns: a sorted list of the elements in L1
*)
fun mergeSort [] = []
|   mergeSort [a] = [a]
|   mergeSort L = merge (mergeSort((fn (x, y) => x) (split L))) (mergeSort((fn (x, y) => y) (split L)));
(* test cases *)
(*
"Test cases for Q3";
mergeSort [];
mergeSort [1];
mergeSort [2, 1];
mergeSort [1, 7, 2, 6, 8, 3, 9, 5, 4];
*)

"Function definition for Q4";
(*
    sort (op <) L => 'a list
    L: a list of elements of any type
    op <: an operator that operates on the element type of L1
    Returns: the sorted list of the elements in L1 using the specified op <
*)

(* test cases *)
(*
"Test cases for Q4";
sort (op <) [];
sort (op <) [1.0];
sort (op <) [3.0, 1.0, 2.0];
*)
