## ----setup, include=FALSE-------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(readxl)
library(ggpubr)
library(tidyverse)


## ----dataLoad-------------------------------------------------------------------------------------------------------------
# loading data
data_all <- read_excel("gapPal_sorting_summary.xlsx")


## ----gc-------------------------------------------------------------------------------------------------------------------
# loading gc data
data_gc <- data_all %>%
  filter(compartment == "gc") %>%
  mutate(construct = case_when(construct == "pDT009" ~ "mScarlet",
                               construct == "pDT010A" ~ "GapPal-mScarlet"),
         construct = fct_relevel(construct, "mScarlet", "GapPal-mScarlet"))

# plotting gc data
fig_3b <- ggplot(data_gc, aes(x = construct, y = percent_red,
                                            fill = construct)) +
  geom_boxplot(linewidth = 0.25, color = "black") + 
  theme_classic(base_size = 10) +
  scale_fill_manual(values = c("#56B4E9", "#D55E00")) +
    stat_compare_means(comparisons = list(c("mScarlet", "GapPal-mScarlet")),
                     label = "p.format", size = 1, linewdith = 0.25) +
  labs(y = "mScarlet GC %", x = "") +
  theme(axis.text.x = element_text(color = "black"),
        axis.text.y = element_text(color = "black"),
        axis.title.x = element_blank(),
        axis.ticks = element_line(color = "black"),
        legend.position = "none"); fig_3b
ggsave("fig_3b.pdf", plot = fig_3b, units = "in",
       height = 2.06, width = 2.08)


## ----soma-----------------------------------------------------------------------------------------------------------------
# loading soma data
data_soma <- data_all %>%
  filter(compartment == "soma") %>%
  mutate(construct = case_when(construct == "pDT009" ~ "mScarlet",
                               construct == "pDT010A" ~ "GapPal-mScarlet"),
         construct = fct_relevel(construct, "mScarlet", "GapPal-mScarlet"))

fig_3a <- ggplot(data_soma, aes(x = construct, y = percent_red,
                                            fill = construct)) +
  geom_boxplot(linewidth = 0.25, color = "black") + 
  theme_classic(base_size = 10) +
  scale_fill_manual(values = c("#56B4E9", "#D55E00")) +
  labs(y = "mScarlet Soma %", x = "") +
  stat_compare_means(comparisons = list(c("mScarlet", "GapPal-mScarlet")),
                     label = "p.format", size = 1, linewdith = 0.25) +
  theme(axis.text.x = element_text(color = "black"),
        axis.text.y = element_text(color = "black"),
        axis.title.x = element_blank(),
        axis.ticks = element_line(color = "black"),
        legend.position = "none"); fig_3a
ggsave("fig_3a.pdf", plot = fig_3a, units = "in",
       height = 2.06, width = 2.08)


## ----sessionInfo----------------------------------------------------------------------------------------------------------
sessionInfo()

