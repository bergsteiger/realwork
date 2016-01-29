{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

unit ElHandPt;

interface

uses Windows, Controls, Forms;

{$ifdef BORLAND_URL_CURSOR}
const crURLCursor = crHandPoint;
{$else}
{$r ElHandPt.res}
const crURLCursor = 1458;
{$endif}

implementation

{$ifndef BORLAND_URL_CURSOR}
initialization
  Screen.Cursors[crURLCursor] := LoadCursor(HInstance, 'URLCURSOR');
{$endif}

end.
