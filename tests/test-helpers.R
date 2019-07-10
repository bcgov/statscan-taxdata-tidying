# Copyright 2019 Province of British Columbia
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.

tidy_spec_from_raw <- function(raw) {
  col_classes <- unname(map_chr(raw, class))
  
  
  one_dig_cls <- case_when(
    col_classes == "character" ~ "c",
    col_classes == "integer" ~ "i",
    col_classes == "numeric" ~ "d",
    col_classes == "double" ~ "d",
    col_classes == "logical" ~ "l",
    col_classes == "factor" ~ "f",
    col_classes == "Date" ~ "D",
    col_classes == "date time" ~ "T",
    col_classes == "time" ~ "t"
  )
  
  paste0("d", paste0(one_dig_cls, collapse = ""))
}


compare_raw_to_tidy <- function(col, raw, tidy) {
  ## Find position of named col
  col_position_integer <- match(col, names(tidy))
  
  ## Sort the raw and tidy data columns
  sorted_tidy <- sort(tidy[[col_position_integer]])
  sorted_raw <- sort(raw[[col_position_integer - 1]]) ## tidy adds year.
  
  if (all(sorted_raw %in% sorted_tidy)) {
    return(data.frame(col = col, valid = TRUE))
  } else{
    data.frame(col = col, valid = FALSE)
  }
}


## Take a vector of numbers and determines if any decimals exist
is_decimal <- function(x){
  x <- x[!is.na(x)]
  any(!(floor(x) == x))
}

## Create summary data.frame of rounding errors
check_numeric_cols_for_rounding <- function(x){
  message(basename(x))
  trans_sum <- read_csv(x, na = c("", "X")) %>% 
    summarise_if(is.numeric, is_decimal) %>% 
    gather()
  
  non_num_names <- select_if(read_csv(x, na = c("", "X")), !is.numeric) %>% 
    names()
  
  rounding_cols <- any(trans_sum$value)
  
  if(rounding_cols == TRUE){
    data.frame(
      file = basename(x),
      rounding = rounding_cols,
      cols = paste0(trans_sum$key[trans_sum$value], collapse = ","),
      non_num_col = paste0(non_num_names, collapse = ",")
    ) 
  } else(
    data.frame(
      file = basename(x),
      rounding = rounding_cols,
      cols = NA_character_,
      non_num_col = paste0(non_num_names, collapse = ",")
    )
  )
}