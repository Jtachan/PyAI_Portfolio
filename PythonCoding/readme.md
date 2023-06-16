# Python Coding

Welcome to my *Python Coding* folder. Here I have uploaded as a small Python project a few easy tools. All modules uploaded at this folder are very simple modules, with no high complexity with the only goal of showing my coding style and organisation for the codes/documentation.

Thus, once the tools are created and committed into the repo, the only support they will keep is bug-fixing. No tool will have any new features in the future, that is not the main purpose of these codes.

* [**VideoHelper**](#videohelper): Tool to open and write a video using the OpenCV package.
* [**ExtendedTestCase**](#extendedtestcase): Base class of `unittest.TestCase` containing extra assert methods.

All tools are installable within the package and are easily importable with the package name:

```python
import extended_utils as pkg

ocv_video = pkg.VideoHelper("video_path")
```

## VideoHelper

`VideoHelper` is a Python Manager to easily read and write videos with the OpenCV package. The webcam live video is not supported by the tool.

The tool contains the following arguments:
* `input_path`: Path to the input video to be read.
* `output_path` (Optional): Path to the output video to be written, fixed to `.avi` format. If not given, it won't be possible to write any output video.
* `force`: If set to True, it will allow overwriting an existing video.

### Example of use

The tool must be called with the 'with' statement. Then, the tool will return the frame images with an interator behaviour.

```python
from cv2 import cv2
from extended_utils import VideoHelper

with VideoHelper("video.mp4") as video:
    for frame_image in video:
        cv2.imshow("Video example", frame_image)
        cv2.waitKey(30)
```

To use the tool's video writer, the output path must also be given.

```python
from cv2 import cv2
from extended_utils import VideoHelper

with VideoHelper("input_video.mp4", "output_video.avi") as video:
    for frame_image in video:
        mirror_frame = cv2.flip(frame_image)
        video.write(mirror_frame)
```

If the path `"output_video.avi"` already exist, the tool will raise an error. To overwrite it, the `force` argument must also be set. This will be then the proper setup, using keywords:

```python
from cv2 import cv2
from extended_utils import VideoHelper

with VideoHelper(
        input_path="video.mp4", output_path="output_video.avi", force=True
) as video:
    for frame_image in video:
        mirror_frame = cv2.flip(frame_image)

        cv2.imshow("Video example", frame_image)
        cv2.imshow("Video mirror", mirror_frame)

        video.write(mirror_frame)
        cv2.waitKey(30)
```

## ExtendedTestCase

`ExtendedTestCase` is a base class, inherited from `unittest.TestCase`. The main purpose of the class is to contain extra assert methods for unittests.

The created methods allow applying `assertAlmostEqual`(https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertAlmostEqual) to iterables:

* **AssertListAlmostEqual**(list1, list2, places=7, msg=None):Method to apply `assertAlmostEqual` to lists. Both list must contain the same elements with the same arrange.
* **AssertDictAlmostEqual**(dict1, dict2, places=7, msg=None): Method to apply `assertAlmostEqual` to dictionaries. Both dicts must contain the same items with the same arrange.

The two listed methods are compatible with list or dictionaries containing the following elements:
* List
* Dictionaries
* Floats
* Ints
* Strings

If any other type is contained, the classes will raise an error.
