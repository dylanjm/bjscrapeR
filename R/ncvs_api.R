#' @title Request Data from the National Crime Victimization Survey (NCVS)
#' @description Returns data from NCVS API
#' @param year These data archives span all the way back from 1993 to 2016. The default is 2016
#' @param dataset The API provides two different datasets, the personal victimization, and household victimization for all years.
#' @param population A boolean value specifying whether to return personal victimization population of incidents reported to the NCVS by year.
#' @param ... Any additional parameters
#' @return A tibble containing information downloaded from API.
#' @importFrom readr read_csv
#' @keywords bjs crime victimization law policy
#' @export ncvs_api
#' @seealso \url{https://www.bjs.gov/developer/ncvs/developers.cfm#/bjs/ncvs/v2/personal/population/{year}}
#' @examples
#'
#' # A request for personal victimization survey for the year 2012
#' dat <- ncvs_api(year = 2012, dataset = "personal", population = FALSE)
#'
#' # A requestion for household victimization survey for the year 1994
#' dat <- ncvs_api(year = 1994, dataset = "household", population = FALSE)
#'
#'
ncvs_api <- function(year = 2016, dataset = "personal", population = FALSE, ...){

  dataset_options <- c("personal", "household")
  if (!isTRUE(any(grepl(dataset, dataset_options)))){
    rlang::abort("select dataset as 'personal' or 'household'")
  }

  if (!is.logical(population)) {
    rlang::abort("boolean value TRUE/FALSE required for population")
  }

  if (population == TRUE) {
    ncvs_url <- glue::glue("https://api.bjs.ojp.gov/bjs/ncvs/v2/{dataset}/population/{year}?format=csv")
  } else {
    ncvs_url <- glue::glue("https://api.bjs.ojp.gov/bjs/ncvs/v2/{dataset}/{year}?format=csv")
  }

  message("Trying BJS Servers...")
  ncvs_dat <- read_csv(ncvs_url, col_types = cols())
  message("Payload Successful")

  return(ncvs_dat)
}
