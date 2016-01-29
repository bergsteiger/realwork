{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit InspUnit;

interface
{$I dc.inc}
uses
  dcsystem, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, oinspect, StdCtrls, ExtCtrls, typinfo, ComCtrls, Menus, dcpedit,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  DCGen, dccommon, dcstdctl, dcedit, dcconsts, consts, dcdreamlib;

type
  TInspectForm = class(TForm)
    TabControl1: TDCTabControl;
    Properties: TObjectInspector;
    PopupMenu1: TPopupMenu;
    StayonTop1: TMenuItem;
    Hide1: TMenuItem;
    Help1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    DelphiStyle1: TMenuItem;
    VBStyle: TMenuItem;
    ShowCategories1: TMenuItem;
    PropertyHelp: TPropertyHelp;
    DCSplitter1: TDCSplitter;
    CompList1: TCompList;
    procedure FormCreate(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure Hide1Click(Sender: TObject);
    procedure StayonTop1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ShowCategories1Click(Sender: TObject);
    procedure DelphiStyle1Click(Sender: TObject);
    procedure VBStyleClick(Sender: TObject);
    procedure CompList1Change(Sender: TObject);
  private
    function GetList: TList;
    procedure SetList(Value: TList);
    procedure ShowEventPage(Value: boolean);
  protected
    procedure cmHideInspector(var Message: TMessage); message cm_HideInspector;
    procedure SelectionChanged(var Msg: TMessage); message CM_SELECTIONCHANGED;
    procedure cmToolBarForm(var M: TMessage); message cm_ToolBarForm;
  public
    procedure ClearInspector;
    procedure ToggleInspector;
    property ObjectList: TList read GetList write SetList;
  end;
  TInspectFormClass = class of TInspectForm;

var
  InspectForm: TInspectForm;
const
  DefaultInspFormClass: TInspectFormClass = TInspectForm;

function InspForm: TInspectForm; // don't touch me

var
  InspUnitMessageAnswer: TMessageAnswer; // call UnregisterNotifier(InspUnitMessageAnswer) to unregister message answer.
  UseDefaultInspForm: boolean = true;

implementation

{$R *.DFM}

const
  cDescriptionsCount = 78;
  cDescriptions: array [1..cDescriptionsCount] of string = (SDescrName, SDescrCaption,
    SDescrBorderStyle, SDescrCtl3d, SDescrKeyPreview, SDescrHeight, SDescrLeft,
    SDescrTop, SDescrWidth, SDescrWindowState, SDescrVisible, SDescrPosition,
    SDescrCursor, SDescrIcon, SDescrHelpContext, SDescrEnabled, SDescrDragMode,
    SDescrPasswordChar, SDescrScrollBars, SDescrHint, SDescrDataField,
    SDescrDataSource, SDescrAutoSize, SDescrInterval, SDescrTag, SDescrTabStop,
    SDescrTabIndex, SDescrShape, SDescrCancel, SDescrDefault, SDescrColor,
    SDescrFont, SDescrParentFont, SDescrShowHint, SDescrPopupMenu, SDescrActiveControl,
    SDescrScaled, SDescrPrintScale, SDescrAutoScroll, SDescrBorderIcons,
    SDescrClientHeight, SDescrClientWidth, SDescrWindowMenu, SDescrFormStyle,
    SDescrHelpFile, SDescrMenu, SDescrObjectMenuItem, SDescrPixelsPerInch,
    SDescrHorzScrollBar, SDescrVertScrollBar, SDescrFontCharSet, SDescrFontColor,
    SDescrFontHeight, SDescrFontName, SDescrFontPitch, SDescrFontSize,
    SDescrFontStyle, SDescrOnActivate, SDescrOnClick, SDescrOnClose,
    SDescrOnCloseQuery, SDescrOnCreate, SDescrOnDblClick, SDescrOnDestroy,
    SDescrOnDeactivate, SDescrOnDragDrop, SDescrOnDragOver, SDescrOnHide,
    SDescrOnHelp, SDescrOnKeyDown, SDescrOnKeyPress, SDescrOnKeyUp, SDescrOnMouseDown,
    SDescrOnMouseMove, SDescrOnMouseUp, SDescrOnPaint, SDescrOnResize, SDescrOnShow);

  {------------------------------------------------------------------}

procedure TInspectForm.cmToolBarForm(var M: TMessage);
begin
  M.Result := 1;
end;

{----------------------------------------------------------}

function TInspectForm.GetList: TList;
begin
  Result := Properties.CurrentControls;
end;

{----------------------------------------------------------}

procedure TInspectForm.SelectionChanged(var Msg: TMessage);
begin
  if Msg.Lparam <> 0 then
    Properties.Designer := TFormDesigner(Msg.Lparam)
  else
    Properties.Designer := nil;

  SetList(TList(Msg.wParam));
end;

{----------------------------------------------------------}

procedure TInspectForm.SetList(Value: TList);
begin
  if (Value = nil) or (Value.Count = 0) then
    ClearInspector
  else
  begin
    Properties.SetControls(Value);
    CompList1.OwnerComponent := GetTopOwner(Value[0]);
    CompList1.SelectedComponents := Value;
  end;
end;

{----------------------------------------------------------}

var
  IForm: TInspectForm = nil;

function InspForm: TInspectForm;
begin
  if not Assigned(IForm) then
    IForm := DefaultInspFormClass.Create(nil);
  Result := IForm;
end;

{----------------------------------------------------------}

procedure TInspectForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  RegisterNotifier(Self);
  SetFormFont(self);

  with Properties do
    ReadWinPosFromReg(Self, 'Inspector'); //don't resource
  with Properties.Descriptions do
    for i := 1 to cDescriptionsCount do
      Add(cDescriptions[i]);

  Caption := RemoveCharSet(['&'], SVerbObjectInspector);
  TabControl1.Tabs.Text := SInspectorTabs;
  StayonTop1.Caption := SVerbStayOnTop;
  ShowCategories1.Caption := SVerbShowCategory;
  Hide1.Caption := SVerbHide;
  DelphiStyle1.Caption := SVerbDelphiStyle;
  VBStyle.Caption := SVerbVBStyle;
  Help1.Caption := ResStr(SHelpButton);
end;

{----------------------------------------------------------}

procedure TInspectForm.TabControl1Change(Sender: TObject);
begin
  if TabControl1.TabIndex = 0 then
    Properties.Filter := tkAny - tkMethods
  else
    Properties.Filter := tkmethods;
end;

{----------------------------------------------------------}

procedure TInspectForm.Hide1Click(Sender: TObject);
begin
  Close;
end;

{----------------------------------------------------------}

procedure TInspectForm.StayonTop1Click(Sender: TObject);
begin
  with StayOnTop1 do
  begin
    Checked := not Checked;
    if Checked then
      FormStyle := fsStayOnTop
    else
      FormStyle := fsNormal
  end;
end;

{----------------------------------------------------------}

procedure TInspectForm.PopupMenu1Popup(Sender: TObject);
begin
  StayOnTop1.Checked := FormStyle = fsStayOnTop;

  VBStyle.Checked := Properties.Style = isVB;
  DelphiStyle1.Checked := Properties.Style <> isVB;
  ShowCategories1.Checked := oiUseGroups in Properties.Options;
end;

{----------------------------------------------------------}

procedure TInspectForm.FormDestroy(Sender: TObject);
begin
  UnRegisterNotifier(Self);
  with Properties do
    WriteWinPosToReg(Self, 'Inspector'); //don't resource
  if Self = IForm then
    IForm := nil;
end;

{----------------------------------------------------------}

procedure TInspectForm.ToggleInspector;
begin
  if FormIsActive(self) then
    ShowFormEx(GetPForm(Properties.CurrentControl), SW_RESTORE)
  else
    Show;
end;

{----------------------------------------------------------}

procedure TInspectForm.ShowCategories1Click(Sender: TObject);
begin
  with GlobalInspectorOptions do
  begin
    if oiUseGroups in Options then
      Options := Options - [oiUseGroups]
    else
      Options := Options + [oiUseGroups];
    ApplyOptions;
  end;
end;

{----------------------------------------------------------}

procedure TInspectForm.DelphiStyle1Click(Sender: TObject);
begin
  with GlobalInspectorOptions do
  begin
    Style := isDelphi;
    ApplyOptions;
  end;
end;

{----------------------------------------------------------}

procedure TInspectForm.VBStyleClick(Sender: TObject);
begin
  with GlobalInspectorOptions do
  begin
    Style := isVB;
    ApplyOptions;
  end;
end;

{----------------------------------------------------------}

procedure TInspectForm.ClearInspector;
begin
  CompList1.OwnerComponent := nil;
  Properties.CurrentControl := nil;
end;

{----------------------------------------------------------}

procedure TInspectForm.cmHideInspector(var Message: TMessage);
begin
  if FormStyle <> fsMDIChild then
    Hide;
end;

{----------------------------------------------------------}

procedure TInspectForm.ShowEventPage(Value: boolean);
begin
  with TabControl1, Tabs do
    if Value then
    begin
      if Count = 1 then
        Text := SInspectorTabs
    end
    else if Count = 2 then
      Delete(1);
end;

{----------------------------------------------------------}

procedure TInspectForm.CompList1Change(Sender: TObject);
var
  d: TFormDesigner;
begin
  if Active then
    Properties.SetFocus;

  if CompList1.SelectedComponents.Count <> 1 then
    exit;

  d := GetFormDesigner(CompList1.SelectedComponents[0]);
  if d <> nil then
    d.SelectComponent(CompList1.SelectedComponents[0]);
end;

{----------------------------------------------------------}

type
  TMyMessageAnswer = class(TMessageAnswer)
  public
    procedure cmShowInspector(var Message: TMessage); message cm_ShowInspector;
    procedure cmToggleInspector(var Message: TMessage); message cm_ToggleInspector;
  end;

  {----------------------------------------------------------}

procedure TMyMessageAnswer.cmToggleInspector(var Message: TMessage);
begin
  if UseDefaultInspForm then
    InspForm.ToggleInspector;
end;

{----------------------------------------------------------}

procedure TMyMessageAnswer.cmShowInspector(var Message: TMessage);
var
  iform: TInspectForm;
begin
  if UseDefaultInspForm then
  begin
    iform := InspForm;
    if not iform.Visible or Boolean(Message.wParam) then
    begin
      iform.FormStyle := ToolsFormStyle;
      iform.ShowEventPage(not HideEventsInInspector);
      iform.Show;
    end;
  end;
end;

{----------------------------------------------------------}

procedure _Register;
begin

end;

{----------------------------------------------------------}

procedure _InstantRegister;
begin
end;

{----------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForInstant(_InstantRegister);
  RegisterForDelphi(_Register);
end;

{----------------------------------------------------------}

initialization
  InspUnitMessageAnswer := TMyMessageAnswer.Create;
  RunRegister;
finalization
  InspUnitMessageAnswer.Free;
  FreeObject(IForm,IForm);
end.
