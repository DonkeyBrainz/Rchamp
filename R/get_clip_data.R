#'  Get Clip Data
#' 
#' Fetch relevant clip data from twitch api using id and oauth token.
#' 
#'@return A list with clip information
#' 
#'@param clip_id the clip slug, Can be found in the url of the twitch clip.
#' 
#'@param client_id the client id used to format http requests, This is granted from dev.twitch.tv 
#' 
#'@references https://github.com/Freguglia/rTwitchAPI/blob/master/R/get_clip.R
#' 
#'@import dplyr
#' 
#'@import httr
#' 
#'@importFrom purrr simplify_all
#' 
#'@importFrom purrr transpose
#' 
#'@importFrom httr content
#' 
#'@importFrom httr GET
#' 
#'@importFrom magrittr %>%
#' 
#'@export
#' 

get_clip_data <- function(clip_id,client_id){

  client_id <- Sys.getenv("TWITCH_CLIENT_ID")
  client_secret <- Sys.getenv("TWITCH_CLIENT_SECRET")
  httr::set_config(httr::add_headers('Client-Id'=client_id, 'Authorization'= paste('Bearer',client_secret,sep = " ")))

  api_clip_url <- 'https://api.twitch.tv/helix/clips?id='
  clip_data <- httr::GET(paste(api_clip_url,clip_id,sep = ""),
  httr::add_headers(
  'Client-Id'=client_id, 
  'Authorization'= paste('Bearer',client_secret,sep = " "))) # used this to get clip-id
  clip_content <- httr::content(clip_data)
  #clip_data <- httr::GET(paste(url,'GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ',sep = "")) %>% content()
  if(!is.null(clip_data$status_code) & clip_data$status_code=="200"){
    print('Got the clip data B)')
    return(clip_content)
    }
  if(length(clip_content)<1){ print("No results for this query parameters.")}

}

#test<-get_clip_data('GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ')