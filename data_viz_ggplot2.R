library(ggplot2)
library(dplyr)
diamonds
mtcars
## Q: one variable, number
## A: histogram / density

## mapping
base <- ggplot(data = diamonds,
               mapping = aes(x = price)) 
## setting
base + geom_histogram(bins=15, fill = "green", color = "black")

base + geom_density()
base + geom_freqpoly()

## discrete = non-number = factor
## one variable, factor
ggplot(data = diamonds,
       mapping = aes(x = clarity) ) +
  geom_bar()

ggplot(data = diamonds,
       mapping = aes(x = cut) ) +
  geom_bar(fill = "salmon", alpha = 0.8)

base2 <- ggplot(data = diamonds,
                mapping = aes(x = cut) )

base2 + geom_bar(mapping = aes(fill = cut), alpha = 0.6)

ggplot(data = diamonds,
       mapping = aes(x = cut) ) +
  geom_bar()+
coord_polar("y", start = 0)

## two variables, number x number
## scatter plot (statistician love this)
ggplot(data = diamonds,
       mapping = aes(x=price, y=carat)) +
  geom_point(mapping = aes(color = cut))

set.seed(42)
small_diamonds <- diamonds %>%
  sample_n(5000)
ggplot(data = small_diamonds,
       mapping = aes(x=price, y=carat)) +
  geom_point(mapping = aes(color = cut), alpha = 0.7) + theme_minimal()

ggplot(data = small_diamonds,
       mapping = aes(x=price, y=carat)) +
  geom_point(alpha = 0.7, shape = "x" )

## overplotting
library(ggplot2)
library(ggthemes)

ggplot(data = small_diamonds,
       mapping = aes(x=price, y=carat)) +
  geom_point(mapping = aes(color = cut), alpha = 0.7) + theme_economist()

## Two approaches to statistics
## [1] graphical [2] numerical
library(dplyr)
diamonds %>%
  group_by(cut) %>%
  summarise(
    n = n(),
    avg_price = mean(price),
    avg_carat = mean(carat)
  )

library(plotly)
ggplot(mtcars, aes(hp, mpg)) +
  geom_point()

plot1 <- ggplot(mtcars, aes(hp, mpg)) +
  geom_point()

ggplotly(plot1)

## ggplot2: 2D
## add more variables
## mapped to aesthetic of the chart
ggplot(diamonds,
       aes(x=carat, y=price)) +
  geom_point()

ggplot(diamonds,
       aes(x=carat, y=price)) +
  geom_point(aes(color = clarity))

library(dplyr)
ggplot(diamonds %>% sample_n(1500),
       aes(x=carat, y=price)) +
  geom_point(aes(color = clarity))

ggplot(diamonds %>% sample_n(1500),
       aes(x=carat, y=price)) +
  geom_point(aes(color = clarity, shape = cut), size = 3) + theme_minimal()

## faceting breaks down big chart into small multiples
ggplot(diamonds %>% sample_n(5000),
       aes(x=carat, y=price)) +
  geom_point() + 
  facet_grid(cut ~ clarity) ## 40 sub plots

ggplot(diamonds %>% sample_n(1500),
       aes(x=carat, y=price)) +
  geom_point(color = "brown",alpha = 0.5) + 
  facet_grid(~color)

ggplot(diamonds %>% sample_n(1500),
       aes(x=carat, y=price)) +
  geom_point(color = "green",alpha = 0.5) + 
  facet_wrap(~color, ncol=3 )

## let's look at mtcars
ggplot(mtcars, aes(hp, mpg)) +
  geom_point() +
  geom_smooth()+
  geom_rug()
  
ggplot(mtcars, aes(hp, mpg)) +
  geom_point() +
  geom_smooth(method = "lm")

ggplot(mtcars, aes(hp, mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red")

ggplot(mtcars, aes(hp, mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, color = "red",fill = "gold")+
theme_minimal()+
labs(title="scatter plot hp x mpg",
  subtitle = "Positive relationship between two variable", 
  caption = "Dataset: Mtcars",
  x = "horse power",
  y = "Mile per gallon")

lm(mpg ~ hp, data = mtcars)$coef

mtcars %>%
  filter(hp < 130, mpg > 16) %>%
  ggplot(aes(hp, mpg)) +
  geom_point() +
  geom_smooth(method = "loess",
              se = F,
              color = "red") +
  theme_minimal()

## dplyr + ggplot
diamonds %>%
  filter(carat >= 0.5, 
         price >= 4000,
         cut == "Ideal") %>%
  count(clarity) %>%
  ggplot(aes(clarity, n)) +
  geom_col()

## boxplot
ggplot(diamonds %>% sample_n(1000),
       aes(x=cut, y=price)) +
  geom_boxplot()

## violin plot  "scatter data"
ggplot(diamonds %>% sample_n(1000),
       aes(x=cut, y=price)) +
  geom_violin()

ggplot(diamonds %>% sample_n(1000),
       aes(price)) +
  geom_histogram(aes(fill=cut), alpha=0.4) +
  theme_minimal()

## multiple datasets
premium_di <- diamonds %>%
  filter(cut == "Premium" %>%
  sample_n(500)
  
  ## change color manually
premium_di <- diamonds %>%
  filter(cut == "Premium", carat>=2) %>%
  sample_n(500)
good_di <- diamonds %>%
  filter(cut == "Good") %>%
  sample_n(500)

ggplot() +
  geom_point(data = premium_di, 
             mapping = aes(carat, price),
             color = "red") +
  geom_point(data = good_di, 
             mapping = aes(carat, price),
             color = "blue", alpha=0.5) +
  theme_minimal()

## change color manually
diamonds %>%
  ggplot(aes(cut, fill = cut))+
  geom_bar()

diamonds %>%
  ggplot(aes(cut, fill = cut))+
  geom_bar()+
theme_minimal()+
scale_fill_manual(values = c("orange",
                          "yellow",
                          "green",
                          "violet",
                          "#d12121"
                          ))
mtcars %>%
  ggplot(aes(wt, mpg, color = wt))+
  geom_point(size=3)+
  theme_minimal()+
  scale_color_gradient(low = "blue",
                       high = "red")

