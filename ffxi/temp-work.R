library(readxl)
cae_cook <- read_excel("ffxi/data/2018-03-09_FFXISynth.xlsx", sheet = "Cooking")
cae_cook

library(dplyr)
ttt <-
cae_cook %>%
    rename(count='回数', result='成功', skill.up='アップ', skill.disp='スキル表示',
           lost='ロスト', rank='階級', target='合成物', skill.cap='スキルキャップ',
           support='サポート') %>%
  filter(., is.na(support)) %>%
  select(-lost, -rank, -support)

library(ggplot2)

head(ttt)

ggplot(ttt, aes(x=count, y=Skill)) +
  geom_line()

ggplot(ttt, aes(x=Gap, y=Skill)) +
  geom_line()


getGapRange <- function(gp){
  ifelse(gp < -27, 1, 
         ifelse(gp >=-27 & gp < -10, 2, 
            ifelse(gp >= -10 & gp < -5, 3, 
              ifelse(gp >= -5 & gp < -3, 4,
                ifelse(gp >= -3 & gp < -2, 5,
                  ifelse(gp >= -2 & gp < 0, 6, 
                    ifelse(gp ==0, 7, 
                      ifelse(gp >0 & gp < 11, 8,
                        ifelse(gp >= 11 & gp < 31, 9, 
                          ifelse(gp >= 31 & gp < 51, 10, 11))))))))))
}

getGapRange(ttt$Gap)

ttt %>%
  mutate(gr = as.factor(getGapRange(Gap)))
