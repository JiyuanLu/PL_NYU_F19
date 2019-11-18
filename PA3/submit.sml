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
|   merge (a::b) (c::d) = if a < c then a :: (merge b (c::d)) else c :: (merge (a::b) d)

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
|   split (a::b::c) = (a :: (fn (x, y) => x) (split c), b:: (fn (x, y) => y) (split c))

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
|   mergeSort L = merge (mergeSort((fn (x, y) => x)(split L))) (mergeSort((fn (x, y) => y)(split L)))

(*
"Test cases for Q3";
mergeSort [];
mergeSort [1];
mergeSort [2, 1];
mergeSort [1, 7, 2, 6, 8, 3, 9, 5, 4];
*)

(* "Function definition for Q4" *)
(*
    sort (op <) L => 'a list
    L: a list of elements of any type
    op <: an operator that operates on the element type of L1
    Returns: the sorted list of the elements in L1 using the specified op <
*)
fun sort (op <) [] = []
|   sort (op <) [a] = [a]
|   sort (op <) L = 
        let fun merge [] L2 = L2
        |       merge L1 [] = L1
        |       merge (a::b) (c::d) = if a < c then a::(merge b (c::d)) else c::(merge(a::b) d)
        
            fun split [] = ([], [])
        |       split (a::[]) = ([a], [])
        |       split (a::b::c) = (a::(fn(x, y) => x)(split c), b::(fn(x, y) => y)(split c))
        in merge (sort (op <) ((fn(x, y) => x)(split L))) (sort (op <) ((fn(x, y) => y)(split L)))
        end

(*
"Test cases for Q4";
sort (op <) [];
sort (op <) [1.0];
sort (op <) [1, 9, 3, 6, 7];
sort (fn(a, b) => length a < length b) [[], []];
sort (fn(a, b) => length a < length b) [[1, 9, 3, 6], [1], [2, 4, 6], [5, 5]];
*)

(* "Datatype definition for Q5"; *)
(*
    datatype 'a tree
    An element of 'a tree can be one of the following:
        - An empty tree.
        - A leaf that is labeled with an value of type 'a.
        - An interior node tha is labeled with an 'a and has two children, each of type 'a tree.
*)

datatype 'a tree = empty | leaf of 'a | node of 'a * 'a tree * 'a tree

(*
"Test cases for Q5";
val tree1 = node (5, node (4, leaf 3, empty),
                     node (8, node (7, leaf 6, empty),
                              node (9, empty, leaf 10)));
*)      
    
(* "Function definition for Q6"; *)
(*
    labels T => 'a list
    T: an 'a tree.
    Returns: a list of labels associated with the leaves and interior nodes of T 
             determined by in-order tree traversal.
 *)
fun labels empty = []
|   labels (leaf n) = [n]   
|   labels (node(v, l, r)) = (labels l) @ [v] @ (labels r)

(*
"Test cases for Q6";
val tree1 = node (5, node (4, leaf 3, empty),
                     node (8, node (7, leaf 6, empty),
                              node (9, empty, leaf 10)));
labels tree1;
*)

(* "Function definition for Q7"; *)
(*
    replace (op ==) x y T => 'a tree
    T: an 'a tree.
    x, y: values of type 'a.
    Returns: a tree identical to T except anywhere a label equal to x 
             appears in T, the label y appears instead.
 *)
 infix ==
 fun replace (op ==) x y empty = empty
 |   replace (op ==) x y (leaf n) = if n == x then (leaf y) else (leaf n)
 |   replace (op ==) x y (node(v, l, r)) = if v == x then (node(y, replace (op ==) x y l, replace (op ==) x y r)) 
                                                    else (node(v, replace (op ==) x y l, replace (op ==) x y r))
(*
"Test cases for Q7";
val tree1 = node (5, node (4, leaf 3, empty),
                     node (8, node (7, leaf 6, empty),
                              node (9, empty, leaf 10)));
                              
val tree2 = replace (op =) 4 40 tree1;
labels tree2;

val tree3 = replace (op <>) 7 0 tree1;
labels tree3;    
*)

(* "Function definition for Q8"; *)
(*
    replaceEmpty y T => 'a tree
    T: an 'a tree.
    y: an 'a tree.
    Returns: a tree identical to T except that each empty subtree in T has been
             replaced with y.
*)
fun replaceEmpty y empty = y
|   replaceEmpty y (leaf n) = (leaf n)
|   replaceEmpty y (node(v, l, r)) = node(v, replaceEmpty y l, replaceEmpty y r)

(*
"Test cases for Q8";
val tree1 = node (5, node (4, leaf 3, empty),
                     node (8, node (7, leaf 6, empty),
                              node (9, empty, leaf 10)));
                              
val tree4 = replaceEmpty (node (12, leaf 11, leaf 13)) tree1;
labels tree4;
*)

(* "Function definition for Q9"; *)
(*
    mapTree f T => 'a tree
    T: an 'a tree.
    f: a function.
    Returns: a tree resulting from applying f to every node, leaf, and empty in T.
*)
(*
fun increment empty = leaf 0
|   increment (leaf a) = leaf (a+1)
|   increment (node (a, L, R)) = node (a+1, L, R)
*)
fun mapTree f empty = f empty
|   mapTree f (leaf a) = f (leaf a)
|   mapTree f (node (a, L, R)) = f (node (a, mapTree f L, mapTree f R))
        
(*
"Test cases for Q9";
val tree1 = node (5, node (4, leaf 3, empty),
                     node (8, node (7, leaf 6, empty),
                              node (9, empty, leaf 10)));
                              
val tree5 = mapTree increment tree1;
labels tree5;
*)

(* "Function definition for Q10"; *)
(*
    sortTree (op <) T => 'a list tree
    T: an 'a list tree.
    (op <): an infix operator for comparison.
    Returns: an 'a tree that is identical to T, except that each label is sorted.
    Note: each label is a list of elements of type 'a.
*)
(* A recursive solution using only the sort function *)
(*
fun sortTree (op <) empty = empty
|   sortTree (op <) (leaf n) = leaf (sort (op <) n)
|   sortTree (op <) (node (a, L, R)) = node (sort (op <) a, sortTree (op <) L, sortTree (op <) R);
*)
(* Using both the sort function and the mapTree function *)
(* sort: list -> sorted list, but mapTree requires f to be node -> sorted node *)
fun sortTree (op <) T = 
    mapTree (fn empty => empty 
             |  (leaf n) => leaf (sort (op <) n)
             |  (node (a, L, R)) => node (sort (op <) a, L, R)) T

(*
"Test cases for Q10";
val tree6 = node ([1, 5, 6, 8], leaf [1, 2, 3, 4], node ([12, 4, 16, 13], empty, leaf [0, 2, 5, 7]));
labels tree6;

val tree7 = sortTree (op <) tree6;
labels tree7;
*)   