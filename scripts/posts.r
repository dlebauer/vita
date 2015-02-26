## Test for parsing YAML

library(yaml)

## Load the talks
talks <- yaml.load_file("../content/posts.yaml")[[1]]

lines <- lapply(talks, function(x) {
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

out.file <- "../templates/posts.tex"
if (file.exists(out.file)) file.remove(out.file)
invisible(lapply(lines, write, file=out.file, append=TRUE))
