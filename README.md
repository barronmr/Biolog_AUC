This repository contains scripts to calculate area under the curve (AUC) values from OD595 values collected for 2 bacterial strains over 48 hours in a 96-well Biolog plate (PM1). 

**Scripts**

There are 3 scripts required to calculate the AUC values from raw Biolog plate data. The order in which they are used is denoted at the beginning of the script name as "step_1", "step_2", and "step_3". 

1. The first script (step_1_read_continuous_biolog_function_mb.R) encodes a function that reads in raw Biolog data files (as excel documents), normalizes the OD595 readings, and returns the file for each bacterial strain as a matrix. It also denotes the wells in which the readings went negative after normalization and converts those values to "0".

2. The second script, (step_2_continuous_auc_function.mb.R), is a function that calculates AUC values from the Biolog plate data.

3. The final script (step_3_calculate_auc_biolog_mr.R) applies functions from the first two scripts to generate a single excel file denoting the well identity of the 96-well plate and AUC values for each bacterial strain.

4. To generate a heatmap from the resulting AUC values, the auc_heatmap_mb.R script can be used. 

**Packages**

Base R is used for scripts outlined in steps 1-3 above. To generate a heatmap (step 4), the following packages are required:

tidyverse

viridis (color scheme of heatmap)

**Data**

The raw excel files used to calculate AUC for wild-type ECOR2 and its isogenic *rpoS* mutant, as well as the csv file for creating a heatmap from those values, are included in the "data" folder of this repository. For reference, "strain 1" refers to wild-type while "strain 2" refers to the *rpoS* mutant.
