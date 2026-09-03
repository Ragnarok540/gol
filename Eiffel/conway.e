class
    CONWAY
inherit
    POSIX_PROCESS
create
    make
feature
    g: GRID
    make
        local
            r: INTEGER
        do
            create g.make (10, 20)

            g.set (0, 3, 1)
            g.set (1, 4, 1)
            g.set (2, 2, 1)
            g.set (2, 3, 1)
            g.set (2, 4, 1)

            g.print_grid

            from
            until
               false
            loop
                g.simulate
                g.print_grid
                r := sleep (1.to_natural_32).to_integer_32
            end

        end
end

-- mkdir -p bin
-- ../../../../Downloads/Liberty/target/bin/se compile conway.e -o bin/conway -clean
-- ./bin/conway
