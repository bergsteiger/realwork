{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit PropCBReg;

interface
{$I dc.inc}

uses Classes,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  sysutils;

type
  {$IFDEF D3}
  TCompEditor = class(TComponentProperty)
    procedure GetValues(Proc: TGetStrProc); override;
  end;
  {$ENDIF}

  {$IFDEF D6}
  TDCDsgnProp=IProperty;
  {$ELSE}
  TDCDsgnProp=TPropertyEditor;
  {$ENDIF}

  TPropNameEditor = class(TStringProperty)
  private
    FProc: TGetStrProc;
    {$IFDEF D6}
    procedure PropNameProc(const Prop: TDCDsgnProp);
    {$ELSE}
    procedure PropNameProc(Prop: TDCDsgnProp);
    {$ENDIF}
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

procedure Register;

implementation
{$R *.dcr}

uses
  TypInfo, Forms, PropCB, dcConsts {$IFDEF D5}, Contnrs{$ENDIF};

{------------------------}

procedure Register;
begin
  RegisterComponents(SPalDreamEdit, [TDCPropCheck]);
  {$IFDEF D3}
  RegisterPropertyEditor(TypeInfo(TPersistent), TDCPropCheck, 'Component',
    TCompEditor);
  {$ENDIF}
  RegisterPropertyEditor(TypeInfo(string), TDCPropCheck, 'PropName',
    TPropNameEditor);
end;

{------------------------}

{$IFDEF D3}
procedure TCompEditor.GetValues(Proc: TGetStrProc);
begin
  Proc(TComponent(GetComponent(0)).Owner.Name);
  inherited GetValues(Proc);
end;
{$ENDIF}

{------------------------}

function TPropNameEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paRevertable];
end;

{------------------------}

type
  TMComponentList=class(
     {$IFDEF D6}
     TDesignerSelections
     {$ELSE}
     {$IFDEF D5}
     TDesignerSelectionList
     {$ELSE}
     TComponentList
     {$ENDIF}
     {$ENDIF}
  )
  end;

procedure TPropNameEditor.GetValues(Proc: TGetStrProc);
var
  CList:TMComponentList;
  Comp: TPersistent;
begin
  Comp := (GetComponent(0) as TDCPropCheck).Component;
  if Comp <> nil then
  begin
    CList := TMComponentList.Create;
    try
      TMComponentList(CList).Add(TComponent(Comp));
      FProc := Proc;
      GetComponentProperties(CList, tkProperties, Designer, PropNameProc);
    finally
      CList.Free;
    end;
  end;
end;

{------------------------}

{$IFDEF D6}
procedure TPropNameEditor.PropNameProc(const Prop: TDCDsgnProp);
{$ELSE}
procedure TPropNameEditor.PropNameProc(Prop: TDCDsgnProp);
{$ENDIF}
begin
  if Assigned(FProc) and (CompareText(Prop.GetPropType.Name, 'Boolean') = 0) then
    FProc(Prop.GetName); //add only Boolean properties
  {$IFNDEF D6}
  Prop.Free;
  {$ENDIF}
end;

{------------------------}

end.
