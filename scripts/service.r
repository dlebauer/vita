## Test for parsing YAML
source("yaml.r")
library(stringr)

f <- function(l) {

    tmp <- l[[1]]

    ## First process the committees etc
    ## Sort by year order
    ord <- order(unlist(lapply(tmp, function(x) x$start)))
    comms <- tmp[ord]

    comm.lines <- lapply(comms, function(x) {
        if ("end" %in% names(x)) {
            with(x, sprintf("\\ind %d--%s.  %s, %s.\n", start, end, role, entity))
        } else {
            with(x, sprintf("\\ind %d.  %s, %s.\n", start, role, entity))
        }
    })

    ## Then grant reviews
    grants <- paste0("\\ind Research proposal reviewer for ",
                     paste0(l[[2]], collapse=", "), "\n")

    ## Then journal reviews
    journals <- paste0("\\ind Journal reviewer for ",
                       paste0(paste("\\emph{", l[[3]], "}", sep=""), collapse=", "), "\n")

    journals <- str_replace(journals, "&", "\\\\&")

    ## Then consultancy
    consultancy <- paste0("\\ind Independent consultancy for ",
                          paste0(l[[4]], collapse=", "), "\n")

    lines <- c(comm.lines, grants, journals, consultancy)
    return(lines)
}

process_yaml("../content/service.yaml",
             "../templates/service.tex", f)
