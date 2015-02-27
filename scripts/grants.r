#' Process the grants

source("yaml.r")
source("tex_functions.r")

process_yaml("../content/grants.yaml",
             "../templates/grants.tex", process_grants)
process_yaml("../content/grants.yaml",
             "../templates/awards.tex", process_awards)
