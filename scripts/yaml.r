#' Functions for parsing YAML files
#' 
library(yaml)

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
#' \code{format_functions.r}
#' 
#' @return NULL
process_yaml <- function(section, input_dir="../content", output_dir="../templates", format) {

    input <- file.path(input_dir, paste0(section, ".yaml"))
    output <- file.path(output_dir, paste0(section, ".", format))
    source(paste0(format, "_functions.r"))
    
    if (!file.exists(input)) stop(sprintf("Unable to find input file '%s'", input))

    message(sprintf("Processing '%s'...", input), appendLF=FALSE)
    
    data <- yaml.load_file(input)

    f <- paste0("format_", section)
    lines <- eval(call(f, data))

    if (file.exists(output)) file.remove(output)
    invisible(lapply(lines, write, file=output, append=TRUE))
    message("done")
    
}
    
