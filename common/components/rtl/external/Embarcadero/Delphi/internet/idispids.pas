{*{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Idispids;

interface

uses Winapi.Windows;

{ +------------------------------------------------------------------------- }

{  Microsoft Windows }
{  Copyright 1995-1998 Microsoft Corporation. All Rights Reserved. }

{  File: idispids.h }

{ -------------------------------------------------------------------------- }

{ For C++ support }
(*$HPPEMIT '#include <idispids.h>'*)

const
  DISPID_READYSTATE                                 = -525; 
  {$EXTERNALSYM DISPID_READYSTATE}
  DISPID_READYSTATECHANGE                           = -609; 
  {$EXTERNALSYM DISPID_READYSTATECHANGE}
  DISPID_AMBIENT_TRANSFERPRIORITY                   = -728; 
  {$EXTERNALSYM DISPID_AMBIENT_TRANSFERPRIORITY}
  DISPID_AMBIENT_OFFLINEIFNOTCONNECTED              = -5501; 
  {$EXTERNALSYM DISPID_AMBIENT_OFFLINEIFNOTCONNECTED}
  DISPID_AMBIENT_SILENT                             = -5502; 
  {$EXTERNALSYM DISPID_AMBIENT_SILENT}

{ Until these appear in OLECTL.H }
{$IFNDEF DISPID_AMBIENT_CODEPAGE}
  DISPID_AMBIENT_CODEPAGE             = -725; 
  {$EXTERNALSYM DISPID_AMBIENT_CODEPAGE}
  DISPID_AMBIENT_CHARSET              = -727; 
  {$EXTERNALSYM DISPID_AMBIENT_CHARSET}
{$ENDIF}

implementation


end.
