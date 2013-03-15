\name{gensemble}
\alias{gensemble}
\alias{print.gensemble}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Generalized ensemble methods 
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Gensemble is a generalisation of random forests allowing allowing arbitrary use of underlying models.
}
\usage{
gensemble(abm, X, Y, sampsize = NULL, sampsize_prop = FALSE, nmods = 100, 
	perturb_val = 0.1, Xtest = NULL, Ytest = NULL, do.trace = TRUE, 
	stepsize = 10)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{abm}{
An object of type \code{\link{AbstractModel-class}}
}
  \item{X}{
A data frame or matrix of predictors
}
  \item{Y}{
A response vector. If Y is a factor classification is assumed, otherwise regression. See the notes for more details.
}
  \item{sampsize}{
%%     ~~Describe \code{sampsize} here~~
A list or vector of sample sizes used when creating a bagged sample. If not supplied, all input data will be used to build the models. See \link{mksampsize} for details on how this will be interpreted. 
}
  \item{sampsize_prop}{
A boolean indictating the values in samplesize should be interpreted as proportions.
}
  \item{nmods}{
How many models to build.
}
  \item{perturb_val}{
The proportion of input data to perturb.
}
  \item{Xtest}{
%%     ~~Describe \code{Xtest} here~~
Optional test set of \code{X} values.
}
  \item{Ytest}{
%%     ~~Describe \code{Ytest} here~~
Optional test set of \code{Y} values.
}
  \item{do.trace}{
If \code{TRUE}, summary statistics will be printed.
The information printed is as follows:
\enumerate{
	\item For classification, the per-class accuracy is printed, along with the proportion of training points not yet included in any model, and the total accuracy.
	\item For regression, the variance, mse, scaled mse, estimated R^2 and proportion of training points not yet included in any model. 
}
}
  \item{stepsize}{
If \code{do.trace} is \code{TRUE}, specifies how often to print trace information. For example, a value of 10 will print every 10 models. A value of 1 will print after every model. 
}
}
\details{
This is a general implmentation of bagging. It enables (in theory) any 
underling modelling/learning algorithm to be used, via the \code{\link{AbstractModel-class}}. 
}
\section{Wrapping the model function}{
The first argument to \code{gensemble} is an instance of an \code{\link{AbstractModel-class}}. 
You will need to wrap the model you wish to use in this class before using gensemble.

First off, you should probably make sure the model function works for the 
data you will pass to gensemble. For example let's say we are using ksvm 
from kernlab, on the iris data set. You might have something that looks like
this:

\preformatted{
library(kernlab)
X <- iris[,1:4]
Y <- iris[,5]
cnt <- nrow(iris)
samp <- sample(1:cnt, cnt * 0.7)
mod <- ksvm(as.matrix(X[samp,]), Y[samp], type="C-svc", C=1, epsilon=0.1)
preds <- predict(mod, X[-samp,])
}

We can wrap this up in an instance of \code{\link{AbstractModel-class}} as 
follows:

\preformatted{
abm <- ab.create(model.call="ksvm", model.args=list(type="C-svc", C=1, 
	epsilon=0.1), xtrans=as.matrix)
}

We now pass the arguments we would pass to \code{ksvm} via the \code{model.args} 
argument to \code{ab.create}. It is simply list of the arguments and their values.
\cr
\cr
Note we define the \code{X} transform to be \code{as.matrix}, which means 
the \code{X} values passed to \code{ksvm} by \code{AbstractModel} will 
first be run through \code{as.matrix}.
\cr
\cr
We can check this is working as expected using \code{\link{ab.model}} and \code{\link{ab.predict}}.

\preformatted{
mod <- ab.model(abm, X[samp,], Y[samp])
preds <- ab.predict(abm, mod, X[-samp,])
}

\bold{Classification with gensemble requires a probability matrix to be returned 
by the underlying model}. We will need to pass some extra arguments to ksvm
to make sure this is present. 

\preformatted{
abm <- ab.create(model.call="ksvm", model.args=list(prob.model=TRUE, 
	type="C-svc", C=1, epsilon=0.1), predict.args=list(type="probabilities"), 
	xtrans=as.matrix)
}

We have added two extra things. First we pass \code{prob.model=TRUE} to the
\code{ksvm} model function, telling it to generate probabilities. We also 
added \code{predict.args} to \code{AbstractModel}, so when the \code{predict} 
function for \code{ksvm} is called, it will be passed \code{type="probabilities"}, 
telling it to return a matrix of class probabilities.
\cr
\cr
We now have an \code{AbstractModel-class} instance ready to use with \code{gensemble}. 
Please see the documentation for \code{\link{AbstractModel-class}} for 
further examples and information.
}
\value{
An object of class \code{\link{gensemble-class}} uncode \link{gensemble-class}.
}
\references{
%% ~put references to the literature/web site here ~
\url{http://www.stat.berkeley.edu/~breiman/RandomForests/cc_home.htm}
}
\author{
Peter Werner and Eugene Dubossarsky \email{gensemble.r@gmail.com}
}
\note{
This is still relatively experimental code. In particular I expect 
AbstractModel to not be abstract enough at some point in the near future,
and fail to be able to model normal usage. We welcome bug reports or any
other feedback.
}
\seealso{
\code{\link{mksampsize}}, \code{\link{AbstractModel-class}}, \code{\link{predict.gensemble}}
}
\examples{
\dontrun{
#classification with kernlab
library(kernlab)
#make our abstract model object
abm <- ab.create(model.call="ksvm", model.args=list(prob.model=TRUE, 
	type="C-svc", C=1, epsilon=0.1), predict.args=list(type="probabilities"), 
	xtrans=as.matrix)
#the example data
X <- iris[,1:4]
Y <- iris[,5]
#create a training/test set
samp <- sample(1:nrow(iris), nrow(iris) * 0.8)        
#train the model
gmod <- gensemble(abm, X[samp,], Y[samp], sampsize=0.8, sampsize_prop=TRUE)
#test it out
gpreds <- predict(gmod, X[-samp,])
#compare
cbind(apply(gpreds, 1, which.max), Y[-samp])


#regression with rpart
library(rpart)
abm <- ab.create(model.call="rpart", model.args=list(control=rpart.control(minsplit=2)))
X <- trees[,1:2]
Y <- trees[,3]
#generate a training set
samp <- sample(1:nrow(trees), nrow(trees) * 0.8)
#build the model
gmod <- gensemble(abm, X[samp,], Y[samp])
#use it to predict with the test set
gpreds <- predict(gmod, X[-samp,])
#compare
cbind(gpreds, Y[-samp])
}
}
