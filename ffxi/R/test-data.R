Cae_cook <- read_csv("ffxi/data/Cae-cook.csv", locale = locale(encoding = "SHIFT-JIS"), skip = 3)
Cae_leather <- read_csv("ffxi/data/Cae-leather.csv", locale = locale(encoding = "SHIFT-JIS"), skip = 2)
Prim_leather <- read_csv("ffxi/data/Prim-leather.csv", locale = locale(encoding = "SHIFT-JIS"), skip = 4)

library(dplyr)

names(Cae_cook) <- c("count", "result", "skill.up", "skill", "HQ", "lost", "rank", "target",
                     "target.cap", "support", "skill.gap")

names(Cae_leather) <- c("count", "result", "skill.up", "skill", "HQ", "lost", "rank", "target",
                    "target.cap", "support")

names(Prim_leather) <-c("count", "result", "skill.up", "skill", "HQ", "lost", "rank", "target",
                     "target.cap", "skill.gap")
Cae_cook %>%
  filter(.,is.na(support)) %>%
  select(-support) %>%
  mutate(player='Caerae', Synth='Cooking') %>%
  saveRDS(., file='ffxi/data/caec.rds')

Cae_leather %>%
  filter(., is.na(support)) %>%
  select(-support) %>%
  mutate(skill.gap = skill-target.cap, player='Caerae', Synth='Leathercraft') %>%
  saveRDS(., file='ffxi/data/cael.rds')

  
Prim_leather %>%
  mutate(player='Primsynth', Synth='Leathercraft') %>%
  saveRDS(., file='ffxi/data/pril.rds')
