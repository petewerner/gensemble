\name{mksampsize}
\alias{mksampsize}
\title{
Generate sample size information for use with \code{\link{gensemble}}
}
\description{
This translates the \code{sampsize} argument to \code{\link{gensemble}} to a form for use internally. 
}
\usage{
mksampsize(Y, sampsize = NULL, proportion = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Y}{
The response vector.
}
  \item{sampsize}{
The desired sample size(s). Can be NULL, a single value, a vector or a list. See the details section for more information.
}
  \item{proportion}{
A \code{logical} indicating the values in \code{sampsize} represent proportions.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
For regression, \code{sampsize} indicates how much of the underlying data should be used in the bagged model. It should either be \code{NULL} or a single value. If it is \code{NULL}, roughly 80% of the data will be used. If it is a single value and \code{proportion} is \code{FALSE}, exactly that much data will be used. If \code{proportion} is \code{TRUE}, \code{sampsize} will be iterpreted as a proprotion and should range between \code{0} and \code{1}. 

For classification, the internals of \code{\link{gensemble}} require a list of each class and the size of the sample from each class. If \code{sampsize} is \code{NULL}, this list will be built using the levels present in \code{Y}, and roughly 80% of the data for each class will be used. If \code{sampsize} is a list, each item in the list should match a the class names in \code{Y}, and the value for each item represents how much data will be used for that class. If \code{proportion} is \code{TRUE} the per class values will be converted to actual counts. If \code{sampsize} is a single value, it specifies how much data to use for each class present (respecting the \code{proportion} logical). If \code{sampsize} is a vector, its length should equal the number of levels in \code{Y}, and will be interpreted as the sample size for each class. 
}
\value{
If \code{Y} is a factor, will return a list of each class and the number of data points to sample for that class. Otherwise it will return a single value. 
}
\author{
Peter Werner <gensemble.r@gmail.com>
}
\seealso{
\code{\link{gensemble}}
}
\examples{


#regression
Y <- trees[,3]
#use roughly 80% for each training iteration
mksampsize(Y)
#the same thing using proportion
mksampsize(Y, 0.8, TRUE)

#classification
Y <- iris[,5]
#use rougly 80% of each class
mksampsize(Y)
#specifiy the size of each class in absolute terms
mksampsize(Y, list(setosa=20, versicolor=30, virginica=40))
#use about 70% of each class
mksampsize(Y, 0.7, proportion=TRUE)
#specifiy the proportion for each class
mksampsize(Y, c(0.5, 0.6, 0.7), proportion=TRUE)
}
