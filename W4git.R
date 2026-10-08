install.packages("tidyverse")

library(tidyverse)

a<-1
b<-1

dat <-read.csv("data/plot_diversity.csv")

#> Rows: 614 Columns: 13
#> #> Column specification
#> #> chr  (2): siteID, plotID
#> #> dbl (11): n_stems, richness_observed, ...

dat
dim(dat)
names(dat)

filter(dat, n_stems > 30)

dat |> filter(n_stems > 30) |> filter(siteID == "BART")

dat |> filter(siteID == "HARV"  | n_stems >= 30)

names(dat)

dat |> select(siteID, plotID, phylogenetic_alpha_mpd)


# 종수가적은순서(기본은오름차순)
dat |> arrange(richness_observed)

# 종수가많은순서
dat |> arrange(desc(richness_observed))

# 종하나당줄기수계산
dat |> mutate(stems_per_sp = n_stems / richness_observed)

# 조건으로등급만들기
dat |> mutate(grade = if_else(richness_observed >= 8,
                              "높음", "낮음"))

dat2 <- dat |>
  mutate(grde = if_else(richness_observed >= 8, "높음", "낮음"))

dat |> summarise(rich_mean = mean(richness_observed))

# 여러개를한번에
dat |> summarise(n         = n(),
                 rich_mean = mean(richness_observed),
                 rich_max  = max(richness_observed),
                 stems_mean = mean(n_stems))

dat |> summarize(rich_mean = mean(richness_observed))

dat |>group_by(siteID) |>
  summarise(rich_mean = mean(richness_observed))

dat |> group_by(siteID) |> summarise(n = n())
dat |> count(siteID)

res <-dat |>
  filter(!is.na(taxonomic_beta_lcbd)) |>   # 1. 결측제외
  select(siteID, plotID, n_stems,
         richness_observed) |>              # 2. 열줄이기
  mutate(stems_per_sp =n_stems / richness_observed) |>  # 3. 열만들기
  group_by(siteID) |>                       # 4. 묶기
  summarise(
    n_plot    = n(),
    rich_mean = round(mean(richness_observed), 2)) |>
  arrange(desc(rich_mean))                  # 5. 정렬

res
