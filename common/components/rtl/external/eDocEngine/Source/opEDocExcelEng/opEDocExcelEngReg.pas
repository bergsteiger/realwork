{ --------------------------------------------------------- }
{ OPUS eDoc Integration                                     }
{ Copyright (c) 1986-2011 by gs-soft AG                     }
{                                                           }
{ All rights reserved.                                      }
{ --------------------------------------------------------- }

unit opEDocExcelEngReg;

interface
uses
  Classes, opEDocExcelEngine;

procedure Register;

implementation

procedure Register;
begin
	RegisterComponents('eDocEngine Additional', [TOpEDocExcelEngineGS]);
end;
end.
