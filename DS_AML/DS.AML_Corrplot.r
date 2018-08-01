#Starter Script for Rackeb and Jordan

#7/17/18 


#Purpose: Subset expression data and visualize sample-wise correlations. 

options(stringsAsFactors = FALSE)
?options

#The role of the options function is to allow the user to set and examine a variety of global options which affect the way in which R computes and displays its results.
#^^^this came from the bulitnin definition reader for the R program.

############ Load Libraries ################

# 1)We will need to load libraries. The libraries we need are:  tidyverse, corrplot, and ggplot2,
#For tidyvese, see https://www.tidyverse.org/packages/ and follow the instructions. 
#For corrplot, see the tutorial 
#Now, try ggplot2 on your own. 

install.packages(c("tidyverse", "corrplot", "ggplot2"))

############ Read in the data files ############

# 2) read in the expression data 

#The expression data is normalize to "transcripts per million" (TPMs). We will talk about normalization soon
# *Important*: We used normalized data to allow for sample to sample comparisons. 

#hint:
# what type of file is it? look at the suffix (.csv, .txt )
#which function would you choose based on the suffix? 

#It is a .csv file so in order to read it we would use the function, read.csv(x)

#This one is given to you. uncomment this and complete the code

TPMs <- read.csv("TARGET_AML_AAML0531_M7_and_DS-AML_dupGenesRemoved_TPM.csv", row.names=1)

#We need the gene names to be rownames. 
#look at read.csv() documentation to see why we used the row.names argument. 

?read.csv()
?rownames()

#We use rownames(x) as an argument because in the case where we would not use it, the rows would be numbers. 
#Due to the fact that we want the first row to be gene names and have the rest of the columns refer to the data of these genes,
#we will use {rownames(x, do.NULL = FALSE, prefix = ...)}. This will cause the first row to be a name ordered list rather that a numerical ordered list. 


#add code to the first few lines and the dimensions of the data.frame. 

head(TPMs)
tail(TPMs)
dim(TPMs)
summary(TPMs)

#3) read in the clinical data elements (CDE) file, 

#uncomment this and complete the code

CDE <- read.csv("TARGET_AML_1031_M7s_DS-AML_CDE.csv")

#add code to the first few lines and the dimensions of the data.frame. 

head(CDE)
tail(CDE)
dim(CDE)
summary(CDE)

#4) read in reference file, Homo_Sapiens_Entrez_Gene_IDs.txt. 

read.delim("Homo_Sapiens_Entrez_Gene_IDs.txt.")

#uncomment this and complete the code

ref <- read.delim("Homo_Sapiens_Entrez_Gene_IDs.txt.")

#add code to the first few lines and the dimensions of the data.frame.

head(ref)
tail(ref)
dim(ref)
summary(ref)

############### Data Exploration and Manipulation ###############


# 5)Look at the first patient's ISCN in the CDE's. Use the dataframe[row#,column#] (slice notation) syntax.
# An ISCN is a systematic way of describing an individuals karyotype using symbols and abbreviations. 

head(CDE[1,5])

#What is a karyotype? review this video if you don't remember ( https://www.youtube.com/watch?v=hNMYV213xu0 ) 
#Just write the definition here and comment it out by adding a "#" in front. 

#A karyotype is the number and appearance of chromosomes in the nucleus of an eukaryotic cell. The term is also used for 
#the complete set of chromosomes in a species or in an individual organism[1][2][3] and for a test that detects this 
#complement or measures the number.

#^^^ information supplieed from https://en.wikipedia.org/wiki/Karyotype


# 6) Look at the first patients ISCN using the row index (numeric) and the column name (string). dataframe[row#, column_name]
# Often it can be best to specify the column name when indexing. This avoids mistakes like adding a column and thus shifting the columns over. 
#That way you column 3 is now column 4, and re-running your code will introduce an error. 

CDE[1, 5]

# 7) Create a variable where you convert the column, "Age.at.Diagnosis.in.Days", to age in years.

Age.in.Years <- CDE[, "Age.at.Diagnosis.in.Days"] / 365

#uncomment this and complete the code

Age.in.Years <- CDE[, "Age.at.Diagnosis.in.Days"] / 365

# 8) Create a new column in CDE called "Age.in.years". Populate this column with
# the results from converting the column, "Age.at.Diagnosis.in.Days", to age in years. 
#Use base R.  So things like [] notation or $ notation.   

New_CDE <- cbind(CDE, Age.In.Years)
New_CDE

#example: data.frame[,"newColName"] <- c(1,2,3,4) / 2  

#add code to the first few lines and the dimensions of the updated data.frame. 
#This is to check that you added the information and its correct. 

head(New_CDE)
tail(New_CDE)
dim(New_CDE)
summary(New_CDE)

# 9) Copy and paste, and then run 2 examples of  gsub() and one example of grep() from the documentation. Examples on the bottom of the page. 
#Explain what each example is doing. Pick simple examples that use functions you have seen before. 

grep("[a-z]", letters)
gsub("([ab])", "\\1_\\1_", "abc and ABC")
txt <- "a test of capitalizing"
gsub("(\\w)(\\w*)", "\\U\\1\\L\\2", txt, perl=TRUE)

#grep allows you to focus on a certain subject of a column and classify it by the row that it pertains to.
#For instance,in the example above it asks for the rows that have letters a-z in the column called letters.
#Since we can assume that each row is a different letter of the alphabet and there are no repeats (the order is unknown).
#We can conclude that there is approximately 26 rows that can correlate with this function. 
#In the case where the differentiation in letters is smaller like a-b, then we would have an oputcome of 2.

#gsub allows you to replace all matches of a string.
#It takes the character subjects or results that you wish to match with and then replaces them with a new charater definition.
#this allows you to rename results or parts of data by matching with them and then finding a replacement character that will be the new definition.

#What type of data is returned by grep? use class()

class(grep)

#Function 

#What type of data is returned by gsub? use class()

class(gsub)

#Function

# 10) Use head() to look at the first few lines of the "Chromosome" column in reference data.frame (ref). 
#The notation here is chromosome#, chromosome arm, and the location of G-bands where that gene is found. 

head(ref[,"Chromosome"])

# example: gene A1BG is found at 19q13.43,  so chromosome 19, q arm, g-band sections 13.43
#we won't go into detail about the g-band sections here,so description of the g-bands here is NOT technical. 


# 11) Look at row 102 using slice notation. Describe chromosomal location it is found at.
#Example: data.frame[row, columnName]

ref[102, "Chromosome"]

#The location of this gene is found at chromosme 12, p arm, g-band sections 12.1.


# 12) Create a variable with the row numbers (called row indices) for genes that come from chromosome 21. 


#uncomment this and complete the code

row.indices <- grep("^21[p,q]", ref$Chromosome)

#Here I gave you the regular expression to use since we didn't cover them yet. 
#Lets breakdown what "^21[pq]" is matching
#^ means the strings begins with number 2, 
#21 means that the strings 1 and 2 must follow each other exactly  
#[pq] means that 21 is followed by the letters p or q only. 
#Thus we get 


# 13) Create a new variable to subset the reference dataframe (ref) for genes on chromosome 21.  
#select all the columns in the refernce df. 
#Use the variable row.indices to select the rows you want
#Example: data.frame[row.indices, ]


#uncomment this and complete the code

chr.21.ref <- ref[row.indices,]

# write code to check on the dimensions of the subset reference. 

dim(chr.21.ref)

#Result came out as "NULL". This is due to the fact that you need at least 2 columns in order for the dim(x) function to work.
#As long as the data you are analyzing in dim(x) is one-dimensional, it will nnot work.
#dim(x) requires to have the data be two-dimensional (at least 2 columns being analyzed), rather than only a single column (one-dimensional).

# 14) Use intersect to find the genes that are in both the chr21 reference dataframe and the expression dataset. 
#THe idea of this is to define a vector of genes names that are in BOTH TPMs and chr.21.ref. 


#Use intersect to find common names between the two dataframe. 

intersect(chr.21.ref[,"Approved.Symbol"], rownames(TPMs))

#what type of objects does intersect need? does it take data.frames? matrices? vectors? lists?

?intersect

#R definitons page defines that the intersect(x) function is only operable when vectors are in use.

#uncomment this and complete the code

head(rownames(TPMs))
head(rownames(chr.21.ref)) # you provide which column to use
chr.21.genes <- intersect(rownames(TPMs), chr.21.ref[,"Approved.Symbol"])


# 15) Select the rows from TPMs expression matrix for genes that are on chromosome 21. Select all columns. 
#Use the vector chr.21.genes you created. Save it as a new variable. 
#Example: TPMs[chr.21.genes,]


#uncomment this and complete the code

row.indices <- grep("^21[p,q]", ref$Chromosome)
chr.21.expn <- TPMs[chr.21.genes, ]

################# Correlation Plots 


# 16) follow the tutorial:	http://www.sthda.com/english/wiki/visualize-correlation-matrix-using-correlogram
#Add a lines of code here. Do NOT copy and paste. 
# Stop after "Changing the color and the rotation of text labels" section. Do Not compute P-values yet.
#We want to always understand the code we use. So we haven't covered this yet.  

#NOTE: We want to look at gene-wise correlations. So you should see gene symbols on the x and y axis. 

install.packages("corrplot")
library("corrplot")
head(mtcars)
M <- cor(mtcars)
M
head(round(M,2))
corrplot(M, method = "circle")
corrplot(M, method = "pie")
corrplot(M, method = "color")
corrplot(M, method = "number")
corrplot(M, type = "upper")
corrplot(M, type = "lower")
corrplot(M, type = "upper", order = "hclust")
col <- colorRampPalette(c("red", "white", "blue"))(20)
corrplot(M, type = "upper", order = "hclust", col = col)
corrplot(M, type = "upper", order = "hclust", col = c("black", "white"), bg = "lightblue")
library(RColorBrewer)
corrplot(M, type = "upper", order = "hclust", col = brewer.pal(n = 8, name = "RdBu"))
corrplot(M, type = "upper", order = "hclust", col = brewer.pal(n = 8, name = "RdYlBu"))
corrplot(M, type = "upper", order = "hclust", col = brewer.pal(n = 8, name = "PuOr"))

#17) Create a corrplot with the method="color" and with gene names in a readable size (fontsize change).  
#Create a corrplot with chr.21.expn data frame.

head(chr.21.expn)

#need to transpose data frame, use function t(x)

chr.21.P <- cor(chr.21.expn)
chr.21.P
corrplot(chr.21.P, method = "color")


