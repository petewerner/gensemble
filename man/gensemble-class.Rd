\name{gensemble-class}
\Rdversion{1.1}
\docType{class}
\alias{gensemble-class}
\title{Class \code{"gensemble"}}
\description{
The gensemble class is returned by a call to \code{\link{gensemble}}. It should be passed to \code{\link{predict.gensemble}} for prediction.

Details on the slots are provided below, but in general it should be treated as an opaque data structure. 
}
\section{Slots}{
  \describe{
    \item{\code{abm}:}{The \code{AbstractModel-class} object used to build the model }
    \item{\code{dclass}:}{\code{logical} \code{TRUE} when classification was performed }
    \item{\code{nlev}:}{For classification, a \code{numeric} indicating how many levels were detected }
    \item{\code{ylevels}:}{For classification, a \code{vector} containing the levels }
    \item{\code{mods}:}{The \code{list} of models built }
    \item{\code{nmods}:}{\code{numeric} indication the number of models built }
    \item{\code{bagmat}:}{A \code{matrix} containing which samples were used in which iteration of model building }
    \item{\code{oobpred}:}{The aggregated OOB predictions for all iterations}
    \item{\code{oobpredmat}:}{A \code{matrix} of per iteration OOB predictions }
    \item{\code{accmat}:}{A \code{matrix} tracking per iteraction accuracy }
    \item{\code{test_oobpred}:}{The aggregated OOB predictions of the test set}
    \item{\code{test_oobpredmat}:}{A \code{matrix} for the test set equivalent to \code{oobpredmat} }
    \item{\code{test_accmat}:}{A \code{matrix} for the test set equivalent to \code{accmat}}
  }
}
\author{
Peter Werner and Eugene Dubossarsky \email{gensemble.r@gmail.com}
}
\note{
The \code{test_*} items will only make sense if a test set was provided to the call to \code{\link{gensemble}}.
}
\seealso{
\code{\link{gensemble}}, \code{\link{predict.gensemble}}
}
\keyword{classes}
