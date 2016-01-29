{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

type
{ Used by other time functions.  }
  tm = record
    tm_sec: Integer;            // Seconds. [0-60] (1 leap second)
    tm_min: Integer;            // Minutes. [0-59]
    tm_hour: Integer;           // Hours.[0-23]
    tm_mday: Integer;           // Day.[1-31]
    tm_mon: Integer;            // Month.[0-11]
    tm_year: Integer;           // Year since 1900
    tm_wday: Integer;           // Day of week [0-6] (Sunday = 0)
    tm_yday: Integer;           // Days of year [0-365]
    tm_isdst: Integer;          // Daylight Savings flag [-1/0/1]
    tm_gmtoff: LongInt;         // Seconds east of UTC
    tm_zone: MarshaledAString;  // Timezone abbreviation
  end;
  {$EXTERNALSYM tm}
  Ptm = ^tm;

{ POSIX.4 structure for a time value.  This is like a `struct timeval' but
  has nanoseconds instead of microseconds. }
  timespec = record
    tv_sec: Longint;            // Seconds.
    tv_nsec: Longint;           // Nanoseconds.
  end;
  {$EXTERNALSYM timespec}
  Ptimespec = ^timespec;
