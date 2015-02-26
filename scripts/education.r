## Test for parsing YAML

library(yaml)

## Load the talks
talks <- yaml.load_file("../content/education.yaml")[[1]]

## Sort by year order
ord <- order(unlist(lapply(talks, function(x) x$year)))
talks <- talks[ord]

lines <- lapply(talks, function(x) {

    post <- ""
    
    if ("thesis" %in% names(x)) 
        post <- paste0(post, sprintf("\\emph{%s}", x$thesis))
    

    if ("award" %in% names (x)) 
        post <- paste0(post, sprintf("%s", x$award))
    
    if (nchar(post)>0) post <- paste0(post, ".")
    
    with(x, sprintf("\\ind %d. %s, %s. %s\n", year, degree, university, post))
})

out.file <- "../templates/education.tex"
if (file.exists(out.file)) file.remove(out.file)
invisible(lapply(lines, write, file=out.file, append=TRUE))
