#Heatmap of area under the curve (AUC) values of strain 1 and strain 2 for each carbon source in 96-well Biolog PM1 plate.
#Madeline Barron
#April 2020
#---------------------------------------------------------------------------------------------------------------------------------------
##INPUT
#1. csv file containing AUC values for strain 1 and strain 2 and names of each carbon substrate in PM1 plate (1 column/variable)

#OUTPUT
#2. Heatmap comparing AUC of each strain (viridis color scheme)
#---------------------------------------------------------------------------------------------------------------------------------------
### LIBRARY REQUIREMENTS #### 

library(tidyr)
library(tidyverse)
library(extrafont)
library(viridis)

### READ IN CSV FILE OF AUC VALUES FOR STRAIN 1 AND STRAIN 2 (INCLUDES NAME OF CARBON SOURCE FOR EACH WELL, AS OUTLINED BY BIOLOG)

data_auc <- read.csv(file = "file_name.csv")

### CONVERT TO TIBBLE ###

data_auc_2 <- as_tibble(data_auc)

### GATHER DATA SO EACH VARIABLE IS UNDER ONE COLUMN (I.E. STRAIN AND CARBON SOURCE) ###

data_auc_long <- gather(data = data_auc_2, key = Strain, value = AUC, -Carbon.Source)

### GENERATE HEATMAP WITH GGPLOT ###

auc_heatmap <- ggplot(data_auc_long, mapping = aes(x = Strain,
                                                   y = Carbon.Source,
                                                   fill = AUC)) +
  #BETWEEN TILES = WHITE
  geom_tile(color = "white") + #between tiles = white

  #CHANGE SIZE OF HEAT MAP TILES
  coord_fixed(ratio = 0.2) +

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
