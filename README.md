# Projects made by Jaime Gonzalez

This repository is a description of the projects I've worked on, with all basic ideas explained.
However, not all codes are public. 

Every project is identified by:

- A link to its folder or repository.
- Documentation (markdown or mkdocs) where the project is explained.
- Additional help as example codes or images.

## List of all projects
Documented projects at this repository.<br />
Each one has a brief introduction below. 

The projects are organized from newest to older.

- [_Rubik's solver_](#rubiks-solver)
- [*Enigma Cipher*](#enigma-cipher)
- [*DNN: Range AutoEncoder to Camera(RAE2Cam)*](https://github.com/Jtachan/CV_projects/blob/main/RAE2Cam/project-AE.md)
- [*Covid Friendly Face Detector (CFFD)*](https://github.com/Jtachan/CV_projects/blob/main/covid_drowsiness_detector/project-CFFD.md)
- [*6-DoF Vehicle Model Predictor (VMP)*](https://github.com/Jtachan/CV_projects/blob/main/VMP_6DoF/project-VMP.md)
  

## Rubik's solver

The project is a genetic algorithm capable of solving Rubik's cube.

❗ Project in development ❗

[Link to repo](https://github.com/Jtachan/genetic_rubiks_solver)

## Enigma Cipher

The `EnigmaCipher` is a python package that allows text ciphering using the enigma machine's logic.<br/>
It presents some **differences** to the real machine:

- The number of rotors is selectable, non-static in 3.
- The reflector can be defined as historical, with custom connections or totally random.
- Allows the possibility to use the same instance to encode/decode texts.

The package is installable by pip:

````shell
pip install enigma-cipher
````

Then, it can be set up easily with a random initialization for a quick use.

```python
from enigma_cipher import EnigmaMachine

cipher = EnigmaMachine.random_configuration()
text = cipher.cipher_text("Hello world!")
print(text)
# 'OQOAX LBGBU!'

text = cipher.cipher_text("OQOAX LBGBU!")
print(text)
# 'HELLO WORLD!'
```

The code is open source, to be found at its [**GitHub repository**](https://github.com/Jtachan/enigma_cipher).<br/>
The [**documentation**](https://jtachan.github.io/enigma_cipher/) is mkdocs generated, with multiple topics to understand the enigma machine logic and how to correctly use the python package.

## AutoEncoder: From Lidar-Range to Camera image (RAE2Cam)
When working with lidar systems at an automotive environment, one of the main problems is to identify the scene at the lidar data.
This could be an easier problem to solve if the 3D Point Cloud Data (PCD) could be analyzed as an image, because
Computer Vision is a very wide field that already has a lot of backgrounds.

The main goal of this project was to create a Deep Neural Network (DNN), named AutoEncoder (AE), that could obtain 
a camera-like image from a lidar-range image.
An AE is a Convolutional Neural Network (CNN) composed by an encoder, a flat layer and a decoder in this order.<br />

[Link to project](https://github.com/Jtachan/CV_projects/blob/main/RAE2Cam/project-AE.md)

<img src="RAE2Cam/imgs/range_trained.png" alt="autoencoder" width=500> 

## Covid Friendly Face Detector (CFFD)
Because of Covid-19, a very common sight is that everyone has a mask outside their homes. 
With the face partially covered, old face detectors might not work.

This project implements a CNN-based face detector with a re-trained 22-face-landmarks shape predictor.
The goal is to be able to detect any face (with or without a mask) and predict drowsiness at the detected face.
<br />

[Link to project](https://github.com/Jtachan/CV_projects/blob/main/covid_drowsiness_detector/project-CFFD.md)

<img src="covid_drowsiness_detector/imgs/mix_front.png" alt="mix_front" width=500>

## Vehicle Model Predictor with 6-DoF (VMP)
This was my Final Bachelor's Degree Project at the University.<br />
The formal memory is also uploaded to the same file. However, it's only in Spanish.

In it, a 6-DoF mathematical model is developed to be implemented as a predictor for a moving vehicle.
This model is to be used as the predictor inside a Kalman Filter to improve the results.<br />

[Link to project](https://github.com/Jtachan/CV_projects/blob/main/VMP_6DoF/project-VMP.md)<br />
[Link to University report](https://github.com/Jtachan/CV_projects/blob/main/VMP_6DoF/TFG_Jaime_Gonzalez_Gomez.pdf) (Spanish)

<img src="VMP_6DoF/imgs/full_vehicle.png" alt="vmp" width=500> 
