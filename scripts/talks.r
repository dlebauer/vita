## Test for parsing YAML

library(yaml)

## Load the talks
talks <- yaml.load_file("../content/talks.yaml")[[1]]

## Sort by year order
ord <- order(unlist(lapply(talks, function(x) x$year)))
talks <- talks[ord]

lines <- lapply(talks, function(x) {
    with(x, sprintf("\\ind %d ``%s''. %s, %s. %s.\n", year, title, event, city, month))
})

out.file <- "../templates/talks.tex"
if (file.exists(out.file)) file.remove(out.file)
invisible(lapply(lines, write, file=out.file, append=TRUE))
