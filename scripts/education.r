#' Process the education files
source("yaml.r")

f <- function(l) {

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

process_yaml("../content/education.yaml",
             "../templates/education.tex", f)
