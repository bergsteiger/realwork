{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{ Number of descriptors that can fit in an `fd_set'.  }
type
  fd_mask = LongWord;
  {$EXTERNALSYM fd_mask}

const
  NFDBITS       = 8 * sizeof(fd_mask);
  {$EXTERNALSYM NFDBITS}

  FD_SETSIZE    = 1024;
  {$EXTERNALSYM FD_SETSIZE}

{ fd_set for select and pselect.  }
type
  fd_set = record { XPG4.2 requires this member name.  Otherwise avoid the name
       from the global namespace.  }
    fds_bits: packed array[0..(FD_SETSIZE div NFDBITS)-1] of fd_mask;
  end;
  {$EXTERNALSYM fd_set}
  Pfd_set = ^fd_set;
