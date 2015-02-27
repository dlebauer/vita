#' Process the posts
source("yaml.r")
source("tex_functions.r")

process_yaml("../content/posts.yaml",
             "../templates/posts.tex",
             format_posts)
