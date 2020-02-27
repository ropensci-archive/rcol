#' Name Usage: Search
#'
#' @export
#' @param q (character) main query string
#' @param id (character) the name identifier
#' @param dataset_key (character) dataset key
#' @param rank (character) filter by rank. one of: domain, superkingdom,
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
#' @param type (character) filter by name type. one of: scientific, virus,
#' hybrid-formula, cultivar, otu, placeholder, none
#' @param publishedIn (character) reference id to filter names by
#' @param hasField (logical) filter that only includes name where the
#' requested name property is not `NULL`
#' @param facet (character) request a facet to be returned. one of:
#' dataset_key, rank, nom_status, status, issue, type, field. facet
#' limit default: 50
#' @param sortBy (character) one of: "relevance", "name", "key"
#' @param start (integer) requested number of offset records. Default: 0
#' @param limit (integer) requested number of maximum records to be returned.
#' Default: 10; max: 1000
#' @param ... curl options passed on to [crul::verb-GET]
#' @examples \dontrun{
#' cp_nameusage_search(q="Apis", rank = "genus")
#' cp_nameusage_search(q="Agapostemon")
#' cp_nameusage_search(q="Agapostemon", dataset_key = 3)
#' cp_nameusage_search(q="Agapostemon", rank = "genus")
#' cp_nameusage_search(q="Agapostemon", nomstatus = "doubtful")
#' cp_nameusage_search(q="Agapostemon", status = "accepted")
#' cp_nameusage_search(type = "virus")
#' cp_nameusage_search(q="Bombus", facet = "rank")
#' 
#' x <- cp_nameusage_search(q="Poa")
#' x
#' x$result
#' x$result$usage
#' x$result$usage$name
#' }
cp_nameusage_search <- function(q = NULL, id = NULL, dataset_key = NULL, rank = NULL,
  nomstatus = NULL, status = NULL, issue = NULL, type = NULL,
  publishedIn = NULL, hasField = NULL, facet = NULL, sortBy = NULL,
  start = 0, limit = 10, ...) {

  assert(start, c("numeric", "integer"))
  assert(limit, c("numeric", "integer"))
  args <- cc(list(q = q, id = id, dataset_key = dataset_key, rank = rank,
    nomstatus = nomstatus, status = status, issue = issue, type = type,
    publishedIn = publishedIn, hasField = hasField, facet = facet,
    sortBy = sortBy, offset = start, limit = limit))
  tmp <- cp_GET(colplus_base(), "nameusage/search", query = args, ...)
  tmp$result <- tibble::as_tibble(tmp$result)
  tmp <- cp_meta(tmp)
  return(tmp)
}
