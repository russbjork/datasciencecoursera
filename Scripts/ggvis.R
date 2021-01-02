library(ggvis)
library(dplyr)
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points()

mtcars %>% 
  ggvis(~wt, ~mpg) %>% 
  layer_points(fill = ~factor(cyl))