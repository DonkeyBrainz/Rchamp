test_that('get clip data!',{
  clip_data <- Rchamp::get_clip_data('TrappedGeniusWatercressBuddhaBar-WCSfEZPTtS46c1Cy')
  testthat::expect_equal(clip_data$data[[1]]$broadcaster_name,"pokelawls")
})