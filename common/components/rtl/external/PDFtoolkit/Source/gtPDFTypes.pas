{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }
{$I gtDefines.inc}
unit gtPDFTypes;

interface

uses
   {$IFDEF gtDelphi6up}Types,{$ENDIF} Classes;

type
  //enums
//  TgtNonFullScreen = (nfsUseNone, nfsUseOutlines, nfsUseThumbs);

  TCMPDFDocumentChanged = packed record
    Msg: Cardinal;
    Document: Longint;
    {$IFDEF gtDelphi7Up}
      Unused: DWORD;
    {$ELSE}
      Unused: longword;
    {$ENDIF}
    Result: Longint;
  end;

  TCMPDFDocumentDestroying = TCMPDFDocumentChanged;

implementation

end.

