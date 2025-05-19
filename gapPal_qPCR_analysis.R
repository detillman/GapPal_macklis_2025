## ----setup, include=FALSE-------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(readxl)
library(ggpubr)
library(tidyverse)


## ----dataLoad-------------------------------------------------------------------------------------------------------------
data_all <- read_excel("gapPal_qPCR_summary.xlsx")


## ----consSort-------------------------------------------------------------------------------------------------------------
# loading constitutive data
data_cons <- data_all %>%
  filter(construct == "pDT012dc" | 
           construct == "pDT012dGc" | 
           construct == "pDT013dc" | 
           construct == "pDT013dGc") %>%
  filter(mmp24_kd != 1) %>%
  mutate(construct = fct_relevel(construct, "pDT012dc", "pDT013dc", 
                                 "pDT012dGc", "pDT013dGc"))

# plotting constitutive data
fig_4e <- ggplot(data_cons %>%
                      mutate(construct = case_when(construct == "pDT012dc" ~ 
                                                     "hfCas13d",
                                                   construct == "pDT013dc" ~ 
                                                     "GapPal-hfCas13d",
                                                   construct == "pDT012dGc" ~ 
                                                     "hfCas13d-eGFP",
                                                   construct == "pDT013dGc" ~ 
                                                     "GapPal-hfCas13d-eGFP")) %>%
                      mutate(construct = fct_relevel(construct, 
                                                     "hfCas13d",
                                                     "hfCas13d-eGFP",
                                                     "GapPal-hfCas13d",
                                                     "GapPal-hfCas13d-eGFP")) %>%
                               mutate(construct_alpha = case_when(construct == "hfCas13d" ~ "dark",
                                                                  construct == "GapPal-hfCas13d" ~ "dark",
                                                                  construct == "hfCas13d-eGFP" ~ "light",
                                                                  construct == "GapPal-hfCas13d-eGFP" ~ "light"),
                                      construct_fill = case_when(construct == "hfCas13d" ~ "cas",
                                                                  construct == "GapPal-hfCas13d" ~ "axon",
                                                                  construct == "hfCas13d-eGFP" ~ "cas",
                                                                  construct == "GapPal-hfCas13d-eGFP" ~ "axon")), 
                    aes(x = construct, y = mmp24_kd * 100, 
                        fill = construct_fill, 
                        alpha = construct_alpha)) +
  scale_alpha_manual(values = c(1, 0.5)) +
  geom_boxplot(color = "black", linewidth = 0.25) + 
  theme_classic(base_size = 10) +
  labs(y = "KD Efficiency %", x = "") +
  scale_fill_manual(values = c("#56B4E9", "#D55E00")) +
  theme(axis.text.x = element_text(color = "black",
                                   angle = 90, vjust = 0.5, hjust=1),
        axis.text.y = element_text(color = "black"),
        axis.title.x = element_blank(),
        axis.ticks = element_line(color = "black"),
        legend.position = "none"); fig_4e
ggsave("fig_4e.pdf", plot = fig_4e, units = "in",
       height = 2.36, width = 3.36)


## ----sessionInfo----------------------------------------------------------------------------------------------------------
sessionInfo()

