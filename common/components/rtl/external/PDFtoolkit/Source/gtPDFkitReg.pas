{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }
unit gtPDFkitReg;

{$I gtDefines.Inc}

interface

uses
  Classes, gtPDFClasses, gtPDFDoc, gtPDFConsts, gtPDFViewer, gtPDFOutlineViewer,
  gtPDFPrinter, gtPDFSearchPanel;

const
  CPaletteName = 'PDFtoolkit';

procedure Register;

implementation

procedure Register;
begin
    RegisterComponents(CPaletteName, [TgtPDFDocument,TgtPDFViewer, TgtPDFOutlineViewer,
    TgtPDFPrinter, TgtPDFSearchPanel]);
end;

end.
