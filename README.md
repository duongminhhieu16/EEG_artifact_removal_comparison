# EEG_artifact_removal_comparison
This repository introduces some of approaches to remove artifacts in EEG signal.

## Stationary Wavelet Transform (SWT)
- [Original code](https://github.com/kafiiut/artifact-removal).
- Paper: [Artifact characterization and removal for in vivo neural recording](http://www.sciencedirect.com/science/article/pii/S0165027014000387), Journal of neuroscience methods 226 (2014): 110-123.

## Multi-channel Wiener Filter (MWF)
- [Original code](https://github.com/exporl/mwf-artifact-removal).
- Paper: [A generic EEG artifact removal algorithm based on the multi-channel Wiener filter. Journal of Neural Engineering](https://www.researchgate.net/publication/322901721_A_generic_EEG_artifact_removal_algorithm_based_on_the_multi-channel_Wiener_filter).

## Discrete Wavelet Transform (DWT)

## Independent Components Analysis (ICA-based algorithm)
- Mostly implemented by using [EEGLAB](https://sccn.ucsd.edu/eeglab/).

## Dataset
- TUAR dataset from [Temple University EEG Corpus](https://isip.piconepress.com/projects/tuh_eeg/html/downloads.shtml).

## I use Power Spectral Density (PSD) and Frequency Correlation to compare these algorithms.
