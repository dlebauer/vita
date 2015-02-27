#' Process the students
source("yaml.r")
source("tex_functions.r")

process_yaml("../content/students.yaml",
             "../templates/students.tex",
             format_students)
