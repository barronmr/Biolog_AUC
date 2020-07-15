#Heatmap of area under the curve (AUC) values of strain 1 and strain 2 for each carbon source in 96-well Biolog PM1 plate.
#Madeline Barron
#April 2020
#---------------------------------------------------------------------------------------------------------------------------------------
##INPUT
#1. csv file containing AUC values for strain 1 and strain 2 and names of each carbon substrate in PM1 plate (1 column/variable)

#OUTPUT
#2. Heatmap comparing AUC of each strain (viridis color scheme)
#---------------------------------------------------------------------------------------------------------------------------------------
### LIBRARY REQUIREMENTS #### install.packages("tidyr")

library(tidyverse)
library(viridis)
getwd()
setwd("/Users/maddiebarron/desktop")
### READ IN CSV FILE OF AUC VALUES FOR STRAIN 1 AND STRAIN 2 (INCLUDES NAME OF CARBON SOURCE FOR EACH WELL, AS OUTLINED BY BIOLOG)

getwd()
setwd("/Users/maddiebarron/desktop")
data_auc <- read.csv(file = "AUC_pm1_01_2020_3.csv")

### CONVERT TO TIBBLE ###

data_auc_2 <- as_tibble(data_auc)

### GATHER DATA SO EACH VARIABLE IS UNDER ONE COLUMN (I.E. STRAIN AND CARBON SOURCE) ###

data_auc_long <- gather(data = data_auc_2, key = Strain, value = AUC, -Carbon.Source)

data_auc_long_2 <- arrange(data_auc_long, Strain, AUC)

### GENERATE HEATMAP WITH GGPLOT ###

auc_heatmap <- ggplot(data_auc_long_2, mapping = aes(x = Strain,
                                                   y = reorder(Carbon.Source, -AUC),
                                                  fill = AUC)) +
  #BETWEEN TILES = WHITE
  geom_tile(color = "white") + #between tiles = white

  #CHANGE SIZE OF HEAT MAP TILES
  coord_fixed(ratio = 0.5) +

  #LABEL X AND Y AXES
  xlab(label = "Strain") +
  ylab(label = "Carbon Source") +

  #CHANGE COLOR SCHEME
  scale_fill_distiller("AUC", palette = "RdYlBu") + #change color

  #CHANGE SIZE AND COLOR OF X AND Y LABELS, AXES, LEGEND TITLES
   theme(
    axis.text.y = element_text(size = 3, colour = "black"),
    axis.text.x = element_text(size = 5, colour = "black"),
    text = element_text(colour = "black", size = 9))

auc_heatmap

