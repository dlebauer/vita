files <- list.files(pattern="*.r")
ignore <- "build-content.r"
files <- files[-grep(ignore, files)]
lapply(files, source)
