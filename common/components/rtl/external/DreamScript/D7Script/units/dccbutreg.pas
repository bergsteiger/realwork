{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcCButReg;

interface
procedure Register;

implementation
{$I dc.inc}
uses
  SysUtils,Classes, Forms,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}
  
  dcconsts, dccbut;

{-----------------------------------------------------------}

{$IFDEF D4}
Function GetComponentDesigner(AComponent:TComponent):{$IFDEF D6}IDesignerHook{$ELSE}IDesigner{$ENDIF};
{$ELSE}
Function GetComponentDesigner(AComponent:TComponent):TDesigner;
{$ENDIF}
Begin
  Result:=Nil;
  While AComponent<>Nil Do
  Begin
    If AComponent Is TCustomForm Then
      Break;
    AComponent:=AComponent.Owner;
  End;

  If AComponent<>Nil then
    Result:=TCustomForm(AComponent).Designer;
End;

{-----------------------------------------------------------}

Procedure SelectComponentInDesigner(AComponent:TComponent);
{$IFDEF D6}
var
  LDesigner:IDesigner;
begin
  if Supports(FindRootDesigner(AComponent), IDesigner, LDesigner) then
    LDesigner.SelectComponent(AComponent);
end;
{$ELSE}
Var
{$IFDEF D4}
  Designer:IDesignerNotify;
  DesignerIntf:IFormDesigner;
{$ELSE}
  Designer:TDesigner;
{$ENDIF}
begin
  If AComponent=Nil Then
    Exit;
  If Not (csDesigning In AComponent.ComponentState) Then
    Exit;
  Designer:=GetComponentDesigner(AComponent);
  If (Designer<>Nil) Then
  Begin
     {$IFDEF D4}
     Designer.QueryInterface(IFormDesigner,DesignerIntf);
     If DesignerIntf<>Nil Then
       DesignerIntf.SelectComponent(AComponent);
     {$ELSE}
     If (Designer Is TFormDesigner) Then
      (Designer As TFormDesigner).SelectComponent(AComponent);
     {$ENDIF}
  End;
end;
{$ENDIF}

{-----------------------------------------------------------}

procedure Register;
begin
  RegisterComponents(SPalDream, [TDCCaptionButton]);
end;

Initialization
  SelectComponentInDesignerProc:=SelectComponentInDesigner;
end.
