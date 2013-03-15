\name{predict.gensemble}
\alias{predict.gensemble}
\title{
predict method for generalized ensemble methods.
}
\description{
Prediction of data using a model built with \code{\link{gensemble}}
}
\usage{
\method{predict}{gensemble}(object, X, type = c("prob", "class"), method = c("prob", "vote"), return.all = F, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	An instance of \code{\link{gensemble-class}}.
}
  \item{X}{
The input predictors.
}
  \item{type}{
For classification, either probabilities or the class name can be returned.
}
  \item{method}{
For classification, if \code{method} is \code{prob}, the assigned class will be the highest probability. If \code{method} is \code{vote}, the assigned class will be the class with the highest number of votes across all underlying models.
}
  \item{return.all}{
For regression, if \code{TRUE}, a matrix with the output of each underlying model will be returned in addition to a the output vector.
}
  \item{...}{
Present for compatibility. You could put stuff here but it won't be used.
}
}
\details{
Please see \code{\link{gensemble}} for examples.
}
\value{
The return value will vary depending on classification or regression, and if \code{return.all} was \code{FALSE} (default) or \code{TRUE}. 

For classification, the return value will be a matrix of probabilities where each row corresponds to the input \code{X} and the columns are the classes and the probabilites aggregated from the underlying models.

For regression, the return value will be a vector of the predictor values. If \code{return.all} is \code{TRUE}, the return value will be a list. The first item is the vector of predicted values, and the second is a matrix where each row corresponds to the input \code{X} and each column is the predicted value generated from each model. For example an input X with 150 rows, using a gensemble with 100 underlying models would return a 150 row x 100 column matrix. 
}
\author{
Peter Werner and Eugene Dubossarsky \email{gensemble.r@gmail.com}
}
\seealso{
\code{\link{gensemble}}, \code{\link{gensemble-class}}.
}
