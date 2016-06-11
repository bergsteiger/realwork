{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

const
{ Value returned by 'fnmatch' if STRING does not match PATTERN.  }
  FNM_NOMATCH      = 1; { Match failed. }
  {$EXTERNALSYM FNM_NOMATCH}
  FNM_NOSYS        = 2; { Function not supported (unused). }
  {$EXTERNALSYM FNM_NOSYS}

{ Bits set in the FLAGS argument to 'fnmatch'.  }
  FNM_NOESCAPE     = 1; { Disable backslash escaping.  }
  {$EXTERNALSYM FNM_NOESCAPE}
  FNM_PATHNAME     = 2; { Slash must be matched by slash.  }
  {$EXTERNALSYM FNM_PATHNAME}
  FNM_PERIOD       = 4; { Period must be matched by period.  }
  {$EXTERNALSYM FNM_PERIOD}
  FNM_LEADING_DIR  = 8; { Ignore /<tail> after Imatch. }
  {$EXTERNALSYM FNM_LEADING_DIR}
  FNM_CASEFOLD     = 16; { Case insensitive search. }
  {$EXTERNALSYM FNM_CASEFOLD}
  FNM_IGNORECASE   = FNM_CASEFOLD;
  {$EXTERNALSYM FNM_IGNORECASE}
  FNM_FILE_NAME    = FNM_PATHNAME;
  {$EXTERNALSYM FNM_FILE_NAME}
