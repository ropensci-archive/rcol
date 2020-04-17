#' Name Matching
#' 
#' Match name against the name index
#'
#' @export
#' @template args
#' @param q (character) scientific name to match
#' @param rank (character) rank to restrict matches to. one of: domain,
#' superkingdom,
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
#' @param code (character) nomenclatural code to restrict matches to. one of:
#' bacterial, botanical, cultivated, viral, zoological, unknown
#' @param trusted (logical) if `TRUE`, unmatched name will be inserted into
#' the names index. default: `FALSE`
#' @param ver_bose (logical) if `TRUE`, list alternatively considered name
#' matches. default: `FALSE`
#' @examples \dontrun{
#' cp_name_match(q="Apis", rank = "genus")
#' cp_name_match(q="Agapostemon")
#' cp_name_match(q="Apis mellifera")
#' cp_name_match(q="Apis mellifer")
#' }
cp_name_match <- function(q = NULL, rank = NULL, code = NULL, trusted = NULL,
  ver_bose = NULL, start = 0, limit = 10, ...) {

  assert(q, "character")
  assert(rank, "character")
  assert(code, "character")
  assert(trusted, "logical")
  assert(ver_bose, "logical")
  assert(start, c("numeric", "integer"))
  assert(limit, c("numeric", "integer"))
  args <- cc(list(q = q, rank = rank, code = code, trusted = trusted,
    verbose = ver_bose, offset = start, limit = limit))
  cp_GET(colplus_base(), "name/matching", query = args, ...)
}
