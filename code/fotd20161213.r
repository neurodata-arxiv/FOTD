
require(meda)
outf <- '~/Desktop/Ex10R55_resulVol1_MEDA.html'

dat1 <- fread('~/neurodata/synaptome-stats/Code/Notebooks/Ex10R55_Synapsin1_2_vecs.csv')

genHTML(dat1, outf, nmethod='cur', dmethod = 'cur')
