source("yaml.r")

sections <- c("affiliations",
              "education",
              "grants",
              "awards",
              "posts",
              "service",
              "students",
              "talks",
              "teaching")
invisible(lapply(sections, function(s) process_yaml(s, format="tex")))
