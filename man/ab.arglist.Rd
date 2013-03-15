\name{ab.arglist}
\alias{ab.arglist}
\title{
Get the arglist for the given model
}
\description{
Generate a list containing the arguments to be passed to the underlying model building function. Most interaction with \code{\link{AbstractModel-class}} is done via \link{ab.create}, \link{ab.model} and \link{ab.predict}, however it may be useful for debugging purposes to call this function directly.
}
\usage{
ab.arglist(ab, X, Y)
}
\arguments{
  \item{ab}{
An object of class \code{\link{AbstractModel-class}}
}
  \item{X}{
The \code{X} values. Will be passed through \code{xtrans}.
}
  \item{Y}{
The \code{Y} values. Will be passed through \code{ytrans}.
}
}
\details{
Both \code{X} and \code{Y} must be present. They will be passed through the xtransfrom and ytransform functions respectively, which default to a passthrough. If a formula is to be used, the \code{X} and \code{Y} data will be combined via \code{\link{cbind}}.
}
\value{
Returns a list of values that will be passed to the underlying model function
}
\author{
Peter Werner
}
\seealso{
\code{\link{AbstractModel-class}}, \code{\link{gensemble}}.
}
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
