{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{ A time value that is accurate to the nearest
   microsecond but also has a range of years.  }
type
  timeval = {packed} record
    tv_sec: time_t;           { Seconds.  }
    tv_usec: suseconds_t;     { Microseconds.  }
  end;
  {$EXTERNALSYM timeval}
  Ptimeval = ^timeval;
