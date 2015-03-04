#' Load the required libraries
library(yaml)
library(stringr)
library(tools)
vc_dir <- "../style"

#' Processes a specified YAML file to create outputs
#'
#' @param section a character giving the name of the section to
#' process.  There must be a corresponding \code{section.yaml} file in
#' the input directory and \code{format_section} function in the
#' formats file.  The function should take a YAML parsed list as input
#' and returned a list of lines in the correct format.
#' @param input_dir the input directory (no trailing /)
#' @param output_dir the output directory (no trailing /)
#' @param format a character giving a file name of the format
#' \code{format_functions.r}.  The default is "tex"
#' 
#' @return NULL
process_yaml <- function(section, input_dir="../content", output_dir="output", format="tex") {

    input <- file.path(input_dir, paste0(section, ".yaml"))
    output <- file.path(output_dir, paste0(section, ".", format))
    source(paste0(format, "_functions.r"))
    
    if (!file.exists(input)) stop(sprintf("Unable to find input file '%s'", input))

    data <- yaml.load_file(input)

    f <- paste0("format_", section)
    lines <- eval(call(f, data))

    if (file.exists(output)) file.remove(output)
    invisible(lapply(lines, write, file=output, append=TRUE))

}
    



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

#' Formats the address for printing
#'
#' @param address a list of address lines.
#' @return a character including lines breaks for TeX
format_address <- function(address) {
    top_lines <- paste0(address[1:3], collapse="\\\\")
    postcode <- sprintf("\\vspace{-0.04in}\\addfontfeature{Numbers={Proportional, Lining}}%s", address$postcode)
    paste0(c(top_lines, postcode), collapse="\\\\")
}

#' Generates a CV from given content and style files
#'
#' @param content a character giving the name of the YAML file
#' containing the vita content
#'
#' @param style a character giving the name of the style file.  
#'
#' @return NULL
generate_cv <- function(content, style, outdir="output") {

    ## Prepare the output directory
    if (!file.exists(outdir)) dir.create(outdir)

    fmt <- "tex"
    
    if (!file.exists(content))
        stop(sprintf("Unable to find content file '%s'", content))

    message("Processing YAML files...", appendLF=FALSE)
    config <- yaml.load_file(content)

    ## Start with the document header    
    header <- with(config, c(
        sprintf("\\title{%s}", person$title),
        sprintf("\\name{%s %s}", person$first_name, person$last_name),
        sprintf("\\postnoms{%s}", person$postnoms),
        sprintf("\\address{%s}", format_address(person$address)),
        sprintf("\\www{%s}", person$web),
        sprintf("\\email{%s}", person$email),
        sprintf("\\tel{%s}", person$tel),
        sprintf("\\subject{%s}", person$subject)))
    header <- sanitize(header)

    ## Then add the bibliography stuff
    bibinfo <- with(config$publications, c(
        sprintf("\\bibliography{%s}", file_path_sans_ext(bib_file)),
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
            file_root <- file_path_sans_ext(x$file)

            ## Process the YAML file
            invisible(process_yaml(file_root, format=fmt, output_dir=outdir))

            ## Return the lines
            c(sprintf("\\section*{%s}", x$title),
              sprintf("\\input{%s}", file_root),
              "")

        }
    }))

    ## Build the entire document
    lines <- c("\\documentclass[11pt, a4paper]{article}",
               "",
               sprintf("\\usepackage{%s}", file_path_sans_ext(basename(style))),
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
    message("done")

    message(sprintf("Copying source files to '%s'...", outdir), appendLF=FALSE)
    ## Copy in the bib file and package
    style_file <- basename(style)
    file.copy(from=style, to=file.path(outdir, style_file))
    file.copy(from=file.path(dirname(content), config$publications$bib_file),
              to=file.path(outdir, basename(config$publications$bib_file)))

    ## Run the version control script and copy result to build directory
    cwd <- getwd()
    setwd(vc_dir)
    system2("./vc.sh")
    setwd(cwd)
    file.copy(from=file.path(vc_dir, "vc.tex"), to=file.path(outdir, "vc.tex"))
    
    ## Create the tex file in the right place
    outfile <- paste0(c(file_path_sans_ext(basename(content)), ".", fmt),
                      collapse="")
    outfile <- file.path(outdir, outfile)
    if (file.exists(outfile)) file.remove(outfile)
    invisible(lapply(lines, write, file=outfile, append=TRUE))
    message("done")
           
    ## Build the pdf
    message("Building the PDF...")
    commands <- c("xelatex", "biber", "xelatex", "xelatex")
    tex_file <- file_path_sans_ext(basename(content))
    setwd(outdir)
    codes <- unlist(lapply(commands, function(x) system2(x, args=tex_file, stdout=NULL)))
    if (all(codes==0)) {
        all_files <- list.files()
        all_files <- all_files[-grep("\\.pdf", all_files)]
        lapply(all_files, file.remove)
        message(sprintf("CV successfully built at '%s'",
                        file.path(outdir, paste0(tex_file, ".pdf"))))
        
    } else {
        warning(sprintf("Error building CV.  All source files left in '%s'", outdir))
    }
    setwd(cwd)
    
}
