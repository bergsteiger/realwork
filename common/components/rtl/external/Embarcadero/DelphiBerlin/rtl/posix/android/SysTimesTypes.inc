{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

// Translated from sys/times.h

{  Structure describing CPU time used by a process and its children.  }
type
  tms = {packed} record
    tms_utime: clock_t;         { User CPU time.  }
    tms_stime: clock_t;         { System CPU time.  }

    tms_cutime: clock_t;        { User CPU time of dead children.  }
    tms_cstime: clock_t;        { System CPU time of dead children.  }
  end;
  {$EXTERNALSYM tms}
  Ptms = ^tms;
