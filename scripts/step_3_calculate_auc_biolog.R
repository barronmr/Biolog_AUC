
### CALCULATING AREA UNDER THE CURVE (AUC) FROM BIOLOGY DATA USING STEP 1 AND STEP 2 FUNCTIONS
##Written by Emily Benedict and Stephanie Thiede, modified by Madeline Barron
#January 2020
#---------------------------------------------------------------------------------------------------------------------------------------
##INPUTS:
# 1. S1 and S2 matrices generated in step_1

## OUTPUTS:
# 1. Excel file containing AUC values for strain 1 and strain 2 for each well in Biolog plate (labeled A-H, 1-12)
#----------------------------------------------------------------------------------------------------------------------------------------------
#### LIBRARY REQUIREMENTS ####
library(stringr)
library(readxl)
library(openxlsx)
library(magrittr)
#----------------------------------------------------------------------------------------------------------------------------------------------

#### READ IN STRAIN 1 AND STRAIN 2 DATA MATRICES (GENERATED IN STEP 1) ####
source('step_1_read_in_continuous_biolog_function_mb.R')
pm1 <- step_1_read_in_continuous_biolog_function_mb('path to folder containing function')

#ASSIGN VARIABLES TO STRAIN 1 AND STRAIN 2 MATRICES
S1_pm1 <- pm1[[1]]
S2_pm1 <- pm1[[2]]

#### STORING DATA ####
filler <- rep(NA, nrow(S1_pm1)*96*2)
megamat_plates <- array(filler,c(nrow(S1_pm1), 96, 2)) # apply to 2 plates (strain 1 and strain 2)
cnames <- c(sapply(LETTERS[1:8], function(letter){
  paste(letter, c(1:12), sep = '')
}))

  #Time (from 0-24 hrs, collected every 15 mins)
  time <- seq(0, 24, 0.25)

  #Assign time and column names to S1_pm1 and S2_pm2 matrices
  dimnames(megamat_plates) <- list(time, cnames, c('Strain_1','Strain_2'))

  megamat_plates[,,1] <- S1_pm1
  megamat_plates[,,2] <- S2_pm1


#### GENERATING AUC VALUES FOR STRAIN 1 AND STRAIN 2  ####

### SOURCE STEP 2 AUC FUNCTION ###

source('path to step_2_continuous_auc_function_mb')

### CALCUALTE AUC ###
AUC <- continuous_auc_function_mb(megamat = megamat_plates)

### ADD WELL ID TO DATAFRAME WITH STRAIN 1 AND STRAIN 2 AUC VALUES ###

AUC_1 <- as.data.frame(AUC)

AUC_1$Well <- c(sapply(LETTERS[1:8], function(letter){
  paste(letter, c(1:12), sep = '') }))

AUC_2 <- AUC_1[, c(3,1,2)]

#### SAVE TO EXCEL FILE ####
write.xlsx(AUC_2, file = 'AUC_test.xlsx')
