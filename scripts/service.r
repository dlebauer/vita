## Test for parsing YAML

library(yaml)

## Load the data
data <- yaml.load_file("../content/service.yaml")

## First process the committees etc
## Sort by year order
ord <- order(unlist(lapply(data[[1]], function(x) x$start)))
comms <- data[[1]][ord]

comm.lines <- lapply(comms, function(x) {
    if ("end" %in% names(x)) {
        with(x, sprintf("\\ind %d--%s.  %s, %s.\n", start, end, role, entity))
    } else {
        with(x, sprintf("\\ind %d.  %s, %s.\n", start, role, entity))
    }
})

## Then grant reviews
grants <- paste0("\\ind Research proposal reviewer for ", paste0(data[[2]], collapse=", "), "\n")

## Then journal reviews
journals <- paste0("\\ind Journal reviewer for ",
                   paste0(paste("\\emph{", data[[3]], "}", sep=""), collapse=", "), "\n")
library(stringr)
journals <- str_replace(journals, "&", "\\\\&")

## Then consultancy
consultancy <- paste0("\\ind Independent consultancy for ", paste0(data[[4]], collapse=", "), "\n")

lines <- c(comm.lines, grants, journals, consultancy)
out.file <- "../templates/service.tex"
if (file.exists(out.file)) file.remove(out.file)
invisible(lapply(lines, write, file=out.file, append=TRUE))
