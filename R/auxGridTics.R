#' Calculate position of map grid tics
#'
#' @description
#' The function computes the position of map grid tics
#'
#' @param gdf a geo-data file
#' @param gnbr number of map grid lines (horizontal = vertical)
#'
#' @return data frame with grid tic positions
#'
#' @export auxGridTics
#'
#' @examples
#' Not run:
#' grid <- auxGridTics(gdf = raster, gnbr = 5)

auxGridTics <- function(gdf, gnbr=5){
  
  library(raster)
  library(sp)

  yat = seq(extent(gdf)@ymin, 
            extent(gdf)@ymax, length.out = gnbr)
  xat = seq(extent(gdf)@xmin, 
            extent(gdf)@xmax, length.out = gnbr)
  
  data.frame(yat = yat,
             xat = xat)
}