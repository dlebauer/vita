# JK-Vita

This is an R project for automatically building [my academic CV](http://www.imperial.ac.uk/people/j.keirstead).  It's based on the idea that content and style should be separate and that a person might want different CVs for different purposes.  Inspiration came from [Kieran Healy](https://github.com/kjhealy/kjh-vita) for the formatting of the CV itself and [Rob Hyndman](http://robjhyndman.com/research/cv.sty) for the use of Biblatex to manage the publications list.

## Project layout

The project consists of:

 * a `content` directory that contains: YAML files for the overall CV
   configuration, YAML files to store the data for all of the
   non-publication parts of the CV, and a bibtex file that contains
   the publications.
   
 * a `style` directory that contains the overall LaTeX style, as well
   as scripts for inserting version control information
   
 * a `scripts` directory that contains R scripts for building the CV.
 
## How to build a CV

Creating a new CV is relatively simple.

1) Export all of your publications as a `*.bib` file 

2) Write all of the other sections of your CV, putting them in YAML files

3) Write an overall CV file in YAML.  There are a couple of gotchas to
   be careful of here.
     
   * In the `publications` section, each of the named sections must
     correspond to a declared biblatex section in the style file,
     e.g. `jk-vita.sty`.
	   
   * In the `sections` section, the file field should contain the
     name of a YAML file describing that section's content.  **There
     must be a corresponding `format_{section}` function in the
     `{style}_functions.r` file that specifies how to display the
     information.** For example, if you have a section file called
     `awards.yaml` and you wish to generate a `tex` output document,
     then the `tex_functions.r` file must contain a `format_awards`
     function.

4) Define a style file.  At the moment, only LaTeX formats are
   supported so modify the `jk-vita.sty` file as appropriate.  The
   most important lines in here have to do with the formatting of the
   publications using biblatex, but there are also settings for fonts,
   colours, and other details.
   
5) Build the CV.  This is easy.  Simply open up R, change into the
   `scripts` directory and run the following commands:

```r
> source("generate_cv.r")
> generate_cv("../path/to/my-cv.yaml", "../path/to/my-style.sty", "output_directory")
```	   

   The compiling process will build a PDF and place it in the
   specified output directory.  Compilation uses xelatex and biber so
   make sure these are installed on your system.  If the compilation
   if successful, then the source files will be deleted leaving only
   the finished PDF.  If unsuccessful, all of the source files are
   left so you can try to patch things up manually.
