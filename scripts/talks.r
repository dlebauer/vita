#' Process the talks

source("yaml.r")
source("tex_functions.r")

process_yaml("../content/talks.yaml",
             "../templates/talks.tex",
             format_talks)
