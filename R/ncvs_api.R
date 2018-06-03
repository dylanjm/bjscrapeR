#' @title Request Data from the National Crime Victimization Survey (NCVS)
#' @description Returns data from NCVS API
#' @param year These data-archives span all the way back from 1993 to 2016. Currently there is no way to query multiple years at a time. The default year is 2016.
#' @param dataset The API provides two different datasets, the personal victimization, and household victimization for all years.
#' @param population A boolean value specifying whether to return personal victimization population of incidents reported to the NCVS by year.
#' @param ... Any additional parameters
#' @return A tibble containing information downloaded from API.
#' @importFrom readr read_csv cols
#' @importFrom glue glue
#' @importFrom dplyr %>%
#' @importFrom tibble is_tibble
#' @keywords bjs crime victimization law policy
#' @note \strong{Please be aware of the Decennial Sample Redesign:} "In 2006 and 2016, the NCVS sample was redesigned to reflect changes in the population based on the most recent Decennial Census. The redesign impacted the comparability of 2006 and 2016 estimates to prior years of data. Use caution when comparing 2006 and 2016 estimates to other years. See Criminal Victimization, 2006 Technical Notes \emph{(BJS Web, NCJ 219413, December 2007)}, Criminal Victimization, 2007 \emph{(BJS Web, NCJ 224390, December 2008)} and Criminal Victimization, 2016 \emph{(BJS Web, NCJ 250652, November 2017)} for more information."
#' @export ncvs_api
#' @seealso \url{https://www.bjs.gov/developer/ncvs/methodology.cfm}
#' @examples
#'
#' # A request for personal victimization survey for the year 2012
#' \donttest{dat <- ncvs_api(year = 2012, dataset = "personal", population = FALSE)}
#'
#' # A request for household victimization survey for the year 1994
#' \donttest{dat <- ncvs_api(year = 1994, dataset = "household", population = FALSE)}
#'
ncvs_api <- function(year = 2016, dataset = "personal", population = FALSE, ...){

  dataset_options <- c("personal", "household")
  if (!isTRUE(any(grepl(dataset, dataset_options)))){
    stop("select dataset as 'personal' or 'household'")
  }

  if (!is.logical(population)) {
    stop("boolean value TRUE/FALSE required for population")
  }

  if (population == TRUE) {
    ncvs_url <- glue("https://api.bjs.ojp.gov/bjs/ncvs/v2/{dataset}/population/{year}?format=csv")
  } else {
    ncvs_url <- glue("https://api.bjs.ojp.gov/bjs/ncvs/v2/{dataset}/{year}?format=csv")
  }

  message("Trying BJS Servers...")
  ncvs_dat <- read_csv(ncvs_url, col_types = cols())

  if (is_tibble(ncvs_dat) && nrow(ncvs_dat) == 0) {
    stop("Query returned empty data frame")
  }
  else {
    message("Payload Successful")
  }

  return(ncvs_dat)
}

