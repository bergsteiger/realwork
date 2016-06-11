{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}


const
{ Bits in the third argument to `waitpid'.  }
  WNOHANG    = $00000001;               { Don't block waiting.  }
  {$EXTERNALSYM WNOHANG}
  WUNTRACED  = $00000002;               { Report status of stopped children.  }
  {$EXTERNALSYM WUNTRACED}

  WSTOPPED   = WUNTRACED;
  {$EXTERNALSYM WSTOPPED}
  WEXITED    = $00000004;
  {$EXTERNALSYM WEXITED}
  WCONTINUED = $00000008;
  {$EXTERNALSYM WCONTINUED}
  WNOWAIT    = $01000000;
  {$EXTERNALSYM WNOWAIT}

type
  idtype_t = (
    P_ALL,
    P_PID,
    P_PGID );
  {$EXTERNALSYM idtype_t}


