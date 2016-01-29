{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

type
  dl_info = record
     dli_fname: MarshaledAString;
     dli_fbase: Pointer;
     dli_sname: MarshaledAString;
     dli_saddr: Pointer;
  end;
  {$EXTERNALSYM dl_info}
  Pdl_info = ^dl_info;
  
const
  RTLD_LAZY   = 1;             { Lazy function call binding.  }
  {$EXTERNALSYM RTLD_LAZY}
  RTLD_NOW    = 2;             { Immediate function call binding.  }
  {$EXTERNALSYM RTLD_NOW}
  RTLD_GLOBAL = 3;
  {$EXTERNALSYM RTLD_GLOBAL}
  RTLD_LOCAL  = 4;
  {$EXTERNALSYM RTLD_LOCAL}
  RTLD_NOLOAD = $10;
  {$EXTERNALSYM RTLD_NOLOAD}
  RTLD_NODELETE = $80;
  {$EXTERNALSYM RTLD_NODELETE}
  RTLD_FIRST = $100;
  {$EXTERNALSYM RTLD_FIRST}


  RTLD_DEFAULT = LongWord(-2);  { This one is not POSIX-compliant }
  {$EXTERNALSYM RTLD_DEFAULT}
