#' Defines the functions for each section of the CV
#'
#' This file generates LaTeX formatted lines
library(stringr)

format_talks <- function(l) {
    tmp <- l[[1]]

    ## Sort by year order
    ord <- order(unlist(lapply(tmp, function(x) x$year)))
    tmp <- tmp[ord]
    
    lines <- lapply(tmp, function(x) {
        with(x, sprintf("\\ind %d ``%s''. %s, %s. %s.\n", year, title, event, city, month))
    })
    return(lines)
}

format_affiliations <- function(l) {
    tmp <- l[[1]]
    
    ## Sort by year order
    ord <- order(unlist(lapply(tmp, function(x) x$start)))
    tmp <- tmp[ord]

    lines <- lapply(tmp, function(x) {
        with(x, sprintf("\\ind %d--%s.  %s, \\emph{%s}.\n", start, end, status, org))
    })
    return(lines)
}

format_education <- function(l) {

    tmp <- l[[1]]

    ## Sort by year order
    ord <- order(unlist(lapply(tmp, function(x) x$year)))
    tmp <- tmp[ord]

    lines <- lapply(tmp, function(x) {

        post <- ""
        
        if ("thesis" %in% names(x)) 
            post <- paste0(post, sprintf("\\emph{%s}", x$thesis))
        
        
        if ("award" %in% names (x)) 
            post <- paste0(post, sprintf("%s", x$award))
        
        if (nchar(post)>0) post <- paste0(post, ".")
        
        with(x, sprintf("\\ind %d. %s, %s. %s\n", year, degree, university, post))
    })

    return(lines)
}

format_grants <- function(l) {
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


format_awards <- function(l) {
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


format_posts <- function(l) {
    tmp <- l[[1]]

    lines <- lapply(tmp, function(x) {
        topline <- sprintf("\\emph{%s}\n", x$employer)

        roles <- lapply(x$roles, function(x) {
            if ("end" %in% names(x)) {
                with(x, sprintf("\\ind %s--%s.  %s.\n", start, end, title))
            } else {
                with(x, sprintf("\\ind %s.  %s.\n", start, title))
            }
        })
        
        c(list(topline), roles, list("\\medskip\n"))
    })
    
    lines <- head(unlist(lines), -1)
    return(lines)
}



format_service <- function(l) {

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

format_students <- function(l) {
    tmp <- l[[1]]
    
    ## Sort by year order
    ord <- order(unlist(lapply(tmp, function(x) x$start)))
    tmp <- tmp[ord]

    lines <- lapply(tmp, function(x) {
        with(x, sprintf("\\ind %d--%s.  %s, \\emph{%s}.\n", start, end, name, title))
    })

    return(lines)
}

format_teaching <- function(l) {

    tmp <- l[[1]]
    
    ## Sort by year order
    ord <- order(unlist(lapply(tmp, function(x) x$start)))
    tmp <- tmp[ord]

    lines <- lapply(tmp, function(x) {
        with(x, sprintf("\\ind %d--%s.  %s.\n", start, end, title))
    })

    return(lines)
}

