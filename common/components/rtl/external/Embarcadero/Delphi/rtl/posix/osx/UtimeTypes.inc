{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{
  N.B.  This header is marked as obsolete in the posix spec.
}

type
  utimbuf = record
    actime: time_t;           { Access time.  }
    modtime: time_t;          { Modification time.  }
  end;
  {$EXTERNALSYM utimbuf}
  Putimbuf = ^utimbuf;
