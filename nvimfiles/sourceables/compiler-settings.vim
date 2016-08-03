" compiler settings

" build from the "build" dir, even though vim was started in "workspace" dir
:set makeprg=make\ -w\ -C\ ../build
""'make -C ../build'
set errorformat=
            \%*[^\"]\"%f\"%*\\D%l:%c:\ %m,
            \%*[^\"]\"%f\"%*\\D%l:\ %m,
            \\"%f\"%*\\D%l:%c:\ %m,
            \\"%f\"%*\\D%l:\ %m,
            \%-G%f:%l:\ %trror:\ (Each\ undeclared\ identifier\ is\ reported\ only\ once,
            \%-G%f:%l:\ %trror:\ for\ each\ function\ it\ appears\ in.),
            \%-G%f:%l:%c:\ %tarning:\ %m,
            \%-G%f:%l:\ %tarning:\ %m,
            \%-G%f:%l:%c:\ %tote:\ %m,
            \%f:%l:%c:\ %trror:\ %m,
            \%f:%l:%c:\ %m,
            \%f:%l:\ %trror:\ %m,
            \%f:%l:\ %m,
            \\"%f\"\\,\ line\ %l%*\\D%c%*[^\ ]\ %m,
            \%D%*\\a[%*\\d]:\ Entering\ directory\ [`']%f',
            \%X%*\\a[%*\\d]:\ Leaving\ directory\ [`']%f',
            \%D%*\\a:\ Entering\ directory\ [`']%f',
            \%X%*\\a:\ Leaving\ directory\ [`']%f',
            \%DMaking\ %*\\a\ in\ %f
set errorformat +=\[%f:%l\]:\ (%tyle)\ %m
set errorformat +=%-G%.%#
