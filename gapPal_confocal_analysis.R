## ----setup, include=FALSE-------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(readxl)
library(ggpubr)
library(tidyverse)


## ----somaLoad-------------------------------------------------------------------------------------------------------------
# loading soma data
data_soma <- read_excel("gapPal_confocal_intensities.xlsx",
                        sheet = "Soma") %>%
  separate(Sample, into = c("Construct", "Brain", "Section", "Cell")) %>%
  mutate(Construct = case_when(Construct == "CasRx" ~ "hfCas13d-eGFP",
                               Construct == "AxonCasRx" ~ "GapPal-hfCas13d-eGFP"),
         Construct = fct_relevel(Construct, "hfCas13d-eGFP", "GapPal-hfCas13d-eGFP"))

# plotting soma data
fig_4c <- ggplot(data_soma, aes(x = Construct, y = Mean,
                                fill = Construct)) +
  geom_boxplot(show.legend = F, outlier.color = "black", outlier.size = 0.001,
               color = "black", linewidth = 0.25) +
  theme_classic(base_size = 10) +
  #scale_y_continuous(trans = "log10") +
  scale_fill_manual(values = c("#56B4E9", "#D55E00")) +
  labs(y = "Soma eGFP", x = "") +
  stat_compare_means(comparisons = list(c("hfCas13d-eGFP", "GapPal-hfCas13d-eGFP")),
                     label = "p.format", size = 1, linewdith = 0.25) +
  theme(axis.text.x = element_text(color = "black", 
                                   angle = 90, vjust = 0.5, hjust=1),
        axis.text.y = element_text(color = "black"),
        axis.title.x = element_blank(),
        axis.ticks = element_line(color = "black"),
        legend.position = "none"); fig_4c
ggsave("fig_4c.pdf", plot = fig_4c, units = "in",
       height = 2.36, width = 1.65)


## ----gcLoad---------------------------------------------------------------------------------------------------------------
# loading gc data
data_gc <- read_excel("gapPal_confocal_intensities.xlsx",
                        sheet = "GC") %>%
  separate(Sample, into = c("Construct", "Brain", "Section", "Drop", "Particle")) %>%
  mutate(Construct = case_when(Construct == "CasRx" ~ "hfCas13d-eGFP",
                               Construct == "Axon" ~ "GapPal-hfCas13d-eGFP"),
         Construct = fct_relevel(Construct, "hfCas13d-eGFP", "GapPal-hfCas13d-eGFP"))

# plotting gc data
fig_4d <- ggplot(data_gc, aes(x = Construct, y = Mean,
                                            fill = Construct)) +
  geom_boxplot(show.legend = F, outlier.color = "black", outlier.size = 0.001,
               color = "black", linewidth = 0.25) +
  theme_classic(base_size = 10) +
  #scale_y_continuous(trans = "log10") +
  scale_fill_manual(values = c("#56B4E9", "#D55E00")) +
  labs(y = "GC eGFP", x = "") +
  stat_compare_means(comparisons = list(c("hfCas13d-eGFP", "GapPal-hfCas13d-eGFP")),
                     label = "p.format", size = 1, linewdith = 0.25) +
  theme(axis.text.x = element_text(color = "black", 
                                   angle = 90, vjust = 0.5, hjust=1),
        axis.text.y = element_text(color = "black"),
        axis.title.x = element_blank(),
        axis.ticks = element_line(color = "black"),
        legend.position = "none"); fig_4d
ggsave("fig_4d.pdf", plot = fig_4d, units = "in",
       height = 2.36, width = 1.65)


## ----sessionInfo----------------------------------------------------------------------------------------------------------
sessionInfo()

