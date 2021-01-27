#' Name Usage: Search
#'
#' @export
#' @param q (character) vector of one or more scientific names
#' @param dataset_key (character) dataset key
#' @param minRank,maxRank (character) filter by rank. one of: domain, superkingdom,
#' kingdom, subkingdom, infrakingdom, superphylum, phylum, subphylum,
#' infraphylum, superclass, class, subclass, infraclass, parvclass,
#' superlegion, legion, sublegion, infralegion, supercohort, cohort,
#' subcohort, infracohort, magnorder, superorder, grandorder, order,
#' suborder, infraorder, parvorder, superfamily, family, subfamily,
#' infrafamily, supertribe, tribe, subtribe, infratribe, suprageneric name,
#' genus, subgenus, infragenus, supersection, section, subsection, superseries,
#' series, subseries, infrageneric name, species aggregate, species,
#' infraspecific name, grex, subspecies, cultivar group, convariety,
#' infrasubspecific name, proles, natio, aberration, morph, variety,
#' subvariety, form, subform, pathovar, biovar, chemovar, morphovar, phagovar,
#' serovar, chemoform, forma specialis, cultivar, strain, other, unranked
#' @param nomstatus (character) filter by nomenclatural status. one of: ok,
#' unavailable, illegitimate, variant, conserved, rejected, doubtful, unevaluated
#' @param status (character) filter by taxonomic status. one of: accepted,
#' doubtful, ambiguous synonym
#' @param issue (character) filter by issue found
#' @param publishedIn (character) reference id to filter names by
#' @param facet (character) request a facet to be returned. one of:
#' dataset_key, rank, nom_status, status, issue, type, field. facet
#' limit default: 50
#' @param sortBy (character) one of: "relevance", "name", "taxonomic",
#' "index_name_id", or "native"
#' @param content (character) one of: 'scientific_name' or 'authorship'
#' @param highlight (logical) `TRUE` or `FALSE`. default: `NULL`
#' @param reverse (logical) `TRUE` or `FALSE`. default: `NULL`
#' @param fuzzy (logical) `TRUE` or `FALSE`. default: `NULL`
#' @param type (character) one of: 'prefix', 'whole_words', 'exact'
#' @template args
#' @examples 
#' if (cp_up("/nameusage/search?q=Apis")) {
#' cp_nu_search(q="Apis", limit = 1)
#' }
#' \dontrun{
#' cp_nu_search(q="Agapostemon")
#' cp_nu_search(q="Agapostemon", dataset_key = 3)
#' cp_nu_search(q="Agapostemon", minRank = "genus")
#' cp_nu_search(q="Agapostemon", nomstatus = "doubtful")
#' cp_nu_search(q="Agapostemon", status = "accepted")
#' cp_nu_search(q="Bombus", facet = "rank")
#' cp_nu_search(q="Agapostemon", dataset_key = 3, hasField="uninomial")
#' 
#' x <- cp_nu_search(q="Poa")
#' x
#' x$result
#' x$result$usage
#' x$result$usage$name
#' }
cp_nu_search <- function(q = NULL, dataset_key = NULL, minRank = NULL,
  maxRank = NULL, content = NULL, highlight = NULL, reverse = NULL,
  fuzzy = NULL, type = NULL, nomstatus = NULL, status = NULL, issue = NULL,
  publishedIn = NULL, facet = NULL, sortBy = NULL,
  start = 0, limit = 10, ...) {

  assert(start, c("numeric", "integer"))
  assert(limit, c("numeric", "integer"))
  assert(highlight, "logical")
  assert(content, "character")
  assert(reverse, "logical")
  assert(fuzzy, "logical")
  args <- cc(list(q = q, dataset_key = dataset_key, minRank = minRank,
    maxRank = maxRank, content = content,
    highlight = as_log(highlight), reverse = as_log(reverse),
    fuzzy = as_log(fuzzy), type = type,
    nomstatus = nomstatus, status = status, issue = issue,
    publishedIn = publishedIn, facet = facet,
    sortBy = sortBy, offset = start, limit = limit))
  tmp <- cp_GET(col_base(), "nameusage/search", query = args, ...)
  tmp$result <- tibble::as_tibble(tmp$result)
  tmp <- cp_meta(tmp)
  return(tmp)
}
