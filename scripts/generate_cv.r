library(yaml)
library(stringr)

#' Creates a section break
#'
#' Creates a section break in LaTeX comments
#' @param name the name of the section
#' @param width the column width
#' @return a character of separate lines
section_break <- function(name, width=80) {
    c(paste0(c("% ", rep("-", width - 2)), collapse=""),
      sprintf("%% %s", name),
      paste0(c("% ", rep("-", width - 2)), collapse=""))
}

#' Tidies lines for LaTeX.  Currently only escapes ampersands
#' 
sanitize <- function(l) {
   str_replace(l, "\\&", "\\\\&")
}

#' Generates a CV from given content and style files
#'
#' @param content a character giving the name of the YAML file
#' containing the vita content
#'
#' @param style a character giving the name of the style file.  This
#' should not include the extension
#'
#' @param outfile name of the output file
#' 
#' @return NULL
generate_cv <- function(content, style, outfile) {

    if (!file.exists(content))
        stop(sprintf("Unable to find content file '%s'", content))

    config <- yaml.load_file(content)

    ## Start with the document header
    header <- with(config, c(
        sprintf("\\title{%s}", person$title),
        sprintf("\\name{%s %s}", person$first_name, person$last_name),
        sprintf("\\postnoms{%s}", person$postnoms),
        sprintf("\\address{%s}", paste0(unlist(person$address), collapse="\\\\")),
        sprintf("\\www{%s}", person$web),
        sprintf("\\email{%s}", person$email),
        sprintf("\\tel{%s}", person$tel),
        sprintf("\\subject{%s}", person$subject)))
    header <- sanitize(header)

    ## Then add the bibliography stuff
    bibinfo <- with(config$publications, c(
        sprintf("\\bibliography{%s}", bib_file),
        unlist(lapply(1:length(sections), function(i) {
            sprintf("\\addtocategory{%s}{%s}",
                    names(sections)[i],
                    paste0(sections[[i]], collapse=", "))
        }))))

    ## Then add the other sections
    sections <- unlist(lapply(config$sections, function(x) {
        if (x$file=="BIBTEX") {
            # INSERT Publications
            c("\\begin{publications}",
              lapply(names(config$publications$sections),
                     function(x) sprintf("\\printbib{%s}", x)),
              "\\end{publications}", "")
                     
        } else {
            # TODO process YAML file
            c(sprintf("\\section*{%s}", x$title),
              sprintf("\\input{%s}", str_sub(x$file, end=-6)),
              "")
        }
    }))

    ## Build the entire document
    lines <- c("\\documentclass[11pt, a4paper]{article}",
               "",
               sprintf("\\usepackage{%s}", style),
               "",
               section_break("Personal information"),
               header,
               "",
               section_break("Publications info"),
               bibinfo,
               "",
               "\\begin{document}",
               "\\maketitle",
               "",
               sections,
               "\\end{document}")

    if (file.exists(outfile)) file.remove(outfile)
    invisible(lapply(lines, write, file=outfile, append=TRUE))

}
