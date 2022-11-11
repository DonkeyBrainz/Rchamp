#'  Get Clip Data
#' 
#' Fetch relevant clip data from twitch api using id and oauth token.
#' 
#'@return A list with clip information
#' 
#'@param clip_id the clip slug, Can be found in the url of the twitch clip.
#' 
#'@references https://github.com/Freguglia/rTwitchAPI/blob/master/R/get_clip.R
#' 
#'@import dplyr
#' 
#'@import httr
#' 
#'@import glue
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

get_clip_data <- function(clip_id){

  client_id <- Sys.getenv("TWITCH_CLIENT_ID")
  client_secret <- Sys.getenv("TWITCH_CLIENT_SECRET")
  bearer_token<-httr::POST(url=glue("https://id.twitch.tv/oauth2/token?client_id={Sys.getenv('TWITCH_CLIENT_ID')}&client_secret={Sys.getenv('TWITCH_CLIENT_SECRET')}&grant_type=client_credentials"))
  bearer_token <- httr::content(bearer_token)$access_token

  api_clip_url <- 'https://api.twitch.tv/helix/clips?id='

  clip_data <- httr::GET(paste(api_clip_url,clip_id,sep = ""),
  httr::add_headers(
  'Client-Id'=client_id, 
  'Authorization'= paste('Bearer',bearer_token,sep = " "))) # used this to get clip-id
  clip_content <- httr::content(clip_data)
  #clip_data <- httr::GET(paste(url,'GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ',sep = "")) %>% content()
  if(!is.null(clip_data$status_code) & clip_data$status_code=="200"){
    print('Got the clip data B)')
    return(clip_content)
    }
  if(length(clip_content)<1){ print("No results for this query parameters.")}

}

#test<-get_clip_data('GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ')

# curl -X POST “https://id.twitch.tv/oauth2/token?client_id=$TWITCH_CLIENT_ID&client_secret=$TWITCH_CLIENT_SECRET&grant_type=client_credentials 75”

bearer_token<-httr::POST(url=glue("https://id.twitch.tv/oauth2/token?client_id={Sys.getenv('TWITCH_CLIENT_ID')}&client_secret={Sys.getenv('TWITCH_CLIENT_SECRET')}&grant_type=client_credentials"))