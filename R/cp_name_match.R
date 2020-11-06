#' Name Matching
#' 
#' Match name against the name index
#'
#' @export
#' @template args
#' @param q (character) scientific name to match
#' @param rank (character) rank to restrict matches to. one of: domain,
#' realm, subrealm, superkingdom, kingdom, subkingdom, infrakingdom,
#' superphylum, phylum, subphylum, infraphylum, superclass, class,
#' subclass, infraclass, parvclass, superdivision, division, subdivision,
#' infradivision, superlegion, legion, sublegion, infralegion, supercohort,
#' cohort, subcohort, infracohort, gigaorder, magnorder, grandorder, mirorder,
#' superorder, order, nanorder, hypoorder, minorder, suborder, infraorder,
#' parvorder, megafamily, grandfamily, superfamily, epifamily, family,
#' subfamily, infrafamily, supertribe, tribe, subtribe, infratribe,
#' suprageneric_name, genus, subgenus, infragenus, supersection, section,
#' subsection, superseries, series, subseries, infrageneric_name,
#' species_aggregate, species, infraspecific_name, grex, subspecies,
#' cultivar_group, convariety, infrasubspecific_name, proles, natio,
#' aberration, morph, variety, subvariety, form, subform, pathovar, biovar,
#' chemovar, morphovar, phagovar, serovar, chemoform, forma_specialis,
#' cultivar, strain, other, unranked
#' @param code (character) nomenclatural code to restrict matches to. one of:
#' bacterial, botanical, cultivars, viral, zoological, phytosociological
#' @param trusted (logical) if `TRUE`, unmatched name will be inserted into
#' the names index. default: `FALSE`
#' @param ver_bose (logical) if `TRUE`, list alternatively considered name
#' matches. default: `FALSE`
#' @details Matches by the canonical name, it's authorship and rank.
#' Authorship matching is somewhat loose, but name matching is quite strict
#' and only allows for a few common misspellings frequently found in
#' epithets (silent h, gender suffix, double letters, i/y), but not in
#' uninomials. Suprageneric ranks are all considered to be the same,
#' otherwise a different rank results in a different match.
#' @examples \dontrun{
#' cp_name_match(q="Apis", rank = "genus")
#' cp_name_match(q="Agapostemon")
#' cp_name_match(q="Apis mellifera")
#' cp_name_match(q="Apis mellifer") # no fuzzy match apparently
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
