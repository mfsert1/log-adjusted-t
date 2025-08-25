set.seed(1)
x <- rnorm(50)
y <- rnorm(50, 0.2)

log_adj_t_test(x, y, base = 10)
