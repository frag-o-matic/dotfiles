echo Cleaning old stuff...
rm -f cscope.files cscope.in.out cscope.out cscope.po.out
rm -f GPATH GRTAGS GTAGS gtags.files
rm -f tags

echo Creating File List...
# create tags for require dirs and filetypes only
find . -type d \( -name UnitTests -o -name drivers -o -name utils \) -prune -name "*.c" -o -name "*.h" -o -name "*.hpp" -o -name "*.hxx" -o -name "*.cpp" -o -name "*.cxx" > cscope.files

echo Creating CScope DB...
cscope -q -R -b -i cscope.files

echo Creating CTags...
ctags --c++-kinds=+p --fields=+iamS --extra=+fq --recurse=yes --languages=c++ --tag-relative=yes

echo Creating gtags...
mv cscope.files gtags.files
gtags
rm -f gtags.files

echo Done!!
