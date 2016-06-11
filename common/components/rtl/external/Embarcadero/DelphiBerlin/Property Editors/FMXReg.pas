{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FmxReg;

interface

uses
  System.Classes, Vcl.Controls, FMX.ListView.Appearances, FMX.Controls,
  System.Types, FMX.ListView.DynamicAppearance, DesignIntf, System.TypInfo;

type
 TCustomSyntheticProperty = class(TBasePropertyEditor, IProperty, IPropertyKind)
  private
    FDesigner: IDesigner;
  protected
    { IProperty }
    procedure Initialize; override;
    procedure SetPropEntry(Index: Integer; AInstance: TPersistent;
      APropInfo: PPropInfo); override;
    procedure Activate;
    function AllEqual: Boolean;
    function AutoFill: Boolean;
    procedure Edit; virtual;
    function HasInstance(Instance: TPersistent): Boolean;
    function GetAttributes: TPropertyAttributes; virtual;
    function GetEditLimit: Integer;
    function GetEditValue(out Value: string): Boolean;
    function GetName: string; virtual;
    function GetValue: string; virtual;
    procedure SetValue(const Value: string); virtual;
    procedure GetProperties(Proc: TGetPropProc); virtual;
    function GetPropInfo: PPropInfo; virtual;
    function GetPropType: PTypeInfo; virtual;
    procedure GetValues(Proc: TGetStrProc); virtual;
    procedure Revert;
    function ValueAvailable: Boolean;
    { IPropertyKind }
    function GetKind: TTypeKind; virtual;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); override;
    property Designer: IDesigner read FDesigner;
  end;


procedure Register;

implementation

uses
  Windows, System.SysUtils, System.Actions, System.UITypes, System.Math,
  System.RTLConsts, System.UIConsts, Vcl.Graphics, Vcl.Forms, DesignEditors, MaskUtils,
  TreeIntf, DesignMenus, DsnConst, DesignConst, FMX.Ani, FMX.StdCtrls, FMX.Graphics, FMX.Utils, FMX.Forms,
  FMX.ExtCtrls, ColnEdit, FMX.Header, FMX.Grid.Style, FMX.Grid, FMX.Dialogs, Dialogs, FMX.Types3D, FMX.Colors, FMX.Effects,
  FMX.Filter, FMX.Filter.Effects, FMX.Layers3D, FMX.Objects, FMX.Objects3D, FMX.Layouts, FMX.ListBox, FMX.Memo,
  FMX.Memo.Style, FMX.TabControl, FMX.Media, FMX.Edit, FMX.TreeView, FMX.ListView, FMX.Menus,
  FMX.Platform, FMX.Platform.Win, FMX.Materials, FMX.Styles, FmxDsnConst, FMX.Viewport3D, FMX.Controls3D,
  FMX.MaterialSources, FMX.MagnifierGlass, FMX.MediaLibrary.Actions, FmxEditors, FMX.WebBrowser, FMX.Gestures,
  FMX.Printer, Generics.Collections, Generics.Defaults, FMX.PhoneDialer.Actions, FMX.MultiResBitmap,
  Fmx.ImgList, FMX.DateTimeCtrls, FMX.BehaviorManager, FMX.InAppPurchase, FMX.Advertising, FMX.Calendar, FiltEdit,
  FMX.Styles.Objects, FMX.MultiView, FMX.EditBox, FMX.NumberBox, FMX.SpinBox, FMX.SearchBox, FMX.ComboEdit,
  FMX.ComboTrackBar, FMX.Edit.Style, FMX.SpinBox.Style, FMX.NumberBox.Style, FMX.ComboEdit.Style,
  FMX.ComboTrackBar.Style, FMX.SearchBox.Style, FMX.Calendar.Style, FMX.CalendarEdit, FMX.CalendarEdit.Style, FMX.Maps,
  FMX.Analytics.AppAnalytics, FMX.Presentation.Factory, FMX.Switch.Style, FMX.MultiView.Types, FMX.MultiView.Types.Style,
  FMX.Presentation.Style, FMX.ScrollBox, FMX.ScrollBox.Style, FMX.AddressBook, FMX.ListView.Types,
  // Designers
  FmxMultiResBitmapEditors, FmxImageListEditors, FMX.Design.Brush, FMX.Design.Bitmap, FMX.Design.ListView,
  FMX.Design.Items, FMX.Design.Path, FMX.Design.Lang, ActnEdit, FMX.ActnList, FMX.StdActns, FMX.ActnRes, ActionEditors,
  ComponentDesigner, VCLEditors, FmxAnimationEditors, FMX.Design.Import, FMX.Editor.MultiView,
  {$IFDEF MSWINDOWS}
  StringsEdit,
  StrEdit,
  {$ENDIF}
  {$IFDEF LINUX}
  FmxStrEdit,
  {$ENDIF}
  FMX.Editor.Items, FmxSprigs, FmxStyleLookup, FMX.Types, FMX.Design.Font;

{ TBrushProperty }

type
  TBrushProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

procedure TBrushProperty.Edit;
var
  BrushDesigner: TBrushDesigner;
begin
  BrushDesigner := TBrushDesigner.Create(nil);
  with BrushDesigner do
  try
    Designer := Self.Designer;
    Component := Self.GetComponent(0);
    CurrentBrush := TBrush(Self.GetOrdValue);
    ShowModal;
  finally
    FreeAndNil(BrushDesigner);
  end;
  Designer.Activate;
end;

function TBrushProperty.GetValue: string;
begin
  Result := '(Brush)';
end;

function TBrushProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly];
end;

type
  TFontProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TFontNameProperty = class(VCLEditors.TFontNameProperty)
  public
    function GetValue: String; override;
  end;

  TFontSizeProperty = class(TFloatProperty)
  public
    function GetValue: String; override;
  end;

  TPathDataProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: String; override;
    procedure Edit; override;
  end;

  TTriggerProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{ TTriggerProperty }

function TTriggerProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paRevertable];
end;

procedure TTriggerProperty.GetValues(Proc: TGetStrProc);
begin
  try
    Proc('IsChecked=true');
    Proc('IsChecked=false');
    Proc('IsDragOver=true');
    Proc('IsDragOver=false');
    Proc('IsFocused=true');
    Proc('IsFocused=false');
    Proc('IsMouseOver=true');
    Proc('IsMouseOver=false');
    Proc('IsOpen=true');
    Proc('IsOpen=false');
    Proc('IsPressed=true');
    Proc('IsPressed=false');
    Proc('IsSelected=true');
    Proc('IsSelected=false');
    Proc('IsVisible=true');
    Proc('IsVisible=false');
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

function TTriggerProperty.GetValue: string;
begin
  try
    Result := GetStrValue;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

procedure TTriggerProperty.SetValue(const Value: string);
begin
  try
    SetStrValue(Value);
    Modified;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

type

  TMeshDataProperty = class(TClassProperty)
  private
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: String; override;
    procedure Edit; override;
  end;

  TStringOfFloatTripletsProperty = class(TStringProperty)
  protected
    procedure ValidateInput(const Value: string);
  public
    procedure SetValue(const Value: string); override;
  end;

  TStringOfFloatDoublesProperty = class(TStringProperty)
  protected
    procedure ValidateInput(const Value: string);
  public
    procedure SetValue(const Value: string); override;
  end;

  TStringOfIntegersProperty = class(TStringProperty)
  protected
    procedure ValidateInput(const Value: string);
  public
    procedure SetValue(const Value: string); override;
  end;

procedure TStringOfFloatTripletsProperty.SetValue(const Value: string);
begin
  try
    ValidateInput(Value);
    try
      SetStrValue(Value);
      Modified;
    except
      raise;
    end;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

procedure TStringOfFloatTripletsProperty.ValidateInput(const Value: string);
var
  Pos: Integer;
  S1, S2, S3: String;
begin
  Pos := 1;
  while Pos < Length(Value) do
  begin
      S1 := WideGetToken(Pos, Value, ' ,');
      if Length(S1) = 0 then
        raise Exception.Create(SThreeFloatsException);
      try
        StrToFloat(S1, USFormatSettings);
      except
        raise Exception.Create(SThreeFloatsException);
      end;

      S2 := WideGetToken(Pos, Value, ' ,');
      if Length(S2) = 0 then
        raise Exception.Create(SThreeFloatsException);
      try
        StrToFloat(S2, USFormatSettings);
      except
        raise Exception.Create(SThreeFloatsException);
      end;

      S3 := WideGetToken(Pos, Value, ' ,');
      if Length(S3) = 0 then
        raise Exception.Create(SThreeFloatsException);
      try
        StrToFloat(S3, USFormatSettings);
      except
        raise Exception.Create(SThreeFloatsException);
      end;
  end;
end;

procedure TStringOfFloatDoublesProperty.SetValue(const Value: string);
begin
  try
    ValidateInput(Value);
    try
      SetStrValue(Value);
      Modified;
    except
      raise;
    end;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

procedure TStringOfFloatDoublesProperty.ValidateInput(const Value: string);
var
  Pos: Integer;
  S1, S2: String;
begin
  Pos := 1;
  while Pos < Length(Value) do
  begin
      S1 := WideGetToken(Pos, Value, ' ,');
      if Length(S1) = 0 then
        raise Exception.Create(STwoFloatsException);
      try
        StrToFloat(S1, USFormatSettings);
      except
        raise Exception.Create(STwoFloatsException);
      end;

      S2 := WideGetToken(Pos, Value, ' ,');
      if Length(S2) = 0 then
        raise Exception.Create(STwoFloatsException);
      try
        StrToFloat(S2, USFormatSettings);
      except
        raise Exception.Create(STwoFloatsException);
      end;
  end;
end;

procedure TStringOfIntegersProperty.SetValue(const Value: string);
begin
  try
    ValidateInput(Value);
    try
      SetStrValue(Value);
      Modified;
    except
      raise;
    end;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

procedure TStringOfIntegersProperty.ValidateInput(const Value: string);
var
  Pos: Integer;
  S1: String;
begin
  Pos := 1;
  while Pos < Length(Value) do
  begin
      S1 := WideGetToken(Pos, Value, ' ');
      if Length(S1) = 0 then
        raise Exception.Create(SIntegersSetException);
      try
        StrToInt(S1);
      except
        raise Exception.Create(SIntegersSetException);
      end;
  end;
end;

{ Items Editor Base Classes ===================================================}

{TShorCutProperty}

type
  TShortCutProperty = class(VCLEditors.TShortCutProperty)
  public
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

function TShortCutProperty.GetValue: string;
var
  CurValue: TShortCut;
  MenuService: IFMXMenuService;
  S: string;
begin
  CurValue := GetOrdValue;
  if CurValue = scNone then
    Result := srNone
  else
  begin
    S := '';
    if TPlatformServices.Current.SupportsPlatformService(IFMXMenuService, IInterface(MenuService)) then
      S := MenuService.ShortCutToText(CurValue);
    if S = '' then
      Result := '(' + IntToStr(CurValue) + ')'
    else
      Result := S;
  end;
end;

procedure TShortCutProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  MenuService: IFMXMenuService;
  S: string;
begin
  Proc(srNone);
  TPlatformServices.Current.SupportsPlatformService(IFMXMenuService, IInterface(MenuService));
  for I := 0 to RegisteredShortCutCount - 1 do
  begin
    S := '';
    if Assigned(MenuService) then
      S := MenuService.ShortCutToText(RegisteredShortCut(I));
    if S = '' then
      S := '(' + IntToStr(RegisteredShortCut(I)) + ')';
    Proc(S);
  end;
end;

procedure TShortCutProperty.SetValue(const Value: string);
var
  NewValue: TShortCut;
  S: string;
  I, Code: integer;
begin
  S := Trim(Value);
  NewValue := 0;
  if (S <> '') and (AnsiCompareText(Value, srNone) <> 0) then
  begin
    NewValue := FMX.ActnList.TextToShortCut(S);
    if NewValue = 0 then
    begin
      if (S[1] = '(') and (S[Length(S)] = ')') then
      begin
        S := Copy(S, 2, Length(S) - 2);
        Val(S, I, Code);
        if Code = 0 then
          NewValue := I;
      end;
      if NewValue = 0 then
        raise EDesignPropertyError.Create(SInvalidPropertyValue);
    end;
  end;
  SetOrdValue(NewValue);
end;

type

{ TLangProperty }

  TLangProperty = class(TStringProperty)
  private
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

function TLangProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paRevertable];
end;

procedure TLangProperty.Edit;
begin
  vgLangDesigner := TLangDesigner.Create(Application);
  vgLangDesigner.Designer := Designer;
  with vgLangDesigner do
  begin
    FLang := TLang(GetComponent(0));
    langList.Items.Assign(FLang.Resources);
    if langList.Items.Count > 0 then
      langList.ItemIndex := FLang.Resources.IndexOf(FLang.Lang);

    layoutAdd.Visible := langList.Items.Count = 0;
    layoutSelect.Visible := langList.Items.Count > 0;

    RebuildOriginalList;
    if ShowModal = mrOk then
    begin
      FLang.Lang := langList.Text;
      Designer.Modified;
    end;
  end;
  vgLangDesigner.Free;
end;

type

{ TLangEditor }

  TLangEditor = class(TComponentEditor)
  private
  public
    procedure Edit; override;
  end;

procedure TLangEditor.Edit;
begin
  ShowDsgnLang(TLang(Component), Designer);
end;


{ TMeshCollectionProperty }
type

  TMeshCollectionProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

function TMeshCollectionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TMeshCollectionProperty.GetValue: string;
begin
  Result := '(MeshCollection)';
end;

procedure TMeshCollectionProperty.Edit;
var
  LMeshCollectionDesigner: TMeshCollectionDesigner;
  I: Integer;
  BtnEnable: Boolean;
begin
  LMeshCollectionDesigner := TMeshCollectionDesigner.Create(nil);
  LMeshCollectionDesigner.CloneMeshCollection(TModel3D(GetComponent(0)));
  LMeshCollectionDesigner.Scale := TModel3D(GetComponent(0)).Scale.X;

  {enable/disable some buttons from the editor}
  BtnEnable:= LMeshCollectionDesigner.Model3D1.ChildrenCount > 0;
  LMeshCollectionDesigner.btnClear.Enabled:=BtnEnable;
  LMeshCollectionDesigner.btnUp.Enabled:= BtnEnable;
  LMeshCollectionDesigner.btnDown.Enabled:= BtnEnable;
  LMeshCollectionDesigner.btnLeft.Enabled:= BtnEnable;
  LMeshCollectionDesigner.btnRight.Enabled:= BtnEnable;

  if LMeshCollectionDesigner.ShowModal = mrOk then
  begin
    if LMeshCollectionDesigner.Command = cClear then
      for I := 0 to PropCount - 1 do
        TModel3D(GetComponent(I)).Clear
    else
    if LMeshCollectionDesigner.Command = cOpen then
      for I := 0 to PropCount - 1 do
        TModel3D(GetComponent(I)).LoadFromFile(LMeshCollectionDesigner.FileName);

    Modified;

  end;
  LMeshCollectionDesigner.Free;
end;

{ TActionListEditor }

type
  TActionListEditor = class(TComponentEditor {$IFDEF LINUX}, IDesignerThreadAffinity{$ENDIF})
  protected
    {$IFDEF LINUX}
    function GetThreadAffinity: TThreadAffinity;
    {$ENDIF}
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TActionListEditor.ExecuteVerb(Index: Integer);
begin
  ShowActionListDesigner(Designer, Component as TActionList);
end;

{$IFDEF LINUX}
function TActionListEditor.GetThreadAffinity: TThreadAffinity;
begin
  Result := taQt;
end;
{$ENDIF}

function TActionListEditor.GetVerb(Index: Integer): string;
begin
  Result := SActionListEdit;
end;

function TActionListEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;


{ TGestureIDProperty }

type
  TGestureIDProperty = class(TIntegerProperty)
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

function TGestureIDProperty.GetValue: string;
begin
  GestureToIdent(GetOrdValue, Result);
end;

procedure TGestureIDProperty.SetValue(const Value: string);
var
  NewValue: integer;
begin
  if IdentToGesture(Value, NewValue) then
    SetOrdValue(NewValue)
  else
    inherited SetValue(Value);
end;


{ TTouchManagerProperty }

type
  TTouchManagerProperty = class(TClassProperty)
  protected
    function GetIsDefault: boolean; override;
  public
    function GetAttributes: TPropertyAttributes; override;
  end;

function TTouchManagerProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties, paVolatileSubProperties, paReadOnly];
end;

type
  THackTouchManager = class(TTouchManager);

function TTouchManagerProperty.GetIsDefault: boolean;
begin
  if TPersistent(GetOrdValue) is TTouchManager then
    Result := THackTouchManager(GetOrdValue).IsDefault
  else
    Result := inherited;
end;

type
  TGesturesProperty = class(TCustomSyntheticProperty)
  private type
    TGestureComparer = class(TComparer<FMX.Types.TCustomGestureCollectionItem>)
    public
      function Compare(const Left, Right: FMX.Types.TCustomGestureCollectionItem): Integer; override;
    end;
  private
    FControl: TFmxObject;
    FTouchManager: FMX.Types.TTouchManager;
    FStandardGestureList: FMX.Gestures.TGestureCollection;
  protected
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetName: string; override;
    procedure GetProperties(Proc: TGetPropProc); override;
    function GetValue: string; override;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer;
      ATouchManager: FMX.Types.TTouchManager); reintroduce; virtual;
  end;

  TGestureListProperty = class(TCustomSyntheticProperty)
  private
    FControl: TFmxObject;
    FGestureList: FMX.Gestures.TGestureCollection;
    FGestureTypes: FMX.Types.TGestureTypes;
    FPropName: string;
  protected
    function GetAttributes: TPropertyAttributes; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure GetProperties(Proc: TGetPropProc); override;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer;
      const APropName: string; AGestureList: FMX.Gestures.TGestureList; AControl: TFmxObject;
      AGestureTypes: FMX.Types.TGestureTypes); reintroduce; virtual;
    destructor Destroy; override;
  end;

  TGestureProperty = class(TCustomSyntheticProperty, ICustomPropertyDrawing,
    ICustomPropertyDrawing80, ICustomPropertyMessage, IProperty80)
  private
    FActionListView: TActionListView;
    FControl: TFmxObject;
    FGesture: FMX.Types.TCustomGestureCollectionItem;
    FHost: IPropertyHost;
    FPreviewPoints: FMX.Types.TGesturePointArray;
    FPreviewSize: Integer;
    FFrameworkType: string;
    FIDEActions: TIDEActionsClass;
    function CheckRect(const ItemRect: TRect) : TRect;
    procedure DoNewAction(Sender: TObject; const Category: string;
      ActionClass: TContainedActionClass; ActionList: TContainedActionList);
    procedure DoSelectAction(Sender: TObject; Action: TContainedAction);
    function GetChecked: Boolean;
    procedure SetChecked(const Value: Boolean);
  protected
    function GetAttributes: TPropertyAttributes; override;
    function GetKind: TTypeKind; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure SetAction(const Value: TContainedAction);
    procedure SetValue(const Value: string); override;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer;
      AGesture: FMX.Types.TCustomGestureCollectionItem; AControl: TFmxObject); reintroduce; virtual;
    destructor Destroy; override;
    // IProperty80
    procedure Edit(const Host: IPropertyHost; DblClick: Boolean); reintroduce; overload;
    // ICustomPropertyDrawing
    procedure PropDrawName(ACanvas: Vcl.Graphics.TCanvas; const ARect: TRect;
      ASelected: Boolean);
    procedure PropDrawValue(ACanvas: Vcl.Graphics.TCanvas; const ARect: TRect;
      ASelected: Boolean);
    // ICustomPropertyDrawing80
    function PropDrawNameRect(const ARect: TRect): TRect;
    function PropDrawValueRect(const ARect: TRect): TRect;
    // ICustomPropertyMessage
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
      InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
    procedure MouseMove(Shift: TShiftState; X, Y: Integer; InNameRect: Boolean;
      const ItemRect: TRect; var Handled: Boolean);
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
      InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
    procedure HintShow(var HintInfo: Vcl.Controls.THintInfo; InNameRect: Boolean;
      const ItemRect: TRect; var Handled: Boolean);

    property Checked: Boolean read GetChecked write SetChecked;
    property Gesture: FMX.Types.TCustomGestureCollectionItem read FGesture write FGesture;
    property IDEActions: TIDEActionsClass read FIDEActions;
  end;

  TGestureSelectionEditor = class(TSelectionEditor)
  private
    class var FGestureUnits: TStrings;
    class var FGestureUnitMap: TDictionary<string, string>;
    class constructor Create;
    class destructor Destroy;
  public
    class procedure AddGesture(AGesture: FMX.Types.TCustomGestureCollectionItem);
    class procedure SelectGesture(const AGestureName: string);
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TTouchManagerPropertyFilter = class(TSelectionEditor, ISelectionPropertyFilter)
  protected
    { ISelectionPropertyFilter }
    procedure FilterProperties(const ASelection: IDesignerSelections;
      const ASelectionProperties: IInterfaceList);
  end;

  THackGestureManager = class(FMX.Gestures.TGestureManager)
  end;

  TMobileFormFilter = class(TSelectionEditor, ISelectionpropertyFilter)
  protected
    { ISelectionPropertyFilter }
    procedure FilterProperties(const ASelection: IDesignerSelections;
      const ASelectionproperties: IInterfaceList);
  end;

  TTabItemFilter = class(TSelectionEditor, ISelectionpropertyFilter)
  protected
    { ISelectionPropertyFilter }
    procedure FilterProperties(const ASelection: IDesignerSelections;
      const ASelectionproperties: IInterfaceList);
  end;

  TTintColorFilter = class(TSelectionEditor, ISelectionpropertyFilter)
  protected
    { ISelectionPropertyFilter }
    procedure FilterProperties(const ASelection: IDesignerSelections;
      const ASelectionproperties: IInterfaceList);
  end;

  TFontColorForStateFilter = class(TSelectionEditor, ISelectionpropertyFilter)
  protected
    { ISelectionPropertyFilter }
    procedure FilterProperties(const ASelection: IDesignerSelections; const ASelectionproperties: IInterfaceList);
  end;

  TGridSelectionEditor = class(TSelectionEditor)
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TAddressBookSelectionEditor = class(TSelectionEditor)
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TTabCustomIconProperty = class(TMultiResBitmapProperty)
  public
    procedure Edit; override;
  end;

  TLightSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TCommonDialogEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TCommon3DSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

 procedure TLightSelectionEditor.RequiresUnits(Proc: TGetStrProc);
 begin
   Proc('FMX.Types3D');
   Proc('System.Math.Vectors');
 end;

{ Registration }

function VclApplicationHandle: HWND;
begin
  Result := Vcl.Forms.Application.Handle;
end;

function VclApplicationState: TApplicationState;
begin
  if Vcl.Forms.Application <> nil then
    Result := TApplicationState.Running
  else
    Result := TApplicationState.None;
end;

procedure Register;
begin
  StartClassGroup(FMX.Types.TFmxObject);
  ActivateClassGroup(FMX.Types.TFmxObject);
  RegisterComponents(srStandard, [TMainMenu, TPopupMenu]);
  RegisterComponents(srStandard, [FMX.ActnList.TActionList]);
  RegisterComponents(srStandard, [TLang]);
  RegisterComponents(srStandard, [TStyleBook]);
  RegisterComponents(srStandard, [TButton]);
  RegisterComponents(srStandard, [TCheckBox, TRadioButton, TGroupBox, TPopupBox]);
  RegisterComponents(srStandard, [TPanel, TCalloutPanel, TLabel, TImageControl, TPathLabel, TProgressBar, TScrollBar, TSmallScrollBar,
    TExpander, TTrackBar, TSwitch, TSplitter]);
  RegisterComponents(srStandard, [TMenuBar, TStatusBar, TToolBar]);
  RegisterComponents(srStandard, [TSizeGrip]);
  RegisterComponents(srStandard, [TListBox, TComboBox, TMemo, TEdit, TTreeView, TListView]);
  RegisterComponents(srStandard, [TPopup]);

//  GroupDescendentsWith(TMenuItem, TControl);
//  GroupDescendentsWith(TMenu, TControl);
//  RegisterClass(TMenuItem);


  RegisterComponents(srAdditional, [TSpeedButton, TCornerButton, TArcDial,
    TAniIndicator, TMediaPlayer, TMediaPlayerControl, TCameraComponent, TBannerAd]);

  {$WARNINGS OFF}
  RegisterNoIcon([TCalendarEdit, TClearingEdit]); // Deprecated
  {$WARNINGS ON}
  RegisterComponents(srAdditional, [TCalendar, TDateEdit, TTimeEdit,
    TDropTarget, TImageViewer, TNumberBox, TSpinBox, TComboEdit, TComboTrackBar, TPlotGrid, TMagnifierGlass]);

  RegisterComponents(SGridsColumns, [TGrid, TStringGrid, THeader]);
//  RegisterComponents(srGridsColumns, [T_Grid, T_ValueGrid, T_Header]);
//  RegisterPropertyEditor(TypeInfo(string),
//                         TBaseAbstractGridSettings,
//                         'CustomOptionsName',
//                         TCustomOptionsNameProperty);
//  RegisterPropertyEditor(TypeInfo(TBaseAbstractGridSettings),
//                         nil,
//                         '',
//                         TSettingsProperty);
//  RegisterPropertyEditor(TypeInfo(TAbstractGridCustomOptions),
//                         nil,
//                         '',
//                         TCustomOptionsProperty);


  RegisterComponents(srCommonControls, [TTabControl, TMultiView]);

  RegisterComponents(SAnimations, [TColorAnimation, TGradientAnimation,
    TFloatAnimation, TRectAnimation, TBitmapAnimation, TBitmapListAnimation,
    TColorKeyAnimation, TFloatKeyAnimation, TPathAnimation]);

  RegisterComponents(SColors, [THueTrackBar, TAlphaTrackBar, TBWTrackBar,
    TColorQuad, TColorPicker, TGradientEdit, TColorBox, TColorPanel,
    TComboColorBox, TColorButton, TColorComboBox, TColorListBox]);

  RegisterComponentEditor(TColorButton, TForceOnClickEditor);
  RegisterComponentEditor(TSwitch, TForceOnSwitchEditor);

  RegisterComponents(SEffects, [TShadowEffect, TBlurEffect, TGlowEffect,
    TInnerGlowEffect, TBevelEffect, TReflectionEffect, TRippleEffect,
    TSwirlEffect, TMagnifyEffect, TSmoothMagnifyEffect, TBandsEffect,
    TWaveEffect, TWrapEffect, TBandedSwirlEffect, TPinchEffect, TTilerEffect,
    TPixelateEffect, TEmbossEffect, TSharpenEffect, TToonEffect, TSepiaEffect,
    TPaperSketchEffect, TPencilStrokeEffect, TFillEffect, TFillRGBEffect,
    TNormalBlendEffect, THueAdjustEffect, TContrastEffect, TBloomEffect,
    TGloomEffect, TInvertEffect, TMonochromeEffect, TColorKeyAlphaEffect,
    TMaskToAlphaEffect, TBandedSwirlTransitionEffect, TBlindTransitionEffect,
    TBloodTransitionEffect, TCircleTransitionEffect, TMagnifyTransitionEffect,
    TCrumpleTransitionEffect,  TDissolveTransitionEffect, TDropTransitionEffect,
    TFadeTransitionEffect, TBrightTransitionEffect, TPixelateTransitionEffect,
    TBlurTransitionEffect, TWiggleTransitionEffect, TShapeTransitionEffect,
    TRippleTransitionEffect, TRotateCrumpleTransitionEffect, TSaturateTransitionEffect,
    TSlideTransitionEffect, TSwirlTransitionEffect, TWaterTransitionEffect,
    TWaveTransitionEffect, TLineTransitionEffect, TAffineTransformEffect,
    TPerspectiveTransformEffect, TCropEffect, TGaussianBlurEffect, TBoxBlurEffect,
    TDirectionalBlurEffect, TRadialBlurEffect, TSwipeTransitionEffect,
    TRasterEffect]);

  RegisterComponents(SViewports, [TViewport3D]);

  RegisterComponents(SDialogs, [FMX.Dialogs.TOpenDialog, FMX.Dialogs.TSaveDialog,
    FMX.Printer.TPrintDialog, FMX.Printer.TPageSetupDialog, FMX.Printer.TPrinterSetupDialog]);

  RegisterComponents(SGestures, [FMX.Gestures.TGestureManager]);

  RegisterComponents(SShapes, [TLine, TRectangle, TRoundRect, TEllipse, TCircle,
    TArc, TPie, TText, TPath, TImage, TPaintBox, TCalloutRectangle,
    TSelection, TSelectionPoint]);

  RegisterComponents(SScene3D, [TCamera, TLight, TDummy, TProxyObject]);
  RegisterComponents(SShapes3D, [TPlane, TDisk, TCube, TMesh, TSphere, TCylinder,
    TRoundCube, TCone, TGrid3D, TStrokeCube, TText3D, TPath3D, TRectangle3D, TEllipse3D,
    TModel3D]);

  RegisterComponents(SLayers3D, [TLayout3D, TBufferLayer3D, TSplitter3D, TSolidLayer3D, TImage3D, TLayer3D, TTextLayer3D]);


  RegisterNoIcon([TMaterialBook]);
  RegisterComponents(SMaterials, [TColorMaterialSource, TTextureMaterialSource, TLightMaterialSource]);

  RegisterComponents(SShapes3D, [TPlane, TCube, TMesh, TSphere, TCylinder,
    TRoundCube, TCone, TGrid3D, TStrokeCube, TText3D, TPath3D, TRectangle3D, TEllipse3D]);

  RegisterComponents(SLayouts, [TLayout, TScaledLayout, TGridLayout, TGridPanelLayout, TFlowLayoutBreak, TFlowLayout,
    TScrollBox, TVertScrollBox, THorzScrollBox, TFramedScrollBox,
    TFramedVertScrollBox, TPresentedScrollBox]);

  RegisterComponents(SInternet, [TWebBrowser]);

  RegisterComponents(SStyles, [TStyleObject, TActiveStyleObject, TTabStyleObject, TCheckStyleObject, TButtonStyleObject,
    TSystemButtonObject, TTintedStyleObject, TTintedButtonStyleObject, TMaskedImage, TActiveMaskedImage,
    TStyleTextObject, TActiveStyleTextObject, TTabStyleTextObject, TButtonStyleTextObject, TActiveOpacityObject]);

  RegisterComponents(srSystem, [TTimer]);
  GroupDescendentsWith(TAppAnalytics, TFmxObject);
  RegisterComponents(SService, [TInAppPurchase, TMapView, TAppAnalytics, TAddressBook]);

  RegisterComponentEditor(FMX.ActnList.TActionList, TActionListEditor);
  RegisterComponentEditor(TMainMenu, TMenuEditor);
  RegisterComponentEditor(TEdit, TEditEditor);
  RegisterComponentEditor(TPopupMenu, TMenuEditor);
  RegisterComponentEditor(TMenuBar, TMenuEditor);
  RegisterComponentEditor(TListBox, TListBoxEditor);
  RegisterComponentEditor(TComboBox, TListBoxEditor);
  RegisterComponentEditor(TTreeView, TTreeViewEditor);
  RegisterComponentEditor(THeader, THeaderEditor);
  RegisterComponentEditor(TTabControl, TTabControlEditor);
  RegisterComponentEditor(TGrid, TGridEditor);
  RegisterComponentEditor(TStringGrid, TStringGridEditor);
  RegisterComponentEditor(FMX.Dialogs.TCommonDialog, TCommonDialogEditor);
  RegisterComponentEditor(TMultiView, TMultiViewEditor);

                                           
  RegisterPropertyEditor(TypeInfo(TTrigger), nil, '', TTriggerProperty);
  RegisterPropertyEditor(TypeInfo(TBrush), nil, '', TBrushProperty);
  RegisterPropertyEditor(TypeInfo(TPathData), nil, '', TPathDataProperty);
  RegisterPropertyEditor(TypeInfo(TFont), nil, '', TFontProperty);
  RegisterPropertyEditor(TypeInfo(TFontName), TFont, '', TFontNameProperty);
  RegisterPropertyEditor(TypeInfo(Single), TFont, 'Size', TFontSizeProperty);
  RegisterPropertyEditor(TypeInfo(TShortCut), nil, '', TShortCutProperty);
  RegisterPropertyEditor(TypeInfo(TTabItem), TTabControl, 'ActiveTab', TActiveTabProperty);
  RegisterPropertyEditor(TypeInfo(TBrushKind), TStrokeBrush, '', TBrushKindProperty);

  // meshdata related editors
  RegisterPropertyEditor(TypeInfo(TMeshData),nil, '', TMeshDataProperty);
  RegisterPropertyEditor(TypeInfo(string), TMeshData, 'Normals', TStringOfFloatTripletsProperty);
  RegisterPropertyEditor(TypeInfo(string), TMeshData, 'Points', TStringOfFloatTripletsProperty);
  RegisterPropertyEditor(TypeInfo(string), TMeshData, 'TexCoordinates', TStringOfFloatDoublesProperty);
  RegisterPropertyEditor(TypeInfo(string), TMeshData, 'TriangleIndices', TStringOfIntegersProperty);

  RegisterPropertyEditor(TypeInfo(TStrings), nil, '', TStringListProperty);

  RegisterComponentEditor(TLang, TLangEditor);
  RegisterPropertyEditor(TypeInfo(string), TLang, 'Lang', TLangProperty);

  // Float animation support
  RegisterPropertyEditor(TypeInfo(string), TFloatAnimation, 'PropertyName', TFloatAnimationPropertyName);
  RegisterPropertyEditor(TypeInfo(string), TFloatKeyAnimation, 'PropertyName', TFloatAnimationPropertyName);
  RegisterPropertyEditor(TypeInfo(single), TFmxObject, '', TFmxFloatProperty);
  RegisterPropertyEditor(TypeInfo(single), TPosition, '', TFmxFloatProperty);
  RegisterPropertyEditor(TypeInfo(Single), TControlSize, '', TFmxFloatProperty);

  // Rect animation support
  RegisterPropertyEditor(TypeInfo(string), TRectAnimation, 'PropertyName', TRectAnimationPropertyName);
  // Disabled - because impossible to edit sub-propertities
//  RegisterPropertyEditor(TypeInfo(TBounds), TFmxObject, '', TRectAnimationProperty);

  // Color animation support
  RegisterPropertyEditor(TypeInfo(string), TColorAnimation, 'PropertyName', TColorAnimationPropertyName);
  RegisterPropertyEditor(TypeInfo(string), TColorKeyAnimation, 'PropertyName', TColorAnimationPropertyName);
  RegisterPropertyEditor(TypeInfo(TAlphaColor), TFmxObject, '', TAlphaColorProperty);
  RegisterPropertyEditor(TypeInfo(TAlphaColor), TPersistent, '', TAlphaColorProperty);
  RegisterPropertyEditor(TypeInfo(TAlphaColor), TGrid3D, '', TAlphaColorProperty);
  RegisterPropertyEditor(TypeInfo(TAlphaColor), TFillEffect, '', TAlphaColorProperty);
  RegisterPropertyEditor(TypeInfo(TAlphaColor), TFillRGBEffect, '', TAlphaColorProperty);
  RegisterPropertyEditor(TypeInfo(TAlphaColor), TColorKey, '', TAlphaColorProperty);
  RegisterPropertyEditor(TypeInfo(TAlphaColor), TFontColorForState, '', TColorForStateProperty);

  // Gradient animation support
  RegisterPropertyEditor(TypeInfo(string), TGradientAnimation, 'PropertyName', TGradientAnimationPropertyName);
  RegisterPropertyEditor(TypeInfo(TGradient), nil, '', TGradientProperty);

  // Bitmap animation support
  RegisterPropertyEditor(TypeInfo(string), TBitmapAnimation, 'PropertyName', TBitmapAnimationPropertyName);
  RegisterPropertyEditor(TypeInfo(string), TBitmapListAnimation, 'PropertyName', TBitmapListAnimationPropertyName);
  RegisterPropertyEditor(TypeInfo(FMX.Graphics.TBitmap), nil, '', TBitmapProperty);

  RegisterPropertyEditor(TypeInfo(TMeshCollection), nil, '', TMeshCollectionProperty);

  //Gestures
  GroupDescendentsWith(FMX.Types.TCustomGestureManager, TFmxObject);
  RegisterPropertyEditor(TypeInfo(FMX.Types.TGestureID), nil, '', TGestureIDProperty);
  RegisterPropertyEditor(TypeInfo(FMX.Types.TTouchManager), nil, '', TTouchManagerProperty);
  RegisterSelectionEditor(FMX.Gestures.TGestureManager, TGestureSelectionEditor);
  RegisterSelectionEditor(TFmxObject, TTouchManagerPropertyFilter);
  THackGestureManager(FMX.Gestures.TGestureManager).FDesignerHook := TGestureSelectionEditor.AddGesture;

  RegisterPropertyEditor(TypeInfo(string), FMX.Dialogs.TOpenDialog, 'Filter', FiltEdit.TFilterProperty);

  // Tint property filter
  RegisterSelectionEditor(TCustomButton, TTintColorFilter);
  RegisterSelectionEditor(TToolBar, TTintColorFilter);
  // Tint property FontColorForState
  RegisterSelectionEditor(TCustomButton, TFontColorForStateFilter);

  // Mobile Form Designer
  RegisterSelectionEditor(TCommonCustomForm, TMobileFormFilter);

  // TGrid
  RegisterSelectionEditor(TCustomGrid, TGridSelectionEditor);

  // TAddressBook
  RegisterSelectionEditor(TCustomAddressBook, TAddressBookSelectionEditor);

  // Common 3D component Editors
  RegisterSelectionEditor(TPlane, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TDisk, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TCube, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TMesh, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TSphere, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TCylinder, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TRoundCube, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TCone, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TGrid3D, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TStrokeCube, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TText3D, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TPath3D, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TRectangle3D, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TEllipse3D, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TModel3D, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TLayout3D, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TBufferLayer3D, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TSplitter3D, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TSolidLayer3D, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TImage3D, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TLayer3D, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TTextLayer3D, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TCamera, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TDummy, TCommon3DSelectionEditor);
  RegisterSelectionEditor(TProxyObject, TCommon3DSelectionEditor);

  { all properties and events that are managed by actions }
  RegisterPropertiesInCategory(sActionCategoryName,
    ['Action', 'Caption', 'Checked', 'Enabled', 'HelpContext', 'Hint', { do not localize }
     'ImageIndex', 'ShortCut', 'Visible']); { do not localize }

  { properties and events that manage the data shown by a component }
  {RegisterPropertiesInCategory(TDataCategory,
    ['Text', 'Tag', 'EditMask', TypeInfo(TPersistent)]);}

  { all drag-n-drop or docking related properties and events }
  RegisterPropertiesInCategory(sDragNDropCategoryName,
    ['Drag*', 'Dock*', 'UseDockManager', 'OnDockOver', 'OnGetSiteInfo', { do not localize }
     'OnDragOver', 'On*Drop', 'On*Drag', 'On*Dock']); { do not localize }

  { all help, hint or assistance related properties and events }
  RegisterPropertiesInCategory(sHelpCategoryName,
    ['Help*', '*Help', 'Hint*', '*Hint']); { do not localize }

  { all layout related properties or events }
  RegisterPropertiesInCategory(sLayoutCategoryName,
    ['Left', 'Top', 'Width', 'Height', 'TabOrder', 'TabStop', 'Align', { do not localize }
     'Anchors', 'Constraints', 'AutoSize', 'AutoScroll', 'Scaled', 'OnResize', { do not localize }
     'OnConstrained', 'OnCanResize']); { do not localize }

  // all legacy related properties or events and
  //   make sure the category defaults to not visible
  RegisterPropertiesInCategory(sLegacyCategoryName,
    ['Ctl3d', 'ParentCtl3d', 'OldCreateOrder']); //.Visible := False; { do not localize }
                                           

  { all linkage references between components }
  RegisterPropertyInCategory(sLinkageCategoryName, TypeInfo(TComponent));

  { all OS locale related properties and events }
  RegisterPropertiesInCategory(sLocaleCategoryName,
    ['Ime*', 'BiDi*', 'ParentBiDi*']); { do not localize }

  { any visual related properties and events }
  RegisterPropertiesInCategory(sVisualCategoryName,
    ['Left', 'Top', 'Width', 'Height', 'Visible', 'Enabled', 'Caption', { do not localize }
     'Align', 'Alignment', 'ParentColor', 'ParentFont', 'Bevel*', 'Border*', { do not localize }
     'ClientHeight', 'ClientWidth', 'Scaled', 'AutoSize', 'EditMask', { do not localize }

     'OnShow', 'OnPaint', 'OnClose', 'OnCloseQuery', 'OnResize', { do not localize }
     'OnConstrained', 'OnActivate', 'OnDeactivate', 'OnCanResize', 'OnHide', { do not localize }

     TypeInfo(TFont), TypeInfo(TAlphaColor), TypeInfo(TBrush), {TypeInfo(TPen),}
     TypeInfo(TCursor){, TypeInfo(TGraphic)}]);

  { input property events }
  RegisterPropertiesInCategory(sInputCategoryName,
    ['AutoScroll', 'KeyPreview', 'ReadOnly', 'Enabled', 'OnClick', { do not localize }
     'OnDblClick', 'OnShortCut', 'OnKey*', 'OnMouse*']); { do not localize }

  { All localizable properties:
      See also:
        WCompReg, InetReg, ISP, ISP3, VCSPELL3, VCF1,
        Win31Reg, DBReg, QRTeeReg, QRTee, SysReg
  }
  RegisterPropertiesInCategory(sLocalizableCategoryName, { for all controls }
    ['BiDiMode', { do not localize }
     'Caption', 'Constraints', { do not localize }
     'EditMask', { do not localize }
     'Glyph', { do not localize }
     'Height', 'Hint', { do not localize }
     'Icon', 'ImeMode', 'ImeName', { do not localize }
     'Left', { do not localize }
     'ParentBiDiMode', 'ParentFont', 'Picture', { do not localize }
     'Text', 'Top', { do not localize }
     'Width']); { do not localize }
  RegisterPropertiesInCategory(sLocalizableCategoryName, TCommonCustomForm,
    ['ClientHeight', 'ClientWidth', 'HelpFile']); { do not localize }

  RegisterPropertiesInCategory(sLocalizableCategoryName, { by TypeInfo }
    [TypeInfo(FMX.Graphics.TFont)]);          { Graphics }

  { Standard action registration }

  RegisterActions('', [FMX.ActnList.TAction, FMX.Controls.TControlAction, FMX.StdActns.TValueRangeAction], nil);
  RegisterActions(SFileCategory, [FMX.StdActns.TFileExit,
                                  FMX.StdActns.TFileHideApp,
                                  FMX.StdActns.TFileHideAppOthers],
                  TStandardActions);
  RegisterActions(SWindowCategory, [FMX.StdActns.TWindowClose],
                  TStandardActions);
  RegisterActions(SViewCategory, [FMX.StdActns.TViewAction], TStandardActions);
  RegisterActions(SEditCategory, [FMX.StdActns.TVirtualKeyboard], TStandardActions);

  RegisterActions(STabCategory, [TChangeTabAction], nil);
  RegisterActions(STabCategory, [TNextTabAction], nil);
  RegisterActions(STabCategory, [TPreviousTabAction], nil);

  RegisterActions(SPhoneCategory, [TPhoneCallAction], nil);
  RegisterActions(SMediaLibraryCategory, [TTakePhotoFromLibraryAction, TTakePhotoFromCameraAction, TShowShareSheetAction], nil);
  RegisterActions(SMediaLibraryCategory, [TMediaPlayerStart, TMediaPlayerStop, TMediaPlayerPlayPause,
    TMediaPlayerCurrentTime, TMediaPlayerVolume], nil);

  { Bitmap collection }
  RegisterPropertyEditor(TypeInfo(string), TCustomBitmapItem, 'Name', TBitmapNameProperty);
  RegisterPropertyEditor(TypeInfo(Single), TCustomBitmapItem, 'Scale', TBitmapScaleProperty);
  RegisterPropertyEditor(TypeInfo(TCustomMultiResBitmap), nil, '', TMultiResBitmapProperty);
  RegisterPropertyEditor(TypeInfo(TBitmapOfItem), nil, '', TBitmapOfItemProperty);

  // TabItem
  RegisterSelectionEditor(TTabItem, TTabItemFilter);
  RegisterPropertyEditor(TypeInfo(TCustomMultiResBitmap), TTabItem, 'CustomIcon', TTabCustomIconProperty);

  RegisterSelectionEditor(TCustomMultiResBitmap, TMultiResBitmapEditor);
  RegisterComponents(srStandard, [FMX.ImgList.TImageList]);
  RegisterComponents(SShapes, [FMX.ImgList.TGlyph]);
  RegisterPropertyEditor(TypeInfo(string), TLayer, 'Name', TLayerNameProperty);
  RegisterPropertyEditor(TypeInfo(TImageIndex), TCustomAction, '', TImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(TImageIndex), FMX.Controls.TControl, '', TImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(TImageIndex), FMX.Menus.TMenuItem, '', TImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(Boolean), TGlyph, 'Visible', TVisibleGlyphProperty);
  RegisterComponentEditor(FMX.ImgList.TCustomImageList, TImageListEditor);

  RegisterSelectionEditor(TLight, TLightSelectionEditor);

  FMX.Platform.Win.RegisterApplicationHWNDProc(@VclApplicationHandle);
  if FMX.Forms.Application <> nil then
    FMX.Forms.Application.ApplicationStateQuery := @VclApplicationState;

  RegisterStyleLookupEditors;
end;


{ TFontProperty }

function TFontProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paSubProperties, paDialog, paReadOnly];
end;

procedure TFontProperty.Edit;
var
  EditDlg: TFontDialogDesigner;
  TextSettings: TTextSettings;
  TextFont: TFont;
  I: Integer;
begin
  EditDlg := TFontDialogDesigner.Create(Application);
  try
    //Setting dialog parameters
    if GetComponent(0) is TTextSettings then
    begin
      TextSettings := TTextSettings(GetComponent(0));
      EditDlg.Setup(TextSettings.Font.Family, TextSettings.Font.Size, TextSettings.Font.StyleExt);
    end
    else
    begin
      TextFont := TFont(GetOrdValueAt(0));
      EditDlg.Setup(TextFont.Family, TextFont.Size, TextFont.StyleExt);
    end;
    if EditDlg.ShowModal = mrOk then
    begin
      //Setting result
      for I := 0 to PropCount - 1 do
      begin
        if GetComponent(I) is TTextSettings then
        begin
          TextSettings := TTextSettings(GetComponent(I));
          TextSettings.BeginUpdate;
          try
            TextSettings.Font.Family := EditDlg.FamilyName;
            TextSettings.Font.Size := EditDlg.FontSize;
            TextSettings.Font.StyleExt := EditDlg.FontStyle;
          finally
            TextSettings.EndUpdate;
          end;
        end
        else
        begin
          TextFont := TFont(GetOrdValueAt(I));
          TextFont.SetSettings(EditDlg.FamilyName, EditDlg.FontSize, EditDlg.FontStyle);
        end;
      end;
      Modified;
    end;
  finally
    EditDlg.Free;
  end;
end;

{ TFontNameProperty }

function TFontNameProperty.GetValue: String;
var
  I: Integer;
  Font: TFont;
  DefaultFamily: Boolean;
begin
  DefaultFamily := True;
  for I := 0 to PropCount - 1 do
  begin
    Font := TFont(GetComponent(I));
    if Font.IsFamilyStored then
    begin
      DefaultFamily := False;
      Break;
    end;
  end;
  if DefaultFamily then
    Result := '(Default)'
  else
    Result := inherited ;
end;

{ TFontSizeProperty }

function TFontSizeProperty.GetValue: String;
var
  I: Integer;
  Font: TFont;
  DefaultSize: Boolean;
begin
  DefaultSize := True;
  for I := 0 to PropCount - 1 do
  begin
    Font := TFont(GetComponent(I));
    if Font.IsSizeStored then
    begin
      DefaultSize := False;
      Break;
    end;
  end;
  if DefaultSize then
    Result := '(Default)'
  else
    Result := inherited ;
end;

{ TPathDataProperty }

procedure TPathDataProperty.Edit;
var
  EditDlg: TPathDataDesigner;
begin
  EditDlg := TPathDataDesigner.Create(Application);
  EditDlg.PathData.Lines.Text := String(TPathData(GetOrdValue).Data);
  EditDlg.PathData.WordWrap := true;
  if EditDlg.ShowModal = mrOk then
  begin
    TPathData(GetOrdValue).Data := EditDlg.PathData.Lines.Text;
    if GetComponent(0) is TControl then
      TControl(GetComponent(0)).Repaint;
    Modified;
  end;
  EditDlg.Free;
end;

function TPathDataProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly];
end;

function TPathDataProperty.GetValue: String;
begin
  Result := '(PathData)';
end;

{ TMeshDataProperty }

procedure TMeshDataProperty.Edit;
//var
//  M: TMeshData;
begin
//  M := TMeshData(GetOrdValue);
  GetOrdValue;
end;

function TMeshDataProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties, paReadOnly];
end;

function TMeshDataProperty.GetValue: String;
begin
  Result := '(Mesh)';
end;

{ TCustomSyntheticProperty }

procedure TCustomSyntheticProperty.Activate;
begin
end;

function TCustomSyntheticProperty.AllEqual: Boolean;
begin
  Result := True;
end;

function TCustomSyntheticProperty.AutoFill: Boolean;
begin
  Result := True;
end;

constructor TCustomSyntheticProperty.Create(const ADesigner: IDesigner;
  APropCount: Integer);
begin
  inherited;
  FDesigner := ADesigner;
end;

procedure TCustomSyntheticProperty.Edit;
begin
  inherited;
end;

function TCustomSyntheticProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paNotNestable, paReadOnly];
end;

function TCustomSyntheticProperty.GetEditLimit: Integer;
begin
  Result := -1;
end;

function TCustomSyntheticProperty.GetEditValue(out Value: string): Boolean;
begin
  Result := True;
  Value := GetValue;
end;

function TCustomSyntheticProperty.GetKind: TTypeKind;
begin
  Result := tkInteger;
end;

function TCustomSyntheticProperty.GetName: string;
begin
  Result := '';
end;

procedure TCustomSyntheticProperty.GetProperties(Proc: TGetPropProc);
begin
end;

function TCustomSyntheticProperty.GetPropInfo: PPropInfo;
begin
  Result := nil;
end;

function TCustomSyntheticProperty.GetPropType: PTypeInfo;
begin
  Result := nil;
end;

function TCustomSyntheticProperty.GetValue: string;
begin
  Result := ''
end;

procedure TCustomSyntheticProperty.GetValues(Proc: TGetStrProc);
begin
end;

function TCustomSyntheticProperty.HasInstance(Instance: TPersistent): Boolean;
begin
  Result := False;
end;

procedure TCustomSyntheticProperty.Initialize;
begin
  inherited;
end;

procedure TCustomSyntheticProperty.Revert;
begin
end;

procedure TCustomSyntheticProperty.SetPropEntry(Index: Integer;
  AInstance: TPersistent; APropInfo: PPropInfo);
begin
  inherited;
end;

procedure TCustomSyntheticProperty.SetValue(const Value: string);
begin
end;

function TCustomSyntheticProperty.ValueAvailable: Boolean;
begin
  Result := True;
end;

{ TGesturesProperty.TGestureComparer }

function TGesturesProperty.TGestureComparer.Compare(const Left,
  Right: FMX.Types.TCustomGestureCollectionItem): Integer;
begin
  Result := Right.GestureID - Left.GestureID;
end;

{ TGesturesProperty }

constructor TGesturesProperty.Create(const ADesigner: IDesigner;
  APropCount: Integer; ATouchManager: FMX.Types.TTouchManager);
var
  List: IDesignerSelections;
  LGesture: FMX.Types.TStandardGesture;
begin
  inherited Create(ADesigner, APropCount);
  FTouchManager := ATouchManager;

  // Find the control we're editing
  List := TDesignerSelections.Create;
  Designer.GetSelections(List);
  if (List <> nil) and (List.Count > 0) and (List.Items[0] is TComponent) then
    FControl := TFmxObject(List.Items[0])
  else
    raise Exception.Create(SNoSelectedControl);

  // Create shadow list for standard gestures
  FStandardGestureList := TGestureCollection.Create;
  for LGesture := Low(FMX.Types.TStandardGesture) to High(FMX.Types.TStandardGesture) do
    FStandardGestureList.Add.GestureID := FMX.Types.TGestureID(LGesture);
end;

procedure TGesturesProperty.Edit;
begin
  //if Assigned(FTouchManager) and Assigned(FTouchManager.GestureManager) then
  //  ShowGestureSelector(FControl, FDesigner);
end;

function TGesturesProperty.GetAttributes: TPropertyAttributes;
begin
  if Assigned(FTouchManager) and Assigned(FTouchManager.GestureManager) then
    Result := [paNotNestable, paVolatileSubProperties, paSubProperties, paReadOnly]
  else
    Result := [paNotNestable, paVolatileSubProperties, paReadOnly];
end;

function TGesturesProperty.GetName: string;
begin
  Result := 'Gestures';  // Do not localize
end;

procedure TGesturesProperty.GetProperties(Proc: TGetPropProc);
var
  I: Integer;
  LList: FMX.Gestures.TGestureList;
  LComparer: TGestureComparer;
  LGestureManager: FMX.Gestures.TGestureManager;
  Item: FMX.Types.TCustomGestureCollectionItem;
begin
  if Assigned(FTouchManager) and Assigned(FTouchManager.GestureManager) then
  begin
    LList := FMX.Gestures.TGestureList.Create;
    try
      LGestureManager := FMX.Gestures.TGestureManager(FTouchManager.GestureManager);
      // Add custom & registered gestures
      if (LGestureManager.RecordedGestureCount > 0) or
         (FMX.Gestures.TGestureManager.RegisteredGestureCount > 0) then
      begin
        LList.Clear;
        for Item in LGestureManager.RecordedGestures do
          LList.Add(Item);
        for Item in FMX.Gestures.TGestureManager.RegisteredGestures do
          LList.Add(Item);

        LComparer := TGestureComparer.Create;
        try
          // Sort list by ID in descending order
          LList.Sort(LComparer);
        finally
          LComparer.Free;
        end;

        Proc(TGestureListProperty.Create(FDesigner, 1,
          'Custom', LList, FControl, [FMX.Types.TGestureType.Recorded, FMX.Types.TGestureType.Registered]) as IProperty); // do not localize
      end;

      // Add standard gestures
      LList.Clear;
      for I := 0 to FStandardGestureList.Count - 1 do
        LList.Add(FStandardGestureList[I]);
      Proc(TGestureListProperty.Create(FDesigner, 1,
        'Standard', LList, FControl, [FMX.Types.TGestureType.Standard]) as IProperty); // do not localize
    finally
      LList.Free;
    end;
  end;
end;

function TGesturesProperty.GetValue: string;
begin
  if Assigned(FTouchManager) and Assigned(FTouchManager.GestureManager) then
    Result := ''
  else
    Result := '(Assign GestureManager)';
end;

{ TGestureListProperty }

constructor TGestureListProperty.Create(const ADesigner: IDesigner;
  APropCount: Integer; const APropName: string; AGestureList: FMX.Gestures.TGestureList;
  AControl: TFmxObject; AGestureTypes: FMX.Types.TGestureTypes);
var
  I: Integer;
begin
  inherited Create(ADesigner, APropCount);
  FControl := AControl;
  FGestureList := FMX.Gestures.TGestureCollection.Create;
  FGestureTypes := AGestureTypes;
  for I := 0 to AGestureList.Count - 1 do
    FGestureList.Add.Assign(AGestureList[I]);
  FPropName := APropName;
end;

destructor TGestureListProperty.Destroy;
begin
  FreeAndNil(FGestureList);
  inherited;
end;

function TGestureListProperty.GetAttributes: TPropertyAttributes;
begin
  if (FGestureList <> nil) and (FGestureList.Count > 0) then
    Result := [paSubProperties, paReadOnly]
  else
    Result := [paReadOnly];
end;

function TGestureListProperty.GetName: string;
begin
  Result := FPropName;
end;

procedure TGestureListProperty.GetProperties(Proc: TGetPropProc);
var
  I: Integer;
begin
  for I := 0 to FGestureList.Count - 1 do
    Proc(TGestureProperty.Create(FDesigner, 1,
      FMX.Types.TCustomGestureCollectionItem(FGestureList[I]), FControl) as IProperty);
end;

function TGestureListProperty.GetValue: string;
var
  LItem: FMX.Types.TCustomGestureCollectionItem;
  LGObj: IGestureControl;
begin
  Result := '';
  if Supports(FControl, IGestureControl, LGObj) then

  for LItem in LGObj.TouchManager.GestureList do
    if LItem.GestureType in FGestureTypes then
      Result := Format('%s%s,', [Result, LItem.DisplayName]);
  Delete(Result, Length(Result), 1);
  Result := Format('[%s]', [Result]);
end;

{ TGestureProperty }
procedure DrawCheckbox(ACanvas: Vcl.Graphics.TCanvas; ARect: TRect;
  ASelected, AEnabled, AAllEqual, AValue: Boolean);
const
  UnThemedStyles : array[0..2] of array[Boolean] of Cardinal =
    ((DFCS_BUTTONCHECK or DFCS_INACTIVE, DFCS_BUTTONCHECK),
     (DFCS_CHECKED or DFCS_INACTIVE, DFCS_CHECKED),
     (DFCS_BUTTON3STATE or DFCS_INACTIVE, DFCS_BUTTON3STATE));
var
  State: Integer;
begin
  if not AAllEqual then
    State := 0
  else if AValue then
    State := 1
  else
    State := 2;

  DrawFrameControl(ACanvas.Handle, ARect, DFC_BUTTON, UnThemedStyles[State][AEnabled]);
end;

function ScaleGesturePoints(const Points: array of TPointF; Size: Integer): FMX.Types.TGesturePointArray;
var
  LPoint: TPointF;
  LScale: Double;
  I, MaxX, MaxY: Integer;
  OffsetX, OffsetY: Integer;
begin
  MaxX := 0;
  MaxY := 0;

  for I := 0 to Length(Points) - 1 do
  begin
    if Points[I].X > MaxX then
      MaxX := Round(Points[I].X);
    if Points[I].Y > MaxY then
      MaxY := Round(Points[I].Y);
  end;

  if (MaxX = 0) and (MaxY = 0) then
  begin
    LScale := 1;
    OffsetX := 0;
    OffsetY := 0;
  end
  else
  begin
    if MaxX > MaxY then
      LScale := (Size / MaxX)
    else
      LScale := (Size / MaxY);
    OffsetX := (Size - Round(MaxX * LScale)) div 2;
    OffsetY := (Size - Round(MaxY * LScale)) div 2;
  end;

  SetLength(Result, Length(Points));
  for I := 0 to Length(Result) - 1 do
  begin
    LPoint := Points[I];
    Result[I] := PointF(Round(LPoint.X * LScale) + OffsetX,
      Round(LPoint.Y * LScale) + OffsetY);
  end;
end;


function TGestureProperty.CheckRect(const ItemRect: TRect): TRect;
begin
  Result := Rect(ItemRect.Right + 2, ItemRect.Top,
    ItemRect.Right + ItemRect.Bottom - ItemRect.Top + 2, ItemRect.Bottom);
end;

constructor TGestureProperty.Create(const ADesigner: IDesigner;
  APropCount: Integer; AGesture: FMX.Types.TCustomGestureCollectionItem;
  AControl: TFmxObject);
var
  LData: FMX.Gestures.TStandardGestureData;
  LItem: FMX.Types.TCustomGestureCollectionItem;
  LGObj: IGestureControl;
begin
  inherited Create(ADesigner, APropCount);
  FControl := AControl;
  FGesture := AGesture;
  if (FGesture.GestureType = FMX.Types.TGestureType.Standard) and
     FindStandardGesture(FGesture.GestureID, LData) then
    FPreviewPoints := LData.Points
  else
    FPreviewPoints := FGesture.Points;
  FPreviewSize := 20;

  LItem := nil;
  if Supports(FControl, IGestureControl, LGObj) then
    LItem := LGObj.TouchManager.FindGesture(FGesture.GestureID);
  if Assigned(LItem) then
    FGesture.Action := LItem.Action;
end;

destructor TGestureProperty.Destroy;
begin
   if FActionListView <> nil then
    FreeAndNil(FActionListView);
  inherited;
end;

procedure TGestureProperty.DoNewAction(Sender: TObject; const Category: string;
  ActionClass: TContainedActionClass; ActionList: TContainedActionList);
var
  LRoot: ComponentDesigner.IRoot;
  LCategory, LName: string;
  NewAction: TContainedAction;
  LIDEActions: TIDEActionsClass;
begin
  LCategory := Category;
  if AnsiCompareText(LCategory, SActionCategoryNone) = 0 then
    LCategory := '';

  // Create new action
  LIDEActions := GetIDEActions(FFrameworkType);

  // Create new action
  NewAction := CreateAction(ActionList.Owner,
                            ActionClass,
                            FFrameworkType) as TContainedAction;
  try
    LName := GetNewActionName(NewAction, FFrameworkType);
    if ActionList.Owner = Designer.Root then
      NewAction.Name := Designer.UniqueName(LName)
    else
    begin
      LRoot := ActiveDesigner.FindRoot(ActionList.Owner);
      if LRoot <> nil then
        NewAction.Name := LRoot.GetDesigner.UniqueName(LName)
      else
        raise Exception.CreateResFmt(@SUnableToFindComponent, [ActionList.Owner.Name]);
    end;
    NewAction.Category := LCategory;
    NewAction.ActionList := ActionList;
    if (LIDEActions <> nil) then
      LIDEActions.CopyImageIfAvailable(NewAction, ActionList);

    // Update gesture
    DoSelectAction(Sender, NewAction);
  except
    NewAction.Free;
    raise;
  end;
end;


procedure TGestureProperty.DoSelectAction(Sender: TObject; Action: TContainedAction);
begin
  FHost.CloseDropDown;
  SetAction(Action);
end;

procedure TGestureProperty.Edit(const Host: IPropertyHost; DblClick: Boolean);
var
  LHost20: IPropertyHost20;
begin
  FHost := Host;
  if FActionListView <> nil then
    FActionListView.Free;

  FActionListView := TActionListView.Create(nil);
  if Supports(FHost, IPropertyHost20, LHost20) then
    FActionListView.Width := LHost20.GetDropDownWidth;
  FActionListView.OnNewAction := DoNewAction;
  FActionListView.OnSelectAction := DoSelectAction;
  FActionListView.Designer := Designer;
  FActionListView.Visible := True;
  FHost.DropDownControl(FActionListView);
end;

function TGestureProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paCustomDropDown];
end;

function TGestureProperty.GetChecked: Boolean;
var
  LGObj: IGestureControl;
begin
  if Supports(FControl, IGestureControl, LGObj) then
    Result := Assigned(LGObj.TouchManager.FindGesture(FGesture.GestureID))
  else
    Result := False;
end;

function TGestureProperty.GetKind: TTypeKind;
begin
  Result := tkEnumeration;
end;

function TGestureProperty.GetName: string;
begin
  Result := FGesture.DisplayName;
end;

function TGestureProperty.GetValue: string;
var
  LAction: TContainedAction;
begin
  LAction := FGesture.Action;
  if LAction <> nil then
  begin
    if LAction.Owner <> Designer.Root then
      Result := LAction.Owner.Name + DotSep + LAction.Name
    else
      Result := LAction.Name;
  end
  else
    Result := '';
end;

procedure TGestureProperty.HintShow(var HintInfo: Vcl.Controls.THintInfo;
  InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
var
  S: string;
begin
  if not FMX.Gestures.GestureToIdent(FGesture.GestureID, S) then
    S := IntToStr(FGesture.GestureID);
  HintInfo.HintStr := Format('Name: %s  ID: %s', [FGesture.DisplayName, S]); // Do not localize
  Handled := True;
end;

procedure TGestureProperty.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer; InNameRect: Boolean; const ItemRect: TRect;
  var Handled: Boolean);
begin
  Handled := False;
end;

procedure TGestureProperty.MouseMove(Shift: TShiftState; X, Y: Integer;
  InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
begin
  Handled := False;
end;

procedure TGestureProperty.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer; InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
begin
  Handled := False;
  if PtInRect(CheckRect(ItemRect), Point(X, Y)) then
  begin
    Checked := not Checked;
    Handled := True;
    Designer.Modified;
  end;
end;

procedure TGestureProperty.PropDrawName(ACanvas: Vcl.Graphics.TCanvas; const ARect: TRect;
  ASelected: Boolean);
begin
  ACanvas.TextRect(ARect, ARect.Left + 2, ARect.Top + 1, GetName);
end;

function TGestureProperty.PropDrawNameRect(const ARect: TRect): TRect;
begin
  Result := ARect;
end;

procedure TGestureProperty.PropDrawValue(ACanvas: Vcl.Graphics.TCanvas; const ARect: TRect;
  ASelected: Boolean);
var
  I: Integer;
  LRect: TRect;
  LPoints: FMX.Types.TGesturePointArray;
begin
  LRect := ARect;
  LRect.Right := LRect.Left + FPreviewSize + 4;
  DrawCheckbox(ACanvas, LRect, ASelected, True, AllEqual, Checked);

  OffsetRect(LRect, FPreviewSize + 4, 0);
  Inc(LRect.Right, 4);

  LPoints := ScaleGesturePoints(FPreviewPoints, FPreviewSize - 1);
  if Length(LPoints) > 0 then
  begin
    ACanvas.Pen.Color := clDkGray;
    ACanvas.Pen.Style := psSolid;
    ACanvas.MoveTo(Round(LPoints[0].X + 2 + LRect.Left), Round(LPoints[0].Y + 1 + LRect.Top));

    for I := 1 to Length(LPoints) - 1 do
      ACanvas.LineTo(Round(LPoints[I].X + 2 + LRect.Left), Round(LPoints[I].Y + 1 + LRect.Top));

    ACanvas.Pixels[Round(LPoints[Length(LPoints) - 1].X + 2 + LRect.Left),
      Round(LPoints[Length(LPoints) - 1].Y + 1 + LRect.Top)] := clDkGray;
  end;
end;

function TGestureProperty.PropDrawValueRect(const ARect: TRect): TRect;
begin
  FPreviewSize := ARect.Bottom - ARect.Top - 2;
  Result := Rect(ARect.Left, ARect.Top,
    FPreviewSize + FPreviewSize + 8 + ARect.Left,
    ARect.Bottom);
end;

procedure TGestureProperty.SetAction(const Value: TContainedAction);
var
  LItem: FMX.Types.TCustomGestureCollectionItem;
  LGObj: IGestureControl;
begin
  if FGesture <> nil then
  begin
    // If an Action is set for a gesture that isn't selected, select the gesture
    if (Value <> nil) and not Checked then
      Checked := True;

    FGesture.Action := FMX.ActnList.TCustomAction(Value);
    LItem := nil;
    if Supports(FControl, IGestureControl, LGObj) then
      LItem := LGObj.TouchManager.FindGesture(FGesture.GestureID);
    if LItem <> nil then
      LItem.Action := FMX.ActnList.TCustomAction(FGesture.Action);
    Designer.Modified;
  end;
end;

procedure TGestureProperty.SetChecked(const Value: Boolean);
var
  LItem: FMX.Types.TCustomGestureCollectionItem;
  LGObj: IGestureControl;
begin
  if Value then
  begin
    LItem := nil;
    if Supports(FControl, IGestureControl, LGObj) then
      LItem := LGObj.TouchManager.FindGesture(FGesture.GestureID);
    if LItem = nil then
      LGObj.TouchManager.SelectGesture(FGesture.GestureID)
    else
      LItem.Action := FGesture.Action;

    if FGesture.GestureType = FMX.Types.TGestureType.Registered then
      TGestureSelectionEditor.SelectGesture(FGesture.Name);
  end
  else
    if Supports(FControl, IGestureControl, LGObj) then
      LGObj.TouchManager.UnselectGesture(FGesture.GestureID);
end;

procedure TGestureProperty.SetValue(const Value: string);
var
  LComponent: TComponent;
begin
  if Value <> '' then
  begin
    LComponent := Designer.GetComponent(Value);
    if LComponent is TBasicAction then
      SetAction(TContainedAction(LComponent));
  end
  else
    SetAction(nil);
end;

{ TGestureSelectionEditor }

class procedure TGestureSelectionEditor.AddGesture(AGesture: FMX.Types.TCustomGestureCollectionItem);
begin
  if FGestureUnitMap.ContainsKey(AGesture.Name) then
    FGestureUnitMap.Remove(AGesture.Name);
  FGestureUnitMap.Add(AGesture.Name, AGesture.UnitName);
end;

class constructor TGestureSelectionEditor.Create;
begin
  FGestureUnits := TStringList.Create;
  FGestureUnitMap := TDictionary<string, string>.Create;
end;

class destructor TGestureSelectionEditor.Destroy;
begin
  FGestureUnits.Free;
  FGestureUnitMap.Free;
end;

procedure TGestureSelectionEditor.RequiresUnits(Proc: TGetStrProc);
var
  S: string;
begin
  inherited;
  for S in FGestureUnits do
    Proc(S);
end;

class procedure TGestureSelectionEditor.SelectGesture(
  const AGestureName: string);
begin
  if FGestureUnitMap.ContainsKey(AGestureName) then
    if FGestureUnits.IndexOf(FGestureUnitMap.Items[AGestureName]) = -1 then
      FGestureUnits.Add(FGestureUnitMap.Items[AGestureName]);
end;

{ TTouchManagerPropertyFilter }

procedure TTouchManagerPropertyFilter.FilterProperties(
  const ASelection: IDesignerSelections; const ASelectionProperties: IInterfaceList);
var
  I: Integer;
  LSelectedItem: TPersistent;
  LGestureListProp: TGesturesProperty;
begin
  for I := 0 to ASelection.Count - 1 do
  begin
    LSelectedItem := ASelection[I];
    if (LSelectedItem.ClassName = 'TTouchManager') then
    begin
      LGestureListProp := TGesturesProperty.Create(Designer, 1, FMX.Types.TTouchManager(LSelectedItem));
      ASelectionProperties.Insert(1, LGestureListProp as IProperty);
    end;
  end;
end;

{ TMobileFormFilter }

procedure TMobileFormFilter.FilterProperties(const ASelection: IDesignerSelections;
  const ASelectionproperties: IInterfaceList);
var
  I, J: Integer;
  LSelectedItem: TPersistent;
  LPropertyName: string;
  LCustomForm: TCommonCustomForm;
begin
  for i := 0 to ASelection.Count - 1 do
  begin
    LSelectedItem := ASelection[i];
    if (LSelectedItem is TCommonCustomForm) then
    begin
      LCustomForm := TCommonCustomForm(LSelectedItem);
      if (LCustomForm.Designer <> nil) and LCustomForm.Designer.HasFixedSize then
      begin
        for J := ASelectionProperties.Count - 1 downto 0 do
        begin
          LPropertyName := (ASelectionProperties[J] as IProperty).GetName;
          if SameText(LPropertyName, 'Width') or
            SameText(LPropertyName, 'Height') or
            SameText(LPropertyName, 'ClientWidth') or
            SameText(LPropertyName, 'ClientHeight') or
            SameText(LPropertyName, 'Left') or
            SameText(LPropertyName, 'Top') or
            SameText(LPropertyName, 'WindowState') or
            SameText(LPropertyName, 'Position') or
            SameText(LPropertyName, 'BorderIcons') or
            SameText(LPropertyName, 'TopMost') then // do not localize
            ASelectionProperties.Delete(J);
        end;
      end;
    end;
  end;
end;

{ TTabItemFilter }

procedure TTabItemFilter.FilterProperties(const ASelection: IDesignerSelections;
  const ASelectionproperties: IInterfaceList);
var
  I, J: Integer;
  LSelectedItem: TPersistent;
  LPropertyName: string;
  Style: TFmxObject;
begin
  for i := 0 to ASelection.Count - 1 do
  begin
    LSelectedItem := ASelection[i];

    Style := nil;
    if (LSelectedItem is TTabItem) and Assigned(TTabItem(LSelectedItem).Scene) then
    begin
      if Assigned(TTabItem(LSelectedItem).Scene.StyleBook) then
        Style := TTabItem(LSelectedItem).Scene.StyleBook.Style;
      if not Assigned(Style) then
        Style := TStyleManager.ActiveStyleForScene(TTabItem(LSelectedItem).Scene);
    end;

    if Assigned(Style) then
      for J := 0 to Style.ChildrenCount - 1 do
        if Pos('tabitemcustom', LowerCase(Style.Children[J].StyleName)) > 0 then Exit;

    for J := ASelectionProperties.Count - 1 downto 0 do
    begin
      LPropertyName := (ASelectionProperties[J] as IProperty).GetName;
      if SameText(LPropertyName, 'CustomIcon') then // do not localize
        ASelectionProperties.Delete(J);
    end;
  end;
end;

{ TTintColorFilter }

procedure TTintColorFilter.FilterProperties(const ASelection: IDesignerSelections;
  const ASelectionproperties: IInterfaceList);

  function CabBeTintedUsingTintColor(const Selected: TPersistent): Boolean;
  var
    Control: FMX.Controls.TStyledControl;
    TintObject: ITintedObject;
  begin
    Result := False;
    if (Selected is FMX.Controls.TStyledControl) then
    begin
      Control := FMX.Controls.TStyledControl(Selected);
      Control.ApplyStyleLookup;

      TintObject := nil;
      if (Control is TToolBar) then
        TintObject := TToolBar(Control).TintObject;
      if (Control is TButton) then
        TintObject := TButton(Control).TintObject;
      if (Control is TSpeedButton) then
        TintObject := TSpeedButton(Control).TintObject;

      if TintObject <> nil then
        Result := TintObject.CanBeTinted;
    end;
  end;

  function CabBeTintedUsingIconTintColor(const Selected: TPersistent): Boolean;
  var
    Control: FMX.Controls.TStyledControl;
    TintObject: ITintedObject;
  begin
    Result := False;
    if (Selected is FMX.Controls.TStyledControl) then
    begin
      Control := FMX.Controls.TStyledControl(Selected);
      Control.ApplyStyleLookup;

      TintObject := nil;
      if (Control is TButton) then
        TintObject := TButton(Control).IconTintObject;
      if (Control is TSpeedButton) then
        TintObject := TSpeedButton(Control).IconTintObject;

      if TintObject <> nil then
        Result := TintObject.CanBeTinted;
    end;
  end;

  procedure FilterProperty(const PropertyName: string);
  var
    I: Integer;
    LPropertyName: string;
  begin
      for I := ASelectionProperties.Count - 1 downto 0 do
      begin
        LPropertyName := (ASelectionProperties[I] as IProperty).GetName;
        if SameText(LPropertyName, PropertyName) then
          ASelectionProperties.Delete(I);
      end;
  end;

var
  I: Integer;
begin
  for I := 0 to ASelection.Count - 1 do
  begin
    if not CabBeTintedUsingTintColor(ASelection[I]) then
      FilterProperty('TintColor');
    if not CabBeTintedUsingIconTintColor(ASelection[I]) then
      FilterProperty('IconTintColor');
  end;
end;

{ TFontColorForStateFilter }

procedure TFontColorForStateFilter.FilterProperties(const ASelection: IDesignerSelections;
  const ASelectionproperties: IInterfaceList);

  function CanBeUsingExColors(const Obj: TPersistent): Boolean;
  var
    Control: FMX.Controls.TStyledControl;
    StyleResource: TFmxObject;
  begin
    Result := False;
    Control := nil;
    if (Obj is FMX.Controls.TTextSettingsInfo.TBaseTextSettings) and
      (FMX.Controls.TTextSettingsInfo.TBaseTextSettings(Obj).Control is FMX.Controls.TStyledControl) then
      Control := FMX.Controls.TStyledControl(FMX.Controls.TTextSettingsInfo.TBaseTextSettings(Obj).Control)
    else if Obj is FMX.Controls.TTextControl then
      Control := FMX.Controls.TTextControl(Obj);
    if Control <> nil then
    begin
      Control.ApplyStyleLookup;
      StyleResource := Control.FindStyleResource('text');
      Result := StyleResource is TButtonStyleTextObject;
    end;
  end;

const
  PropertyName: string = 'FontColorForState';

var
  LPropertyFound: Boolean;
  I: Integer;

begin
  LPropertyFound := False;
  for I := 0 to ASelection.Count - 1 do
    if CanBeUsingExColors(ASelection[I]) then
    begin
      LPropertyFound := True;
      Break;
    end;
  if not LPropertyFound then
    for I := ASelectionProperties.Count - 1 downto 0 do
      if SameText((ASelectionProperties[I] as IProperty).GetName, PropertyName) then
        ASelectionProperties.Delete(I);
end;

{ TGridSelectionEditor }

procedure TGridSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited;
  Proc('System.Rtti');
  Proc('FMX.Grid.Style');
end;

{ TTabCustomIconProperty }

procedure TTabCustomIconProperty.Edit;
var
  I: Integer;
begin
  inherited;
  for I := 0 to PropCount - 1 do
    TTabItem(GetComponent(I)).StyleLookup := 'tabitemcustom';
end;

procedure TCommonDialogEditor.ExecuteVerb(Index: Integer);
begin
  if Component is FMX.Dialogs.TCommonDialog then
    FMX.Dialogs.TCommonDialog(Component).Execute;
end;

function TCommonDialogEditor.GetVerb(Index: Integer): string;
begin
  Result := STestDialog;
end;

function TCommonDialogEditor.GetVerbCount: Integer;
begin
  Result := 1
end;

{ TCommon3DSelectionEditor }

procedure TCommon3DSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited;
  Proc('System.Math.Vectors');
end;

type

  TPresentedControlBehavior = class(TInterfacedObject, IPresentedControlBehavior)
  public
    { IPresentedControlBehavior }
    function GetOverlayIcon: FMX.Graphics.TBitmap;
  end;

{ TPresentedControlBehavior }

function TPresentedControlBehavior.GetOverlayIcon: FMX.Graphics.TBitmap;
const
  PresentationIconName = 'presentationicon'; //do not localize
var
  Stream: TResourceStream;
begin
  if FindResource(HInstance, PChar(PresentationIconName), RT_RCDATA) <> 0 then
  begin
    Stream := TResourceStream.Create(HInstance, PresentationIconName, RT_RCDATA);
    try
      Result := FMX.Graphics.TBitmap.CreateFromStream(Stream);
    finally
      Stream.Free;
    end;
  end
  else
    Result := nil;
end;

{ TAddressBookSelectionEditor }

procedure TAddressBookSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited;
  Proc('FMX.AddressBook.Types');
end;

initialization
  TBehaviorServices.Current.AddBehaviorService(IPresentedControlBehavior, TPresentedControlBehavior.Create);
  // Design-Time presentations
  TPresentationProxyFactory.Current.Register(TCalendar, TControlType.Platform, TStyledPresentationProxy<TStyledCalendar>);
  // We replace existing presentation for these controls, because IDE works under Windows and we already register native presentation
  // in fmx package.
  TPresentationProxyFactory.Current.Replace(TEdit, TControlType.Platform, TStyledPresentationProxy<TStyledEdit>);
  TPresentationProxyFactory.Current.Replace(TMemo, TControlType.Platform, TStyledPresentationProxy<TStyledMemo>);
  TPresentationProxyFactory.Current.Replace(TSwitch, TControlType.Platform, TStyledPresentationProxy<TStyledSwitch>);
  TPresentationProxyFactory.Current.Replace(TPresentedScrollBox, TControlType.Platform, TStyledPresentationProxy<TStyledCustomScrollBox>);
  TPresentationProxyFactory.Current.Replace('default-native', TStyledPresentationProxy);
  TPresentationProxyFactory.Current.Replace(TGrid, TControlType.Platform, TStyledPresentationProxy<TStyledGrid>);
  TPresentationProxyFactory.Current.Replace(TStringGrid, TControlType.Platform, TStyledPresentationProxy<TStyledGrid>);
finalization
  TPresentationProxyFactory.Current.Unregister(TCalendar, TControlType.Platform, TStyledPresentationProxy<TStyledCalendar>);
  TPresentationProxyFactory.Current.Unregister(TEdit, TControlType.Platform, TStyledPresentationProxy<TStyledEdit>);
  TPresentationProxyFactory.Current.Unregister(TMemo, TControlType.Platform, TStyledPresentationProxy<TStyledMemo>);
  TPresentationProxyFactory.Current.Unregister(TSwitch, TControlType.Platform, TStyledPresentationProxy<TStyledSwitch>);
  TPresentationProxyFactory.Current.Unregister(TPresentedScrollBox, TControlType.Platform, TStyledPresentationProxy<TStyledCustomScrollBox>);
  TPresentationProxyFactory.Current.Unregister('default-native', TStyledPresentationProxy);
  TPresentationProxyFactory.Current.Unregister(TStringGrid, TControlType.Platform, TStyledPresentationProxy<TStyledGrid>);
  TPresentationProxyFactory.Current.Unregister(TGrid, TControlType.Platform, TStyledPresentationProxy<TStyledGrid>);
end.
