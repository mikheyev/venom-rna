## Load library
library(WGCNA)
library(dplyr)
library(flashClust)
options(stringsAsFactors = FALSE)

datOld <- readRDS("./datExprVenom.rds")
datNew<-readRDS("./datNew.rds")
tpmKeep<-readRDS("./tpmKeep.rds")
gsg<-goodSamplesGenes(datOld, verbose = 3)
gsg$allOK #if returns TRUE, all genes have passed the cut. If not, remove the offending genes and samples from the data.

gsg<-goodSamplesGenes(datNew, verbose = 3)
gsg$allOK #if returns TRUE, all genes have passed the cut. If not, remove the offending genes and samples from the data.

#No longer needed
#dynamicMods.new<-readRDS("./dynamicMods.New")

#dynamicColours.new <- labels2colors(dynamicMods.new)
#table(dynamicColours.new)

setLabels = c("old", "new");
multiExpr = list(old = list(data = datOld), new = list(data = datNew));
multiColor = list(old = tpmKeep$colors);

allowWGCNAThreads(4)
mp = modulePreservation(multiExpr, multiColor,
referenceNetworks = 1,
nPermutations = 200,
randomSeed = 1,
verbose = 3)

saveRDS(mp,"./modulepres_old_v_new2.RDS")
