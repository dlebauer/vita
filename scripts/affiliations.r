#' Process the affiliations

source("yaml.r")
source("tex_functions.r")

process_yaml("../content/affiliations.yaml", 
             "../templates/affiliations.tex",
             format_affiliations)
