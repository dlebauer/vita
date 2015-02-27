#' Process the teaching

source("yaml.r")
source("tex_functions.r")

process_yaml("../content/teaching.yaml",
             "../templates/teaching.tex",
             format_teaching)
