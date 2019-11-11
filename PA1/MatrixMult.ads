package MatrixMult is    
    SIZE: constant integer := 10;
    subtype matrix_index is integer range 1 .. SIZE;
    type Matrix is array (matrix_index, matrix_index) of integer;
    procedure NaiveMatmult(A, B: in Matrix; C: out Matrix);
    procedure Matmult(A, B: in Matrix; C: out Matrix);
end MatrixMult;