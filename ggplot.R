library(readr)
library(ggplot2)
library(dplyr)

# Read gene information from the file and specify header is present
gene_info <- read_tsv("D:/Me/public-archivedwl-862/Homo_sapiens.gene_info")

# Convert the "chromosome" column to a factor with the desired order
chromosome_order <- c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", 
                      "11", "12", "13", "14", "15", "16", "17", "18", "19", 
                      "20", "21", "22", "X", "Y", "MT", "Un")
gene_info$chromosome <- factor(gene_info$chromosome, levels = chromosome_order)

# Filter out rows with NA values in the "chromosome" column
gene_info_filtered <- gene_info %>%
  filter(!is.na(chromosome))

# Count the number of genes per chromosome
gene_count_per_chromosome <- gene_info_filtered %>%
  group_by(chromosome) %>%
  summarise(Number_of_Genes = n())

# Create a bar plot using ggplot2
ggplot(gene_count_per_chromosome, aes(x = chromosome, y = Number_of_Genes)) +
  geom_bar(stat = "identity", fill = "grey35") +
  labs(title = "Number of Genes per Chromosome in Human Genome",
       x = "Chromosomes", y = "Number of Genes") +
  theme_minimal()+theme(axis.line = element_line(size = .5, colour = "black"))+
  theme(panel.grid = element_blank())
