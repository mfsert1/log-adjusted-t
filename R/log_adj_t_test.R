#' Log-Adjusted t-Test
#'
#' Computes the log-adjusted t-statistic:
#' \deqn{t_d = |t|^{1 / \log_{10}(df)}, \quad p_d = 2 \{ 1 - F_t(|t_d|; df) \}}
#'
#' @param x A numeric vector representing sample 1.
#' @param y A numeric vector representing sample 2. If NULL, a one-sample test is run.
#' @param base Logarithm base (default = 10). Common choices: 10, 2, exp(1).
#' @param var.equal Logical; assume equal variances? (default = TRUE)
#' @param alternative Character string: "two.sided" (default), "less", or "greater".
#' @param conf.level Confidence level (default = 0.95)
#' @param paired Logical; whether to do a paired test (default = FALSE)
#' @param ... Additional arguments passed to [stats::t.test()].
#'
#' @return An object of class "htest" with components similar to [stats::t.test()],
#'   but using the adjusted statistic and p-value.
#'
#' @examples
#' set.seed(1)
#' x <- rnorm(50); y <- rnorm(50, 0.2)
#' log_adj_t_test(x, y, base = 10)
#' @export
log_adj_t_test <- function(x, y = NULL, base = 10,
                           var.equal = TRUE,
                           alternative = c("two.sided","less","greater"),
                           conf.level = 0.95,
                           paired = FALSE, ...) {
  alternative <- match.arg(alternative)

  # Classical t-test first
  tt <- stats::t.test(x, y,
                      var.equal = var.equal,
                      alternative = alternative,
                      conf.level = conf.level,
                      paired = paired, ...)

  t_val <- as.numeric(tt$statistic)
  df    <- as.numeric(tt$parameter)

  if (!is.finite(df) || df <= 1) {
    stop("Degrees of freedom (df) must be > 1 to apply the log adjustment.")
  }

  # Log-adjusted correction
  t_corr <- sign(t_val) * (abs(t_val))^(1 / log(df, base = base))
  p_corr <- 2 * (1 - stats::pt(abs(t_corr), df = df))

  out <- list(
    statistic   = c(t_d = t_corr),
    parameter   = c(df = df),
    p.value     = p_corr,
    method      = sprintf("Log-adjusted t-test (base = %s)", format(base)),
    null.value  = tt$null.value,
    alternative = tt$alternative,
    data.name   = tt$data.name,
    call        = match.call()
  )
  class(out) <- "htest"
  out
}

#' Legacy wrapper (deprecated)
#' @export
logAdjT <- function(x, y) {
  .Deprecated("log_adj_t_test",
              msg = "logAdjT() is deprecated; use log_adj_t_test(x, y, base = 10, ...).")
  log_adj_t_test(x, y, base = 10, var.equal = TRUE)
}
