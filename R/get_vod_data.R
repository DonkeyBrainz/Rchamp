#'  Get Vod Data
#'@return VOD INFO
#'@param vod_id this vod id can be found after using the get_clip_data function.
#'@references https://github.com/Freguglia/rTwitchAPI/blob/master/R/get_clip.R
#'@import dplyr
#'@import httr
#'@importFrom purrr simplify_all
#'@importFrom purrr transpose
#'@importFrom httr content
#'@importFrom httr GET
#'@importFrom magrittr %>%
#'@export
#' 

get_vod_data <- function(vod_id){
    # vod_id = 1650077296 'summit1g'
  client_id <- Sys.getenv("TWITCH_CLIENT_ID")
  client_secret <- Sys.getenv("TWITCH_CLIENT_SECRET")
  bearer_token<-httr::POST(url=glue("https://id.twitch.tv/oauth2/token?client_id={Sys.getenv('TWITCH_CLIENT_ID')}&client_secret={Sys.getenv('TWITCH_CLIENT_SECRET')}&grant_type=client_credentials"))
  bearer_token <- httr::content(bearer_token)$access_token
  api_vod_url <- 'https://api.twitch.tv/helix/videos?id='
  link <- paste(api_vod_url,vod_id,sep = "")
  vod_data <- httr::GET(link,
  httr::add_headers(
  'Client-Id'=client_id, 
  'Authorization'= paste('Bearer',bearer_token,sep = " ")))
  vod_content <- httr::content(vod_data)
  if(vod_data$status_code == '200'){
    print('Got the VOD data B)')
    return(vod_content)
  }
  if(length(vod_content)<1){ print("No results for this query parameters.")}

}