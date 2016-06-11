{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

type
  iovec = record
    iov_base: Pointer;
    iov_len: size_t;
  end;
  {$EXTERNALSYM iovec}

  Piovec = ^iovec;
