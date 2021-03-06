% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extractCached.R
\name{extractCached}
\alias{extractCached}
\title{Extract cached objects}
\usage{
extractCached(
  prefix,
  chunk,
  objects,
  flexible = TRUE,
  envir = topenv(parent.frame())
)
}
\arguments{
\item{prefix}{String containing the prefix of the Rmarkdown file.}

\item{chunk}{String containing the name of the requested chunk.}

\item{objects}{Character vector containing variable names for one or more objects to be extracted.}

\item{flexible}{Logical scalar indicating a flexible search for the Rmarkdown file should be performed.}

\item{envir}{Environment where the loaded objects should be stored.}
}
\value{
Variables with names \code{objects} are created in the global environment.
An markdown chunk (wrapped in a collapsible element) is printed that contains all commands needed to generate those objects, 
based on the code in the named chunks of the Rmarkdown file.
}
\description{
Extract specific R objects from the knitr cache of a previously compiled Rmarkdown file.
}
\details{
Each object is extracted in its state at the requested chunk at \code{chunk}.
Note that the object does not have to be generated or even referenced in \code{chunk},
provided it was generated in a previous chunk.

The Rmarkdown file is also subject to several constraints:
\itemize{
\item All chunks that might be referenced by the \code{chunk} argument are named.
\item All named chunks are executed, i.e., no \code{eval=FALSE}.
\item All relevant code occurs within triple backticks, i.e., any inline code should be read-only.
\item All triple backticks occur at the start of the line, i.e., no code nested in list elements.
\item The report with prefix \code{prefix} has already been compiled with \code{cache=TRUE}.
\item Any assignment or modifications to variables are done \emph{correctly} with \code{<-}.
}

Unnamed chunks are allowed but cannot be referenced and will not be shown in the output of this function.
This should not be used for code that might affect variables in the named chunks,
i.e., code in unnamed chunks should be \dQuote{read-only} with respect to variables in the named chunks.

Chunks with names starting with \code{unref-} are considered to be the same as unnamed chunks and will not be referenced.
}
\section{Flexible search}{

The function will first attempt to find a Rmarkdown file with name \code{<prefix>.Rmd} relative to the working directory.
This is used in situations where one workflow depends on another in the \code{workflows/} directory.

If this fails and \code{flexible=TRUE}, the function will then search in \code{../workflows/<prefix>},
under the assumption that it is being called from a file in \code{analysis/}.

If this also fails, the function will then search for a file in the current working directory that ends with \code{<prefix>.Rmd} and follows the same naming scheme as a \pkg{bookdown} chapters.
This is relevant for the final compilation of the book.

If the discovered file does not have a cache, 
\code{extractCached} will compile it (and thus generate the cache) using \code{\link{compileWorkflows}}.
}

\seealso{
\code{\link{setupHTML}} and \code{\link{chapterPreamble}}, to set up the code for the collapsible element.
}
\author{
Aaron Lun
}
