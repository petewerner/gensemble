\name{ab.create}
\alias{ab.create}
\title{
Create an Abstract Model instance
}
\description{
This function provides a wrapper around instantiating an object of class \code{\link{AbstractModel-class}}. 

Please see the documentation for \code{\link{AbstractModel-class}} for example usage.
}
\usage{
ab.create(model.call, model.args = list(), predict.args = list(), formula = NA, ...)
}
\arguments{
  \item{model.call}{
The name of the model function as a string.
}
  \item{model.args}{
A named list of arguments. If used with \code{\link{gensemble}} please note classification requires a probability matrix to be returned.
}
  \item{predict.args}{
A named list of arguments to be passed to the predict method for the model selected.
}
  \item{formula}{
A \code{logical} indicating if the formula method of the underlying model should be used or not. If this is NA (i.e. unspecified), \code{ab.create} will examine \link{formals} of \code{model.call} to determine if formula syntax is required.
}
  \item{\dots}{
Additional arguments to be passed to \code{\link{AbstractModel-class}} creation.
}
}
\value{
Returns an object of class \code{\link{AbstractModel-class}}.
}
\author{
Peter Werner
}
\seealso{
\code{\link{ab.model}}, \code{\link{ab.predict}}, \code{\link{AbstractModel-class}}, \code{\link{gensemble}}.
}
\keyword{ gensemble }
\keyword{ AbstractModel }
