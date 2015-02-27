#' Functions for parsing YAML files
#' 
library(yaml)

#' Processes a specified YAML file to create outputs
#'
#' @param input a character giving the YAML file
#' @param output a character giving the output file name
#' @param f a function describing how to parse the YAML file.  It
#' should take a list of YAML data and process appropriately,
#' returning a list of output lines
#'
#' @return NULL
process_yaml <- function(input, output, f) {

    if (!file.exists(input)) stop(sprintf("Unable to find input file '%s'", input))

    message(sprintf("Processing '%s'...", input), appendLF=FALSE)
    
    data <- yaml.load_file(input)

    lines <- f(data)

    if (file.exists(output)) file.remove(output)
    invisible(lapply(lines, write, file=output, append=TRUE))
    message("done")
    
}
    
