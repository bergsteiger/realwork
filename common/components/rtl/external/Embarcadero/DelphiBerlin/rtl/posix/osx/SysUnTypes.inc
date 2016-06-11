{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
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
