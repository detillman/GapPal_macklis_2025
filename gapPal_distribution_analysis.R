## ----setup, include=FALSE-------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)


## ----dataLoad-------------------------------------------------------------------------------------------------------------
# loading data
dist_data <- read.csv("gapPal_distributionAnalysis.csv")

# getting unique file names
dist_files <- unique(dist_data$file)
write.table(dist_files, file = "clipboard", quote = T, row.names = F)

# making file metadata
dist_meta <- data.frame(file = c("5-26-23 E14.5 IUE pTA051 pDT010A+Dox P1 Perfuse P3 slide 1 section 3",
                                 "5-26-23 E14.5 IUE pTA051 pDT010A+Dox P1 Perfuse P3 slide 1 section 4",
                                 "5-26-23 E14.5 IUE pTA051 pDT010A+Dox P1 Perfuse P3 slide 1 section 5",
                                 "5-26-23 E14.5 IUE pTA051 pDT010A+Dox P1 Perfuse P3 slide 2 section 3",
                                 "5-26-23 E14.5 IUE pTA051 pDT010A+Dox P1 Perfuse P3 slide 2 section 4",
                                 "5-26-23 E14.5 IUE pTA051 pDT010A+Dox P1 Perfuse P3 slide 2 section 5",
                                 "5-26-23 E14.5 IUE pTA051 pDT010A+Dox P1 Perfuse P3 slide 3 section 3",
                                 "5-26-23 E14.5 IUE pTA051 pDT010A+Dox P1 Perfuse P3 slide 3 section 4",
                                 "5-26-23 E14.5 IUE pTA051 pDT010A+Dox P1 Perfuse P3 slide 3 section 5 2",
                                 "5-26-23 E14.5 IUE pTA051 pDT010A+Dox P1 Perfuse P3 slide 3 section 5",
                                 "6-19-23 E14.5 IUE pTA051 + pDT010A Dox P1 Perfuse at P3 brain 2 section 3",
                                 "6-19-23 E14.5 IUE pTA051 + pDT010A Dox P1 Perfuse at P3 brain 2 section 4",
                                 "6-19-23 E14.5 IUE pTA051 + pDT010A Dox P1 Perfuse at P3 brain 3 section 3",
                                 "6-19-23 E14.5 IUE pTA051 + pDT010A Dox P1 Perfuse at P3 brain 3 section 4",
                                 "6-19-23 E14.5 IUE pTA051 + pDT010A Dox P1 Perfuse at P3 brain 4 section 3",
                                 "6-19-23 E14.5 IUE pTA051 + pDT010A Dox P1 Perfuse at P3 brain 4 section 4",
                                 "6-19-23 E14.5 IUE pTA051 + pDT010A Dox P1 Perfuse at P3 brain 6 section 3",
                                 "6-7-23 E14.5 IUE pTA051 + pDT009 Dox P1 Perfuse at P3 brain 1 section 3",
                                 "6-7-23 E14.5 IUE pTA051 + pDT009 Dox P1 Perfuse at P3 brain 1 section 4",
                                 "6-7-23 E14.5 IUE pTA051 + pDT009 Dox P1 Perfuse at P3 brain 4 section 3",
                                 "6-7-23 E14.5 IUE pTA051 + pDT009 Dox P1 Perfuse at P3 brain 4 section 4",
                                 "6-7-23 E14.5 IUE pTA051 + pDT009 Dox P1 Perfuse at P3 brain 6 section 3",
                                 "6-7-23 E14.5 IUE pTA051 + pDT009 Dox P1 Perfuse at P3 brain 8 section 2 redo BAD",
                                 "6-7-23 E14.5 IUE pTA051 + pDT009 Dox P1 Perfuse at P3 brain 8 section 3 redo",
                                 "6-7-23 E14.5 IUE pTA051 + pDT009 Dox P1 Perfuse at P3 brain 8 section 4",
                                 "6-7-23 E14.5 IUE pTA051 + pDT010A Dox P1 Perfuse at P3 brain 3 section 3",
                                 "E14.5 IUE 8.20.22 pDT010A P3 DoxAtP1 number1 section2 d200g400r600 10x",
                                 "E14.5 IUE 8.20.22 pDT010A P3 DoxAtP1 number1 section3 d200g400r600 10x",
                                 "E14.5 IUE 8.20.22 pDT010A P3 DoxAtP1 number2 section4 d200g400r600 10x",
                                 "E14.5 IUE 8.20.22 pDT010A P3 DoxAtP1 number2 section5 d200g400r600 10x",
                                 "E14.5 IUE 8.23.22 pDT010D P3 DoxAtP1 number1 section1 d200g400r600 10x",
                                 "E14.5 IUE 8.23.22 pDT010D P3 DoxAtP1 number1 section2 d200g400r600 10x",
                                 "E14.5 IUE 8.23.22 pDT010D P3 DoxAtP1 number2 section2 d200g400r600 10x",
                                 "E14.5 IUE 8.23.22 pDT010D P3 DoxAtP1 number2 section3 d200g400r600 10x",
                                 "E14.5 IUE 8.23.22 pDT010D P3 DoxAtP1 number3 section2 d200g400r600 10x",
                                 "E14.5 IUE 8.23.22 pDT010D P3 DoxAtP1 number3 section3 d200g400r600 10x",
                                 "E14.5 IUE 8.26.22 pDT009 P3 DoxAtP1 number1 section1 d200g400r600 10x",
                                 "E14.5 IUE 8.3.22 pDT009 P3 DoxAtP1 number1 section3 d200g400r600 10x",
                                 "E14.5 IUE 8.3.22 pDT009 P3 DoxAtP1 number1 section4 d200g400r600 10x",
                                 "E15.5 IUE 8.14.22 pDT009 P3 DoxAtP1 number1 section3 d200g400r600 10x",
                                 "E15.5 IUE 8.14.22 pDT009 P3 DoxAtP1 number1 section4 d200g400r600 10x",
                                 "E15.5 IUE 8.14.22 pDT009 P3 DoxAtP1 number1 section5 d200g400r600 10x",
                                 "E15.5 IUE 8.14.22 pDT009 P3 DoxAtP1 number2 section4 d200g400r600 10x"),
                        iue_date = c("5-26-23",
                                     "5-26-23",
                                     "5-26-23",
                                     "5-26-23",
                                     "5-26-23",
                                     "5-26-23",
                                     "5-26-23",
                                     "5-26-23",
                                     "5-26-23",
                                     "5-26-23",
                                     "6-19-23",
                                     "6-19-23",
                                     "6-19-23",
                                     "6-19-23",
                                     "6-19-23",
                                     "6-19-23",
                                     "6-19-23",
                                     "6-7-23",
                                     "6-7-23",
                                     "6-7-23",
                                     "6-7-23",
                                     "6-7-23",
                                     "6-7-23",
                                     "6-7-23",
                                     "6-7-23",
                                     "6-7-23",
                                     "8-20-22",
                                     "8-20-22",
                                     "8-20-22",
                                     "8-20-22",
                                     "8-23-22",
                                     "8-23-22",
                                     "8-23-22",
                                     "8-23-22",
                                     "8-23-22",
                                     "8-23-22",
                                     "8-26-22",
                                     "8-3-22",
                                     "8-3-22",
                                     "8-14-22",
                                     "8-14-22",
                                     "8-14-22",
                                     "8-14-22"),
                        iue_age = c("E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E14.5",
                                    "E15.5",
                                    "E15.5",
                                    "E15.5",
                                    "E15.5"),
                        construct = c("pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT009",
                                      "pDT009",
                                      "pDT009",
                                      "pDT009",
                                      "pDT009",
                                      "pDT009",
                                      "pDT009",
                                      "pDT009",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010A",
                                      "pDT010D",
                                      "pDT010D",
                                      "pDT010D",
                                      "pDT010D",
                                      "pDT010D",
                                      "pDT010D",
                                      "pDT009",
                                      "pDT009",
                                      "pDT009",
                                      "pDT009",
                                      "pDT009",
                                      "pDT009",
                                      "pDT009"),
                        brain_section = c("brain1 section3",
                                          "brain1 section4",
                                          "brain1 section5",
                                          "brain2 section3",
                                          "brain2 section4",
                                          "brain2 section5",
                                          "brain3 section3",
                                          "brain3 section4",
                                          "brain3 section5",
                                          "brain3 section5",
                                          "brain2 section3",
                                          "brain2 section4",
                                          "brain3 section3",
                                          "brain3 section4",
                                          "brain4 section3",
                                          "brain4 section4",
                                          "brain6 section3",
                                          "brain1 section3",
                                          "brain1 section4",
                                          "brain4 section3",
                                          "brain4 section4",
                                          "brain6 section3",
                                          "brain8 section2",
                                          "brain8 section3",
                                          "brain8 section4",
                                          "brain3 section3",
                                          "brain1 section2",
                                          "brain1 section3",
                                          "brain2 section4",
                                          "brain2 section5",
                                          "brain1 section1",
                                          "brain1 section2",
                                          "brain2 section2",
                                          "brain2 section3",
                                          "brain3 section2",
                                          "brain3 section3",
                                          "brain1 section1",
                                          "brain1 section3",
                                          "brain1 section4",
                                          "brain1 section3",
                                          "brain1 section4",
                                          "brain1 section5",
                                          "brain2 section4")) %>%
  separate("brain_section", into = c("brain", "section"), sep = " ") %>%
  unite("combo", "iue_date", "iue_age", "construct", "brain", remove = F)

# incoporate metadata
data_final <- dist_meta %>%
  left_join(dist_data, by = "file") %>%
  mutate(total_intensity = mean * thresholdArea) %>%
  replace(is.na(.), 0)

# summarize metadata
metadata_sum <- dist_meta %>%
  distinct(construct, iue_age, brain) %>%
  group_by(construct, iue_age) %>%
  summarize(number_brains = n())
print(metadata_sum)


## ----distAnalysis---------------------------------------------------------------------------------------------------------
# calculating measurement sums for each section
dist_sums <- data_final %>%
  
  # restrict to less than 401 boxes
  filter(box < 401) %>%
  group_by(file, color) %>%
  summarize(total_mean = sum(mean),
            total_totalIntensity = sum(total_intensity),
            total_threshFraction = sum(thresholdFraction),
            total_threshNumber = sum(thresholdNumber))

# calculating measurement percentages for each section
dist_percents <- data_final %>%
  
  # restrict to less than 401 boxes
  filter(box < 401) %>%
  left_join(dist_sums, by = c("file", "color")) %>%
  mutate(percent_mean = mean / total_mean * 100,
         percent_totalIntensity = total_intensity / total_totalIntensity * 100,
         percent_fraction = thresholdFraction / total_threshFraction * 100,
         percent_number = thresholdNumber / total_threshNumber * 100)

# calculating red - green measurement percentages for each section
dist_subtract <- dist_percents %>%
  distinct(file, combo, iue_date, iue_age, construct, brain, section, color, box,
           distance_pixels, distance_microns, height_microns, 
           percent_mean, percent_totalIntensity, percent_fraction, percent_number) %>%
  pivot_wider(names_from = "color", values_from = c("percent_mean",
                                                    "percent_totalIntensity",
                                                    "percent_fraction", 
                                                    "percent_number")) %>%
  mutate(diff_mean = percent_mean_red - percent_mean_green,
         ratio_mean = percent_mean_red / percent_mean_green,
         diff_totalIntensity = percent_totalIntensity_red - percent_totalIntensity_green,
         ratio_totalIntensity = percent_totalIntensity_red / percent_totalIntensity_green,
         diff_fraction = percent_fraction_red - percent_fraction_green,
         ratio_fraction = percent_fraction_red / percent_fraction_green,
         diff_number = percent_number_red - percent_number_green,
         ratio_number = percent_number_red / percent_number_green)

# plotting difference between number of red and green pixels above threshold after normalization
fig_2e <- ggplot(dist_subtract %>%
                            mutate(construct = case_when(construct == "pDT009" ~ "mScarlet",
                                                         construct == "pDT010A" ~ "gapPal-mScarlet",
                                                         construct == "pDT010D" ~ "mScarlet-cAPP"),
                                   construct = fct_relevel(as.factor(construct), 
                                                           "mScarlet", 
                                                           "gapPal-mScarlet", 
                                                           "mScarlet-cAPP")), 
       aes(x = box, y = diff_number)) +
  stat_smooth(se = T, level = 0.95, method = "loess", formula = "y ~ x",
              
              # can play with span setting for different smoothness
              span = 0.75, linewidth = 0.25,
              aes(group = construct, color = construct, fill = construct)) +
  theme_classic(base_size = 10) +
  scale_fill_manual(values = c("#56B4E9", "#D55E00", "#E69F00")) +
  scale_color_manual(values = c("#56B4E9", "#D55E00", "#E69F00")) +
  theme(axis.text.x = element_text(color = "black"),
        axis.text.y = element_text(color = "black"),
        axis.ticks = element_line(color = "black"),
        legend.position = "inside",
        legend.position.inside = c(0.8, 0.2)) +
  labs(x = "Distance From Somata (bins)", color = "", fill = "",
       y = "Red - Green"); fig_2e
ggsave("fig_2e.pdf", fig_2e, units = "in",
       width = 6.77, height = 1.43)


## ----sessionInfo----------------------------------------------------------------------------------------------------------
sessionInfo()

