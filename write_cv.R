#!/usr/bin/env Rscript

devtools::load_all()
library(vita)
myCV.yaml <-  system.file("content/dlebauer-full-vita.yaml", package = "vita")
myCV.sty <- system.file("style/dl-vita.sty", package = "vita")
#debugonce(generate_cv)
generate_cv(content = myCV.yaml,
            style = myCV.sty,
            outdir = "outdir")
file.copy("outdir/dlebauer-full-vita.pdf", "dlebauer-full-vita.pdf", overwrite = TRUE)
