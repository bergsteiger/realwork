{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DiffMakeReg;

interface

procedure Register;

implementation
{.$I dc.inc}
{$I dcprod.inc}
uses
  Classes,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}
  
  dcgenreg,
  dcconsts, diffmake;

procedure Register;
begin
  RegisterComponents(SPalDream,[TDiffMaker]);
  RegisterPropertyEditor(TypeInfo(string), TDiffMaker, 'InFile', TFileNameEdit);
  RegisterPropertyEditor(TypeInfo(string), TDiffMaker, 'OutFile', TFileNameEdit);
  RegisterPropertyEditor(TypeInfo(string), TDiffMaker, 'UseFile', TFileNameEdit);
end;

end.
