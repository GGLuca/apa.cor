#' A correlation matrix in R, using APA style
#'
#' @param x A dataframe with the variables of interest.
#' @param export Copies the resulted dataframe into the clipboard.
#'
#' @return A dataframe
#' @export
#'
#' @examples
#' x <- airquality
#' apa.cor(x, export = ",")

apa.cor<- function(x, export=FALSE) {

  # Check if the required packages are installed
  packages <- c("papaja")
  if (!all(packages %in% installed.packages())) {

    # If package is not installed, install it
    install.packages(packages[!packages %in% installed.packages()])
  }

  # Load the required packages
  library(papaja)

  r <-psych::corr.test(x)$r	#taking just the correlation matrix; no N, or p
  p <-psych::corr.test(x)$p	#taking the p*s

  #define notions for significance levels
  mystars <- ifelse(p < .001, "**"
                    , ifelse(p < .01, "**"
                             , ifelse(p < .05, "*"
                                      , ifelse(p < .10, "+", " "))))

  #round r, define new matrix Rnew with the correlations from rnd and paste mystars
  rnd  <- papaja::printnum(r, gt1 = FALSE, digits = 2)  #round, drop leading 0 - Thanks CRSH!
  Rnew <- matrix(paste(rnd, mystars, sep=""), ncol=ncol(rnd))

  #remove 1.0 correlations from diagonal  and set the strings
  diag(Rnew) <- ''
  Rnew[upper.tri(Rnew)] <- ''

  rownames(Rnew) <- paste(1:ncol(rnd), colnames(rnd), sep=" ") #define number and name
  colnames(Rnew) <- paste(1:ncol(rnd), "", sep="") 			       #define number

  #fun-part: we trim the top half
  Rnew[upper.tri(Rnew)] <- ''
  Rnew

  Rnew <- cbind(round(psych::describe(x)[,3:4],2), Rnew)		     #describe x, M sD - put them in the matrix
  colnames(Rnew)[1:2] <- c("M","SD")					      		#Beschriftung der neuen Spalten
  Rnew <- Rnew[,1:(ncol(Rnew)-1)]							        	#delete the last column (ugly)

  #export to clipboard

  if (export==TRUE){
    result<-write.table(Rnew
                        , "clipboard"
                        , sep=";"
                        , row.names=FALSE)
  }
  else result <- Rnew
  return(result)
}

