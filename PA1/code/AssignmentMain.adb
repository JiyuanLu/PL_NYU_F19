with text_io; use text_io;
with MatrixMult; use MatrixMult;

procedure AssignmentMain is
    package int_io is new integer_io(integer); use int_io;
    A : Matrix;
    B : Matrix;
    C : Matrix;
    
    task One is -- read in matrix A from input
        entry E; -- wait for signal from main to read matrix A
    end One;
    
    task Two is -- read in matrix B from input
        entry E; -- wait for signal from One to read matrix B after One has finished reading
    end Two;
    
    task Three is -- print matrix C to output
        entry E; -- wait for signal from main to print
    end Three;
    
    task body One is
    begin
        accept E do
            -- put("A starts reading");
            for i in matrix_index loop
                for j in matrix_index loop
                    get(A(i, j));
                    -- put(A(i, j));
                end loop;
            end loop;
            -- put("A finishes reading");
            Two.E;
        end;
    end One;

    task body Two is
    begin
        accept E do
            -- put("B starts reading");
            for i in matrix_index loop
                for j in matrix_index loop
                    get(B(i, j));
                    -- put(B(i, j));
                end loop;
            end loop;
            -- put("B finishes reading");
        end;
    end Two;
    
    task body Three is
    begin
        accept E do
            -- put("C starts printing");
            for i in matrix_index loop
                for j in matrix_index loop
                    put(C(i, j));
                end loop;
            end loop;
            -- put("C finishes printing");
        end;
    end Three;

begin
    -- put("main calls A to read");
    One.E;
    -- put("A and B should have read everything");
    -- call Matmul to multiply A and B
    -- NaiveMatmult(A, B, C);
    Matmult(A, B, C);
    -- put("main calls C to print");
    Three.E;
    -- put("C should have printed everything");
end AssignmentMain;
