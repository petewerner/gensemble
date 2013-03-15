\name{ab.model}
\alias{ab.model}
\title{
call the underlying model
}
\description{
This function can be used to call the underlingly model of an \code{\link{AbstractModel-class}} instance.

Please see the documentation for \code{\link{AbstractModel-class}} for example usage.
}
\usage{
ab.model(ab, X, Y)
}
\arguments{
  \item{ab}{
An object of type \code{\link{AbstractModel-class}}.
}
  \item{X}{
The \code{X} values to passed to the model function.
}
  \item{Y}{
The \code{Y} values to be passed to the model function.
}
}
\value{
Returns an trained instance of whatever underlying model is in use. Suitable to be passed to \code{\link{predict}} or \code{\link{ab.predict}}.
}
\author{
Peter Werner
}
\seealso{
\code{\link{ab.create}}, \code{\link{ab.predict}}, \code{\link{AbstractModel-class}}, \code{\link{gensemble}}.
}
\keyword{ gensemble }
\keyword{ AbstractModel }
