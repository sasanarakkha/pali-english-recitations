# single left
s/ '`*\([[:alpha:]]\)/ ‘\1/g
s/^ *'`*\([[:alpha:]]\)/‘\1/g

# single right
s/\([[:alpha:][:punct:]]\)`*'\([^[:alpha:]]\)/\1’\2/g
s/\([[:alpha:][:punct:]]\)`*' *$/\1’/g

# double left
s/ "`*\([[:alpha:]]\)/“\1/g
s/^ *"`*\([[:alpha:]]\)/“\1/g

# double right
s/\([[:alpha:][:punct:]]\)`*"\([^[:alpha:]]\)/\1”\2/g
s/\([[:alpha:][:punct:]]\)`*" *$/\1”/g