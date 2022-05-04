#' Title
#' Give MSMS Score using spectral entropy.
#'
#' @param spec_query, measured ms2
#' @param spec_reference, ms2 in database
#' @param ms2_da, the tolerence between ms2Act and ms2DB
#'
#' @return scoreOfMS2
#' @export ms2ScoreSpectralEntropy
#' @references Li, Y., Kind, T., Folz, J. et al. Spectral entropy outperforms MS/MS dot product similarity for small-molecule compound identification. Nat Methods 18, 1524–1531 (2021). https://doi.org/10.1038/s41592-021-01331-z

ms2ScoreSpectralEntropy <- function(spec_query, spec_reference, ms2_da, need_clean_spectra = TRUE, noise_removal = 0.01){
  entropySimilarity <- spectral_entropy.calculate_entropy_similarity(spec_query,
                spec_reference,
                ms2_da,
                need_clean_spectra = need_clean_spectra,
                noise_removal = noise_removal)
  return(entropySimilarity)
}

tools.normalize_distance <- function(dist, dist_range){
  if (dist_range[2] == Inf){
    if (dist_range[1] == 0){
      result = 1 - 1 / (1 + dist)
    } else if (dist_range[1] == 1){
      result = 1 - 1 / dist
    } else {
      packageStartupMessage("Error")
    }
  } else if (dist_range[1] == -Inf){
    if (dist_range[2] == 0){
      result = -1 / (-1 + dist)
    } else{
      packageStartupMessage("Error")
    }
  } else {
    result = (dist - dist_range[1]) / (dist_range[2] - dist_range[1])
  }

  if (result < 0){
    result = 0
  } else if (result > 1) {
    result = 1
  }
  return(result)
}

spectral_similarity.similarity <- function(spectrum_query,
                       spectrum_library,
                       method,
                       ms2_ppm = NA,
                       ms2_da = NA,
                       need_clean_spectra = TRUE,
                       need_normalize_result = TRUE){

  # Calculate the similarity between two spectra, find common peaks.
  # If both ms2_ppm and ms2_da is defined, ms2_da will be used.
  # :param spectrum_query: The query spectrum, need to be in numpy array format.
  # :param spectrum_library: The library spectrum, need to be in numpy array format.
  # :param method: Supported methods:
  #         "entropy", "unweighted_entropy", "euclidean", "manhattan", "chebyshev",
  #         "squared_euclidean", "fidelity", "matusita", "squared_chord", "bhattacharya_1",
  #         "bhattacharya_2", "harmonic_mean", "probabilistic_symmetric_chi_squared",
  #         "ruzicka", "roberts", "intersection", "motyka", "canberra", "baroni_urbani_buser",
  #         "penrose_size", "mean_character", "lorentzian","penrose_shape", "clark",
  #         "hellinger", "whittaker_index_of_association", "symmetric_chi_squared",
  #         "pearson_correlation", "improved_similarity", "absolute_value", "dot_product",
  #         "dot_product_reverse", "spectral_contrast_angle", "wave_hedges", "jaccard",
  #         "dice", "inner_product", "divergence", "avg_l", "vicis_symmetric_chi_squared_3",
  #         "ms_for_id_v1", "ms_for_id", "weighted_dot_product"
  # :param ms2_ppm: The MS/MS tolerance in ppm.
  # :param ms2_da: The MS/MS tolerance in Da.
  # :param need_clean_spectra: Normalize spectra before comparing, required for not normalized spectrum.
  # :param need_normalize_result: Normalize the result into [0,1].
  # :return: Similarity between two spectra
  if (need_normalize_result){
    return(1 - spectral_similarity.distance(spectrum_query = spectrum_query,
                        spectrum_library = spectrum_library,
                        method = method,
                        need_clean_spectra = need_clean_spectra,
                        need_normalize_result = need_normalize_result,
                        ms2_ppm = ms2_ppm,
                        ms2_da = ms2_da))
  } else{
    return(0 - spectral_similarity.distance(spectrum_query = spectrum_query,
                        spectrum_library = spectrum_library,
                        method = method,
                        need_clean_spectra = need_clean_spectra,
                        need_normalize_result = need_normalize_result,
                        ms2_ppm = ms2_ppm,
                        ms2_da = ms2_da))
  }

}

math_distance.unweighted_entropy_distance <- function(p, q){
  # Unweighted entropy distance:
  #
  #   .. math::
  #
  #   -\frac{2\times S_{PQ}-S_P-S_Q} {ln(4)}, S_I=\sum_{i} {I_i ln(I_i)}
  merged = p + q # ???
  entropy_increase = 2 * scipy.stats.entropy(merged) - scipy.stats.entropy(p) - scipy.stats.entropy(q)
  return(entropy_increase)
}

math_distance.entropy_distance <- function(p, q){
  # Entropy distance:
  #
  #   .. math::
  #
  #   -\frac{2\times S_{PQ}^{'}-S_P^{'}-S_Q^{'}} {ln(4)}, S_I^{'}=\sum_{i} {I_i^{'} ln(I_i^{'})}, I^{'}=I^{w}, with\ w=0.25+S\times 0.5\ (S<1.5)
  p = math_distance._weight_intensity_by_entropy(p)
  q = math_distance._weight_intensity_by_entropy(q)
  return(math_distance.unweighted_entropy_distance(p, q))
}

math_distance._weight_intensity_by_entropy <- function(x){
  WEIGHT_START = 0.25
  ENTROPY_CUTOFF = 3
  weight_slope = (1-WEIGHT_START) / ENTROPY_CUTOFF
  if (sum(x) > 0){
    entropy_x = scipy.stats.entropy(x)
    if (entropy_x < ENTROPY_CUTOFF){
      weight = WEIGHT_START + weight_slope * entropy_x
      x = x^weight
      x_sum = sum(x)
      x = x / x_sum
    }
  }
  return(x)
}


spectral_similarity.distance <- function(spectrum_query,
                     spectrum_library,
                     method,
                     ms2_ppm = NA,
                     ms2_da = NA,
                     need_clean_spectra = TRUE,
                     need_normalize_result = TRUE){

  # Calculate the distance between two spectra, find common peaks.
  # If both ms2_ppm and ms2_da is defined, ms2_da will be used.
  #
  # :param spectrum_query: The query spectrum, need to be in numpy array format.
  # :param spectrum_library: The library spectrum, need to be in numpy array format.
  # :param method: Supported methods:
  #         "entropy", "unweighted_entropy", "euclidean", "manhattan", "chebyshev", "squared_euclidean", "fidelity", "matusita", "squared_chord", "bhattacharya_1", "bhattacharya_2", "harmonic_mean", "probabilistic_symmetric_chi_squared", "ruzicka", "roberts", "intersection", "motyka", "canberra", "baroni_urbani_buser", "penrose_size", "mean_character", "lorentzian", "penrose_shape", "clark", "hellinger", "whittaker_index_of_association", "symmetric_chi_squared", "pearson_correlation", "improved_similarity", "absolute_value", "dot_product", "dot_product_reverse", "spectral_contrast_angle", "wave_hedges", "jaccard", "dice", "inner_product", "divergence", "avg_l", "vicis_symmetric_chi_squared_3", "ms_for_id_v1", "ms_for_id", "weighted_dot_product"
  # :param ms2_ppm: The MS/MS tolerance in ppm.
  # :param ms2_da: The MS/MS tolerance in Da.
  # :param need_clean_spectra: Normalize spectra before comparing, required for not normalized spectrum.
  # :param need_normalize_result: Normalize the result into [0,1].
  # :return: Distance between two spectra

  methods_range <- list(
    entropy = c(0, log(4)),
    unweighted_entropy = c(0, log(4))
    # absolute_value = [0, 2],
    # avg_l = [0, 1.5],
    # bhattacharya_1 = [0, np.arccos(0) ** 2],
    # bhattacharya_2 = [0, np.inf],
    # canberra = [0, np.inf],
    # clark = [0, np.inf],
    # divergence = [0, np.inf],
    # euclidean = [0, np.sqrt(2)],
    # hellinger = [0, np.inf],
    # improved_similarity = [0, np.inf],
    # lorentzian = [0, np.inf],
    # manhattan = [0, 2],
    # matusita = [0, np.sqrt(2)],
    # mean_character = [0, 2],
    # motyka = [-0.5, 0],
    # ms_for_id = [-np.inf, 0],
    # ms_for_id_v1 = [0, np.inf],
    # pearson_correlation = [-1, 1],
    # penrose_shape = [0, np.sqrt(2)],
    # penrose_size = [0, np.inf],
    # probabilistic_symmetric_chi_squared = [0, 1],
    # similarity_index = [0, np.inf],
    # squared_chord = [0, 2],
    # squared_euclidean = [0, 2],
    # symmetric_chi_squared = [0, 0.5 * np.sqrt(2)],
    # vicis_symmetric_chi_squared_3 = [0, 2],
    # wave_hedges = [0, np.inf],
    # whittaker_index_of_association = [0, np.inf]
  )

  if (is.na(ms2_ppm) & is.na(ms2_da)){
    packageStartupMessage("MS2 tolerance need to be defined!")
  }
  if (need_clean_spectra){
    spectrum_query = tools.clean_spectrum(spectrum_query, ms2_ppm=ms2_ppm, ms2_da=ms2_da)
    spectrum_library = tools.clean_spectrum(spectrum_library, ms2_ppm=ms2_ppm, ms2_da=ms2_da)
  }
  if (nrow(spectrum_query) > 0 & nrow(spectrum_library) > 0){
    function_name = paste0("math_distance.", method, "_distance")
    spec_matched = tools.match_peaks_in_spectra(spec_a=spectrum_query,
                                          spec_b=spectrum_library,
                                          ms2_ppm=ms2_ppm, ms2_da=ms2_da)
    eval(parse(text = paste0("dist = ",function_name,"(spec_matched[,2], spec_matched[,3])")))

    # Normalize result
    if (need_normalize_result){
      dist_range = methods_range[[method]]
      dist = tools.normalize_distance(dist, dist_range)
    }
  }
  else {
    if (need_normalize_result){
      dist <- NA
    }else {
      dist <- NA
    }
  }
  return(dist)
}


tools.centroid_spec <- function(spec,
                          ms2_ppm = NA,
                          ms2_da = NA){
  # If both ms2_ppm and ms2_da is defined, ms2_da will be used.
  # Fast check is the spectrum need centroid.
  mz_array = spec[,1]
  need_centroid = 0
  if (length(mz_array) > 1){
    mz_delta = mz_array[2:length(mz_array)] - mz_array[1:(length(mz_array)-1)]
    if (!is.na(ms2_da)){
      if (min(mz_delta) <= ms2_da){
        need_centroid = 1
      }
    }
    else {
      if (min(mz_delta/mz_array[2:length(mz_array)]*1000000) <= ms2_ppm){
        need_centroid = 1
      }
    }
  }

  if (need_centroid){
    intensity_order <- order(spec[,2])
    spec_new = as.data.frame(matrix(data = NA, nrow = 0, ncol = 2))
    for (i in intensity_order){
      if (is.na(ms2_da)){
        if (is.na(ms2_ppm)){
          packageStartupMessage("MS2 tolerance not defined.")
        }
        else {
          mz_delta_allowed = ms2_ppm * 1e-6 * spec[i, 1]
        }
      } else {
        mz_delta_allowed = ms2_da
      }

      if (spec[i, 2] > 0){
        # Find left board for current peak
        i_left = i - 1
        while(i_left > 0){
          mz_delta_left = spec[i, 1] - spec[i_left, 1]
          if (mz_delta_left <= mz_delta_allowed){
            i_left <- i_left - 1
          }
          else {
            break
          }
        }
        i_left = i_left + 1

        # Find right board for current peak
        i_right = i + 1
        while(i_right <= nrow(spec)){
          mz_delta_right = spec[i_right, 1] - spec[i, 1]
          if (mz_delta_right <= mz_delta_allowed){
            i_right <- i_right + 1
          }
          else {
            break
          }
        }
        i_right <- i_right - 1
        # Merge those peaks
        intensity_sum = sum(spec[i_left:i_right, 2])
        intensity_weighted_sum = sum(spec[i_left:i_right, 1] * spec[i_left:i_right, 2])
        spec_new <- rbind(spec_new, c(intensity_weighted_sum / intensity_sum, intensity_sum))
        colnames(spec_new) <- c("V1","V2")
        spec[i_left:i_right, 2] = 0
      }
    }
    spec_new <- as.data.frame(spec_new)
    spec_new <- spec_new[order(spec_new[,1]),]
  }
  else {
    spec_new <- spec
  }
  return(spec_new)
}

tools.standardize_spectrum <- function(spectrum){
  # Sort spectrum by m/z, normalize spectrum to have intensity sum = 1.
  spectrum <- spectrum[order(spectrum[,1]),]
  intensity_sum <- sum(spectrum[,2])
  if (intensity_sum > 0){
    spectrum[,2] <- spectrum[,2]/intensity_sum
  }
  return(spectrum)
}

tools.clean_spectrum <- function(spectrum,
                           max_mz = NA,
                           noise_removal = 0.01,
                           ms2_da = 0.05,
                           ms2_ppm = NA){
  # Clean the spectrum with the following procedures:
  # 1. Remove ions have m/z higher than a given m/z (defined as max_mz).
  # 2. Centroid peaks by merging peaks within a given m/z (defined as ms2_da or ms2_ppm).
  # 3. Remove ions have intensity lower than max intensity * fixed value (defined as noise_removal)
  #
  #
  # :param spectrum: The input spectrum, need to be in 2-D list or 2-D numpy array
  # :param max_mz: The ions with m/z higher than max_mz will be removed.
  # :param noise_removal: The ions with intensity lower than max ion's intensity * noise_removal will be removed.
  # :param ms2_da: The MS/MS tolerance in Da.
  # :param ms2_ppm: The MS/MS tolerance in ppm.
  # If both ms2_da and ms2_ppm is given, ms2_da will be used.

  # # Check parameter
  # spectrum = check_spectrum(spectrum)
  # if ms2_da is None and ms2_ppm is None:
  #   raise RuntimeError("MS2 tolerance need to be set!")

  # 1. Remove the precursor ions
  if (!is.na(max_mz)){
    spectrum = spectrum[which(spectrum[,1] <= max_mz),]
  }

  # 2. Centroid peaks
  spectrum = spectrum[order(spectrum[,1]),]
  spectrum = tools.centroid_spec(spectrum, ms2_da=ms2_da, ms2_ppm=ms2_ppm)

  # 3. Remove noise ions
  if (!is.na(noise_removal) & nrow(spectrum) > 0){
    max_intensity <- max(spectrum[, 2])
    which(spectrum[, 2] >= max_intensity * noise_removal)
    spectrum <- spectrum[which(spectrum[, 2] >= max_intensity * noise_removal),]
  }

  # 4. Standardize the spectrum.
  spectrum = tools.standardize_spectrum(spectrum)
  return(spectrum)
}

scipy.stats.entropy <- function(intensity){
  intensity <- intensity/sum(intensity)
  intensity <- intensity[which(intensity != 0)]
  spectralEntropy <- -sum(intensity*log(intensity))
  return(spectralEntropy)
}

spectral_entropy.calculate_entropy <- function(spectrum,
                              max_mz = NA,
                              noise_removal = 0.01,
                              ms2_da = 0.05,
                              ms2_ppm = NA){
  # The spectrum will be cleaned with the procedures below. Then, the spectral entropy will be returned.
  #
  # 1. Remove ions have m/z higher than a given m/z (defined as max_mz).
  # 2. Centroid peaks by merging peaks within a given m/z (defined as ms2_da or ms2_ppm).
  # 3. Remove ions have intensity lower than max intensity * fixed value (defined as noise_removal)
  #
  # :param spectrum: The input spectrum, need to be in 2-D list or 2-D numpy array
  # :param max_mz: The ions with m/z higher than max_mz will be removed.
  # :param noise_removal: The ions with intensity lower than max ion's intensity * noise_removal will be removed.
  # :param ms2_da: The MS/MS tolerance in Da.
  # :param ms2_ppm: The MS/MS tolerance in ppm.
  # If both ms2_da and ms2_ppm is given, ms2_da will be used.
  spectrum = tools.clean_spectrum(spectrum,
                            max_mz = max_mz,
                            noise_removal = noise_removal,
                            ms2_da = ms2_da,
                            ms2_ppm = ms2_ppm)
  return(scipy.stats.entropy(spectrum[,2]))
}

tools.match_peaks_in_spectra <- function(spec_a,
                                   spec_b,
                                   ms2_ppm = NA,
                                   ms2_da = NA){
  a <- 1
  b <- 1

  spec_merged = as.data.frame(matrix(data = NA, ncol = 3, nrow = 0))
  peak_b_int <- 0

  while (a <= nrow(spec_a) & b <= nrow(spec_b)){
    # if (is.na(ms2_da)){
    #   ms2_da = ms2_ppm * spec_a[a, 1] * 1e6
    # }
    mass_delta <- spec_a[a, 1] - spec_b[b, 1]

    if (mass_delta < -ms2_da){
      # Peak only existed in spec a.
      spec_merged <- rbind(spec_merged,c(spec_a[a, 1], spec_a[a, 2], peak_b_int))
      peak_b_int <- 0
      a <- a + 1
    }
    else if (mass_delta > ms2_da){
      # Peak only existed in spec b.
      spec_merged <- rbind(spec_merged,c(spec_b[b, 1], 0, spec_b[b, 2]))
      b <- b + 1
    }
    else {
      # Peak existed in both spec.
      peak_b_int <- peak_b_int + spec_b[b, 2]
      b <- b + 1
    }
  }

  if (peak_b_int > 0){
    spec_merged <- rbind(spec_merged,c(spec_a[a, 1], spec_a[a, 2], peak_b_int))
    peak_b_int <- 0.
    a <- a + 1
  }

  if (b <= nrow(spec_b)){
    for (x in c(b:nrow(spec_b))){
      spec_merged <- rbind(spec_merged,c(spec_b[x, 1], 0, spec_b[x, 2]))
    }
  }

  if (a <= nrow(spec_a)){
    for (x in c(a:nrow(spec_a))){
      spec_merged <- rbind(spec_merged,c(spec_a[x, 1],spec_a[x, 2],0))
    }
  }
  spec_merged <- as.data.frame(spec_merged)
  colnames(spec_merged) <- c("mz", "spec_a", "spec_b")
  return(spec_merged)
}

spectral_entropy._entropy_similarity <- function(a,b){
  entropy_a_and_a <- spectral_entropy._get_entropy_and_weighted_intensity(a)
  entropy_a <- entropy_a_and_a$spectral_entropy
  entropy_b_and_b <- spectral_entropy._get_entropy_and_weighted_intensity(b)
  entropy_b <- entropy_b_and_b$spectral_entropy

  entropy_merged <- scipy.stats.entropy(entropy_a_and_a[[2]] + entropy_b_and_b[[2]])
  return(1 - (2 * entropy_merged - entropy_a - entropy_b) / log(4))
}

spectral_entropy.calculate_entropy_similarity <- function(spectrum_a,
                                         spectrum_b,
                                         ms2_da = NA,
                                         ms2_ppm = NA,
                                         need_clean_spectra = TRUE,
                                         noise_removal=0.01){
  if (need_clean_spectra){
    spectrum_a = tools.clean_spectrum(spectrum_a, noise_removal=noise_removal, ms2_ppm=ms2_ppm, ms2_da=ms2_da)
    spectrum_b = tools.clean_spectrum(spectrum_b, noise_removal=noise_removal, ms2_ppm=ms2_ppm, ms2_da=ms2_da)
  }
  else {
    # spectrum_a = tools.check_spectrum(spectrum_a)
    spectrum_a = tools.standardize_spectrum(spectrum_a)
    # spectrum_b = tools.check_spectrum(spectrum_b)
    spectrum_b = tools.standardize_spectrum(spectrum_b)
  }
  spec_matched = tools.match_peaks_in_spectra(spec_a=spectrum_a, spec_b=spectrum_b, ms2_ppm=ms2_ppm, ms2_da=ms2_da)
  return(spectral_entropy._entropy_similarity(spec_matched[,2], spec_matched[,3]))
}

spectral_entropy._get_entropy_and_weighted_intensity <- function(intensity){
  spectral_entropy = scipy.stats.entropy(intensity)
  if (spectral_entropy < 3){
    weight = 0.25 + 0.25 * spectral_entropy
    weighted_intensity = intensity^weight
    intensity_sum = sum(weighted_intensity)
    weighted_intensity  <- weighted_intensity/intensity_sum
    spectral_entropy = scipy.stats.entropy(weighted_intensity)
    resultList <- list(spectral_entropy = spectral_entropy,
                       weighted_intensity = weighted_intensity)
  }
  else{
    resultList <- list(spectral_entropy = spectral_entropy,
                       intensity = intensity)
  }
  return(resultList)
}

# spec_query <- read.csv(file = "D:/MS2_a.csv", header = F)
# spec_reference <- read.csv(file = "D:/MS2_b.csv", header = F)
#
# # spec_query <- as.data.frame(matrix(data = c(69.071, 7.917962, 86.066, 1.021589, 86.0969, 100.0), ncol = 2, byrow = T))
# # spec_reference <- as.data.frame(matrix(data = c(41.04, 37.16, 69.07, 66.83, 86.1, 999.0), ncol = 2, byrow = T))
#
# entropy = spectral_entropy.calculate_entropy(spec_reference)
# print(entropy)
# print('---------------------------')
#
# spectrum = as.data.frame(matrix(data = c(41.04, 0.3716, 69.071, 7.917962, 69.070, 100., 86.0969, 66.83), ncol = 2, byrow = T))
# clean_spectrum_df = tools.clean_spectrum(spectrum,
#                                 max_mz=85,
#                                 noise_removal=0.01,
#                                 ms2_da=0.05)
# print(clean_spectrum_df)
# print('---------------------------')
#
# spec_query = tools.clean_spectrum(spec_query)
# entropy = spectral_entropy.calculate_entropy(spec_query)
# print(entropy)
# print('---------------------------')
#
# # Calculate entropy similarity.
# similarity_num = spectral_entropy.calculate_entropy_similarity(spec_query, spec_reference, ms2_da=0.05)
# print(similarity_num)
# print('---------------------------')
#
# # Another way to calculate entropy similarity, the result from this method is the same as the previous method.
# similarity_num = spectral_similarity.similarity(spec_query, spec_reference, method="entropy", ms2_da=0.05)
# print(similarity_num)
# print('---------------------------')
#
# # Calculate unweighted entropy distance.
# similarity_num = spectral_similarity.similarity(spec_query, spec_reference, method="unweighted_entropy",
#                                          ms2_da=0.05)
# print(similarity_num)
# print('---------------------------')
