section <- "teaching"
#library(vita)
load_all("~/dev/vita")
debugonce(process_yaml)
process_yaml(section, input_dir = "../inst/content/", output_dir = tempdir())
