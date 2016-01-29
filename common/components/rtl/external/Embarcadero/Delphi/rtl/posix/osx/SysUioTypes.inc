{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

type
  iovec = record
    iov_base: Pointer;
    iov_len: size_t;
  end;
  {$EXTERNALSYM iovec}

  Piovec = ^iovec;
