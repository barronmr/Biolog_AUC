##CALCULATING AREA UNDER THE CURVE FROM BIOLOG PLATE DATA
### Written by Emily Benedict and Stephanie Thiede, modified by Madeline Barron ###
#January 2020
#------------------------------------------------------------------------------------------------------------------------------------------

## INPUTS:
# 1. megamat = array with strain 1 and and strain 2 Biolog data (collected every 15 mins for 24 hours)

## OUTPUT:
# 1. Area under the curve  (AUC) for strain 1 and strain 2 using OD595 readings obtained every 15 mins for 24 hours for
#each substrate in Biolog PM1 plates.

#------------------------------------------------------------------------------------------------------------------------------------------
step_2_continuous_auc_function_mb <- function(megamat){

  megamat_names = dimnames(megamat)[[3]]


#### GET WIDTH TO MULTIPLY BY OD NUMBERS ####

   width <- c(rep(0.25, 97))

#### CREATING APPROPRIATE STORAGE MATRIX ####
  AUC <- matrix(NA, nrow = ncol(megamat) , ncol = dim(megamat)[[3]])
  colnames(AUC) <- paste(megamat_names)
  rownames(AUC) <- colnames(megamat)

#### GET AUC ####

  for (k in 1:dim(megamat)[3]) {
    #print(k) just to double check what's happening
    for (j in 1:ncol(megamat)) {
      AUC[j,k] <- sum(0.25 * megamat[,j,k]) #0.25hr because takes reading every 15 minutes

    }

  }

  return(AUC) #return AUC information

}
