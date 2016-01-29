{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }
unit gtPDFDoc;

{$I gtDefines.inc}
{$I gtPTKDefines.inc}

interface

uses gtCstPDFDoc
{$IFDEF gtPro}
  , gtExPDFDoc
{$ENDIF}
{$IFDEF gtProPlus}
  , gtExProPDFDoc
{$ENDIF};

type
{$IFDEF gtProPlus}
  TgtPDFDocument = class(TgtExProPDFDocument);
{$ELSE}
{$IFDEF gtPro}
  TgtPDFDocument = class(TgtExPDFDocument);
{$ELSE}
  TgtPDFDocument = class(TgtCustomPDFDocument);
{$ENDIF}
{$ENDIF}


implementation

end.
