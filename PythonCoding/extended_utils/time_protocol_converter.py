"""
This module contains the TimeProtocolConverter class, as well as the Unix and NTP epochs defined with the same class.
"""
from __future__ import annotations

import datetime
from datetime import timedelta
from typing import Optional


class TimeProtocolConverter(datetime.datetime):
    """
    TimeProtocolConverter allows to easily convert timestamps among Unix and NTP epochs.
    """

    @classmethod
    def from_unix_seconds(cls, seconds: int, utc_offset: Optional[int] = None) -> TimeProtocolConverter:
        """
        Inits the class with a Unix timestamp in seconds.
        This method doesn't allow any fractional part of seconds. Refer to 'from_unix_microseconds' for more accuracy.

        Parameters
        ----------
        seconds: int
            Unix timestamp, in seconds, to init the class.
        utc_offset: optional int
            Offset hours, defined as an int. If not specified, it will be defined as the local timezone.

        Returns
        -------
        TimeProtocolConverter
            Class correctly initialized, containing all methods from 'datetime' plus the extended properties.
        """
        timezone = utc_offset if utc_offset is not None else cls.now().tzinfo
        return (_UNIX_EPOCH + timedelta(seconds=seconds)).astimezone(tz=timezone)

    @classmethod
    def from_unix_microseconds(cls, microseconds: int, utc_offset: Optional[int] = None) -> TimeProtocolConverter:
        """
        Inits the class with a Unix timestamp in microseconds.

        Parameters
        ----------
        microseconds: int
            Unix timestamp, in microseconds, to init the class.
        utc_offset: optional int
            Offset hours, defined as an int. If not specified, it will be defined as the local timezone.

        Returns
        -------
        TimeProtocolConverter
            Class correctly initialized, containing all methods from 'datetime' plus the extended properties.
        """
        timezone = utc_offset if utc_offset is not None else cls.now().tzinfo
        return (_UNIX_EPOCH + timedelta(microseconds=microseconds)).astimezone(tz=timezone)

    @classmethod
    def from_ntp_timestamp(cls, ntp_timestamp: int, utc_offset: Optional[int] = None) -> TimeProtocolConverter:
        """
        Inits the class with a NTP timestamp.
        More info about the NTP format here: https://en.wikipedia.org/wiki/Network_Time_Protocol

        Parameters
        ----------
        ntp_timestamp: int
            NTP timestamp.
        utc_offset: optional int
            Offset hours, defined as an int. If not specified, it will be defined as the local timezone.

        Returns
        -------
        TimeProtocolConverter
            Class correctly initialized, containing all methods from 'datetime' plus the extended properties.
        """
        fractional_seconds = ntp_timestamp & 0xFFFFFFFF
        ntp_seconds = ntp_timestamp >> 32 + fractional_seconds / (2**32)
        unix_seconds = ntp_seconds - (_UNIX_EPOCH - _NTP_EPOCH).total_seconds()

        if unix_seconds < 0:
            raise ValueError(
                "The given NTP timestamp, although might be correct, points to a date earlier than "
                "1.Jan.1970.\nTimeProtocolConverter only supports timestamps posterior to the Unix epoch."
            )
        return cls.from_unix_microseconds(int(unix_seconds * 1e6), utc_offset=utc_offset)


_UNIX_EPOCH = TimeProtocolConverter(year=1970, month=1, day=1)
_NTP_EPOCH = TimeProtocolConverter(year=1900, month=1, day=1)
