#' Visualize point vector attributes on top of a raster layer
#'
#' @description
#' The function plots a raster map as background for a point vector layer.
#'
#' @param raster a raster layer
#' @param vector a spatial point data frame
#' @param vector_colors a color palette for the vector layer
#' @param gnbr number of map grid lines (horizontal = vertical)
#' @param attr column number of the attribute to be visualized
#'
#' @return map-type lattice plot object
#'
#' @export mapAttributeOverRaster
#'
#' @examples
#' Not run:
#' map(landsat, vegetation, gnbr=3, attr=4)

mapAttributeOverRaster <- function(raster, vector, vector_colors="default",
                                   gnbr=5, attr=1){

  library(raster)
  library(sp)
  library(latticeExtra)
  
  vector_classes <- cut(vector@data[,attr], 6)
  
  if(vector_colors == "default"){
    vector_colors <- colorRampPalette(brewer.pal(6,"Greens"))(6)
  }
  
  min <- max(mean(getValues(raster)) - sd(getValues(raster)), 0, na.rm = TRUE)
  max <- mean(getValues(raster), na.rm = TRUE) + 
    sd(getValues(raster), na.rm = TRUE)
  
  breaks <- seq(min, max, length.out = 256)
  
  yat = seq(extent(raster)@ymin, 
            extent(raster)@ymax, length.out = gnbr)
  xat = seq(extent(raster)@xmin, 
            extent(raster)@xmax, length.out = gnbr)
  
  plt <- spplot(raster, col.regions = gray.colors(256), at = breaks,
                key = list(space = 'left', text = list(levels(vector_classes)), 
                           points = list(pch = 21, cex = 2, fill = vector_colors)),
                colorkey=list(space="right"),
                panel = function(...){
                  panel.levelplot(...)
                  panel.abline(h = yat, v = xat, col = "grey0", lwd = 0.8, lty = 3) 
                },
                scales = list(x = list(at = xat),
                              y = list(at = yat)))
  
  orl <- spplot(vector, zcol = attr, col.regions = vector_colors)
  
  plt + as.layer(orl)
}