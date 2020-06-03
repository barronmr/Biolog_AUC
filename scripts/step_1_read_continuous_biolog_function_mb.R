### READING BIOLOG DATA (Collected on a plate reader with readings every 15 mins for 48 hrs) ###
### Written by Emily Benedict and Stephanie Thiede, modified by Madeline Barron ###
#January 2020
#------------------------------------------------------------------------------------------------------------------------------------------
##INPUTS:
# 1. path_name = 'path to folder'

## OUTPUTS:
# 1. list containing strain 1 and strain 2 data matrices, the lists well names and timepoints for
# which data is < 0.

## LIBRARY REQUIREMENTS ##
library(readxl)
#------------------------------------------------------------------------------------------------------------------------------------------

step_1_read_in_continuous_biolog_function_mb <- function(path_name){

#### IDENTIFY STRAIN 1 AND STRAIN 2 RAW BIOLOG DATA FILES IN DIRECTORY ####

  S1_file <- list.files(path = path_name, pattern = 'strain_1',
                       full.names = TRUE)
  print(S1_file)

  S2_file <- list.files(path = path_name, pattern = 'strain_2', full.names = TRUE)

  print(S1_file)

#### READ IN STRAIN 1 FILE ####
  S1 <- read_excel(S1_file, skip = 26)

#### SUBSET FIRST 1-193 ROWS AND REMOVE FIRST 3 COLUMNS (EXTRANEOUS INFORMATION FROM PLATE READER)

  S1 <- S1[1:193,-c(1,2,3)]

  S1 <- sapply(S1, as.numeric)

  S1 <-  S1[-1,]

#### GROWTH DATA WAS COLLECTED FOR 48 HRS. ONLY INTERESTED IN 24 HRS. SUBSET ROWS TO INCLUDE OD VALUES FROM 0-24 HRS ONLY.

  S1 <- S1[1:97,]

#### NORMALIZE READING FROM EACH WELL FOR EACH TIMEPOINT TO THE FIRST READING FROM THAT WELL.
#### PREVENTS DISCREPANCIES IN OD DUE TO DIFFERENT STARTING POINTS BETWEEN STRAINS/SUBSTRATES.

  S1 M<- t(apply(S1, 1, function(row){
    row - S1[1,]
  }))

   ## REPEAT STEPS ABOVE FOR STRAIN 2
  S2 <- read_excel(S2_file, skip = 26)
  S2 <-  S2[1:193,-c(1,2,3)]
  S2 <-  sapply(S2, as.numeric)
  S2 <-  S2[-1,]
  S2 <-  S2[1:97,]
  S2 <-  t(apply(S2, 1, function(row){
    row - S2[1,]
  }))

#### NAME COLUMNS WITH A-H, 1-12 ####
  cnames <- c(sapply(LETTERS[1:8], function(letter){
    paste(letter, c('01','02','03','04','05','06','07','08','09','10','11','12'), sep = '')
  }))

#### NAME ROWS 1-97 ####
  rnames <- c(1:97)

#### APPLY COLUMN AND ROW NAMES TO S1 AND S2 ####

  colnames(S1) <- cnames
  colnames(S2) <- cnames

  rownames(S1) <-rnames
  rownames(S2) <- rnames

#### IDENTIFY WELLS THAT WENT NEGATIVE AFTER NORMALIZATION ####

  S1_negative_wells <- paste(colnames(S1)[as.vector(which(S1 < 0,arr.ind = TRUE)[,2])],
                            rownames(S1)[as.vector(which(S1 < 0,arr.ind = TRUE)[,1])],
                            sep = '-')

  S2_negative_wells <-paste(colnames(S2)[as.vector(which(S2 < 0,arr.ind = TRUE)[,2])],
                            rownames(S2)[as.vector(which(S2 < 0,arr.ind = TRUE)[,1])],
                            sep = '-')

  #### TURN NEGATIVE VALUES TO 0 ####

  S1[S1<0] <- 0
  S2[S2 < 0] <- 0

#### RETURN MATRICES FOR S1 AND S2 AND A LIST OF WHICH WELLS WENT NEGATIVE ####

  S1 <- as.matrix(S1)
  S2 <- as.matrix(S2)
  S1_negative_wells<-as.matrix(S1_negative_wells)
  S2_negative_wells<-as.matrix(S2_negative_wells)
  

  return(list(S1, S2, S1_negative_wells, S2_negative_wells))
}
