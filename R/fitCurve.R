#' @title Curve fitting using minpack.lm
#'
#' @description Fit different curve models using \code{minpack}. Fitting
#' parameters can be passed or guessed.
#' We can't use fitCurve in the existing peakPantheR (1.6.1), so we can only build this function into MetEx, but we have marked its reference.
#'
#' @param x (numeric) x values (e.g. retention time)
#' @param y (numeric) y observed values (e.g. spectra intensity)
#' @param curveModel (str) name of the curve model to fit (currently
#' \code{skewedGaussian} and \code{emgGaussian})
#' @param params (list or str) either 'guess' for automated parametrisation or
#' list of initial parameters (\code{$init_params}), lower parameter bounds
#' (\code{$lower_bounds}) and upper parameter bounds (\code{$upper_bounds})
#'
#' @export fitCurve
#' @return A 'peakPantheR_curveFit': a list of fitted curve parameters,
#' \code{fitStatus} from \code{nls.lm$info} and curve shape name
#' \code{curveModel}. \code{fitStatus=0} unsuccessful completion: improper input
#' parameters, \code{fitStatus=1} successful completion: first convergence test
#' is successful, \code{fitStatus=2} successful completion: second convergence
#' test is successful, \code{fitStatus=3} successful completion: both
#' convergence test are successful, \code{fitStatus=4} questionable completion:
#' third convergence test is successful but should be carefully examined
#' (maximizers and saddle points might satisfy), \code{fitStatus=5} unsuccessful
#' completion: excessive number of function evaluations/iterations
#'
#' @details
#' ## Examples cannot be computed as the function is not exported:
#' ## x is retention time, y corresponding intensity
#' input_x  <- c(3362.102, 3363.667, 3365.232, 3366.797, 3368.362, 3369.927,
#'             3371.492, 3373.057, 3374.622, 3376.187, 3377.752, 3379.317,
#'             3380.882, 3382.447, 3384.012, 3385.577, 3387.142, 3388.707,
#'             3390.272, 3391.837, 3393.402, 3394.966, 3396.531, 3398.096,
#'             3399.661, 3401.226, 3402.791, 3404.356, 3405.921, 3407.486,
#'             3409.051)
#' input_y  <- c(51048, 81568, 138288, 233920, 376448, 557288, 753216, 938048,
#'             1091840, 1196992, 1261056, 1308992, 1362752, 1406592, 1431360,
#'             1432896, 1407808, 1345344, 1268480, 1198592, 1126848, 1036544,
#'             937600, 849792, 771456, 692416, 614528, 546088, 492752,
#'             446464, 400632)
#'
#' ## Fit
#' fitted_curve <- fitCurve(input_x, input_y, curveModel='skewedGaussian',
#'                         params='guess')
#'
#' ## Returns the optimal fitting parameters
#' fitted_curve
#' #
#' # $amplitude
#' # [1] 275371.1
#' #
#' # $center
#' # [1] 3382.577
#' #
#' # $sigma
#' # [1] 0.07904697
#' #
#' # $gamma
#' # [1] 0.001147647
#' #
#' # $fitStatus
#' # [1] 2
#' #
#' # $curveModel
#' # [1] 'skewedGaussian'
#' #
#' # attr(,'class')
#' # [1] 'peakPantheR_curveFit'
fitCurve <- function(x, y, curveModel = "skewedGaussian", params = "guess") {

  fitCurve_skewedGaussian <- function(x, y, useGuess, params, curveModel) {
    fittedCurve <- list()

    # Guess parameters and bounds
    if (useGuess) {
      new_params <- skewedGaussian_guess(x, y)
    } else {
      new_params <- params
    }

    # ensure order of init params and bounds (init is a list, lower and
    # upper are ordered numeric vectors)
    init    <- list(amplitude = new_params$init_params$amplitude,
                    center = new_params$init_params$center,
                    sigma = new_params$init_params$sigma,
                    gamma = new_params$init_params$gamma)
    lower   <- unlist(c(new_params$lower_bounds["amplitude"],
                        new_params$lower_bounds["center"],
                        new_params$lower_bounds["sigma"],
                        new_params$lower_bounds["gamma"]))
    upper   <- unlist(c(new_params$upper_bounds["amplitude"],
                        new_params$upper_bounds["center"],
                        new_params$upper_bounds["sigma"],
                        new_params$upper_bounds["gamma"]))

    # perform fit
    resultFit <- minpack.lm::nls.lm(par = init,
                                    lower = lower,
                                    upper = upper,
                                    fn = skewedGaussian_minpack.lm_objectiveFun,
                                    observed = y, xx = x)

    # prepare output
    fittedCurve <- resultFit$par
    fittedCurve$fitStatus <- resultFit$info
    fittedCurve$curveModel <- curveModel
    class(fittedCurve) <- "peakPantheR_curveFit"

    return(fittedCurve)
  }

  fitCurve_emgGaussian <- function(x, y, useGuess, params, curveModel) {
    fittedCurve <- list()

    # Guess parameters and bounds
    if (useGuess) {
      new_params <- emgGaussian_guess(x, y)
    } else {
      new_params <- params
    }

    # ensure order of init params and bounds (init is a list, lower and
    # upper are ordered numeric vectors)
    init    <- list(amplitude = new_params$init_params$amplitude,
                    center = new_params$init_params$center,
                    sigma = new_params$init_params$sigma,
                    gamma = new_params$init_params$gamma)
    lower   <- unlist(c(new_params$lower_bounds["amplitude"],
                        new_params$lower_bounds["center"],
                        new_params$lower_bounds["sigma"],
                        new_params$lower_bounds["gamma"]))
    upper   <- unlist(c(new_params$upper_bounds["amplitude"],
                        new_params$upper_bounds["center"],
                        new_params$upper_bounds["sigma"],
                        new_params$upper_bounds["gamma"]))

    # perform fit
    resultFit <- minpack.lm::nls.lm(par = init,
                                    lower = lower,
                                    upper = upper,
                                    fn = emgGaussian_minpack.lm_objectiveFun,
                                    observed = y, xx = x)

    # prepare output
    fittedCurve <- resultFit$par
    fittedCurve$fitStatus <- resultFit$info
    fittedCurve$curveModel <- curveModel
    class(fittedCurve) <- "peakPantheR_curveFit"

    return(fittedCurve)
  }

  # Check inputs x and y length
  if (length(x) != length(y)) {
    stop("Error: length of \"x\" and \"y\" must match!") }
  # known curveModel
  known_curveModel <- c("skewedGaussian", "emgGaussian")
  if (!(curveModel %in% known_curveModel)) {
    stop(paste("Error: \"curveModel\" must be one of:",
               paste(known_curveModel, collapse=', '))) }
  # params
  if (!(typeof(params) %in% c("list", "character"))) {
    stop("Error: \"params\" must be a list or \"guess\"") }

  useGuess <- TRUE
  if (any(params != "guess")) {
    useGuess <- FALSE
    # check init_params, lower and upper bounds are defined
    if (!all(c("init_params", "lower_bounds", "upper_bounds") %in%
             names(params))) {
      stop("Error: \"params must be a list of \"init_params\", ",
           "\"lower_bounds\" and \"upper_bounds\"") }
    # init_params is list
    if (typeof(params$init_params) != "list") {
      stop("Error: \"params$init_params\" must be a list of parameters")
    }
    # lower_bounds is list
    if (typeof(params$lower_bounds) != "list") {
      stop("Error: \"params$lower_bounds\" must be a list of parameters")
    }
    # upper_bounds is list
    if (typeof(params$upper_bounds) != "list") {
      stop("Error: \"params$upper_bounds\" must be a list of parameters")
    }
  }

  # Init
  fittedCurve <- list()
  # Run fitting skewed gaussian
  if (curveModel == "skewedGaussian") {
    fittedCurve <- fitCurve_skewedGaussian(x, y, useGuess, params,
                                           curveModel)
  }
  else if (curveModel == 'emgGaussian') {
    fittedCurve <- fitCurve_emgGaussian(x, y, useGuess, params,
                                        curveModel)
  }
  # for future curve shapes } else if () { }
  return(fittedCurve)
}
