source("../functions/mse_function.R")
source("../../data/ridge_model.RData") #
load("../../data/ridge_model.RData")
require("hydroGOF")
require(testthat)

test_that( "MSE Test", {
  
  test_set <- read.csv(file = "../../data/test_data.csv")
  response = test_set$Balance
  func_answe = MSE(test_ridge, response)
  package_asnwer = mse(test_ridge, response)
  expect_that(func_answe, equals(package_asnwer, tolerance = .1))
})





