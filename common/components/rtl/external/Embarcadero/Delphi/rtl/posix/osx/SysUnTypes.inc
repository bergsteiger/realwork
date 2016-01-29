{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

type
  sockaddr_un = record
    sun_len: Byte;
    sun_family: sa_family_t;
    sun_path: array[0..103] of Byte;
  end;
  {$EXTERNALSYM sockaddr_un}
  Psockaddr_un = ^sockaddr_un;
