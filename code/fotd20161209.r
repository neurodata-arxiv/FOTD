#!/usr/local/bin/Rscript

require(meda)

Syn <- fread('~/neurodata/synaptome-stats/data/synapsinR_7thA.tif.Pivots.txt.2011Features.txt')
Ex10R55 <- fread('~/neurodata/synaptome-stats/Code/Notebooks/Ex10R55_Synapsin1_2_vecs.csv')


SynF0 <- data.frame(Syn[, V1])
ExF0 <- apply(Ex10R55,1, sum)

ExF0 <- data.frame(ExF0)

p1 <- 
ggplot(ExF0, aes(y = ..density..)) + 
  geom_density(aes(x = ExF0, color='red'), ) + 
  geom_density(data = SynF0,aes(x=SynF0, color = 'blue') ) + 
  xlab("F0: sum of intensities in 11x11x11 cube") + 
  ggtitle("FOTD 20161209: KDE comparison between kristina15:synapsin:F0 and Ex10R55:synapsin:F0") + 
  scale_color_discrete(name="Dataset",
                       labels=c("kristina15_Syn1_F0",
                                "Ex10R55_Syn1_F0"))

pdf("fotd20161209.pdf", w=7,h=7)
print(p1)
dev.off()

png("fotd20161209.pdf", w=720,h=480)
print(p1)
dev.off()

