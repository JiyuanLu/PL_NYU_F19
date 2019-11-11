package body MatrixMult is
    procedure NaiveMatmult(A, B: in Matrix; C: out Matrix) is
    begin
        for i in matrix_index loop
            for j in matrix_index loop
                C(i, j) := 0;
                for k in matrix_index loop
                    C(i, j) := C(i, j) + A(i, k) * B(k, j);
                end loop;
            end loop;
        end loop;
    end;
    
    procedure Matmult(A, B: in Matrix; C: out Matrix) is
        -- define a type of computing task that computes an element of C
        task type Computer is
            entry E(row, column: integer);
        end Computer;
        
        task body Computer is
            i, j: integer;
        begin
            accept E(row, column: in integer) do
                i := row;
                j := column;
            end E;
            C(i, j) := 0;
            for k in matrix_index loop
                C(i, j) := C(i, j) + A(i, k) * B(k, j);
            end loop;     
        end Computer;
    
    -- define an SIZE * SIZE array of type computing tasks
        type Computers is array (matrix_index, matrix_index) of Computer;
        MatmulComputers : Computers;
        
    begin 
        -- start each computing node
        for i in matrix_index loop
            for j in matrix_index loop
                MatmulComputers(i, j).E(i, j);
            end loop;
        end loop;                      
    end;
end MatrixMult;