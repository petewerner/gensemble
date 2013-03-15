\name{ab.predict}
\alias{ab.predict}
\title{
AbstractModel prediction
}
\description{
Take a model trained by ab.model and use it for prediction

Please see the documentation for \code{\link{AbstractModel-class}} for example usage.
}
\usage{
ab.predict(ab, mod, X)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ab}{
An object of type \code{\link{AbstractModel-class}}.
}
  \item{mod}{
A trained model object, possibly the return value from a call to \code{\link{ab.model}}.
}
  \item{X}{
The input predictors.
}
}
\value{
This will return whatever a call to \code{\link{predict}} would return for the given model in use by the AbstractModel instance passed in \code{ab}.
}
\author{
Peter Werner
}
\seealso{
\code{\link{ab.model}}, \code{\link{ab.create}}, \code{\link{AbstractModel-class}}, \code{\link{gensemble}}.
}
\keyword{ gensemble }
\keyword{ AbstractModel }
