#' Process the education files
source("yaml.r")
source("tex_functions.r")


process_yaml("../content/education.yaml",
             "../templates/education.tex",
             format_education)
