""" Setup file to make the content installable """
import setuptools

setuptools.setup(
    name="simple-utils",
    description="The package contains simple and easy usable modules for any user",
    author="Jaime Gonzalez Gomez",
    author_email="jim.gomez.dnn@gmail.com",
    version="1.0.0",
    install_requires=[
        "opencv-python==4.5.*",
    ]
)
