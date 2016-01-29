{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit FormFillReg;

interface

procedure Register;

implementation
{$I dc.inc}
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
  
  dcconsts, formfill;

type
  TFillTypeEditor = Class(TStringProperty)
  public
    function GetAttributes:TPropertyAttributes;override;
    procedure GetValues(Proc:TGetStrProc);override;
  end;

{--------------------------------------------------------------}

function TFillTypeEditor.GetAttributes:TPropertyAttributes;
begin
  Result:=[paValueList];
end;

{--------------------------------------------------------------}

procedure TFillTypeEditor.GetValues(Proc:TGetStrProc);
Var
  i:Integer;
begin
  For i:=0 to FillTypeList.Count-1 do Proc(FillTypeList[i]);
end;

{--------------------------------------------------------------}

procedure Register;
begin
  RegisterComponents(SPalDream,[TDCFormFill]);
  RegisterPropertyEditor(TypeInfo(String),TDCFormFill,'FillType',TFillTypeEditor);
end;

{--------------------------------------------------------------}

end.
