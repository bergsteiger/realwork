{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

const
  UIO_FASTIOV = 8;
  {$EXTERNALSYM UIO_FASTIOV}
  UIO_MAXIOV  = 1024;
  {$EXTERNALSYM UIO_MAXIOV}

type
  iovec = record
    iov_base: Pointer;    { Pointer to data.  }
    iov_len: size_t;      { Length of data.  }
  end;
  {$EXTERNALSYM iovec}
  Piovec = ^iovec;
