library(lipidr)
library(ggplot2)

dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")
source("RIO.R")

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
    pfix = prefix()
  if (length(pfix) != 0) {
     pfix <<- paste(pfix, "/", sep="")
  }

}

run <- function() {}

output <- function(outputfile) {
	pdf(outputfile)
	d_summarized <- readRDS(paste(pfix, parameters["data", 2], sep="/"))
	measure <- parameters["measure", 2]
	d_normalized = normalize_pqn(d_summarized, measure = measure, exclude = "blank", log = TRUE)
plot_samples(d_normalized, "boxplot")
saveRDS(d_normalized, paste(outputfile, "rds", sep="."))
}

