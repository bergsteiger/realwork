{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit AutoAdap;

interface

uses
  System.Classes, System.Contnrs, WebComp, WebAuto,
  SiteComp, Web.HTTPProd, Web.WebCntxt;

type
  { Note: On Windows, the XxxStub classes are not used anymore. They are
    replaced by the objects and native scripting support in WebSnapObjs.pas } 
  IBaseAdapterStub = interface(IComponentsStub)
    ['{CAC1644B-9BAD-11D4-A4F2-00C04F6BB853}']
    function  Get_Fields {Flags(1), (1/0) CC:0, INV:2, DBG:6}: IInterface;
    function  Get_Actions {Flags(1), (1/0) CC:0, INV:2, DBG:6}: IInterface;
    function Get_Name_: string;
    function Get_ClassName_: string;
    property Fields: IInterface read Get_Fields;
    property Actions: IInterface read Get_Actions;
  end;

  TBaseAdapterStub = class(TWebComponentsStub, IComponentStub, IBaseAdapterStub)
  protected
    FFields: IInterface;
    FActions: IInterface;
    function CreateComponentsStub(O: TComponent): IInterface; virtual; abstract;
    function FindObject(const AName: string): TObject; override;
    { IBaseAdapterStub }
    function  Get_Fields: IInterface;
    function Get_Actions: IInterface;
    function Get_Name_: string;
    function Get_ClassName_: string;
  public
  end;

  TAdapterStubClass = class of TBaseAdapterStub;

  IBaseRecordsAdapterStub = interface(IBaseAdapterStub)
    ['{CAC1644F-9BAD-11D4-A4F2-00C04F6BB853}']
    function  Get_Records {Flags(1), (1/0) CC:0, INV:2, DBG:6}: IInterface;
    property Records: IInterface read Get_Records;
  end;

  TBaseRecordsAdapterStub = class(TBaseAdapterStub, IBaseRecordsAdapterStub)
  protected
    function CreateRecordsStub(O: TComponent): IInterface; virtual; abstract;
    { IBaseRecordsAdapterStub }
    function  Get_Records: IInterface;
  end;

  IAdapterErrorsStub = interface
    ['{57EAA08F-4A35-4903-B9AA-21A380F7F94B}']
    procedure DefineLabel {Flags(1), (2/2) CC:0, INV:1, DBG:6}({VT_13:0}const Object_: IUnknown;
                                                               {VT_8:0}const Value: string);
    function  FieldErrors {Flags(1), (2/1) CC:0, INV:1, DBG:6}({VT_13:0}const Object_: IUnknown): IInterface;
  end;

  IAdapterHiddenFieldsStub = interface
    ['{B015307D-D096-11D4-A530-00C04F6BB853}']
    procedure WriteFields {Flags(1), (1/1) CC:0, INV:1, DBG:6}({VT_9:0}const Response: IInterface);
  end;

  IAdapterStub = interface(IBaseRecordsAdapterStub)
    ['{06C1025C-0159-4AB6-B7DD-0843DDE856BE}']
    function  Get_Errors {Flags(1), (1/0) CC:0, INV:2, DBG:6}: IInterface;
    function  Get_Mode {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    procedure Set_Mode {Flags(1), (1/1) CC:0, INV:4, DBG:6}({VT_8:0}const Value: string);
    function  Get_CanView {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Boolean;
    function  Get_CanModify {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Boolean;
    function  Get_HiddenFields {Flags(1), (1/0) CC:0, INV:2, DBG:6}: IInterface;
    function  Get_HiddenRecordFields {Flags(1), (1/0) CC:0, INV:2, DBG:6}: IInterface;
    property Errors: IInterface read Get_Errors;
    property Mode: string read Get_Mode write Set_Mode;
    property CanView: Boolean read Get_CanView;
    property CanModify: Boolean read Get_CanModify;
    property HiddenFields: IInterface read Get_HiddenFields;
    property HiddenRecordFields: IInterface read Get_HiddenRecordFields;
  end;

  TAdapterStub = class(TBaseRecordsAdapterStub, IAdapterStub)
  private
  protected
    function CreateErrorsStub(O: TObject): IInterface; virtual; abstract;
    function CreateHiddenFieldsStub(O: TObject): IInterface; virtual; abstract;

    function FindObject(const AName: string): TObject; override;
    { IAdapterStub }
    function  Get_Errors: IInterface;
    function  Get_Mode: string;
    procedure Set_Mode({VT_8:0}const Value: string);
    function  Get_CanView: Boolean;
    function  Get_CanModify: Boolean;
    function  Get_HiddenFields: IInterface;
    function  Get_HiddenRecordFields: IInterface;
  end;

  IAdapterImageStub = interface
    ['{F2AF207A-A097-11D4-A4F7-00C04F6BB853}']
    function  Get_AsHREF {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    property AsHREF: string read Get_AsHREF;
  end;

  IAdapterValuesListStub = interface(IBaseRecordsAdapterStub)
    ['{7895DB1B-01E5-4B6D-9017-5653A4BEA375}']
    function  Get_ValueName {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_Value {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Variant;
    function  NameOfValue {Flags(1), (2/1) CC:0, INV:1, DBG:6}({VT_12:0}Value: Variant): string;
    function  Get_Image {Flags(1), (1/0) CC:0, INV:2, DBG:6}: IInterface;
    function  ImageOfValue {Flags(1), (2/1) CC:0, INV:1, DBG:6}({VT_12:0}Value: Variant): IInterface;
    property ValueName: string read Get_ValueName;
    property Value: Variant read Get_Value;
    property Image: IInterface read Get_Image;
  end;

  TAdapterValuesListStub = class(TBaseRecordsAdapterStub, IAdapterValuesListStub)
  protected
    function CreateImageStub(AdapterImage: IInterface): IInterface; virtual; abstract;
    function FindObject(const AName: string): TObject; override;
    { IAdapterValuesListStub }
    function  Get_Records: IInterface;
    function  Get_Value: Variant;
    function  Get_ValueName: string;
    function  Get_Image: IInterface;
    function  NameOfValue(Value: Variant): string;
    function  ImageOfValue(Value: Variant): IInterface;
  end;

  IAdapterFieldValuesStub = interface(IBaseRecordsAdapterStub)
    ['{7024ECA0-35B5-491B-9AB2-743DDDB0ECDC}']
    function  HasValue {Flags(1), (2/1) CC:0, INV:1, DBG:6}({VT_12:0}Value: Variant): Boolean;
    function  Get_Value {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Variant;
    property Value: Variant read Get_Value;
  end;

  TAdapterFieldValuesStub = class(TBaseRecordsAdapterStub, IAdapterFieldValuesStub)
  protected
    function FindObject(const AName: string): TObject; override;
    { IAdapterFieldValuesStub }
    function  Get_Records: IInterface;
    function  Get_Value: Variant;
    function  HasValue {Flags(1), (2/1) CC:0, INV:1, DBG:6}({VT_12:0}Value: Variant): Boolean;
  end;

  TAdapterComponentsStub = class(TWebComponentsStub, IComponentsStub)
  protected
    function FindObject(const AName: string): TObject; override;
  end;

  TAdapterRecordsStub = class(TScriptObject)
  private
    FAdapter: TComponent;
  public
    constructor Create(AAdapter: TComponent);
    property Adapter: TComponent read FAdapter;
  end;

  TAdapterActionArrayStub = class(TScriptObject, IAdapterActionArrayStub)
  private
    FAction: IInterfaceComponentReference;
  protected
    { IAdapterActionArrayStub }
  public
    constructor Create(AAction: IInterfaceComponentReference);
    property Action: IInterfaceComponentReference read FAction;
  end;

  TAdapterErrorsStub = class(TScriptObject, IAdapterErrorsStub)
  private
    FErrors: TObject;
  protected
    function CreateErrorsStub(O: TObject): IInterface; virtual; abstract;
    { IAdapterErrorsStub }
    procedure DefineLabel {Flags(1), (2/2) CC:0, INV:1, DBG:6}({VT_13:0}const Object_: IUnknown;
                                                               {VT_8:1}const Value: string);
    function  FieldErrors {Flags(1), (2/1) CC:0, INV:1, DBG:6}({VT_13:0}const Object_: IUnknown): IInterface;
  public
    constructor Create(AErrors: TObject);
    property Errors: TObject read FErrors;
  end;

  TAdapterHiddenFieldsStub = class(TScriptObject, IAdapterHiddenFieldsStub)
  private
    FHiddenFields: TObject;
  protected
    { IAdapterHiddenFieldsStub }
    procedure WriteFields(const Response: IInterface);
  public
    constructor Create(AHiddenFields: TObject);
    property HiddenFields: TObject read FHiddenFields;
  end;

  TAdapterSubComponentStub = class(TScriptObject, IInterfaceComponentReference)
  private
    FIntf: IInterfaceComponentReference;
  protected
    { IInterfaceComponentReference }
    function GetComponent: TComponent;
    function  Get_Name: Variant;
  public
    constructor Create(AObject: TComponent); overload;
    constructor Create(AObject: IInterfaceComponentReference); overload;
    property ObjectIntf: IInterfaceComponentReference read FIntf;
  end;

  IAdapterFieldStub = interface
    ['{6C3ACA79-6314-11D4-A4A2-00C04F6BB853}']
    function  Get_Value {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Variant;
    function  Get_Name {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Variant;
    function  Get_DisplayText {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_EditText {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_InputName {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_DisplayWidth {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Integer;
    function  Get_DisplayLabel {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_ValuesList {Flags(1), (1/0) CC:0, INV:2, DBG:6}: IInterface;
    function  Get_InputStyle {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_DisplayStyle {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_Image {Flags(1), (1/0) CC:0, INV:2, DBG:6}: IInterface;
    function  Get_CanModify {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Boolean;
    function  Get_CanView {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Boolean;
    function  Get_Values {Flags(1), (1/0) CC:0, INV:2, DBG:6}: IInterface;
    function  IsEqual {Flags(1), (2/1) CC:0, INV:1, DBG:6}({VT_12:0}Value: Variant): Boolean;
    function  Get_ViewMode {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_Required {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Boolean;
    function  Get_Visible {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Boolean;
    function  Get_MaxLength {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Integer;
    property Value: Variant read Get_Value;
    property Name: Variant read Get_Name;
    property DisplayText: string read Get_DisplayText;
    property EditText: string read Get_EditText;
    property InputName: string read Get_InputName;
    property DisplayWidth: Integer read Get_DisplayWidth;
    property DisplayLabel: string read Get_DisplayLabel;
    property ValuesList: IInterface read Get_ValuesList;
    property InputStyle: string read Get_InputStyle;
    property DisplayStyle: string read Get_DisplayStyle;
    property Image: IInterface read Get_Image;
    property CanModify: Boolean read Get_CanModify;
    property CanView: Boolean read Get_CanView;
    property Values: IInterface read Get_Values;
    property ViewMode: string read Get_ViewMode;
    property Required: Boolean read Get_Required;
    property Visible: Boolean read Get_Visible;
    property MaxLength: Integer read Get_MaxLength;
  end;

  TAdapterFieldStub = class(TAdapterSubComponentStub, IAdapterFieldStub)
  private
    function AsEditText(const Value: Variant): string;
  protected
    function CreateValuesListStub(O: TComponent): IInterface; virtual; abstract;
    function CreateImageStub(AdapterImage: IInterface): IInterface; virtual; abstract;
    function CreateFieldValuesStub(O: TComponent): IInterface; virtual; abstract;
    { IAdapterFieldStub }
    function  Get_Value: Variant;
    function  Get_Values: IInterface;
    function  Get_DisplayText: string;
    function  Get_EditText: string;
    function  Get_InputName: string;
    function  Get_DisplayWidth: Integer;
    function  Get_MaxLength: Integer;
    function  Get_DisplayLabel: string;
    function  Get_ValuesList: IInterface;
    function  Get_Image: IInterface;
    function  Get_DisplayStyle: string;
    function  Get_InputStyle: string;
    function  Get_ViewMode: string;
    function  Get_CanView: Boolean;
    function  Get_Required: Boolean;
    function  Get_Visible: Boolean;
    function  Get_CanModify: Boolean;
    function  IsEqual(Value: Variant): Boolean;
  end;

  TAdapterActionStub = class(TAdapterSubComponentStub, IAdapterActionStub)
  protected
    function CreateActionArrayStub(O: IInterfaceComponentReference): IInterface; virtual; abstract;
    function CreateActionStub(O: IInterfaceComponentReference): IInterface; overload; virtual; abstract;
    { IAdapterActionStub }
    function  Get_AsFieldValue: string;
    function  Get_AsHREF: string;
    function  LinkToPage({VT_8:0}const PageSuccess: string;
                         {VT_8:0}const PageFail: string): IInterface;
    function  Get_DisplayLabel: string;
    function  Get_Enabled: Boolean;
    function  Get_CanExecute: Boolean;
    function  Get_Visible: Boolean;
    function  Get_Array_: IInterface;
    function  Get_DisplayStyle: string;
  end;

  TAdapterImageStub = class(TScriptObject, IAdapterImageStub)
  private
    FIntf: IInterface;
  protected
    { IAdapterImageStub }
    function  Get_AsHREF: string;
  public
    constructor Create(AIntf: IInterface);
  end;

  IImageProducerStub = interface
    ['{128B1043-EF0A-4D1F-A9F7-84C2B5EB96C8}']
    function  GetImage {Flags(1), (3/2) CC:0, INV:1, DBG:6}({VT_13:0}const Object_: IUnknown;
                                                            {VT_8:0}const Caption: string): IInterface;
    function  GetEventImage {Flags(1), (4/3) CC:0, INV:1, DBG:6}({VT_13:0}const Object_: IUnknown;
                                                                 {VT_8:0}const Event: string;
                                                                 {VT_8:0}const Caption: string): IInterface;
    function  GetDisplayStyle {Flags(1), (2/1) CC:0, INV:1, DBG:6}({VT_13:0}const Object_: IUnknown): string;
  end;

  IAdapterRecordStub = interface(IBaseAdapterStub)
    ['{3A5B3303-6348-11D4-A4A2-00C04F6BB853}']
  end;

  TAdapterRecordStub = class(TScriptObject, IAdapterRecordStub)
  private
    FAdapter: TComponent;
    FAdapterStub: TBaseAdapterStub;
  public
    constructor Create(AAdapter: TComponent; AAdapterStubClass: TAdapterStubClass);
    property Impl: TBaseAdapterStub read FAdapterStub implements IAdapterRecordStub;
  end;

  IAdapterErrorStub = interface
    ['{A23C86B1-672A-11D4-A4A7-00C04F6BB853}']
    function  Get_Message {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_Field {Flags(1), (1/0) CC:0, INV:2, DBG:6}: IInterface;
    function  Get_ID {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Integer;
    property Message: string read Get_Message;
    property Field: IInterface read Get_Field;
    property ID: Integer read Get_ID;
  end;

  TAdapterErrorStub = class(TScriptObject, IAdapterErrorStub)
  private
    FError: IAdapterError;
  protected
    { IAdapterError }
    function  Get_Message: string;
    function  Get_Field {Flags(1), (1/0) CC:0, INV:2, DBG:6}: IInterface;
    function  Get_ID {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Integer;
  public
    constructor Create(const AError: IAdapterError);
  end;

  IAdapterHiddenFieldStub = interface
    ['{B0153081-D096-11D4-A530-00C04F6BB853}']
    function  Get_Name {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_Value {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    property Name: string read Get_Name;
    property Value: string read Get_Value;
  end;

  TAdapterHiddenFieldStub = class(TScriptObject, IAdapterHiddenFieldStub)
  private
    FParam: IAdapterHiddenField;
  protected
    { IAdapterHiddenFieldStub}
    function  Get_Name: string;
    function  Get_Value: string;
  public
    constructor Create(const AParam: IAdapterHiddenField);
  end;

  TActionLink = class(TInterfacedObject, IGetAdapterItemRequestParams,
    IGetAdapterRequestDefaultResponse, IInterfaceComponentReference)
  private
    FAction: IInterface;
    FPage: string;
    FErrorPage: string;
  protected
    { IGetAdapterRequestParams }
    procedure GetAdapterItemRequestParams(var AIdentifier: string; AParams: IAdapterItemRequestParams);
    { IGetAdapterRequestDefaultResponse }
    function GetSuccessPage: string;
    function GetFailurePage: string;
    { IInterfaceComponentReference }
    function GetComponent: TComponent;
  public
    constructor Create(AAction: IInterface; const APage, AErrorPage: string);
  end;

  IEndUserStub = interface(IAdapterStub)
    ['{845CF950-B95B-4411-9061-67FEE8E52E08}']
    function  Get_DisplayName {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_LoggedIn {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Boolean;
    function  Get_LoginFormAction {Flags(1), (1/0) CC:0, INV:2, DBG:6}: IInterface;
    function  Get_LogoutAction {Flags(1), (1/0) CC:0, INV:2, DBG:6}: IInterface;
    property DisplayName: string read Get_DisplayName;
    property LoggedIn: Boolean read Get_LoggedIn;
    property LoginFormAction: IInterface read Get_LoginFormAction;
    property LogoutAction: IInterface read Get_LogoutAction;
  end;

  TWebEndUserStub = class(TAdapterStub, IEndUserStub)
  private
    FContext: IScriptContext;
    FEndUser: IWebEndUser;
    function EndUser: IWebEndUser;
  protected
    function CreateActionStub(O: TComponent): IInterface; overload; virtual; abstract;
    { IWebEndUser }
    function  Get_DisplayName: string;
    function  Get_LoggedIn: Boolean;
    function  Get_LoginFormAction: IInterface;
    function  Get_LogoutAction: IInterface;
  public
    constructor Create(AContext: IScriptContext); reintroduce;
  end;

  IApplicationStub = interface(IAdapterStub)
    ['{E086F82C-CAC2-48B1-AFCD-52022CB454C3}']
    function  Get_Title {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_Designing {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Boolean;
    function  QualifyFileName {Flags(1), (2/1) CC:0, INV:1, DBG:6}({VT_8:0}const FileName: PChar): string;
    function  Get_ModulePath {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_ModuleFileName {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    property Title: string read Get_Title;
    property Designing: Boolean read Get_Designing;
    property ModulePath: string read Get_ModulePath;
    property ModuleFileName: string read Get_ModuleFileName;
  end;

  TWebApplicationStub = class(TAdapterStub, IApplicationStub)
  private
    FContext: IScriptContext;
    FApplicationInfo: IWebApplicationInfo;
    function ApplicationInfo: IWebApplicationInfo;
  protected
    { IWebApplication }
    function  Get_Title: string;
    function  Get_Designing: Boolean;
    function  QualifyFileName({VT_8:0}const FileName: PChar): string;
    function  Get_ModulePath: string;
    function Get_ModuleFileName: string;
  public
    constructor Create(AContext: IScriptContext); reintroduce;
  end;

implementation

uses System.SysUtils, System.Variants, WebDisp, Web.HTTPApp, WebScript;

{ TAdapterStub }

function TAdapterStub.FindObject(const AName: string): TObject;
var
  WebVariablesContainer: IWebVariablesContainer;
begin
  if Supports(Obj, IWebVariablesContainer, WebVariablesContainer) then
    Result := WebVariablesContainer.FindVariable(AName)
  else
    Result := nil;
end;

function TAdapterStub.Get_CanModify: Boolean;
var
  Intf: IAdapterAccess;
begin
  if Supports(Obj, IAdapterAccess, Intf) then
    Result := Intf.HasModifyAccess
  else
    Result := True;
end;

function TAdapterStub.Get_CanView: Boolean;
var
  Intf: IAdapterAccess;
begin
  if Supports(Obj, IAdapterAccess, Intf) then
    Result := Intf.HasViewAccess
  else
    Result := True;
end;

function TAdapterStub.Get_Errors: IInterface;
var
  Intf: IGetAdapterErrors;
begin
  if Supports(Obj, IGetAdapterErrors, Intf) then
    Result := CreateErrorsStub(Intf.GetAdapterErrors)
  else
    Result := nil;
end;

function TAdapterStub.Get_HiddenFields: IInterface;
var
  Intf: IGetAdapterHiddenFields;
  O: TObject;
begin
  if Supports(Obj, IGetAdapterHiddenFields, Intf) then
  begin
    O := Intf.GetAdapterHiddenFields;
    if O <> nil then
      Result := CreateHiddenFieldsStub(O)
    else
      Result := nil
  end
  else
    Result := nil;
end;

function TAdapterStub.Get_HiddenRecordFields: IInterface;
var
  Intf: IGetAdapterHiddenFields;
  O: TObject;
begin
  if Supports(Obj, IGetAdapterHiddenFields, Intf) then
  begin
    O := Intf.GetAdapterHiddenRecordFields;
    if O <> nil then
      Result := CreateHiddenFieldsStub(O)
    else
      Result := nil;
  end
  else
    Result := nil;
end;

function TAdapterStub.Get_Mode: string;
var
  Intf: IAdapterMode;
begin
  if Supports(Obj, IAdapterMode, Intf) then
    Result := Intf.GetAdapterMode
  else
    Result := '';
end;

procedure TAdapterStub.Set_Mode(const Value: string);
var
  Intf: IAdapterMode;
begin
  if Supports(Obj, IAdapterMode, Intf) then
    Intf.SetAdapterMode(Value);
end;

{ TAdapterComponentsStub }

function TAdapterComponentsStub.FindObject(const AName: string): TObject;
var
  WebVariablesContainer: IWebVariablesContainer;
begin
  if Supports(Obj, IWebVariablesContainer, WebVariablesContainer) then
    Result := WebVariablesContainer.FindVariable(AName)
  else
    Result := nil;
end;

{ TAdapterRecordsStub }

constructor TAdapterRecordsStub.Create(AAdapter: TComponent);
begin
  FAdapter := AAdapter;
  inherited Create;
end;

{ TAdapterActionArrayStub }

constructor TAdapterActionArrayStub.Create(AAction: IInterfaceComponentReference);
begin
  FAction := AAction;
  inherited Create;
end;

{ TAdapterErrorsStub }

constructor TAdapterErrorsStub.Create(AErrors: TObject);
begin
  FErrors := AErrors;
  inherited Create;
end;

procedure TAdapterErrorsStub.DefineLabel(const Object_: IUnknown;
  const Value: string);
var
  Intf: IAdapterErrors;
  ComponentIntf: IAdapterFieldStub;
begin
  if Supports(FErrors, IAdapterErrors, Intf) then
    if Supports(Object_, IAdapterFieldStub, ComponentIntf) then
      Intf.DefineLabel(ComponentIntf.Get_Name, Value);
end;

function TAdapterErrorsStub.FieldErrors(
  const Object_: IUnknown): IInterface;
var
  Intf: IAdapterErrors;
  ComponentIntf: IAdapterFieldStub;
begin
  if Supports(FErrors, IAdapterErrors, Intf) then
    if Supports(Object_, IAdapterFieldStub, ComponentIntf) then
      if Intf.HasObjectErrors(ComponentIntf.Get_Name) then
         Result := CreateErrorsStub(Intf.GetObjectErrors(ComponentIntf.Get_Name));
end;

{ TAdapterHiddenFieldsStub }

constructor TAdapterHiddenFieldsStub.Create(AHiddenFields: TObject);
begin
  FHiddenFields := AHiddenFields;
  inherited Create;
end;

procedure TAdapterHiddenFieldsStub.WriteFields(const Response: IInterface);
var
  AdapterHiddenFields: IAdapterHiddenFields;
  I: Integer;
  Field: IAdapterHiddenField;
  ResponseStub: IResponseStub;
  GetStub: IGetStub;
  S: string;
  Intf: IInterface;
begin
  if Supports(Response, IGetStub, GetStub) then
    Intf := GetStub.GetStub
  else
    Intf := Response;
  if Supports(Intf, IResponseStub, ResponseStub) and
    Supports(FHiddenFields, IAdapterHiddenFields, AdapterHiddenFields) then
  begin
    for I := 0 to AdapterHiddenFields.FieldCount - 1 do
    begin
      Field := AdapterHiddenFields.Fields[I];
      S := Format('%s<input type="hidden" name="%s" value="%s">' + SLineBreak, [S, Field.Name, Field.Value]);
    end;
    ResponseStub.Write(S);
  end;
end;

{ TAdapterSubComponentStub }

constructor TAdapterSubComponentStub.Create(AObject: TComponent);
begin
  FIntf := AObject;
  inherited Create;
end;

constructor TAdapterSubComponentStub.Create(AObject: IInterfaceComponentReference);
begin
  FIntf := AObject;
  inherited Create;
end;

function TAdapterSubComponentStub.GetComponent: TComponent;
var
  GetComp: IInterfaceComponentReference;
begin
  if Supports(ObjectIntf, IInterfaceComponentReference, GetComp) then
    Result := GetComp.GetComponent
  else
    Result := nil;
end;

function TAdapterSubComponentStub.Get_Name: Variant;
var
  Intf: IWebVariableName;
begin
  if Supports(ObjectIntf, IWebVariableName, Intf) then
    Result := Intf.VariableName
  else
    Result := Unassigned;
end;

{ TAdapterRecordStub }

constructor TAdapterRecordStub.Create(AAdapter: TComponent; AAdapterStubClass: TAdapterStubClass);
begin
  FAdapter := AAdapter;
  FAdapterStub := AAdapterStubClass.Create(AAdapter);
  inherited Create;
end;

{ TAdapterFieldStub }

function TAdapterFieldStub.Get_DisplayText: string;
var
  AsFormatted: IAsFormatted;
begin
  Supports(ObjectIntf, IAsFormatted, AsFormatted);
  if AsFormatted <> nil then
    Result := AsFormatted.AsFormatted
  else
    Result := Get_EditText;
end;

function TAdapterFieldStub.Get_DisplayWidth: Integer;
var
  GetDisplayWidth: IWebGetDisplayWidth;
begin
  if Supports(ObjectIntf, IWebGetDisplayWidth, GetDisplayWidth) then
    Result := GetDisplayWidth.GetDisplayWidth
  else
    Result := -1;
end;

function TAdapterFieldStub.Get_MaxLength: Integer;
var
  GetMax: IWebGetMaxLength;
begin
  if Supports(ObjectIntf, IWebGetMaxLength, GetMax) then
    Result := GetMax.GetMaxLength
  else
    Result := -1;
end;

function TAdapterFieldStub.Get_DisplayLabel: string;
var
  GetDisplayLabel: IWebGetDisplayLabel;
begin
  if Supports(ObjectIntf, IWebGetDisplayLabel, GetDisplayLabel) then
    Result := GetDisplayLabel.GetDisplayLabel
  else
    Result := '';
end;

function TAdapterFieldStub.Get_EditText: string;
begin
  Result := AsEditText(Get_Value);
end;

function TAdapterFieldStub.Get_InputName: string;
var
  Intf: IWebVariableName;
  InputName: IWebInputName;
begin
  if Supports(ObjectIntf, IWebInputName, InputName) then
    Result := InputName.InputName
  else if Supports(ObjectIntf, IWebVariableName, Intf) then
    Result := Intf.VariableName
  else
    Result := '';
end;

function TAdapterFieldStub.AsEditText(const Value: Variant): string;
begin
  if (not VarIsEmpty(Value)) and (not VarIsNull(Value)) then
    Result := Value
  else
    Result := '';
end;

function TAdapterFieldStub.Get_ValuesList: IInterface;
var
  GetIntf: IGetAdapterValuesList;
  AdapterValuesList: IValuesListAdapter;
  Intf: IInterfaceComponentReference;
begin
  if Supports(ObjectIntf, IGetAdapterValuesList, GetIntf) then
  begin
    AdapterValuesList := GetIntf.GetAdapterValuesList;
    if AdapterValuesList <> nil then
    begin
      if Supports(AdapterValuesList, IInterfaceComponentReference, Intf) and
        (Intf.GetComponent <> nil) then
        Result := CreateValuesListStub(Intf.GetComponent)
      else
        Assert(False);  // Expected component implementation
      Exit;
    end;
  end;
  Result := nil;
end;

function TAdapterFieldStub.Get_Image: IInterface;
var
  GetIntf: IGetAdapterImage;
  AdapterImage: IInterface;
begin
  if Supports(ObjectIntf, IGetAdapterImage, GetIntf) then
  begin
    AdapterImage := GetIntf.GetAdapterImage;
    if AdapterImage <> nil then
    begin
      Result := CreateImageStub(AdapterImage);
      exit;
    end;
  end;
  Result := nil;
end;

function TAdapterFieldStub.Get_DisplayStyle: string;
var
  Intf: IGetHTMLStyle;
begin
  if Supports(ObjectIntf, IGetHTMLStyle, Intf) then
    Result := Intf.GetDisplayStyle('')
  else
    Result := '';
end;

function TAdapterFieldStub.Get_InputStyle: string;
var
  Intf: IGetHTMLStyle;
begin
  if Supports(ObjectIntf, IGetHTMLStyle, Intf) then
    Result := Intf.GetInputStyle('')
  else
    Result := '';
end;

function TAdapterFieldStub.Get_CanModify: Boolean;
var
  Intf: IAdapterFieldAccess;
begin
  if Supports(ObjectIntf, IAdapterFieldAccess, Intf) then
    Result := Intf.HasModifyAccess
  else
    Result := True
end;

function TAdapterFieldStub.Get_CanView: Boolean;
var
  Intf: IAdapterFieldAccess;
begin
  if Supports(ObjectIntf, IAdapterFieldAccess, Intf) then
    Result := Intf.HasViewAccess
  else
    Result := True
end;

function TAdapterFieldStub.Get_Values: IInterface;
var
  GetIntf: IGetFieldValuesAdapter;
  AdapterFieldValues: TComponent;
begin
  if Supports(ObjectIntf, IGetFieldValuesAdapter, GetIntf) then
  begin
    AdapterFieldValues := GetIntf.GetFieldValuesAdapter;
    if AdapterFieldValues <> nil then
    begin
      Result := CreateFieldValuesStub(AdapterFieldValues);
      exit;
    end;
  end;
  Result := nil;

end;

function TAdapterFieldStub.Get_Value: Variant;
var
  Intf: IWebGetFieldValue;
begin
  if Supports(ObjectIntf, IWebGetFieldValue, Intf) then
    Result := Intf.GetValue
  else
    Result := Unassigned;
end;

function TAdapterFieldStub.IsEqual(Value: Variant): Boolean;
var
  Intf: IWebValueIsEqual;
  V: Variant;
begin
  if Supports(ObjectIntf, IWebValueIsEqual, Intf) then
    Result := Intf.IsEqual(Value)
  else
  begin
    V := Get_Value;
    try
      Result := (VarIsEmpty(Value) = VarIsEmpty(V)) and (Value = V);
    except
      Result := False
    end
  end;
end;

function TAdapterFieldStub.Get_ViewMode: string;
var
  Intf: IGetHTMLStyle;
begin
  if Supports(ObjectIntf, IGetHTMLStyle, Intf) then
    Result := Intf.GetViewMode('')
  else
    Result := '';
end;

function TAdapterFieldStub.Get_Required: Boolean;
var
  Intf: IAdapterFieldAttributes;
begin
  if Supports(ObjectIntf, IAdapterFieldAttributes, Intf) then
    Result := Intf.GetRequired
  else
    Result := False
end;

function TAdapterFieldStub.Get_Visible: Boolean;
var
  AdapterFieldAttributes: IAdapterFieldAttributes;
begin
  if Supports(ObjectIntf, IAdapterFieldAttributes, AdapterFieldAttributes) then
    Result := AdapterFieldAttributes.GetVisible
  else
    Result := True;
end;

function FindApplicationModuleOfObject(AObjectIntf: IInterface): TComponent;
var
  C: TComponent;
  CompRef: IInterfaceComponentReference;
begin
  if Supports(AObjectIntf, IInterfaceComponentReference, CompRef) then
    C := CompRef.GetComponent
  else
    C := nil;
  if C <> nil then
    begin
      while C.GetParentComponent <> nil do
        C := C.GetParentComponent;
      C := C.Owner;
    end;
  if WebContext <> nil then
    Result := WebContext.FindApplicationModule(C)
  else
    Result := nil;
end;


type

  TTempAdapterDispatcher = class(TInterfacedObject, IAdapterDispatcher)
  private
    FAdapterDispatcher: TAdapterDispatcher;
  protected
    property AdapterDispatcher: TAdapterDispatcher read FAdapterDispatcher implements IAdapterDispatcher;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  constructor TTempAdapterDispatcher.Create;
  begin
    FAdapterDispatcher := TAdapterDispatcher.Create(nil);
    inherited;
  end;

  destructor TTempAdapterDispatcher.Destroy;
  begin
    FAdapterDispatcher.Free;
    inherited;
  end;

function FindAdapterDispatcher(AObjectIntf: IInterface): IAdapterDispatcher;
var
  GetIntf: IGetWebAppComponents;
  AppModule: TComponent;
begin
  AppModule := FindApplicationModuleOfObject(AObjectIntf);
  if Supports(IUnknown(AppModule), IGetWebAppComponents, GetIntf) then
    Result := GetIntf.GetAdapterDispatcher;
  if Result = nil then
    Result := TTempAdapterDispatcher.Create;
end;

{ TAdapterActionStub }

function TAdapterActionStub.Get_Array_: IInterface;
var
  Intf: IIsAdapterActionList;
begin
  if Supports(ObjectIntf, IIsAdapterActionList, Intf) and Intf.IsAdapterActionList then
    Result := CreateActionArrayStub(ObjectIntf)
  else
    Result := nil;
end;

const
  sUnknown = 'Unknown'; // Do not localize

function TAdapterActionStub.Get_AsFieldValue: string;
var
  Intf: IAdapterDispatcher;
begin
  Intf := FindAdapterDispatcher(ObjectIntf);
  if Intf <> nil then
    Result := Intf.EncodeAdapterItemRequestAsFieldValue(ObjectIntf, [])
  else
    Result := sUnknown;
end;

function TAdapterActionStub.Get_AsHREF: string;
var
  Intf: IAdapterDispatcher;
begin
  Intf := FindAdapterDispatcher(ObjectIntf);
  if Intf <> nil then
    Result := Intf.EncodeAdapterItemRequestAsHREF(ObjectIntf, [])
  else
    Result := sUnknown;
end;

function TAdapterActionStub.Get_CanExecute: Boolean;
var
  Intf: IAdapterActionAccess;
begin
  if Supports(ObjectIntf, IAdapterActionAccess, Intf) then
    Result := Intf.HasExecuteAccess
  else
    Result := True
end;

function TAdapterActionStub.Get_DisplayLabel: string;
var
  GetDisplayLabel: IWebGetDisplayLabel;
begin
  if Supports(ObjectIntf, IWebGetDisplayLabel, GetDisplayLabel) then
    Result := GetDisplayLabel.GetDisplayLabel
  else
    Result := '';
end;

function TAdapterActionStub.Get_DisplayStyle: string;
var
  Intf: IGetHTMLStyle;
begin
  if Supports(ObjectIntf, IGetHTMLStyle, Intf) then
    Result := Intf.GetDisplayStyle('')
  else
    Result := '';
end;

function TAdapterActionStub.Get_Enabled: Boolean;
var
  Intf: IWebEnabled;
begin
  if Supports(ObjectIntf, IWebEnabled, Intf) then
    Result := Intf.WebEnabled
  else
    Result := True;
end;

function TAdapterActionStub.Get_Visible: Boolean;
var
  Intf: IAdapterActionAttributes;
begin
  if Supports(ObjectIntf, IAdapterActionAttributes, Intf) then
    Result := Intf.GetVisible
  else
    Result := True;
end;

function TAdapterActionStub.LinkToPage(const PageSuccess,
  PageFail: string): IInterface;
var
  Link: TInterfacedObject;
begin
  Link := TActionLink.Create(ObjectIntf, PageSuccess, PageFail);
  Result := CreateActionStub(Link as IInterfaceComponentReference);
end;

{ TActionLink }

procedure TActionLink.GetAdapterItemRequestParams(var AIdentifier: string; AParams: IAdapterItemRequestParams);
var
  Intf: IGetAdapterItemRequestParams;
begin
  AParams.ParamValues.Clear;
  if Supports(FAction, IGetAdapterItemRequestParams, Intf) then
    Intf.GetAdapterItemRequestParams(AIdentifier, AParams);
end;

constructor TActionLink.Create(AAction: IInterface; const APage, AErrorPage: string);
begin
  inherited Create;
  FPage := APage;
  FAction := AAction;
  FErrorPage := AErrorPage;
end;

function TActionLink.GetFailurePage: string;
begin
  Result := FErrorPage;
end;

function TActionLink.GetSuccessPage: string;
begin
  Result := FPage;
end;

function TActionLink.GetComponent: TComponent;
var
  CompRef: IInterfaceComponentReference;
begin
  if Supports(FAction, IInterfaceComponentReference, CompRef) then
    Result := CompRef.GetComponent
  else
    Result := nil;
end;

{ TAdapterErrorStub }

constructor TAdapterErrorStub.Create(const AError: IAdapterError);
begin
  FError := AError;
  inherited Create;
end;

function TAdapterErrorStub.Get_Field: IInterface;
var
  GetIntf: IGetScriptObject;
begin
  if Supports(FError.GetField, IGetScriptObject, GetIntf) then
    Result := GetIntf.GetScriptObject
  else
    Result := nil;
end;

function TAdapterErrorStub.Get_ID: Integer;
begin
  Result := FError.ID;
end;

function TAdapterErrorStub.Get_Message: string;
begin
  Result := FError.ErrorText;
end;

{ TAdapterHiddenFieldStub }

constructor TAdapterHiddenFieldStub.Create(const AParam: IAdapterHiddenField);
begin
  FParam := AParam;
  inherited Create;
end;

function TAdapterHiddenFieldStub.Get_Name: string;
begin
  Result := FParam.Name;
end;

function TAdapterHiddenFieldStub.Get_Value: string;
begin
  Result := FParam.Value;
end;

{ TAdapterValuesListStub }

function TAdapterValuesListStub.FindObject(
  const AName: string): TObject;
var
  WebVariablesContainer: IWebVariablesContainer;
begin
  if Supports(Obj, IWebVariablesContainer, WebVariablesContainer) then
    Result := WebVariablesContainer.FindVariable(AName)
  else
    Result := nil;
end;

function TAdapterValuesListStub.Get_Image: IInterface;
var
  Intf: IValuesListAdapter;
  AdapterImage: IInterface;
begin
  if Supports(Obj, IValuesListAdapter, Intf) then
  begin
    AdapterImage := Intf.GetListImage;
    if AdapterImage <> nil then
      Result := CreateImageStub(AdapterImage)
    else
      Result := nil
  end
  else
    Result := nil;
end;

function TAdapterValuesListStub.Get_Records: IInterface;
begin
  Result := CreateRecordsStub(Obj);
end;

function TAdapterValuesListStub.Get_Value: Variant;
var
  Intf: IValuesListAdapter;
begin
  if Supports(Obj, IValuesListAdapter, Intf) then
    Result := Intf.GetListValue
  else
    Result := Unassigned;
end;

function TAdapterValuesListStub.Get_ValueName: string;
var
  Intf: IValuesListAdapter;
begin
  if Supports(Obj, IValuesListAdapter, Intf) then
    Result := Intf.GetListName
  else
    Result := '';
end;

function TAdapterValuesListStub.ImageOfValue(
  Value: Variant): IInterface;
var
  Intf: IValuesListAdapter;
  AdapterImage: IInterface;
begin
  if Supports(Obj, IValuesListAdapter, Intf) then
  begin
    AdapterImage := Intf.GetListImageOfValue(Value);
    if AdapterImage <> nil then
    begin
      Result := CreateImageStub(AdapterImage);
      Exit;
    end;
  end;
  Result := nil;
end;

function TAdapterValuesListStub.NameOfValue(Value: Variant): string;
var
  Intf: IValuesListAdapter;
begin
  if Supports(Obj, IValuesListAdapter, Intf) then
    Result := Intf.GetListNameOfValue(Value)
  else
    Result := '';
end;

{ TBaseAdapterStub }

function TBaseAdapterStub.FindObject(const AName: string): TObject;
var
  WebVariablesContainer: IWebVariablesContainer;
begin
  if Supports(Obj, IWebVariablesContainer, WebVariablesContainer) then
    Result := WebVariablesContainer.FindVariable(AName)
  else
    Result := nil;
end;

function TBaseAdapterStub.Get_Actions: IInterface;
var
  GetIntf: IGetAdapterActions;
begin
  if FActions = nil then
    if Supports(Obj, IGetAdapterActions, GetIntf) then
      FActions := CreateComponentsStub(GetIntf.GetAdapterActions);
  Result := FActions;
end;

function TBaseAdapterStub.Get_ClassName_: string;
begin
  Result := Obj.ClassName;
end;

function TBaseAdapterStub.Get_Fields: IInterface;
var
  GetIntf: IGetAdapterFields;
begin
  if FFields = nil then
    if Supports(Obj, IGetAdapterFields, GetIntf) then
      FFields := CreateComponentsStub(GetIntf.GetAdapterFields);
  Result := FFields;
end;

function TBaseAdapterStub.Get_Name_: string;
var
  Intf: IWebVariableName;
begin
  if Supports(Obj, IWebVariableName, Intf) then
    Result := Intf.VariableName
  else
    Result := '';
end;

{ TBaseRecordsAdapterStub }

function TBaseRecordsAdapterStub.Get_Records: IInterface;
begin
  if Obj <> nil then
    Result := CreateRecordsStub(Obj)
  else
    Result := nil;
end;

{ TAdapterImageStub }

constructor TAdapterImageStub.Create(AIntf: IInterface);
begin
  inherited Create;
  FIntf := AIntf;
end;

function TAdapterImageStub.Get_AsHREF: string;
var
  Dispatcher: IAdapterDispatcher;
  WebImageHREF: IWebImageHREF;
  S: string;
  CompRef: IInterfaceComponentReference;
begin
  if Supports(FIntf, IWebImageHREF, WebImageHREF) then
    if WebImageHREF.WebImageHREF(S) then
    begin
      Result := S;
      Exit;
    end;
  if Supports(FIntf, IInterfaceComponentReference, CompRef) then
    Dispatcher := FindAdapterDispatcher(CompRef.GetComponent)
  else
    Assert(False); // Can't find component
  if Dispatcher <> nil then
    Result := Dispatcher.EncodeAdapterItemRequestAsHREF(FIntf, [])
  else
  begin
    Result := sUnknown;
  end;
end;

{ TWebApplicationStub }

constructor TWebApplicationStub.Create(
  AContext: IScriptContext);
begin
  FContext := AContext;
  if ApplicationInfo <> nil then
    inherited Create(ApplicationInfo.ApplicationAdapter)
  else
    inherited Create(nil);
end;

function TWebApplicationStub.ApplicationInfo: IWebApplicationInfo;
var
  AppModule: TComponent;
  GetIntf: IGetWebAppComponents;
begin
  if not Assigned(FApplicationInfo) then
  begin
    if WebContext <> nil then
    begin
      AppModule := WebContext.FindApplicationModule(FContext.WebModuleContext);
      if Supports(IUnknown(AppModule), IGetWebAppComponents, GetIntf) then
        FApplicationInfo := GetIntf.WebApplicationInfo;
    end;
  end;
  Result := FApplicationInfo;
end;

function TWebApplicationStub.Get_Title: string;
begin
  if ApplicationInfo <> nil then
    Result := ApplicationInfo.ApplicationTitle
  else
    Result := '';
end;

function TWebApplicationStub.Get_Designing: Boolean;
begin
  if FContext.WebModuleContext is TComponent then
    Result := csDesigning in TComponent(FContext.WebModuleContext).ComponentState
  else
    Result := False;
end;

function TWebApplicationStub.Get_ModulePath: string;
begin
  Result := ExtractFilePath(Get_ModuleFileName)
end;

function TWebApplicationStub.Get_ModuleFileName: string;
begin
  if Assigned(GetModuleFileNameProc) then
    Result := GetModuleFileNameProc
  else
    Result := '';
end;

function TWebApplicationStub.QualifyFileName(
  const FileName: PChar): string;
begin
  Result := WebComp.QualifyFileName(FileName)
end;

{ TWebEndUserStub }

constructor TWebEndUserStub.Create(
  AContext: IScriptContext);
begin
  FContext := AContext;
  if EndUser <> nil then
    inherited Create(EndUser.EndUserAdapter)
  else
    inherited Create(nil);
end;

function TWebEndUserStub.EndUser: IWebEndUser;
var
  AppModule: TComponent;
  GetIntf: IGetWebAppComponents;
begin
  if not Assigned(FEndUser) then
  begin
    if WebContext <> nil then
    begin
      AppModule := WebContext.FindApplicationModule(FContext.WebModuleContext);
      if Supports(IUnknown(AppModule), IGetWebAppComponents, GetIntf) then
        FEndUser := GetIntf.GetWebEndUser;
    end;
  end;
  Result := FEndUser;
end;

function TWebEndUserStub.Get_LoginFormAction: IInterface;
var
  Obj: TComponent;
begin
  Result := nil;
  if EndUser <> nil then
  begin
    Obj := EndUser.LoginFormAction;
    if Obj <> nil then
      Result := CreateActionStub(Obj);
  end;
end;

function TWebEndUserStub.Get_LogoutAction: IInterface;
var
  Obj: TComponent;
begin
  Result := nil;
  if EndUser <> nil then
  begin
    Obj := EndUser.LogoutAction;
    if Obj <> nil then
      Result := CreateActionStub(Obj);
  end;
end;

function TWebEndUserStub.Get_DisplayName: string;
begin
  if EndUser <> nil then
    Result := EndUser.DisplayName
  else
    Result := '';
end;

function TWebEndUserStub.Get_LoggedIn: Boolean;
begin
  if EndUser <> nil then
    Result := EndUser.LoggedIn
  else
    Result := False;
end;

{ TAdapterFieldValuesStub }

function TAdapterFieldValuesStub.FindObject(
  const AName: string): TObject;
var
  WebVariablesContainer: IWebVariablesContainer;
begin
  if Supports(Obj, IWebVariablesContainer, WebVariablesContainer) then
    Result := WebVariablesContainer.FindVariable(AName)
  else
    Result := nil;
end;

function TAdapterFieldValuesStub.Get_Records: IInterface;
begin
  Result := CreateRecordsStub(Obj);
end;

function TAdapterFieldValuesStub.Get_Value: Variant;
var
  FieldIntf: IWebGetFieldValues;
  AdapterIntf: IFieldValuesAdapter;
begin
  if Supports(Obj, IFieldValuesAdapter, AdapterIntf) and
    Supports(AdapterIntf.GetField, IWebGetFieldValues, FieldIntf) then
    Result := FieldIntf.GetCurrentValue
  else
    Result := Unassigned;
end;

function TAdapterFieldValuesStub.HasValue(Value: Variant): Boolean;
var
  FieldIntf: IWebGetFieldValues;
  AdapterIntf: IFieldValuesAdapter;
begin
  if Supports(Obj, IFieldValuesAdapter, AdapterIntf) and
    Supports(AdapterIntf.GetField, IWebGetFieldValues, FieldIntf) then
    Result := FieldIntf.HasValue(Value)
  else
    Result := False;
end;

end.
