with text_io; use text_io;

procedure PrintNumbers is
    package int_io is new integer_io(integer); use int_io;
    low: constant integer := 1;
    high: constant integer := 100;
    offset: constant integer := 200;
    batchSize: constant integer := 10;
    
    task One is
        entry start;
    end One;
    
    task Two is
        entry print;
    end Two;

    task body One is
        index: integer := low;
        r: integer;
    begin
        accept start do
            for i in 1 .. high * 2 loop
                r := i mod (batchSize * 2);
                if 0 < r and r <= batchSize then
                    put(index);
                    index := index + 1;
                else
                    Two.print;
                end if;
            end loop;
        end start;
    end One;
    
    task body Two is
    begin
        for i in 1 .. high loop
            accept print do
                put(offset + i);
            end print;
        end loop;
    end Two;
    
begin
    One.start;
end PrintNumbers;
