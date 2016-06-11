{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}


type

{ A time value that is accurate to the nearest
   microsecond but also has a range of years.  }
  timeval = record
    tv_sec: time_t;           { Seconds.  }
    tv_usec: suseconds_t;     { Microseconds.  }
  end;
  {$EXTERNALSYM timeval}
  Ptimeval = ^timeval;

  itimerval = record
    it_interval: timeval;
    it_value: timeval;
  end;
  {$EXTERNALSYM itimerval}
  Pitimerval = ^itimerval;

const
  ITIMER_REAL = 0;
  {$EXTERNALSYM ITIMER_REAL}
  ITIMER_VIRTUAL = 1;
  {$EXTERNALSYM ITIMER_VIRTUAL}
  ITIMER_PROF = 2;
  {$EXTERNALSYM ITIMER_PROF}

