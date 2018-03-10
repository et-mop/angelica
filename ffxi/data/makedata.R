#CSVファイルから、テーブルを読み込む
#基本的には、RDSファイルにして保存。
#初期化などでは、RDSファイルを使う。CSVが書き換わったときに実行する必要あり
#++++++++++++++++++++

#合成カテゴリ
SynthCat <- read.csv("C:/Statistics/angelica/ffxi/data/SynthCat.csv", 
                     header=FALSE, stringsAsFactors=FALSE, encoding = "CP932")
names(SynthCat) <- c("id", "jlabel", "elabel")
jl <- SynthCat$jlabel
el <- SynthCat$elabel
SynthCat$jlabel <- factor(SynthCat$jlabel, 
                         levels = jl)
SynthCat$elabel <- factor(SynthCat$elabel,
                         levels = el)
saveRDS(SynthCat, file = paste(getwd(), "ffxi/data/SynthCat.rds", sep='/'))


#Synth Rank
SynthRank <- read.csv("C:/Statistics/angelica/ffxi/data/SynthRank.csv", 
                     header=FALSE, stringsAsFactors=FALSE, encoding = "CP932")
names(SynthRank) <- c("id", "jlabel", "lower", "upper", "elabel")
SynthRank$jlabel <- factor(SynthRank$jlabel,
                          levels = SynthRank$jlabel)
SynthRank$elabel <- factor(SynthRank$elabel,
                          levels = SynthRank$elabel)
saveRDS(SynthRank, file=paste(getwd(), "ffxi/data/SynthRank.rds", sep = '/'))

#Synth skill gap
SynthGap <-  read.csv("C:/Statistics/angelica/ffxi/data/SkillGap.csv", 
                      header=TRUE, stringsAsFactors=FALSE, encoding = "CP932")
SynthGap$jlabel <- factor(SynthGap$jlabel,
                          levels = SynthGap$jlabel)
saveRDS(SynthRank, file=paste(getwd(), "ffxi/data/SkillGap.rds", sep = '/'))


#HQ prob
HQProb <-  read.csv("C:/Statistics/angelica/ffxi/data/HQProb.csv", 
                      header=TRUE, stringsAsFactors=FALSE, encoding = "CP932")
HQProb$jlabel <- factor(HQProb$jlabel,
                        levels = HQProb$jlabel)
HQProb$elabel <- factor(HQProb$elabel,
                        levels = HQProb$elabel)
HQProb$skillDiff <- factor(HQProb$skillDiff,
                           levels = HQProb$skillDiff)
saveRDS(HQProb, file=paste(getwd(), "ffxi/data/HQProb.rds", sep = '/'))



#