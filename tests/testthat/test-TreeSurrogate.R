context("TreeSurrogate")

test_that("TreeSurrogate works for single output and single feature", {
  tree = TreeSurrogate$new(predictor1)
  dat = tree$results
  expect_class(dat, "data.frame")
  expect_equal(colnames(dat), c(colnames(X), ".node", ".path", ".y.hat", ".y.hat.tree"))
  expect_equal(nrow(dat), nrow(X))  
  expect_numeric(tree$r.squared, lower = 0, upper = 1, any.missing = FALSE, len = 1)  
  
  p = plot(tree)
  expect_s3_class(p, c("gg", "ggplot"))
  expect_s3_class(tree$predict(X), c("data.frame"))
  p
  
})

test_that("TreeSurrogate works for multiple output", {
  tree = TreeSurrogate$new(predictor2)
  dat = tree$results
  expect_class(dat, "data.frame")
  expect_equal(colnames(dat), c(colnames(X), ".node", ".path",  ".y.hat.pred", ".y.hat.pred2", ".y.hat.tree.pred", ".y.hat.tree.pred2"))
  expect_equal(nrow(dat), nrow(X))  
  p = plot(tree)
  expect_s3_class(p, c("gg", "ggplot"))
  expect_s3_class(tree$predict(X), c("data.frame"))
  p
  actual.prediction = predict(tree, X)
  expect_equal(colnames(actual.prediction), c("pred", "pred2"))
  expect_s3_class(actual.prediction, "data.frame")

  actual.classification = predict(tree, X[1:4,], type = "class")
  expect_equal(colnames(actual.classification), ".class")

  expect_numeric(tree$r.squared, lower = 0, upper = 1, any.missing = FALSE, len = 2)  
  
})

test_that("TreeSurrogate works for multiple output with selected class", {
  tree = TreeSurrogate$new(predictor3)
  dat = tree$results
  expect_class(dat, "data.frame")
  expect_equal(colnames(dat), c(colnames(X), ".node", ".path",  ".y.hat", ".y.hat.tree"))
  expect_equal(nrow(dat), nrow(X))  
  p = plot(tree)
  expect_s3_class(p, c("gg", "ggplot"))
  expect_s3_class(tree$predict(X), c("data.frame"))
  p
  pred = predict(tree, newdata = X[1:10, ])
  expect_equal(dim(pred), c(10, 1))
  expect_s3_class(pred, "data.frame")
  
  expect_numeric(tree$r.squared, lower = 0, upper = 1, any.missing = FALSE, len = )  
  
})
