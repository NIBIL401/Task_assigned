grep -v '^>' NC_000913.faa | awk '{ total += length($0) } END { print total / NR }'
