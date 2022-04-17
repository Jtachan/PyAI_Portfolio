""" The module contains the VideoHelper class """
from __future__ import annotations
from typing import Optional, Union

import sys
import os.path
import warnings
from cv2 import cv2 as cv
import numpy.typing as npt


class VideoHelper:
    """
    Python Manager to easily read and write videos. It doesn't support reading from any webcam.
    The class must be called into the code with the 'with' statement.
    """
    # ################################################################ #
    # ------------------------- Constructor  ------------------------- #
    # ################################################################ #
    def __init__(
        self,
        input_path: str,
        output_path: Optional[str] = None,
        force: bool = False
    ):
        """
        Init the VideoHelper.

        Parameters
        ----------
        input_path: str
            Path to the input video to be read.
        output_path: optional str
            Path to the output video to be saved, which will always be encoded as 'avi'. If not given, saving
            a video will not be possible.
        force: bool, default = False
            If True, overwrites an existing output video file.
        """
        # Input path checks
        if not os.path.exists(input_path):
            raise ValueError("Input video file not found.")
        self.__input_path = input_path

        # Output path checks
        if output_path is None:
            self.__output_path = output_path
        else:
            out_extension = os.path.splitext(output_path)[-1].lower()
            if out_extension == "":
                self.__output_path = output_path + ".avi"
            elif out_extension != ".avi":
                self.__output_path = os.path.splitext(output_path)[0] + ".avi"
                warnings.warn("'VideoHelper' supports only 'avi' as output format, but another was given.\n"
                              f"The video will be saved as '{self.__output_path}'.")
            else:
                self.__output_path = output_path

            if os.path.exists(self.__output_path) and not force:
                raise ValueError("Output video already exist.\nUse the 'force' argument to overwrite existing files.")

        self.__context_manager = False

    def __enter__(self) -> VideoHelper:
        """
        Sets the OpenCV VideoCapture to the given video. Method called internally when called the class with the
        'with' statement.
        """
        try:
            self.__context_manager = True
            self.__capturer = cv.VideoCapture(self.__input_path)

            if self.__output_path is not None:
                out_dim = (self.__capturer.get(cv.CAP_PROP_FRAME_WIDTH),
                           self.__capturer.get(cv.CAP_PROP_FRAME_HEIGHT))
                fourcc = cv.VideoWriter_fourcc("M", "J", "P", "G")
                self.__writer = cv.VideoWriter(self.__output_path, fourcc, 30, out_dim)
            return self
        except:
            self.__exit__(*sys.exc_info())
            raise

    def __exit__(self, exc_type, exc_val, exc_tb):
        """
        Closes the class once the video is finished.
        """
        self.__capturer.release()
        self.__context_manager = False

    def __next__(self) -> npt.NDArray:
        """
        Provides the next frame within the video. Method internally called at each loop increment.

        Returns
        -------
        frame_image: numpy N-Dimensional array (openCV image)
            Frame data related to the video.
        """
        self.__check_context_manager()
        try:
            read_value, frame_image = self.__capturer.read()
            if not read_value:
                raise StopIteration
        except:
            raise StopIteration from None

        return frame_image

    def __iter__(self) -> VideoHelper:
        """
        Enables iteration over the frames in the video file. Method internally called at the starting loop.
        """
        self.__check_context_manager()
        return self

    def __check_context_manager(self):
        """
        Checks that the class has been correctly called into the code.
        """
        if not self.__context_manager:
            raise ValueError("'VideoHelper' must be called with the 'with' statement.")

    # ################################################################ #
    # ------------------------ Public methods ------------------------ #
    # ################################################################ #

    def write(self, image: npt.NDArray):
        """
        Writes one frame into the output video.

        Parameters
        ----------
        image: numpy N-dimensional array (OpenCV image)
            Frame image to be written into the output video.
        """
        self.__check_context_manager()
        self.__writer.write(image)

    # ################################################################ #
    # -------------------------- Properties -------------------------- #
    # ################################################################ #
    @property
    def total_nof_frames(self) -> Union[int, str]:
        """ int: Total number of frames containing the video"""
        return self.__capturer.get(cv.CAP_PROP_FRAME_COUNT)

    @property
    def input_video(self) -> str:
        """ str: Source of the input video """
        return self.__input_path

    @property
    def output_video(self) -> str:
        """ str: Path to the output video being saved """
        return self.__output_path
