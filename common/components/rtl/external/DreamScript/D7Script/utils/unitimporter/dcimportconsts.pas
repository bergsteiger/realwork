{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCImportConsts;

{$I DC.inc}

interface

Const
{$IFDEF RUSSIAN_LANGUAGE}
  {$I DCImport_rus.inc}  {Russian}
{$ELSE}
  {$I DCImport_eng.inc} {English}
{$ENDIF}

  SDCDefAliases='WinTypes=Windows;WinProcs=Windows;DbiTypes=BDE;DbiProcs=BDE;DbiErrs=BDE;orbpas=orbpas40;';
  sDCTempImportFileNamePrefix = 'imp';
  sDCImportProjectExt = '.ipj';

implementation

end.
