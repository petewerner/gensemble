\name{AbstractModel-class}
\Rdversion{1.1}
\docType{class}
\alias{AbstractModel-class}

\title{Class \code{"AbstractModel"}}
\description{
%%  ~~ A concise (1-5 lines) description of what the class is. ~~
AbstractModel is an abstraction of R modelling functions/packages. Designed to be used with \link{gensemble}.
}
\section{Objects from the Class}{
It is best to use \code{\link{ab.create}} to instantiate an object of this class.
%%  ~~ describe objects here ~~ 
}
\section{Slots}{
  \describe{
    \item{\code{model}:}{The model function to call e.g. \code{"ksvm"} \code{"nnet"} }
    \item{\code{model_args}:}{Named list of arguments to be passed to the model call, excluding X and Y}
    \item{\code{predict}:}{The model prediction function, if different from \code{predict}}
    \item{\code{predict_args}:}{Named list of arguments to be passed to the predict function}
    \item{\code{xtrans}:}{Function that will be passed the predictor matrix, prior to any model or predict call}
    \item{\code{ytrans}:}{Function that will be passed the response vector, prior to any model or predict call}
    \item{\code{formula}:}{A \code{logical} indicating formula syntax should be used}
  }
}
\author{
Peter Werner \email{gensemble.r@gmail.com}
}
\seealso{
\code{\link{ab.model}}, \code{\link{ab.predict}}, \code{\link{ab.model}}, \code{\link{gensemble}}
}
\examples{
\dontrun{
#ksvm classification
library(kernlab)
#note we pass prob.model=TRUE as gensemble requires the probabilities for classification.
ksvm_model_args <- list(prob.model=TRUE, type="C-svc", C=1, epsilon=0.1)
#create the abstract model instance
abm <- ab.create(model.call="ksvm", model.args=ksvm_model_args, predict.args=list(type="probabilities"), xtrans=as.matrix)

#nnet classification
library(nnet)
#use the formula
abm <- ab.create(model.call="nnet", model.args=list(size=3), formula=TRUE)

#rpart classification
library(rpart)
abm <- ab.create(model.call="rpart", model.args=list(control=rpart.control(minsplit=0)), predict.args=list(type='prob'))

#classification test stub (try with the different abm's from above)
X <- iris[,1:4]
Y <- iris[,5]
#generate train/test samples
cnt <- nrow(iris)
samp <- sample(1:cnt, cnt * 0.7, rep=FALSE)
#train the model
mod <- ab.model(abm, X[samp,], Y[samp])
#get the predictions
preds <- ab.predict(abm, mod, X[-samp,])
#compare to actual classes
cbind(apply(preds, 1, which.max), Y[-samp])

#ksvm regression
library(kernlab)
abm <- ab.create(model.call="ksvm", xtrans=as.matrix)

#nnet regression
library(nnet)
abm <- ab.create(model.call="nnet", model.args=list(size=3, linout=TRUE, maxit=400, rang=0.001, decay=0.0001), xtrans=as.matrix)

#rpart regression
library(rpart)
abm <- ab.create(model.call="rpart", model.args=list(method='anova', control=rpart.control(minsplit=2, cp=1e-03)))

#regression test stub
X <- trees[,1:2]
Y <- trees[,3]
#generate train/test samples
cnt <- nrow(trees)
samp <- sample(1:cnt, cnt * 0.7, rep=FALSE)
#build the model
mod <- ab.model(abm, X[samp,], Y[samp])
#try some predictions
preds <- ab.predict(abm, mod, X[-samp,])
#compare vs actual values
cbind(preds, Y[-samp])
}
}
\keyword{classes}
