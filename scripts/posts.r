#' Process the posts
source("yaml.r")

f <- function(l) {
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

process_yaml("../content/posts.yaml",
             "../templates/posts.tex", f)
