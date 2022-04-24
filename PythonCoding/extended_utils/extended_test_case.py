"""
Module containing a base class for unittests.
"""
from typing import List, Union, Dict
from enum import Enum
import unittest


class ExtendedTestCase(unittest.TestCase):
    """
    TestCase class with extra methods.
    """
    def assertListAlmostEqual(
        self,
        list1: List[Union[Dict, float, int, List, Enum]],
        list2: List[Union[Dict, float, int, List, Enum]],
        places: int = 7,
        msg: str = None
    ) -> None:
        """
        Method for using "assertAlmostEqual" with List.

        Parameters
        ----------
        list1: list
            First list containing only dictionaries, float values or other lists as elements.
        list2: list
            Second list containing only dictionaries, float values or other lists as elements.
        places:
            Number of decimal places to round when checking "assertAlmostEqual" to compare two floats.
        msg:
            Message to be printed if a checking fails. By default, no message is printed.
        """

        # Check both inputs are lists
        self.assertIsInstance(list1, list, msg="First argument is not a list")
        self.assertIsInstance(list2, list, msg="Second argument is not a list")

        # Check both lists have the same length
        self.assertEqual(len(list1), len(list2))

        # Check every element on the list
        for element_list1, element_list2 in zip(list1, list2):
            self.assertEqual(type(element_list1), type(element_list2),
                             msg="Lists must have the elements arranged in the same order.")
            if isinstance(element_list1, dict):
                self.assertDictAlmostEqual(element_list1, element_list2, places=places, msg=msg)
            elif isinstance(element_list1, list):
                self.assertListAlmostEqual(element_list1, element_list2, places=places, msg=msg)
            elif isinstance(element_list1, float):
                self.assertAlmostEqual(element_list1, element_list2, places=places, msg=msg)
            else:
                self.assertEqual(element_list1, element_list2, msg=msg)

    def assertDictAlmostEqual(
        self,
        dict1: Dict[str, Union[Dict, float, int, List, Enum]],
        dict2: Dict[str, Union[Dict, float, int, List, Enum]],
        places: int = 7,
        msg: str = None
    ) -> None:
        """
        Method for using "assertAlmostEqual" with Dicts.

        Parameters
        ----------
        dict1: dict
            First dictionary containing float, list and/or dict.
        dict2: dict
            Second dictionary containing float, list and/or dict.
        places: int
            Number of decimal places to round when checking "assertAlmostEqual" to compare two floats.
        msg: str
            Message to be printed if a checking fails. By default, no message is printed.
        """
        # check if both inputs are dicts
        self.assertIsInstance(dict1, dict, "First argument is not a dictionary")
        self.assertIsInstance(dict2, dict, "Second argument is not a dictionary")

        # check if both inputs have the same keys
        self.assertEqual(dict1.keys(), dict2.keys())

        # check each key
        for key, value in dict1.items():
            if isinstance(value, dict):
                self.assertDictAlmostEqual(dict1[key], dict2[key], places=places, msg=msg)
            elif isinstance(value, list):
                self.assertListAlmostEqual(dict1[key], dict2[key], places=places, msg=msg)
            elif isinstance(value, float):
                self.assertAlmostEqual(dict1[key], dict2[key], places=places, msg=msg)
            else:
                self.assertEqual(dict1[key], dict2[key], msg=msg)
