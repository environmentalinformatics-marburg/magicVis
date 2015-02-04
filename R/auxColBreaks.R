#' Calculate color breaks for raster contrast stretch
#'
#' @description
#' The function computes break values for a contrast stretched raster
#'
#' @param raster a raster data file
#'
#' @return vector of values for color break points
#'
#' @export auxColBreaks
#'
#' @examples
#' Not run:
#' breaks <- auxColBreaks(raster = raster)

auxColBreaks <- function(raster){
  
  library(raster)
  
  min <- max(mean(getValues(raster)) - sd(getValues(raster)), 0, na.rm = TRUE)
  max <- mean(getValues(raster), na.rm = TRUE) + 
    sd(getValues(raster), na.rm = TRUE)
  
  breaks <- seq(min, max, length.out = 256)
}