{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ wchar.h types }

type

  wctype_t = UInt32;
  {$EXTERNALSYM wctype_t}
  Pwctype_t = ^wctype_t;

  wint_t = Int32;
  {$EXTERNALSYM wint_t}
  Pwint_t = ^wint_t;

  mbstate_t = record
    dummy: Integer;
  end;
  {$EXTERNALSYM mbstate_t}
  Pmbstate_t = ^mbstate_t;
