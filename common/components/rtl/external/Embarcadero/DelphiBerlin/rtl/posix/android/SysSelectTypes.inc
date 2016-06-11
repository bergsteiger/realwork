{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

type
  fd_mask = UInt32;

const
  NFDBITS       = 8 * sizeof(fd_mask);
  {$EXTERNALSYM NFDBITS}

  FD_SETSIZE    = 1024;
  {$EXTERNALSYM FD_SETSIZE}

  FDSET_LONGS = (FD_SETSIZE div NFDBITS);
  {$EXTERNALSYM FDSET_LONGS}

{ fd_set for select and pselect.  }
type
  fd_set = record { XPG4.2 requires this member name.  Otherwise avoid the name
       from the global namespace.  }
    fds_bits: packed array[0..FDSET_LONGS-1] of fd_mask;
  end;
  {$EXTERNALSYM fd_set}
  Pfd_set = ^fd_set;
