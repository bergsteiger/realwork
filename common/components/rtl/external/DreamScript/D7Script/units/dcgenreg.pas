{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcGenReg;

interface
{.$I dc.inc}
{$I dcprod.inc}

uses
  Classes, Graphics, TypInfo, SysUtils, Dialogs, Consts,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors, 
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcconsts, dcsystem, dcapi, dcgen, dccommon, dcdreamlib
  {$IFDEF DREAMPARSER}, dccdes{$ENDIF};

type
  TExtCompEditor = class(TComponentProperty)
    function  GetValue : string; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { This property editor is used when you need to select one of published properties
    of object.}
  TPropNameEditor = class(TStringProperty)
  private
    fProc: TGetStrProc;
    {$IFDEF D6}
    procedure GetPropEdit(const Prop: TDCDsgnProp);
    {$ELSE}
    procedure GetPropEdit(Prop: TDCDsgnProp);
    {$ENDIF}
  protected
    { Component returns the object which properties will be shown in the list.
      By default the result is GetComponent(0).
    }
    function Component : TPersistent; virtual;

    function GetFilter : TTypeKinds; virtual;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TVerbNamePropEdit = class(TStringProperty)
  private
    FProc:TGetStrProc;
    function GetVerbNameIterator(Item:TObjectParamListItem;const AParams:Array of variant;
               Var Finish:boolean):Variant;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TPropEditCompEditor = class(TComponentProperty)
  private
    fProc : TGetStrProc;
    procedure getProc(const s : string);
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc : TGetStrProc); override;
  end;

  TDCPropName = class(TStringProperty)
  private
    FProc : TGetStrProc;
    procedure GetProp(Instance:TPersistent;PropInfo:PPropInfo;UserData :integer);
  protected
    function GetLinkName : string; virtual;
  public
    function GetAttributes: TPropertyAttributes;override;
    function Component : TPersistent; virtual;
    function GetClass:TClass;virtual; abstract;
    procedure GetValues(Proc: TGetStrProc);override;
  end;

  TStringsPropName = class(TDCPropName)
  public
    function GetClass:TClass;override;
   end;

  TCollPropName = class(TDCPropName)
  public
    function GetClass:TClass;override;
  end;

  { Property editor for filename property }
  TFileNameEdit = class(TPropertyEditor)
  public
    function  GetAttributes : TPropertyAttributes; override;
    function  GetValue : string; override;
    procedure SetValue(const val : string); override;
    procedure Edit; override;

    {ovveride these function to change filter or Default extension of
     TOpendDialog  which will be show when user clicks elipsis}
    function  GetDefaultExtension : string; virtual;
    function  GetFilter : string; virtual;
  end;

  { Property editor for filename property with AVI extension}
  TAVIFileNameEdit = class(TFileNameEdit)
    function  GetDefaultExtension : string; override;
    function  GetFilter : string; override;
  end;

procedure Register;

implementation
{-------------------------------------------------------------------------}

function TVerbNamePropEdit.GetVerbNameIterator(Item:TObjectParamListItem;
  const AParams:Array of variant; Var Finish:boolean):Variant;
begin
  FProc(Item.Params[SVerbName]);
end;

{-------------------------------------------------------------------------}

procedure TVerbNamePropEdit.GetValues(Proc: TGetStrProc);
begin
  FProc:=Proc;
  ObjectParamList.ForEveryClass(TVerbObject,[1],GetVerbNameIterator);
end;

{-------------------------------------------------------------------------}

function TVerbNamePropEdit.GetAttributes: TPropertyAttributes;
begin
  Result:=inherited GetAttributes+[paSortList, paValueList];
end;

{------------------------------------------------------------------}

function TPropEditCompEditor.GetAttributes: TPropertyAttributes;
begin
  Result:=inherited GetAttributes-[paMultiSelect];
end;

{------------------------------------------------------------------}

procedure TPropEditCompEditor.getProc(const s : string);
var
  i    : integer;
  info : TVerbListItem;
  TestComp:TComponent;
begin
  TestComp:=Designer.GetComponent(S);
  If (TestComp=nil) or (GetItemInherited(TestComp.ClassType,
                          [SAssignIdent],[''],[])=nil) then
    exit;
  info := TVerbListItem(GetComponent(0));
  with info, Collection do
    for i := 0 to Count - 1 do
      if Assigned(TVerbListItem(Items[i]).VerbComp) and
         (CompareText(s, TVerbListItem(Items[i]).VerbComp.Name) = 0) then
        exit;
  fProc(s);
end;

{------------------------------------------------------------------}

procedure TPropEditCompEditor.GetValues(Proc : TGetStrProc);
begin
  fProc := Proc;
  inherited GetValues(getProc);
end;

{------------------------------------------------------------------}

function TDCPropName.GetAttributes: TPropertyAttributes;
begin
  result := inherited GetAttributes;
  include(result,paValueList);
end;

{------------------------------------------------------------------}

procedure TDCPropName.GetValues(Proc: TGetStrProc);
begin
  if Component <> nil then
    begin
      FProc := Proc;
      IterateProps(Component,[tkClass],GetProp,false,integer(@Proc));
    end;
end;

{------------------------------------------------------------------}

procedure TDCPropName.GetProp(Instance:TPersistent;PropInfo:PPropInfo; UserData :integer);
begin
  if TObject(GetOrdProp(Instance, PropInfo)) is GetClass then
    FProc(PropInfo^.Name);
end;

{------------------------------------------------------------------}

function TDCPropName.GetLinkName : string;
begin
  result := 'Link'; //don't resource
end;

{------------------------------------------------------------------}

function TDCPropName.Component : TPersistent;
var
  Instance : TPersistent;
  PropInfo : PPropInfo;
begin
  Instance := GetComponent(0);
  PropInfo := TypInfo.GetPropInfo(Instance.ClassInfo, GetLinkName);
  if (PropInfo <> nil) and (PropInfo^.PropType^.Kind = tkClass) then
    result := TPersistent(GetOrdProp(Instance, PropInfo))
  else
    result := nil;  
end;

{******************************************************************}

function TCollPropName.GetClass:TClass;
begin
  result:=TCollection;
end;

{******************************************************************}

function TStringsPropName.GetClass:TClass;
begin
  result:=TStrings;
end;

{------------------------------------------------------------------}

procedure TFileNameEdit.Edit;
begin
  with TOpenDialog.Create(nil) do
    try
      DefaultExt := GetDefaultExtension;
      Filter := GetFilter;
      if Execute then
        SetStrValue(FileName);
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

function TFileNameEdit.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{------------------------------------------------------------------}

function TFileNameEdit.GetValue : string;
begin
  result := GetStrValue;
end;

{------------------------------------------------------------------}

procedure TFileNameEdit.SetValue(const val : string);
begin
  SetStrValue(val);
end;

{------------------------------------------------------------------}

function  TFileNameEdit.GetDefaultExtension : string;
begin
  result := '';
end;

{------------------------------------------------------------------}

function  TFileNameEdit.GetFilter : string;
begin
  result := ResStr(SDefaultFilter);
end;

{******************************************************************}

function  TAVIFileNameEdit.GetDefaultExtension : string;
begin
  result := 'avi'; //don't resource
end;

{------------------------------------------------------------------}

function  TAVIFileNameEdit.GetFilter : string;
begin
  result := SAVIFilesFilter;
end;

{----------------------------------------------------------}

function TPropNameEditor.GetAttributes: TPropertyAttributes;
begin
  result := inherited GetAttributes;
  Include(result, paValueList);
end;

{------------------------------------------------------------------}

{$IFDEF D6}
procedure TPropNameEditor.GetPropEdit(const Prop: TDCDsgnProp);
begin
  fProc(Prop.GetName);
end;
{$ELSE}
procedure TPropNameEditor.GetPropEdit(Prop: TDCDsgnProp);
begin
  fProc(Prop.GetName);
  Prop.Free;
end;
{$ENDIF}

{------------------------------------------------------------------}

function TPropNameEditor.Component : TPersistent;
begin
  result := GetComponent(0);
end;

{------------------------------------------------------------------}

function TPropNameEditor.GetFilter : TTypeKinds;
begin
  result := tkAny - [tkMethod];
end;

{------------------------------------------------------------------}

procedure TPropNameEditor.GetValues(Proc: TGetStrProc);
var
{$IFDEF D6}
  clist:IDesignerSelections;
{$ELSE}
  clist:TComponentList;
{$ENDIF}
begin
  if Component <> nil then
    begin
      fProc := Proc;
      {$IFDEF D6}
      clist := CreateSelectionList;
      {$ELSE}
      clist := TComponentList.Create;
      {$ENDIF}
      clist.Add(TComponent(Component));
      try
        GetComponentProperties(clist, GetFilter, Designer, GetPropEdit{$IFDEF D6},nil{$ENDIF});
      finally
        {$IFNDEF D6}
        clist.Free;
        {$ENDIF}
      end;
    end;
end;

{-------------------------------------------------------------------------}

function TExtCompEditor.GetValue : string;
var
  o : TObject;
begin
  o := TObject(GetOrdValue);
  if o is TComponent then
    result := inherited GetValue
  else
    result := GetCompName(TPersistent(o));
end;

{-------------------------------------------------------------------------}

procedure TExtCompEditor.GetValues(Proc: TGetStrProc);
begin
  {$IFDEF D3}
  Proc(TComponent(GetComponent(0)).Owner.Name);
  {$ENDIF}
  inherited GetValues(Proc);
end;

procedure Register;
begin
  RegisterComponents(SPalDream,[TDCFileOperation, TActiveNotifier
    {$IFDEF SHELLOBJ},TDCPathDialog{$ENDIF}]);

  RegisterPropertyEditor(TypeInfo(Integer), TFont, 'Size', TFontSizePropEdit); //don't resource
  RegisterPropertyEditor(TypeInfo(string),TVerbListItem,'VerbName',TVerbNamePropEdit); //don't resource
  RegisterPropertyEditor(TComponent.ClassInfo,TVerbListItem,'VerbComp',TPropEditCompEditor); //don't resource
  RegisterComponentEditor(TVerbDispatcher,TDispatchCompEditor);

  {$IFDEF D4}
  RegisterPropertyEditor(TypeInfo(string),TDCIDEAction,'VerbName',TVerbNamePropEdit); //don't resource
  SafeRegisterActions(SDreamActions, [TDCIDEAction], TDCIDEAction);
  {$ENDIF}

  {$IFDEF DREAMPARSER}
  // DCCDES registration
  RegisterPropertyEditor(TypeInfo(TPersistent),TStringsCodeDesigner,'Link',TComponentProperty); //don't resource
  RegisterPropertyEditor(TypeInfo(string),TStringsCodeDesigner,'PropName',TStringsPropName); //don't resource
  {$ENDIF}
end;

end.
