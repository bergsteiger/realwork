{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

const
  PROT_READ = 1;
  {$EXTERNALSYM PROT_READ}
  PROT_WRITE = 2;
  {$EXTERNALSYM PROT_WRITE}
  PROT_EXEC = 4;
  {$EXTERNALSYM PROT_WRITE}
  PROT_NONE = 0;
  {$EXTERNALSYM PROT_NONE}

  MAP_FIXED = $10;
  {$EXTERNALSYM MAP_FIXED}
  MAP_PRIVATE = 2;
  {$EXTERNALSYM MAP_FIXED}
  MAP_SHARED = 1;
  {$EXTERNALSYM MAP_FIXED}

  MAP_FILE  = $0 platform;
  {$EXTERNALSYM MAP_FILE}
  MAP_ANONYMOUS = $20 platform;
  {$EXTERNALSYM MAP_ANONYMOUS}
  MAP_ANON = MAP_ANONYMOUS platform;
  {$EXTERNALSYM MAP_ANON}

  MAP_FAILED  = Pointer(-1);
  {$EXTERNALSYM MAP_FAILED}
