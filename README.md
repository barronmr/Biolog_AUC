**Description**

This repository contains raw data files and code used to calculate area under the curve (AUC) of OD595 values collected for wild-type and *∆rpoS* *E. coli* strain ECOR2 during incubation in Biolog PM1 plates, as outlined in the manuscript: *Title*


**Abstract**
 *Add when ready 
 
 **Packages**

Base R is used for scripts outlined in steps 1-3 below. To generate a heatmap (step 4), the following packages are required:

    - tidyverse

    - viridis (color scheme of heatmap)
 
**Code**

There are 3 scripts required to calculate the AUC values from raw Biolog plate data. The order in which they are used is denoted at the beginning of the script name as "step_1", "step_2", and "step_3". 

1. The first script (step_1_read_continuous_biolog_function_mb.R) encodes a function that reads in raw Biolog data files (as excel documents), normalizes the OD595 readings, and returns the file for each bacterial strain as a matrix. It also denotes the wells in which the readings went negative after normalization and converts those values to "0".

2. The second script, (step_2_continuous_auc_function.mb.R), is a function that calculates AUC values from the Biolog plate data.

3. The final script (step_3_calculate_auc_biolog_mb.R) applies functions from the first two scripts to generate a single excel file denoting the well identity of the 96-well plate and AUC values for each bacterial strain.

4. To generate a heatmap from the resulting AUC values, the auc_heatmap_mb.R script can be used. 

**Data**

The raw excel files used to calculate AUC for wild-type ECOR2 and its isogenic *∆rpoS* mutant for each carbon substrate in the Biolog PM1 plate, as well as the csv file for creating a heatmap from those values, are included in the "data" folder of this repository. For reference, "strain 1" refers to wild-type ECOR2 while "strain 2" refers to the *∆rpoS* mutant.
