# These functions exist to browse environment while testing

#' escUI
#'
#' Place `escUI()` call somewhere within your `ui` definition
#'
#' @importFrom shinyjs runExample
#'
#' @param id "esc"
#'
#' @return esckey module UI
#' @examples
#' \dontrun{
#' # Placed in app UI function
#' escUI()
#' }
#' @export
#'
escUI <- function(id = "esc") {
  ns <- shiny::NS(id)
  js <- sprintf(
    '$(document).on("keydown", function (e) { Shiny.onInputChange("%s", e.code); }); $(document).on("keyup", function (e) { Shiny.onInputChange("%s", null); });',
    ns("key"),
    ns("key")
  )
  tagList(
    shinyjs::useShinyjs(),
    tags$head(tags$script(HTML(js)))
    )
}

#' escServer
#'
#' Place `escServer(i = input, o = output)` call somewhere within your `server` definition.
#' Respond to `esc` keypress with `browser()`
#' Must provide names for objects provided with `...` eg. `foo = foo`
#'
#' @importFrom shinyjs runExample
#'
#' @param id module namespace id "esc"
#' @param i shiny input
#' @param o shiny output
#' @param ... any other NAMED objects from main shiny process to pass to browser
#'
#' @return esckey module server
#'
#' @examples
#' \dontrun{
#' # Placed in app server function
#' escServer(i = input, o = output)
#' }
#'
#' @export
#'
escServer <- function(id = "esc", i, o, ...) {
  shiny::moduleServer(id, function(input, output, session) {
    shiny::observe({
      if (!is.null(input$key) && input$key == "Escape") {
        message("Examine input with i, output with o")
        args <- list(...)
        browser()
      }
    })
  }
  )
}
