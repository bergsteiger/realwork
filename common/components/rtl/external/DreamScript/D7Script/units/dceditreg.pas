{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcEditReg;

interface

procedure Register;

implementation
{.$I dc.inc}
{$I dcprod.inc}
uses
  Classes, Controls, Dialogs,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcconsts, dcsystem,dcgen,dcGenReg,dcpedit, dcedit;

type
  TPopupWindowEditor = class(TClassProperty)
    procedure GetProperties(Proc: TGetPropEditProc); override;
  end;

procedure TPopupWindowEditor.GetProperties(Proc: TGetPropEditProc);
begin
  if GetOrdValueAt(0) = 0 then
    begin
      ShowMessage(sErrEmptyPopupClass);
      exit;
    end;
  inherited GetProperties(Proc);
end;

type
  TPopupClassNameEditor = class(TPropertyEditor)
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{------------------------------------------------------------------}

function TPopupClassNameEditor.GetAttributes: TPropertyAttributes;
begin
  result := [paValueList, paSortList];
end;

{------------------------------------------------------------------}

function TPopupClassNameEditor.GetValue: string;
begin
  result := TCustomDCEdit(GetComponent(0)).PopupWindowClass;
end;

{------------------------------------------------------------------}

procedure TPopupClassNameEditor.GetValues(Proc: TGetStrProc);
var
  i : integer;
  c : TWinControlClass;
begin
  for i := 0 to PopupClasses.Count - 1 do
    begin
      c := TWinControlClass(TPopupClassInfo(PopupClasses[i]).c);
      if Assigned(c) then
        Proc(c.ClassName);
    end;
end;

{------------------------------------------------------------------}

procedure TPopupClassNameEditor.SetValue(const Value: string);
begin
  TCustomDCEdit(GetComponent(0)).PopupWindowClass := Value;
  Designer.Modified;
end;

type
  TEditSourceTypeEditor = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{------------------------------------------------------------------}

function TEditSourceTypeEditor.GetAttributes: TPropertyAttributes;
begin
  result := [paValueList];
end;

{------------------------------------------------------------------}

function TEditSourceTypeEditor.GetValue: string;
begin
  result := TCustomDCEdit(GetComponent(0)).EditSourceClass;
end;

{------------------------------------------------------------------}

procedure TEditSourceTypeEditor.GetValues(Proc: TGetStrProc);
var
  i : integer;
begin
  for i := 0 to EditSourceClasses.Count - 1 do
    Proc(TEditSourceClassInfo(EditSourceClasses[i]).c.ClassName);
end;

{------------------------------------------------------------------}

procedure TEditSourceTypeEditor.SetValue(const Value: string);
begin
  TCustomDCEdit(GetComponent(0)).EditSourceClass := Value;
  Designer.Modified;
end;

{------------------------------------------------------------------}

type
  TEditClassEditor = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{------------------------------------------------------------------}

function TEditClassEditor.GetAttributes: TPropertyAttributes;
begin
  result := [paValueList];
end;

{------------------------------------------------------------------}

function TEditClassEditor.GetValue: string;
begin
  result := TCustomDCEdit(GetComponent(0)).EditClass;
end;

{------------------------------------------------------------------}

procedure TEditClassEditor.GetValues(Proc: TGetStrProc);
var
  i : integer;
  s : TStringList;
begin
  s := TStringList.Create;
  s.Sorted := true;
  try
    for i := 0 to EditClasses.Count - 1 do
      with TEditClassInfo(EditClasses[i]) do
        if not Internal then
          s.Add(c.ClassName);

    StringsToProc(s, Proc);
  finally
    s.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TEditClassEditor.SetValue(const Value: string);
begin
  TCustomDCEdit(GetComponent(0)).EditClass := Value;
  Designer.Modified;
end;

type
  TPropNameEditor2 = class(TPropNameEditor)
  protected
    function Component : TPersistent; override;
  end;

{------------------------------------------------------------------}

function TPropNameEditor2.Component : TPersistent;
begin
  result := (GetComponent(0) as TDCCustomPropEditor).Component;
end;

type
  TLinkedEditorProperty = class(TComponentProperty)
    fProc : TGetStrProc;

    procedure GetStr(const s : string);
    procedure GetValues(Proc: TGetStrProc); override;
  end;

procedure TLinkedEditorProperty.GetStr(const s : string);
var
  edit : TDCCustomPropEditor;
begin
  edit := TDCCustomPropEditor(Designer.GetComponent(s));
  if Assigned(edit) and (edit <> GetComponent(0)) and (edit.LinkedEditor = nil) then
    fProc(s);
end;

{----------------------------------------------------}

procedure TLinkedEditorProperty.GetValues(Proc: TGetStrProc);
begin
  fProc := Proc;
  inherited GetValues(GetStr);
end;

type
  TCheckedValueProperty = class(TStringProperty)
    fProc : TGetStrProc;

    procedure GetProc(const s : string);
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TCheckedValueProperty.GetAttributes: TPropertyAttributes;
begin
  result := inherited GetAttributes;
  include(result, paValueList);
end;

{----------------------------------------------------}

procedure TCheckedValueProperty.GetProc(const s : string);
var
  rbut : TDCPropRadioButton;
  i    : integer;
  Sibling : TControl;
begin
  rbut := GetComponent(0) as TDCPropRadioButton;
  with rbut.Parent do
    for i := 0 to ControlCount - 1 do
      begin
        Sibling := Controls[I];
        if (Sibling <> rbut) and (Sibling is TDCPropRadioButton) and
           (TDCPropRadioButton(Sibling).CheckedValue = s) then
             exit;
      end;
  fProc(s);
end;

{----------------------------------------------------}

procedure TCheckedValueProperty.GetValues(Proc: TGetStrProc);
var
  propedit : TDCDsgnProp;
begin
  propedit := TDCCustomPropEditor(GetComponent(0)).PropEditor;
  fProc := Proc;
  {$IFNDEF D6}
  if propedit is TEnumProperty then
      TEnumProperty(propedit).GetValues(GetProc);
  {$ENDIF}
end;

{----------------------------------------------------}

procedure Register;
begin
  if Assigned(RegisterComponentsProc) then
    RegisterComponents(SPalDreamEdit, [TDCPropEditor, TDCPropCheckBox, TDCPropRadioButton, TCompList,TDCHistoryEdit]);
  RegisterPropertyEditor(TypeInfo(TWinControl), TCustomDCEdit, 'PopupWindow', TPopupWindowEditor);
  RegisterPropertyEditor(TypeInfo(TEditSource), TCustomDCEdit, 'EditSource', TClassProperty);
  RegisterPropertyEditor(TypeInfo(TControl), TCustomDCEdit, 'Edit', TClassProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomDCEdit, 'PopupWindowClass', TPopupClassNameEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomDCEdit, 'EditSourceClass', TEditSourceTypeEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomDCEdit, 'EditClass', TEditClassEditor);
  RegisterPropertyEditor(TypeInfo(string), TDCCustomPropEditor, 'PropName', TPropNameEditor2);
  RegisterPropertyEditor(TypeInfo(TPersistent), TDCCustomPropEditor, 'Component', TExtCompEditor);
  RegisterPropertyEditor(TypeInfo(TComponent), TDCCustomPropEditor, 'LinkedEditor', TLinkedEditorProperty);
  RegisterPropertyEditor(TypeInfo(string), TDCCustomPropEditor, 'CheckedValue', TCheckedValueProperty);
end;

end.
