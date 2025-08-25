#' Legacy wrapper (deprecated)
#' @export
logAdjT <- function(x, y) {
  .Deprecated("log_adj_t_test",
              msg = "logAdjT() is deprecated; use log_adj_t_test(x, y, base = 10, ...).")
  log_adj_t_test(x = x, y = y, base = 10, var.equal = TRUE)
}
