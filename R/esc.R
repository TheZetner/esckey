# These functions exist to browse environment while testing

#' escUI
#'
#' Place `escUI()` call somewhere within your `ui` definition
#'
#' @import shiny
#'
#' @param id "esc"
#'
#' @return esckey module UI
#' @examples
#' \dontrun{escUI()}
#' @export
#'
escUI <- function(id = "esc") {
  ns <- NS(id)
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
#' @import shiny
#' @param id module namespace id "esc"
#' @param i shiny input
#' @param o shiny output
#' @param ... any other NAMED objects from main shiny process to pass to browser
#'
#' @return esckey module server
#' @examples
#' \dontrun{escServer(i = input, o = output)}
#'
#' @export
#'
escServer <- function(id = "esc", i, o, ...) {
  moduleServer(id, function(input, output, session) {
    observe({
      if (!is.null(input$key) && input$key == "Escape") {
        message("Examine input with i, output with o")
        args <- list(...)
        browser()
      }
    })
  }
  )
}
