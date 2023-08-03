library(org.Hs.eg.db)
library(biomaRt)
input_file="D:/Me/public-archivedwl-553/h.all.v2023.1.Hs.symbols.gmt"
output_file="D:/Me/public-archivedwl-553/test_entrez.gmt"
gmt_data <- read.delim(input_file,sep = "\t",header = FALSE)

all_gene_symbols <- unique(unlist(gmt_data[, -(1:2)]))
convert_symbols_to_entrez <- function(gene_symbols) {
  entrez_ids <- mapIds(org.Hs.eg.db, keys = gene_symbols, keytype = "SYMBOL",
                       column = "ENTREZID", multiVals = "first")
  return(entrez_ids)
}
entrez_mapping <- convert_symbols_to_entrez(all_gene_symbols)

replace_gene_symbols_with_entrez <- function(df, mapping) {
  for (col in seq_along(df)[-c(1, 2)]) {
    gene_symbol_col <- df[[col]]
    df[[col]] <- sapply(gene_symbol_col, function(symbols) paste(unlist(mapping[symbols]), collapse = ";"))
  }
  return(df)
}
main_file_entrez <- replace_gene_symbols_with_entrez(gmt_data, entrez_mapping)

write_delim(main_file_entrez, file = output_file, delim = "\t",col_names = FALSE)

