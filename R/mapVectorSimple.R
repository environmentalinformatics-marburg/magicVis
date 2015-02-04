#' Visualize point vector attributes
#'
#' @description
#' The function plots a point vector map.
#'
#' @param vector a spatial point data frame
#' @param colors a color palette for the vector layer
#' @param attr column number of the attribute to be visualized
#' @param gnbr number of map grid lines (horizontal = vertical)
#' @param glns draw grid lines (TRUE) or just tics (FALSE)
#'
#' @return map-type lattice plot object
#'
#' @export mapVectorSimple
#'
#' @examples
#' library(raster)
#' library(sp)
#' 
#' data(meuse)
#' coordinates(meuse) = ~x+y
#' vec <- meuse[5]
#' 
#' mapVectorSimple(vec, attr = 1)
mapVectorSimple <- function(vector, attr=1, 
                            colors="default", gnbr=5, glns = FALSE){
  
  library(raster)
  library(sp)
  library(latticeExtra)
  
  vector_classes <- cut(vector@data[,attr], 6)
  
  if(colors == "default"){
    colors <- colorRampPalette(brewer.pal(6,"Greens"))(6)
  }
  
  grid <- auxGridTics(gdf = vector, gnbr = gnbr)
  
  spplot(vector, zcol = attr,
         col.regions = colors, sub = names(vector)[attr],
         scales = list(x = list(at = grid$xat),
                       y = list(at = grid$yat)))
}
