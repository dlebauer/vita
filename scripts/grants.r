## Test for parsing YAML

library(yaml)

## Load the talks
data <- yaml.load_file("../content/grants.yaml")[[1]]

## Sort by year order
ord <- order(unlist(lapply(data, function(x) x$start)))
data <- data[ord]

lines <- lapply(data, function(x) {
    if (x$start==x$end) {
        with(x, sprintf("\\ind %s. %s, %s. %s (%s).\n",
                        start, title, funder, role, value))
    } else {
        with(x, sprintf("\\ind %s--%s. %s, %s. %s (%s).\n",
                        start, end, title, funder, role, value))
    }
})

out.file <- "../templates/grants.tex"
if (file.exists(out.file)) file.remove(out.file)
invisible(lapply(lines, write, file=out.file, append=TRUE))

## Load the talks
data <- yaml.load_file("../content/grants.yaml")[[2]]

## Sort by year order
ord <- order(unlist(lapply(data, function(x) x$start)))
data <- data[ord]

lines <- lapply(data, function(x) {
    if (x$start==x$end) {
        with(x, sprintf("\\ind %s. %s, %s.\n",
                        start, title, other))
    } else {
        with(x, sprintf("\\ind %s--%s. %s, %s.\n",
                        start, end, title, other))
    }
})

out.file <- "../templates/awards.tex"
if (file.exists(out.file)) file.remove(out.file)
invisible(lapply(lines, write, file=out.file, append=TRUE))
