mse <- function(x,y) {
  if (length(x) == length(y)) {
    error = 0
    for (i in 1:length(x)) {
      error = error + (y[i] - x[i])^2
    }
    return error
  } else {
    print("Objects must have the same length")
  }
  
}