#' Process the affiliations

source("yaml.r")

f <- function(l) {
    tmp <- l[[1]]

    
    ## Sort by year order
    ord <- order(unlist(lapply(tmp, function(x) x$start)))
    tmp <- tmp[ord]

    lines <- lapply(tmp, function(x) {
        with(x, sprintf("\\ind %d--%s.  %s, \\emph{%s}.\n", start, end, status, org))
    })
    return(lines)
}

process_yaml("../content/affiliations.yaml", 
             "../templates/affiliations.tex", f)
