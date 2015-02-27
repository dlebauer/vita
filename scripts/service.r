## Test for parsing YAML
source("yaml.r")
source("tex_functions.r")


process_yaml("../content/service.yaml",
             "../templates/service.tex",
             format_service)
