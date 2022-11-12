test_that('get clip data!',{
  expected <- Rchamp::get_clip_data('TrappedGeniusWatercressBuddhaBar-WCSfEZPTtS46c1Cy')$data[[1]]$broadcaster_name
  testthat::expect_equal(expected,"pokelawls")
})