{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


const
{ Bits in the third argument to `waitpid'.  }
  WNOHANG            = 1;               { Don't block waiting.  }
  {$EXTERNALSYM WNOHANG}
  WUNTRACED          = 2;               { Report status of stopped children.  }
  {$EXTERNALSYM WUNTRACED}

  WEXITED    = $04;
  {$EXTERNALSYM WEXITED}
  WSTOPPED   = $08;
  {$EXTERNALSYM WSTOPPED}
  WCONTINUED = $10;
  {$EXTERNALSYM WCONTINUED}
  WNOWAIT    = $20;
  {$EXTERNALSYM WNOWAIT}

type
  idtype_t = (
    P_ALL,
    P_PID,
    P_PGID );
  {$EXTERNALSYM idtype_t}
