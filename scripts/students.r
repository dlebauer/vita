## Test for parsing YAML

library(yaml)

## Load the talks
talks <- yaml.load_file("../content/students.yaml")[[1]]

## Sort by year order
ord <- order(unlist(lapply(talks, function(x) x$start)))
talks <- talks[ord]

lines <- lapply(talks, function(x) {
    with(x, sprintf("\\ind %d--%s.  %s, \\emph{%s}.\n", start, end, name, title))
})

out.file <- "../templates/students.tex"
if (file.exists(out.file)) file.remove(out.file)
invisible(lapply(lines, write, file=out.file, append=TRUE))
