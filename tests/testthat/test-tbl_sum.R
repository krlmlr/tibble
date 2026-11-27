test_that("output test", {
  skip_if(getRversion() < "4.7.0", "str() output changed in R 4.7.0")

  expect_snapshot({
    str(tbl_sum(1:3))
    str(tbl_sum(vctrs::new_data_frame(a = 1:3, class = "tbl")))
    str(tbl_sum(tibble(a = 1:3, b = letters[2:4])))
  })
})

test_that("dim_desc()", {
  expect_snapshot({
    dim_desc(trees)
    dim_desc(Titanic)
    dim_desc(1:3)
  })
})
