{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

const
  UNIX_PATH_MAX = 108;
  {$EXTERNALSYM UNIX_PATH_MAX}


type
  sockaddr_un = record
    sun_family: sa_family_t;
    sun_path: packed array[0..UNIX_PATH_MAX-1] of Byte;  { Path name.  }
  end;
  {$EXTERNALSYM sockaddr_un}
  Psockaddr_un = ^sockaddr_un;
