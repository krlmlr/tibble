tbl_subset_matrix <- function(x, j) {
  cells <- matrix_to_cells(j, x)
  col_idx <- cells_to_col_idx(cells)

  if (is_empty(col_idx)) {
    return(unspecified())
  }

  values <- map2(x[col_idx], cells[col_idx], vec_slice)

  # Also checks conformity of vectors:
  unname(vec_c(!!!values, .name_spec = ~ .x))
}

tbl_subassign_matrix <- function(x, j, value) {
  stopifnot(vec_is(value), vec_size(value) == 1)

  cells <- matrix_to_cells(j, x)
  col_idx <- cells_to_col_idx(cells)

  x[col_idx] <- map2(x[col_idx], cells[col_idx], `vec_slice<-`, value)
  x
}

matrix_to_cells <- function(j, x) {
  stopifnot(is_bare_logical(j))
  stopifnot(identical(dim(j), dim(x)))

  # Need unlist(list(...)) because apply() isn't type stable if the return
  # has the same length everywhere
  # FIXME: Faster with a C implementation?
  cells <- unlist(apply(j, 2, function(x) list(which(x))), recursive = FALSE)
  cells
}

cells_to_col_idx <- function(cells) {
  sizes <- map_int(cells, vec_size)
  col_idx <- which(sizes > 0)

  col_idx
}
