# Geo-engineering Characterization of Quarrying Materials using Hyperspectral Imaging

## Project Overview

This repository presents **models for characterizing the mechanical properties of rocks** using **hyperspectral imaging and machine learning techniques**. The goal is to provide a fast and cost-effective alternative to traditional laboratory methods used in civil engineering and mining applications.

The project was conducted as part of a B.Sc. graduation project in Electrical and Computer Engineering.

---

## Objectives

- Replace slow and expensive lab-based rock analysis with a hyperspectral AI-based pipeline.
- Extract dense spectral data using the **Specim FX10** camera.
- Calibrate and process hyperspectral images.
- Train regression models to predict:
  - Compressive strength (UCS)
  - Density
  - Water absorption

---

## Dataset
- **Source:** hyperspectral images were acquired in a controlled remote sensing lab using a SPECIM FX10 camera.
- **Spectral Range:** 400 nm – 1000 nm across 448 bands.
- **Image Size:** 1024 × 225 pixels (uint16).
- **Samples:** 102 different rock samples with mechanical property labels obtained through standard IS3 tests.

<p align="left">
  <img src="images/lab1.jpg" alt="Lab Setup 1" width="120px" height="120px" style="object-fit: cover; margin-right: 10px;">
  <img src="images/lab2.jpg" alt="Lab Setup 2" width="120px" height="120px" style="object-fit: cover; margin-right: 10px;">
  <img src="images/lab3.jpg" alt="Lab Setup 3" width="120px" height="120px" style="object-fit: cover;">
</p>



---

## Project Structure
- Imaging
- Image Processing
- Machine learning

<p align="left">
  <img src="images/project_struct.png" alt="project structure" width="400px" style="margin-right: 10px;">
</p>

---


## Imaging
- **Hyperspectral Camera** - Specim FX10

<p align="left">
  <img src="images/Products-Specim-FX10-2.png" alt="Specim FX10 Hyperspectral Camera" width="500px">
</p>

> Source: [www.specim.com](https://www.specim.com/products/specim-fx10/#)

## Preprocessing
- **Image Calibration**
  - Dark frame subtraction
  - White reference normalization

<p align="left">
  <img src="images/before_calib.png" alt="Before Calibration" width="400px" style="margin-right: 10px;">
  <img src="images/after_calib.png" alt="After Calibration" width="400px">
</p>

- **Denoising**
  - Spectral denoising using Polynomial fitting (polyfit)

<p align="left">
  <img src="images/POLYFIT.png" alt="Polyfit" width="400px">
</p>

- **Clustering**
  - Unsupervised pixel segmentation using **K-Means**

- **Feature extraction**
  - Statistical features  
  - Wavelet transform
  
<p align="left">
  <img src="images/wavelet_1.jpg" width="500px"><br>
  <img src="images/wavelet_4.jpg" width="500px"><br>
  <img src="images/wavelet_3.jpg" width="500px">
</p>

- **Machine Learning**
  - Training with:
    - Random Forest Regressor
    - Neural Networks (MLP)

---

## Results

| Target Property     | MAE   | R² Score |
|---------------------|-------|----------|
| Water Absorption    | ~1.1  | 0.93     |
| UCS (Strength)      | ~8.6  | 0.91     |
| Density             | ~0.14 | 0.89     |

---

## Authors
- **Dolev Dahan**  

Supervised by:  
**Dr. Yitzhak August**  
**Dr. Dagan Bakon**

> Sami Shamoon College of Engineering  
> Department of Electrical and Computer Engineering

---

## License

This project is released for academic and research purposes.
