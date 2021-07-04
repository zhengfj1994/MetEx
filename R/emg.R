## -----------------------------------------------------------------------------
## Skewed Gaussian
## -----------------------------------------------------------------------------

#' @title Gaussian Error function
#'
#' @description Implementation of the gaussian error function
#' The functions come from peakPantheR, because they cannot be used alone for the time being, we temporarily put them in MetEx and marked the references.
#'
#' @param x (numeric) value at which to evaluate the gaussian error function
#'
#' @return Value of the gaussian error function evaluated at x
gaussian_erf <- function(x) {
  return(2 * stats::pnorm(x * sqrt(2)) - 1)
}


#' @title Gaussian Error function
#'
#' @description Implementation of the gaussian error function
#' The functions come from peakPantheR, because they cannot be used alone for the time being, we temporarily put them in MetEx and marked the references.
#'
#' @param x (numeric) value at which to evaluate the gaussian error function
#'
#' @return Value of the gaussian error function evaluated at x
gaussian_cerf <- function(x) {
  return(1 - (2 * stats::pnorm(x * sqrt(2)) - 1))
}


#' @title Implementation of the Skewed Gaussian peak shape for use with
#' minpack.lm
#'
#' @description Implementation of the Skewed Gaussian peak shape for use with minpack.lm.
#' The functions come from peakPantheR, because they cannot be used alone for the time being, we temporarily put them in MetEx and marked the references.
#'
#' @param params (list) skewed gaussian parameters (\code{params$gamma},
#' \code{params$center}, \code{params$sigma}, \code{params$amplitude})
#' @param xx (numeric) values at which to evalute the skewed gaussian
#'
#' @return value of the skewed gaussian evaluated at xx
skewedGaussian_minpack.lm <- function(params, xx) {
  erf_term <- 1 + gaussian_erf((params$gamma * (xx-params$center))/
                                 params$sigma * sqrt(2))
  yy <- (params$amplitude/(params$sigma * sqrt(2 * pi))) *
    exp(-(xx - params$center)^2/2 * params$sigma^2) * erf_term

  return(yy)
}

#' @title Implementation of the Exponentially Modified Gaussian (EMG) peak
#' shape for use with minpack.lm
#'
#' @description Implementation of the  Exponentially Modified Gaussian (EMG) peak shape for use with minpack.lm
#' The functions come from peakPantheR, because they cannot be used alone for the time being, we temporarily put them in MetEx and marked the references.
#'
#' @param params (list) exponentiall modified gaussian parameters
#' (\code{params$gamma}, \code{params$center}, \code{params$sigma},
#' \code{params$amplitude})
#' @param xx (numeric) values at which to evalute the exponentially
#' modified gaussian
#'
#' @return value of the exponentially modified gaussian evaluated at xx
emgGaussian_minpack.lm <- function(params, xx) {
  cerf_term <- gaussian_cerf((params$center + params$gamma *
                                (params$sigma^2) - xx)/(params$sigma * sqrt(2)))
  yy <- (params$amplitude*params$gamma/2) *
    exp(params$gamma*(params$center - xx +
                        (params$gamma * (params$sigma^2)/2))) * cerf_term

  return(yy)
}

#' @title Skewed Gaussian minpack.lm objective function
#'
#' @description Skewed Gaussian minpack.lm objective function, calculates residuals using the skewed gaussian Peak Shape
#' The functions come from peakPantheR, because they cannot be used alone for the time being, we temporarily put them in MetEx and marked the references.
#'
#' @param params (list) skewed gaussian parameters (\code{params$gamma},
#' \code{params$center}, \code{params$sigma}, \code{params$amplitude})
#' @param observed (numeric) observed y value at xx
#' @param xx (numeric) value at which to evalute the skewed gaussian
#'
#' @return difference between observed and expected skewed gaussian value
#' evaluated at xx
skewedGaussian_minpack.lm_objectiveFun <- function(params, observed, xx) {
  return(observed - skewedGaussian_minpack.lm(params, xx))
}

#' @title Exponentially Modified Gaussian minpack.lm objective function
#'
#' @description Exponentially Modified Gaussian (EMG) minpack.lm objective function, calculates residuals using the EMG Peak Shape
#' The functions come from peakPantheR, because they cannot be used alone for the time being, we temporarily put them in MetEx and marked the references.
#'
#' @param params (list) exponentially modified gaussian parameters
#' (\code{params$gamma}, \code{params$center}, \code{params$sigma},
#' \code{params$amplitude})
#' @param observed (numeric) observed y value at xx
#' @param xx (numeric) value at which to evalute the exponentially
#' modified gaussian
#'
#' @return difference between observed and expected exponentially modified
#' gaussian value evaluated at xx
emgGaussian_minpack.lm_objectiveFun <- function(params, observed, xx) {
  return(observed - emgGaussian_minpack.lm(params, xx))
}

#' @title Guess function for initial skewed gaussian parameters and bounds
#'
#' @description Guess function for initial skewed gaussian parameters and bounds, at the moment only checks the x position
#' The functions come from peakPantheR, because they cannot be used alone for the time being, we temporarily put them in MetEx and marked the references.
#'
#' @param x (numeric) x values (e.g. retention time)
#' @param y (numeric) y observed values (e.g. spectra intensity)
#'
#' @return A list of guessed starting parameters \code{list()$init_params},
#' lower \code{list()$lower_bounds} and upper bounds \code{list()$upper_bounds}
#' (\code{$gamma}, \code{$center}, \code{$sigma}, \code{$amplitude})
skewedGaussian_guess <- function(x, y) {
  # set center as x position of max y value (e.g. highest spectra intensity)
  center_guess <- x[which.max(y)]
  # init_param
  init_params <- list(amplitude=1e+07, center=center_guess, sigma=1, gamma=1)
  # lower_bounds
  lower_bounds <- list(amplitude=0, center=center_guess-3, sigma=0,gamma=-0.1)
  # upper_bounds
  upper_bounds <- list(amplitude=1e+09, center=center_guess+3, sigma=5,
                       gamma = 5)

  return(list(init_params = init_params, lower_bounds = lower_bounds,
              upper_bounds = upper_bounds))
}

#' @title Guess function for initial exponentially modified gaussian
#' parameters and bounds
#'
#' @description Guess function for initial exponentially modified gaussian parameters and bounds, at the moment only checks the x position
#' The functions come from peakPantheR, because they cannot be used alone for the time being, we temporarily put them in MetEx and marked the references.
#'
#' @param x (numeric) x values (e.g. retention time)
#' @param y (numeric) y observed values (e.g. spectra intensity)
#'
#' @return A list of guessed starting parameters \code{list()$init_params},
#' lower \code{list()$lower_bounds} and upper bounds \code{list()$upper_bounds}
#' (\code{$gamma}, \code{$center}, \code{$sigma}, \code{$amplitude})
emgGaussian_guess <- function(x, y) {
  # set center as x position of max y value (e.g. highest spectra intensity)
  center_guess <- x[which.max(y)]
  # init_param
  init_params <- list(amplitude=1e+07, center=center_guess, sigma=1, gamma=1)
  # lower_bounds
  lower_bounds <- list(amplitude=0, center=center_guess-10, sigma=0,gamma=-0.1)
  # upper_bounds
  upper_bounds <- list(amplitude=1e+09, center=center_guess+10, sigma=20,
                       gamma = 5)

  return(list(init_params = init_params, lower_bounds = lower_bounds,
              upper_bounds = upper_bounds))
}
