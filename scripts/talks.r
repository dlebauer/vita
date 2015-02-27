#' Process the talks

source("yaml.r")

f <- function(l) {
    tmp <- l[[1]]

    ## Sort by year order
    ord <- order(unlist(lapply(tmp, function(x) x$year)))
    tmp <- tmp[ord]
    
    lines <- lapply(tmp, function(x) {
        with(x, sprintf("\\ind %d ``%s''. %s, %s. %s.\n", year, title, event, city, month))
    })
    return(lines)
}

process_yaml("../content/talks.yaml",
             "../templates/talks.tex", f)
