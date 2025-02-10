#' APA-Style Correlation Matrix
#'
#' This function calculates a correlation matrix in APA (American Psychological Association) style
#' and returns the result as a formatted dataframe. Optionally, it can export the dataframe to the clipboard.
#'
#' @param x A dataframe with the variables of interest.
#' @param export Copies the resulted dataframe into the clipboard if set to TRUE (default is FALSE).
#'
#' @return A formatted dataframe representing the APA-style correlation matrix.
#' @export
#'
#' @examples
#' # Using the airquality dataset as an example
#' x <- airquality
#' apa_correlation_matrix <- apa.cor(x, export = FALSE)
#' print(apa_correlation_matrix)

apa.cor<- function(x, export=FALSE) {

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
  colnames(Rnew)[1:2] <- c("M","SD")					      		         #Beschriftung der neuen Spalten
  Rnew <- Rnew[,1:(ncol(Rnew)-1)]							                  	#delete the last column (ugly)

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

