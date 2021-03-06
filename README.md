**Description**

This repository contains raw data files and code used to calculate area under the curve (AUC) of OD595 values collected over 24 hrs for *E. coli* strain ECOR2 and an isogenic *∆rpoS* mutant during incubation in Biolog PM1 plates, as outlined in the manuscript: "The lumen of human intestinal organoids poses greater stress to bacteria compared to the germ-free mouse intestine: *Escherichia coli* deficient in RpoS as a colonization probe", 2020, authored by Madeline R. Barron, Roberto J. Cieza, David R. Hill, Sha Huang, Veda K. Yagadiri, Jason R. Spence, and Vincent B. Young. 


**Abstract**

Pluripotent stem-cell-derived human intestinal organoids (HIOs) are three-dimensional, multicellular structures that model a naïve intestinal epithelium in an in vitro system. Several published reports have investigated the use of HIOs to study host-microbe interactions. We recently demonstrated that microinjection of the non-pathogenic *Escherichia coli* strain, ECOR2, into HIOs induced morphological and functional maturation of the HIO epithelium, including increased secretion of mucins and cationic antimicrobial peptides. In the current work, we use ECOR2 as a biological probe to further characterize the environment present in the HIO lumen. We generated an isogenic mutant in the general stress response sigma factor, RpoS, and employed this mutant to compare challenges faced by a bacterium during colonization of the HIO lumen relative to the germ-free mouse intestine. We demonstrate that loss of RpoS significantly decreases the ability of ECOR2 to colonize HIOs, though it does not prevent colonization of germ-free mice. These results indicate that HIO lumen is a more restrictive environment to *E. coli*  than the germ-free mouse intestine, thus increasing our understanding of the HIO model system as it pertains to studying the establishment of intestinal host-microbe symbioses.    
 
 **Packages**

Base R is used for code outlined in steps 1-3 below. To generate a heatmap from resulting AUC values (step 4), the following packages are required:

    - tidyverse

    - viridis (color scheme of heatmap)
 
**Code**

There are 3 scripts used to calculate the AUC from raw Biolog plate data. The order in which they are used is denoted at the beginning of the script name as "step_1", "step_2", and "step_3". 

1. The first script (step_1_read_continuous_biolog_function_mb.R) encodes a function that reads in raw Biolog data files (as excel documents), normalizes the OD595 readings, and returns the file for each bacterial strain as a matrix. It also denotes the wells in which the readings went negative after normalization and converts those values to "0".

2. The second script, (step_2_continuous_auc_function.mb.R), encodes a function that calculates AUC values from the Biolog plate data.

3. The final script (step_3_calculate_auc_biolog_mb.R) applies functions from steps 1 and 2 to generate a single excel file denoting AUC values for each bacterial strain.

4. To generate a heatmap from the resulting AUC values, the auc_heatmap_mb.R script is used. 

**Data**

The raw excel files used to calculate AUC for wild-type ECOR2 and its isogenic *∆rpoS* mutant for each carbon substrate in the Biolog PM1 plate, as well as the csv file for creating a heatmap from those values, are included in the "data" folder of this repository. For reference, "strain 1" refers to wild-type ECOR2 while "strain 2" refers to the *∆rpoS* mutant.
