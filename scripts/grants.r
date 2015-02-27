#' Process the grants

source("yaml.r")

process_grants <- function(l) {
    tmp <- l[[1]]

    ## Sort by year order
    ord <- order(unlist(lapply(tmp, function(x) x$start)))
    tmp <- tmp[ord]

    lines <- lapply(tmp, function(x) {
        if (x$start==x$end) {
            with(x, sprintf("\\ind %s. %s, %s. %s (%s).\n",
                            start, title, funder, role, value))
        } else {
            with(x, sprintf("\\ind %s--%s. %s, %s. %s (%s).\n",
                            start, end, title, funder, role, value))
        }
    })
    return(lines)
}


process_awards <- function(l) {
    tmp <- l[[2]]

    ## Sort by year order
    ord <- order(unlist(lapply(tmp, function(x) x$start)))
    tmp <- tmp[ord]

    lines <- lapply(tmp, function(x) {
        if (x$start==x$end) {
            with(x, sprintf("\\ind %s. %s, %s.\n",
                            start, title, other))
        } else {
            with(x, sprintf("\\ind %s--%s. %s, %s.\n",
                            start, end, title, other))
        }
    })

    return(lines)
}


process_yaml("../content/grants.yaml",
             "../templates/grants.tex", process_grants)
process_yaml("../content/grants.yaml",
             "../templates/awards.tex", process_awards)
