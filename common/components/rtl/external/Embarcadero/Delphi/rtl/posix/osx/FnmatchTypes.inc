{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

const
{ Value returned by 'fnmatch' if STRING does not match PATTERN.  }
  FNM_NOMATCH      = 1;
  {$EXTERNALSYM FNM_NOMATCH}

{ Bits set in the FLAGS argument to 'fnmatch'.  }
  FNM_NOESCAPE     = $01; { Backslashes don't quote special chars.  }
  {$EXTERNALSYM FNM_NOESCAPE}
  FNM_PATHNAME     = $02; { No wildcard can ever match '/'.  }
  {$EXTERNALSYM FNM_PATHNAME}
  FNM_PERIOD       = $04; { Leading '.' is matched only explicitly.  }
  {$EXTERNALSYM FNM_PERIOD}

