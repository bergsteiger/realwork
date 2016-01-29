{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

const
  PROT_READ = 1;
  {$EXTERNALSYM PROT_READ}
  PROT_WRITE = 2;
  {$EXTERNALSYM PROT_WRITE}
  PROT_EXEC = 4;
  {$EXTERNALSYM PROT_EXEC}
  PROT_NONE = 0;
  {$EXTERNALSYM PROT_NONE}

  MAP_FIXED = $10;
  {$EXTERNALSYM MAP_FIXED}
  MAP_PRIVATE = 2;
  {$EXTERNALSYM MAP_PRIVATE}
  MAP_SHARED = 1;
  {$EXTERNALSYM MAP_SHARED}

  MAP_FILE  = $0 platform;
  {$EXTERNALSYM MAP_FILE}
  MAP_ANON  = $1000 platform;
  {$EXTERNALSYM MAP_ANON}

  MAP_FAILED  = Pointer(-1);
  {$EXTERNALSYM MAP_FAILED}
