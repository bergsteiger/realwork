{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

type
{ Structure describing a word-expansion run.  }
  wordexp_t = record
    we_wordc: size_t;   { Count of words matched. }
    we_wordv: PMarshaledAString;    { List of expanded words. }
    we_offs: size_t;    { Slots to reserve in `we_wordv'. }
  end;
  {$EXTERNALSYM wordexp_t}
  Pwordexp_t = ^wordexp_t;
  
const
  WRDE_APPEND  = $0001;
  {$EXTERNALSYM WRDE_APPEND}
  WRDE_DOOFFS  = $0002;
  {$EXTERNALSYM WRDE_DOOFFS}
  WRDE_NOCMD   = $0004;
  {$EXTERNALSYM WRDE_NOCMD}
  WRDE_REUSE   = $0008;
  {$EXTERNALSYM WRDE_REUSE}
  WRDE_SHOWERR = $0010;
  {$EXTERNALSYM WRDE_SHOWERR}
  WRDE_UNDEF   = $0020;
  {$EXTERNALSYM WRDE_UNDEF}
  
  WRDE_BADCHAR = 1;
  {$EXTERNALSYM WRDE_BADCHAR}
  WRDE_BADVAL  = 2;
  {$EXTERNALSYM WRDE_BADVAL}
  WRDE_CMDSUB  = 3;
  {$EXTERNALSYM WRDE_CMDSUB}
  WRDE_NOSPACE = 4;
  {$EXTERNALSYM WRDE_NOSPACE}
  WRDE_NOSYS   = 5 deprecated 'Open Group Base Specs Issue 6';
  {$EXTERNALSYM WRDE_NOSYS}
  WRDE_SYNTAX  = 6;
  {$EXTERNALSYM WRDE_SYNTAX}
