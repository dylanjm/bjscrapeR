#' National Crime Victimization Survey - Personal Codebook
#'
#' A tidy dataset describing the variables found in the personal ncvs dataset.
#' Each row represents a value associated with a specific variable.
#'
#' @format A \link[tibble]{tibble} with 89 rows and 5 variables:
#' \describe{
#' \item{ncvs_p_id}{ Variable Id}
#' \item{ncvs_p_name}{ Human Readable Variable Name}
#' \item{ncvs_p_desc}{ Short description of Variable}
#' \item{ncvs_p_values}{ Human Readable Values}
#' \item{ncvs_p_factor_values}{ Factor Values Assigned to Values}
#' }
#'
#' @source Methodology - \url{https://www.bjs.gov/developer/ncvs/methodology.cfm}
#' @source XML File - \url{https://api.bjs.ojp.gov/bjs/ncvs/v2/personal/fields}
"ncvs_personal_codebook"
