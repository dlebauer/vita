source("yaml.r")
source("tex_functions.r")

var <- "affiliations"
process_yaml("../content/affiliations.yaml", 
             "../templates/affiliations.tex",
             paste0("format_", var))

process_yaml("../content/education.yaml",
             "../templates/education.tex",
             "format_education")

process_yaml("../content/grants.yaml",
             "../templates/grants.tex",
             "format_grants")

process_yaml("../content/grants.yaml",
             "../templates/awards.tex",
             "format_awards")

process_yaml("../content/posts.yaml",
             "../templates/posts.tex",
             "format_posts")

process_yaml("../content/service.yaml",
             "../templates/service.tex",
             "format_service")

process_yaml("../content/students.yaml",
             "../templates/students.tex",
             "format_students")

process_yaml("../content/talks.yaml",
             "../templates/talks.tex",
             "format_talks")

process_yaml("../content/teaching.yaml",
             "../templates/teaching.tex",
             "format_teaching")
