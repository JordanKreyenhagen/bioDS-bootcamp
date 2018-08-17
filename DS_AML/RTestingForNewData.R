#Read in the data 
read.delim("GitHub/bioDS-bootcamp/DS_AML/TARGET_AML_1031_DS.AML_HTSeq_Hg38_TMMCPM_norm_counts.csv")
#LOOK FOR THINGS THAT NEED QUOTES, WE'VE GONE THROUGH WAY TO MUCH CRAP CAUSE YOU CANT REMEMBER!
read.csv("GitHub/bioDS-bootcamp/DS_AML/TARGET_AML_1031_DS.AML_HTSeq_Hg38_TMMCPM_norm_counts.csv")
Log2.Expn <- read.csv("GitHub/bioDS-bootcamp/DS_AML/TARGET_AML_1031_DS.AML_HTSeq_Hg38_TMMCPM_norm_counts.csv", row.names = 1)
read.csv("GitHub/bioDS-bootcamp/DS_AML/TARGET_AML_1031_M7s_DS-AML_CDE.csv")
DEGs <- read.csv("GitHub/bioDS-bootcamp/DS_AML/TARGET_AML_1031_DS.AML_vs_M7s_DEGs.csv")
read.csv("GitHub/bioDS-bootcamp/DS_AML/")
read.delim("GitHub/bioDS-bootcamp/DS_AML/Homo_Sapiens_Entrez_Gene_IDs.txt")
?intersect
intersect(DEGs[, "Gene"], chr.21.ref[, "Approved.Symbol"])
ref <- read.delim("GitHub/bioDS-bootcamp/DS_AML/Homo_Sapiens_Entrez_Gene_IDs.txt")
row.indices <- grep("^21[p,q]", ref$Chromosome)
chr.21.ref <- ref[row.indices,]
chr.21.ref

#Run the code below to find how many DEGs are on Chr.21.
#Add comments that describe what each line of code is doing. The first one is done for you.
?filter()

chr.21.DEGs <- DEGs %>% #define a new variable and pipe (%>%) the DEGs dataframe into the filter function.
filter(., Gene %in% chr.21.ref$Approved.Symbol) #filter() is finding  where conditions are true and where the condition evaluates to NA: dropped.
chr.21.DEGs

head(chr.21.DEGs)
dim(chr.21.DEGs)

Gene.Names <- rownames(Log2.Expn)

Log2.Expn.df <- Log2.Expn %>%
mutate(., Gene = Gene.Names)

CDE <- read.csv("GitHub/bioDS-bootcamp/DS_AML/TARGET_AML_1031_M7s_DS-AML_CDE (1).csv")
CDE

CDE.subset <- CDE %>%
select(.,Sample, group)
head(CDE)

head(CDE.subset)
dim(CDE.subset)

chr.21.ref

?filter
?gather
?inner_join

library("tidyr")


rlang::quo_name()

DEGs


