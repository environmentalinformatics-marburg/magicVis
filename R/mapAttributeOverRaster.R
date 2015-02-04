#' Visualize point vector attributes on top of a raster layer
#'
#' @description
#' The function plots a raster map as background for a point vector layer.
#'
#' @param raster a raster layer
#' @param vector a spatial point data frame
#' @param vector_colors a color palette for the vector layer
#' @param attr column number of the attribute to be visualized
#' @param gnbr number of map grid lines (horizontal = vertical)
#' @param glns draw grid lines (TRUE) or just tics (FALSE)
#'
#' @return map-type lattice plot object
#'
#' @export mapAttributeOverRaster
#'
#' @examples
#' library(raster)
#' library(sp)
#' data(meuse.grid)
#' coordinates(meuse.grid) = ~x+y
#' gridded(meuse.grid) = TRUE
#' rst <- raster(meuse.grid[3])
#' 
#' data(meuse)
#' coordinates(meuse) = ~x+y
#' vec <- meuse[5]
#' 
#' mapAttributeOverRaster(rst, vec, attr = 1)
mapAttributeOverRaster <- function(raster, vector, attr=1,
                                   vector_colors="default",
                                   gnbr=5, glns = FALSE){
  
  library(raster)
  library(sp)
  library(latticeExtra)
  
  vector_classes <- cut(vector@data[,attr], 6)
  
  if(vector_colors == "default"){
    vector_colors <- colorRampPalette(brewer.pal(6,"Greens"))(6)
  }
  
  breaks <- auxColBreaks(raster = raster)
  
  grid <- auxGridTics(gdf = raster, gnbr = gnbr)
  
  plt <- spplot(raster, col.regions = gray.colors(256), at = breaks,
                sub = paste0("Vector: ", names(vector)[attr]),
                key = list(space = 'left', text = list(levels(vector_classes)), 
                           points = list(pch = 21, cex = 2, fill = vector_colors)),
                colorkey=list(space="right"),
                panel = function(...){
                  panel.levelplot(...)
                  if(glns){
                    panel.abline(h = yat, v = xat, col = "grey0", lwd = 0.8, lty = 3)   
                  }
                },
                scales = list(x = list(at = grid$xat),
                              y = list(at = grid$yat)))
  
  orl <- spplot(vector, zcol = attr, col.regions = vector_colors)
  
  plt + as.layer(orl)
}