{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcpedit;

interface
{$I dc.inc}

uses
  windows, messages, classes, dcgen,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  controls, dcsystem, dcdreamlib,
  graphics, forms, sysutils, dcconsts, dccommon, typinfo, dcedit;


type
  TDCCustomPropEditor = class(TCustomDCPropEditor)
  private
    fPropName   : string;
    fCompList   : TList;
    fdesign     : TFormDesigner;
    fDesigner   : IDCFDesigner;
    fPropEdit   : TDCDsgnProp;
//    flistknown  : boolean;
    fLinkEditor : TDCCustomPropEditor;
    fLinkList   : TList;
    fList       : TStringList;
    fCtrls      : TList;
    fsearchproperty : string;
    fpedit          : TDCDsgnProp;
    fSetEditor      : TDCDsgnProp;
    fButton1Kind    : TPropButtonKind;
    fneedfree       : boolean;
    fInSetText      : boolean;

    procedure SetComponent(val : TPersistent);
    procedure SetButton1Kind(val : TPropButtonKind);
    procedure SetPropName(const val : string);

    {$IFDEF D6}
    procedure GetPropEdit(const Prop: TDCDsgnProp);
    {$ELSE}
    procedure GetPropEdit(Prop: TDCDsgnProp);
    {$ENDIF}

    procedure ResetEditor;
    procedure EditClick(Sender : TObject);
    procedure AddListItem (const s : string);
    procedure FillList;
    procedure SetPropEditor(val:TDCDsgnProp);
    procedure FreePropEditor;
    procedure SetLinkedEditor(val : TDCCustomPropEditor);
    function  GetPropertyEditor(const propname : string):TDCDsgnProp; virtual;
    procedure ChangeValue(selDirect : TSelDirect);
    procedure BroadCastPropChange;
    procedure _SetText(const val : string);
    {$IFDEF D4}
    procedure FillWithClosestValue;
    {$ENDIF}
  protected
    function  GetComponent : TPersistent;
    procedure RestoreSavedText; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DblClick; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetDropValue; override;
    procedure GetDropValue; override;
    function  GetReadOnly : boolean; override;
    procedure Loaded; override;
    procedure DoTerm; override;
    function  GetEditType : TControlClass; virtual;
    function  GetPopupType : TWinControlClass; virtual;
    procedure Change; override;
    procedure PropChanged(var Msg : TMessage); message CM_PROPCHANGED;
    procedure CMUpdateEditor(var Msg : TMessage); message CM_UPDATEEDITOR;
    procedure SetComponentList(val : TList);
    function  UpDownSelect : boolean; virtual;
    procedure SetText(const val : string); override;
    procedure CreateHandle; override;
    procedure ResetAfterCreateHandle; virtual;
    procedure DoAutoUpdate; virtual;
  public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
    procedure UpdateEditorState; virtual;
    property Button1Kind : TPropButtonKind read fButton1Kind write SetButton1Kind;

    property  PropEditor : TDCDsgnProp read fPropEdit write SetPropEditor;
    property  ComponentList : TList read fCtrls write SetComponentList;

    property Component : TPersistent read GetComponent write SetComponent;
    property LinkedEditor : TDCCustomPropEditor read fLinkEditor write SetLinkedEditor;
    property PropName : string read fPropName write SetPropName;
  end;

  TDCPropEditor = class(TDCCustomPropEditor)
  published
    property Align;

{$IFDEF D4}
    property Anchors;
    property AutoSize;
    property BiDiMode;
{$ENDIF}
    property Button1Kind;
    property Component;
    property DropOnClick;
{$IFDEF D4}
    property Constraints;
    property DragKind;
{$ENDIF}

    property LinkedEditor;
{$IFDEF D4}
    property ParentBiDiMode;
{$ENDIF}
    property PropName;

    property BorderStyle;
    property Caption;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Flat;
    property DreamBorderStyle;
    property UseDreamBorder;
    property LineColor;
    property Font;
    property HideCaret;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnButton1Click;
    property OnButton2Click;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
{$IFDEF D4}
    property OnEndDock;
{$ENDIF}
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF D4}
    property OnStartDock;
{$ENDIF}
    property OnStartDrag;
  end;

  TDCPropCheckBox = class(TDCCustomPropEditor)
  private
    fCheckedValue : string;
    fCheckValCaseSens : boolean;

    function  GetCute : boolean;
    procedure SetCute(val : boolean);
    function  GetScaled : boolean;
    procedure SetScaled(val : boolean);
    function  GetChecked : boolean;
    procedure SetChecked(val : boolean);
    procedure SetCheckedValue(const val : string);
    procedure SetCheckValCaseSens(val : boolean);
    function  GetInvert : boolean;
    procedure SetInvert(val : boolean);
  protected
    procedure SetParent(AParent : TWinControl); override;
    function  GetEditType : TControlClass; override;
    function  GetDefaultEditorClass : TControlClass; override;
    function  GetPopupType : TWinControlClass; override;
    procedure SetText(const val : string); override;
    function  GetText : string; override;
    procedure DoTerm; override;
    function  UpDownSelect : boolean; override;

    property CheckedValue : string read fCheckedValue write SetCheckedValue;
    property CheckValCaseSens : boolean read fCheckValCaseSens write SetCheckValCaseSens;

  public
    constructor Create(AOwner : TComponent); override;
    procedure UpdateEditorState; override;
  published
    property Align;
    property Component;
    property LinkedEditor;
    property PropName;

    property Caption;
    property Color;
    property Checked : boolean read GetChecked write SetChecked;
    property Cute : boolean read GetCute write SetCute;
    property Invert : boolean read GetInvert write SetInvert;

    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property Scaled : boolean read GetScaled write SetScaled;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnClick;
    property OnChange;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
{$IFDEF D4}
    property Anchors;
    property AutoSize;
    property BiDiMode;

    property Constraints;
    property DragKind;

    property ParentBiDiMode;

    property OnEndDock;
    property OnStartDock;
{$ENDIF}

  end;

  THistoryStoreEvent = procedure(Sender : TObject; History : TStrings) of object;

  TDCPropRadioButton = class(TDCPropCheckBox)
  protected
    function  GetEditType : TControlClass; override;
    procedure DoTerm; override;
    procedure DblClick; override;
  published
    property CheckedValue;
    property CheckValCaseSens;
{$IFDEF D4}
    property Anchors;
    property AutoSize;
    property BiDiMode;

    property Constraints;
    property DragKind;

    property ParentBiDiMode;

    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

  TDCHistoryEdit = class(TDCCustomPropEditor)
  private
    fRegKey : string;
    fOnLoadHistory : THistoryStoreEvent;
    fOnSaveHistory : THistoryStoreEvent;
  public
    constructor Create(AOwner : TComponent); override;
  published
    property Align;
{$IFDEF D4}
    property Anchors;
    property AutoSize;
    property BiDiMode;
{$ENDIF}
    property Button1Kind;
    property DropOnClick;
{$IFDEF D4}
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
{$ENDIF}
    property BorderStyle;
    property Caption;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Flat;
    property DreamBorderStyle;
    property UseDreamBorder;
    property LineColor;
    property Font;
    property HideCaret;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property RegKey : string  read fRegKey write fRegKey;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnButton1Click;
    property OnButton2Click;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
{$IFDEF D4}
    property OnEndDock;
{$ENDIF}
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF D4}
    property OnStartDock;
{$ENDIF}
    property OnStartDrag;

    property OnLoadHistory : THistoryStoreEvent read fOnLoadHistory write fOnLoadHistory;
    property OnSaveHistory : THistoryStoreEvent read fOnSaveHistory write fOnSaveHistory;
  end;

 TGraphEdit2=class(TGraphEdit)
 protected
    function GetOwnerOrdValue:Integer;
 end;

 TPictureEdit = class(TGraphEdit2)
 protected
   function GetGraphic : TGraphic; override;
 end;

 TImageEdit = class(TGraphEdit2)
 protected
   function GetGraphic : TGraphic; override;
 end;

type
  TCompList = class(TCustomDCEdit)
  private
    fSelected : TList;
    fOwnerComponent : TPersistent;
    fInChange       : boolean;

    procedure SetOwnerComponent(val : TPersistent);
    procedure SetSelected(val : TList);
    procedure AddComp(Instance : TComponent);
    procedure AddItem(Instance : TComponent);
  protected
    procedure Change; override;
    function  GetDefaultEditorClass : TControlClass; override;
    function  GetDefaultPopupClass : TWinControlClass; override;
    procedure GetDropValue; override;
    procedure EditWndProc(var Message: TMessage); override;
    procedure WMSetFocus(var Message : TWMSetFocus); message WM_SETFOCUS;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                         X, Y: Integer); override;
    procedure CMNAMECHANGED(var Message : TMessage); message CM_NAMECHANGED;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property SelectedComponents : TList read fSelected write SetSelected;
    property OwnerComponent : TPersistent read fOwnerComponent write SetOwnerComponent;
  published
    property Align;
    property BorderStyle;
    property Ctl3D;
    property Flat;
    property DreamBorderStyle;
    property UseDreamBorder;
    property LineColor;
    property Font;
    property Hint;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;

    property OnChange;
{$IFDEF D4}
    property Anchors;
    property AutoSize;
    property BiDiMode;

    property Constraints;
    property DragKind;

    property ParentBiDiMode;

    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

type
  TMultiSelectPropEdit = class(TPropertyEditor {$IFDEF D6},IPSCGetInstance{$ENDIF})
  private
    function GetPropEdit(index : integer) : TDCDsgnProp;
  public
    {$IFDEF D6}
    PropEditList : TDCInterfaceList;
    {$ELSE}
    PropEditList : TList;
    {$ENDIF}

    {IPSCGetInstance}
    function GetIntfImplementer:TObject;

    destructor Destroy; override;
    function   AllEqual: Boolean; override;
    procedure  Edit; override;
    function   GetAttributes: TPropertyAttributes; override;
    function   GetEditLimit: Integer; override;
    function   GetName: string; override;
    procedure  GetProperties(Proc: TGetPropEditProc); override;
    function   GetValue: string; override;
    procedure  GetValues(Proc: TGetStrProc); override;
    procedure  SetValue(const Value: string); override;
    function   GetRealPropType : PTypeInfo; virtual;
    property   PropEdit[Index: Integer] : TDCDsgnProp read GetPropEdit;
  end;

  THistoryStringEdit = class(TStringProperty)
  private
    fList : TStrings;

    procedure  AddToHistory(const st : string);
    function   GetList : TStrings;
  protected
    procedure  SaveHistory; virtual;
    procedure  LoadHistory; virtual;
  public
    property   List : TStrings read GetList;
    destructor Destroy; override;
    procedure  SetValue(const Value: string); override;
    function   GetAttributes: TPropertyAttributes; override;
    procedure  GetValues(Proc: TGetStrProc); override;
    function   GetRegName : string; virtual;
  end;

procedure UpdatePropeditEnabled(Form : TCustomForm);
procedure UpdateEditorsState(Form : TCustomForm);

{$IFDEF D6}
function GetPopupClass(PropEdit:TDCDsgnProp;AComp:TPersistent):TWinControlClass;
function GetEditClass(PropEdit:TDCDsgnProp;AComp:TPersistent):TControlClass;
{$ELSE}
function GetPopupClass(PropEdit:TDCDsgnProp):TWinControlClass;
function GetEditClass(PropEdit:TDCDsgnProp):TControlClass;
{$ENDIF}

function _GetEditClass(PropType : PTypeInfo; Instance : TPersistent; const PropName : string) : TControlClass;
function _GetPopupClass(PropType : PTypeInfo; Instance : TPersistent; const PropName : string) : TWinControlClass;

implementation

{$IFNDEF D6}
type
  TMPropEditor = class (TPropertyEditor)
  end;
{$ENDIF}

{------------------------------------------------------------------}

procedure UpdateEditorsState(Form : TCustomForm);
var
  i : integer;
begin
  with Form do
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TDCCustomPropEditor then
        TDCCustomPropEditor(Components[i]).UpdateEditorState;
end;

{----------------}

function TGraphEdit2.GetOwnerOrdValue:Integer;
begin
{$IFDEF D6}
  result:=GetOrdProp(TDCCustomPropEditor(Owner).GetComponent,TDCCustomPropEditor(Owner).PropEditor.GetPropInfo);
{$ELSE}
  Result:=TMPropEditor(TDCCustomPropEditor(Owner).PropEditor).GetOrdValue
{$ENDIF}
end;

{----------------}

function TPictureEdit.GetGraphic : TGraphic;
begin
  result := TPicture(GetOwnerOrdValue).Graphic;
end;

{----------------}

function TImageEdit.GetGraphic : TGraphic;
begin
  result := TGraphic(GetOwnerOrdValue);
end;

{----------------}

constructor TDCCustomPropEditor.Create(AOwner : TComponent);
begin
  fDesigner := TFDesigner.Create;
  fLinkList := TList.Create;
  fCompList := TList.Create;
  fList := TStringList.Create;
  fCtrls := TList.Create;
  fCompList.Add(nil);

  inherited Create(AOwner);

  NumButtons := 0;
  RegisterNotifier(self);
end;

{------------------------------------------------------------------}

destructor  TDCCustomPropEditor.Destroy;
begin
  UnRegisterNotifier(self);
  {$IFNDEF D4}
  fDesigner.Free;
  {$ENDIF}
  FreePropEditor;
  fLinkList.Free;
  fCompList.Free;
  fList.Free;
  fCtrls.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.DoAutoUpdate;
begin

end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if not (csDestroying in ComponentState) then
    if Operation = opRemove then
      if AComponent = fLinkEditor then
        begin
          fLinkEditor := nil;
          ResetEditor;
        end
      else if fCtrls.IndexOf(AComponent) >= 0 then
        begin
          fCtrls.Remove(AComponent);
          ResetEditor;
        end
      else
        fLinkList.Remove(AComponent);
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.ResetAfterCreateHandle;
begin
  if fskipCreateHandle = 0 then
    ResetEditor;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.CreateHandle;
begin
  inherited;
  ResetAfterCreateHandle;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.RestoreSavedText;
begin
  if fPropEdit = nil then
    inherited
  else
    UpdateEditorState;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.SetButton1Kind(val : TPropButtonKind);
begin
  fButton1Kind := val;
  UpdateEditorState;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.SetLinkedEditor(val : TDCCustomPropEditor);
begin
  if val = fLinkEditor then
    exit;

  if val = self then
    raise Exception.Create(sErrSelfLink);

  if fLinkEditor <> nil then
    fLinkEditor.fLinkList.Remove(self);

  fLinkEditor := val;
  if val <> nil then
    val.fLinkList.Add(self);

{
  if Assigned(val) and (PropName = '') then
    fPropName := val.fPropName;
}

  ResetEditor;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.FreePropEditor;
begin
  if fneedfree then
    begin
      {$IFNDEF D6}
      fPropEdit.Free;
      fSetEditor.Free;
      {$ENDIF}
    end;

  fPropEdit := nil;
  fSetEditor := nil;
  fneedfree := false;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.CMUpdateEditor(var Msg : TMessage);
begin
  UpdateEditorState;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.Loaded;
var
  s : string;
begin
  inherited Loaded;
  s := fPropName;
  fPropName := '';
  SetPropName(s);
  PostMessage(Handle, CM_UPDATEEDITOR, 0, 0);
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.ResetEditor;
var
  comp  : TPersistent;
  i     : integer;
begin
  if (csLoading in ComponentState) or not HandleAllocated then
    exit;

  comp := Component;
  fcomplist[0] := comp;
  try
    if comp <> nil then
      begin
        pointer(fdesign) := nil;
        fdesign := GetFormDesigner(Comp);
        if fDesign = nil then
          fdesign := fDesigner;

        FreePropEditor;
        fPropEdit := GetPropertyEditor(propname);
        fneedfree := true;
      end
    else
      begin
        fPropEdit := nil;
        fneedfree := false;
      end;
  finally
    UpdateEditorState;
  end;

  for i := 0 to fLinkList.Count - 1 do
    TDCCustomPropEditor(fLinkList[i]).ResetEditor;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.EditClick(Sender : TObject);
begin
  if Assigned(fPropEdit) then
    begin
      fPropEdit.Edit;
      UpdateEditorState;
    end;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.AddListItem (const s : string);
begin
  fList.Add(s);
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.FillList;
begin
//  if fListKnown then
//    exit;

  if not (Assigned(DropWindow) and (DropWindow is TPopupListBox)) then
    exit;

  TPopupListBox(DropWindow).Items.Clear;
  if fPropEdit = nil then
    exit;

  fList.Clear;
  fList.Sorted := paSortList in fPropEdit.GetAttributes;
  fPropEdit.GetValues(AddListItem);
  TPopupListBox(DropWindow).Items.Assign(fList);
//  fListKnown := true;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.BroadCastPropChange;
begin
  BroadCastToNotifiers(self, CM_PROPCHANGED, integer(fCompList), integer(PropName));
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor._SetText(const val : string);
begin
  inherited SetText(val);
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.SetText(const val : string);
begin
  if (fPropEdit <> nil) and not fInSetText then
    begin
      if (val <> fPropEdit.GetValue) then
        try
          fInSetText := true;
          fPropEdit.SetValue(val);
        finally
          fInSetText := false;
        end;

      _SetText(fPropEdit.GetValue);
    end
  else
    _SetText(val);
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.DoTerm;
var
  _text : string;
begin
  if Assigned(fPropEdit) then
    begin
      _text := Text;

      with fPropEdit do
        if GetValue <> _text then
          try
            SetValue(_text);
          finally
            _SetText(GetValue);
          end;

      if not fNoBroadCast then
        BroadCastPropChange;
    end;
end;

{------------------------------------------------------------------}

function  TDCCustomPropEditor.UpDownSelect : boolean;
begin
  result := true;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.SetComponentList(val : TList);
var
  i : integer;
  s : string;
begin
  fctrls.Clear;
  for i := 0 to val.Count - 1 do
    fCtrls.Add(val[i]);

  s := fPropName;
  fPropName := '';
  SetPropName(s);
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.SetDropValue;
var
  maxwidth : integer;
  i        : integer;
  w        : integer;
  size     : TSize;
  dc       : THandle;
begin
  if Assigned(DropWindow) and (DropWindow is TPopupListBox) then
    with TPopupListBox(DropWindow) do
      begin
        Clear;
        BuildList;
        if Items.Count = 0 then
          FillList;
        if fPropEdit <> nil then
          ItemIndex := Items.IndexOf(fPropEdit.GetValue);

        dc := GetDC(TPopupListBox(DropWindow).handle);
        maxwidth := 0;
        for i := 0 to Items.Count - 1 do
          begin
            Windows.GetTextExtentPoint(dc, PChar(Items[i]), Length(Items[i]), size);
            w := size.cx;
            if w > maxwidth then
              maxwidth := w;
          end;

        ReleaseDC(TPopupListBox(DropWindow).handle, dc);
        ClientWidth := max(min(maxwidth, self.Parent.Width), self.ClientWidth);

        i := Items.Count;
        if i > 7 then
          i := 7;

        if i < 1 then
          i := 1;

        ClientHeight := ItemHeight * i;
      end;

  inherited SetDropValue;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.GetDropValue;
var
  newval   : array[0..1023] of char;
  s        : string;
begin
  TPopupListBox(DropWindow).Perform(WM_GETTEXT, 1023, longint(@newval));
  s := StrPas(newval);

  if s = '' then
    exit;

  with fPropEdit do
    begin
      if GetValue <> s then
        SetValue(s);

      _SetText(GetValue);
      Change;
    end;
end;

{------------------------------------------------------------------}

{$IFDEF D6}
procedure TDCCustomPropEditor.GetPropEdit(const Prop: TDCDsgnProp);
{$ELSE}
procedure TDCCustomPropEditor.GetPropEdit(Prop: TDCDsgnProp);
{$ENDIF}
var
  sname : string;
  ppos  : integer;

  procedure PropFree;
  begin
    {$IFDEF D6}
    {$ELSE}
    Prop.Free;
    {$ENDIF}
  end;

begin
  if fpedit <> nil then
    begin
      propFree;
      exit;
    end;

  ppos := pos('.', fsearchproperty);
  if ppos = 0 then
    sname := fsearchproperty
  else
    sname := copy(fsearchproperty, 1, ppos - 1);

  if CompareText(Prop.GetName, sname) = 0 then
    begin
      if ppos = 0 then
        begin
          fpedit := prop;
          exit;
        end
      else
        begin
          Delete(fsearchproperty, 1, ppos);
          try
            Prop.GetProperties(GetPropEdit);
          finally
            {$IFDEF D6}
            if Prop.GetPropInfo.PropType^.Kind=tkSet then
            {$ELSE}
            if Prop is TSetProperty then
            {$ENDIF}
              fSetEditor := Prop
            else
              PropFree;
          end;
        end
    end
  else
    propFree;
end;

{------------------------------------------------------------------}

type
  TMComponentList=class(TComponentList)
  end;

function TDCCustomPropEditor.GetPropertyEditor(const propname : string):TDCDsgnProp;
var
  clist : TComponentList;
  i     : integer;
begin
  result := nil;
  if Component = nil then
    exit;

  clist := TComponentList.Create;
  if fLinkEditor <> nil then
    with fLinkEditor do
      for i := 0 to fctrls.Count - 1 do
        TMComponentList(clist).Add(fctrls[i])
  else
    for i := 0 to fctrls.Count - 1 do
      TMComponentList(clist).Add(fctrls[i]);

  fDesigner.OwnerControl := GetTopOwner(clist[0]);
  fsearchproperty := propname;
  fpedit := nil;
  try
    GetComponentProperties(clist, tkAny, fDesign, GetPropEdit);
  finally
    clist.Free;
    result := fpedit;
  end;
end;

{------------------------------------------------------------------}

function TDCCustomPropEditor.GetReadOnly : boolean;
begin
  result := inherited GetReadOnly;
  if Assigned(PropEditor) then
    result := result or (fPropEdit.GetAttributes * [paSubProperties, paReadOnly] <> []);
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.UpdateEditorState;
var
  attr      : TPropertyAttributes;
  popclass  : TWinControlClass;
begin
  if fPropEdit = nil then
    begin
      editorclass := GetDefaultEditorClass;
      popupclass := GetDefaultPopupClass;
      Text := '';
      exit;
    end;

  fexcept := true;
  try
    attr := fPropEdit.GetAttributes;
    editorclass := GetEditType;
    popclass := GetPopupType;
//    flistknown := false;
  finally
    fexcept := false;
  end;

  case fButton1Kind of
    bkNone : Button1.Visible := false;
    bkEllipsis :
                 begin
                   Button1.Visible := true;
                   Button1.Kind := bkDots;
                   PopClass := nil;
                 end;
    bkAuto :
            begin
              if (paValueList in attr) and (PopClass <> nil) then
                begin
                  Button1.Kind := bkDropDown;
                  OnButton1Click := nil;
                  Button1.Visible := true;
                end
              else
                begin
                  if paDialog in attr then
                    begin
                      Button1.Kind := bkDots;
                      Button1.Visible := true;
                      OnButton1Click := EditClick;
                    end
                  else
                    Button1.Visible := false;

                  PopClass := nil;
                end;
            end;
  end;

  PopupClass := PopClass;
  _SetText(fPropEdit.GetValue);
  CheckReadOnly;
  //Invalidate;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.SetComponent(val : TPersistent);
var
  s : string;
begin
  fCtrls.Clear;
  if val <> nil then
    fCtrls.Add(val);

  if (val <> nil) and (val is TComponent) then
    TComponent(val).FreeNotification(self);

  if csLoading in ComponentState then
    exit;
  s := fPropName;
  fPropName := '';
  SetPropName(s);
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.PropChanged(var Msg : TMessage);
begin
  if (TList(Msg.wParam).IndexOf(Component) >= 0) then
    UpdateEditorState;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.SetPropName(const val : string);
begin
  fPropName := val;
  ResetEditor;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.SetPropEditor(val:TDCDsgnProp);
begin
  inc(fskipCreateHandle);
  try
    FreePropEditor;
    fPropEdit := val;
//  fListKnown := false;
    UpdateEditorState;
  finally
    dec(fSkipCreateHandle);
  end;
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.ChangeValue(selDirect : TSelDirect);
type
  TGetStrFunc = function(const Value: string): Integer of object;

var
  I: Integer;
  Values: TStringList;
  AddValue: TGetStrFunc;

begin
  Values := TStringList.Create;
  with fPropEdit do
  try
    Values.Sorted := paSortList in fpropedit.GetAttributes;
    AddValue := Values.Add;
    GetValues(TGetStrProc(AddValue));
    if Values.Count > 0 then
    begin
      i := Values.IndexOf(Text);
      if SelDirect = selNext then
        inc(i)
      else
        dec(i);
      if i < 0 then
        i := 0
      else if i >= Values.Count then
        i := Values.Count - 1;

      _SetText(Values[I]);
    end;
  finally
    Values.Free;
    SelectAll;
  end;
end;

procedure TDCCustomPropEditor.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_DOWN, VK_UP : if UpDownSelect and (Shift = []) then
                      if Assigned(fPropEdit) and
                        ([paValueList, paDialog] * fPropEdit.GetAttributes = [paValueList]) then
                          begin
                            if key = VK_DOWN then
                              ChangeValue(selNext)
                            else
                              ChangeValue(selPrior);

                            key := 0;
                          end;

    VK_RETURN : if Assigned(fPropEdit) then
                  if (ssCtrl in Shift) then
                    begin
                      fPropEdit.Edit;
                      _SetText(fPropEdit.GetValue);
                      SelectAll;
                      Term;
                    end;

    VK_ESCAPE : begin
                  if ReadOnly then
                    exit;

                  if Assigned(PropEditor) then
                    _SetText(PropEditor.GetValue);

                  SelectAll;
                  key := 0;
                end;
  end;

  inherited KeyDown(key, Shift);
end;

{------------------------------------------------------------------}

function  TDCCustomPropEditor.GetComponent : TPersistent;
begin
  if fLinkEditor = nil then
    if fctrls.Count > 0 then
      result := fctrls[0]
    else
      result := nil
  else
    result := fLinkEditor.Component;
end;

{------------------------------------------------------------------}

function  TDCCustomPropEditor.GetEditType : TControlClass;
begin
  result := GetEditClass(fPropEdit{$IFDEF D6},GetComponent{$ENDIF});
end;

{------------------------------------------------------------------}

{$IFDEF D4}
procedure TDCCustomPropEditor.FillWithClosestValue;
//var
//  i : integer;
begin

{
  fList.Clear;
  fPropEdit.GetValues(AddListItem);

  for i := 0 to fList.Count - 1 do
    if pos(Text, fList[i]) = 1 then
      begin
        if Text <> fList[i] then
          Text := fList[i];
        exit;
      end;
}
end;
{$ENDIF}
{------------------------------------------------------------------}

procedure TDCCustomPropEditor.Change;
var
  attr : TPropertyAttributes;
begin
  inherited Change;
  if Assigned(PropEditor) then
    begin
      attr := PropEditor.GetAttributes;

      if (paAutoUpdate in attr) then
        begin
          if fPropEdit.GetValue <> Text then
            begin
              fPropEdit.SetValue(Text);
              if not fNoBroadCast then
                BroadCastPropChange;
              DoAutoUpdate;  
            end;
        end
      {$IFDEF D4}
      else if (paValueList in attr) and PropEditor.AutoFill then
        FillWithClosestValue;
      {$ENDIF}
    end;
end;

{------------------------------------------------------------------}

function  TDCCustomPropEditor.GetPopupType : TWinControlClass;
begin
  result := GetPopupClass(PropEditor{$IFDEF D6},GetComponent{$ENDIF});
end;

{------------------------------------------------------------------}

procedure TDCCustomPropEditor.DblClick;
begin
  inherited;
  if Assigned(PropEditor) and not DroppedDown then
    begin
      PropEditor.Edit;
      _SetText(PropEditor.GetValue);
      Invalidate;
//      BroadCastPropChange;
    end;
end;

{******************************************************************}

function TDCPropCheckBox.GetCute : boolean;
begin
  if IsEditAvailable and (fEdit is TCheckEdit) then
    result := TCheckEdit(fEdit).Cute
  else
    result := false
end;

{------------------------------------------------------------------}

procedure TDCPropCheckBox.SetCute(val : boolean);
begin
  if IsEditAvailable and (fEdit is TCheckEdit) then
    TCheckEdit(fEdit).Cute := val;
end;

{------------------------------------------------------------------}

function  TDCPropCheckBox.GetScaled : boolean;
begin
  if IsEditAvailable and (fEdit is TCheckEdit) then
    result := TCheckEdit(fEdit).Scaled
  else
    result := false
end;

{------------------------------------------------------------------}

procedure TDCPropCheckBox.SetScaled(val : boolean);
begin
  if IsEditAvailable and (fEdit is TCheckEdit) then
    TCheckEdit(fEdit).Scaled := val;
end;

{------------------------------------------------------------------}

procedure TDCPropCheckBox.SetChecked(val : boolean);
var
  s : string;
begin
  if val then
    s := 'True' //don't resource
  else
    s := 'False'; //don't resource

  if fCheckedValue <> '' then
    _SetText(s)
  else
    inherited SetText(s); //don't resource
end;

{------------------------------------------------------------------}

function  TDCPropCheckBox.GetChecked : boolean;
var
  s : string;
begin
  s := inherited GetText;
  result := (Edit is TCheckEdit) and TCheckEdit(Edit).Checked;
end;

{------------------------------------------------------------------}

constructor TDCPropCheckBox.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  BorderStyle := bsNone;
  Height := 17;
  ParentColor := true;
end;

{------------------------------------------------------------------}

procedure TDCPropCheckBox.SetParent(AParent : TWinControl);
begin
  inherited SetParent(AParent);
  if (AParent <> nil) and (fEdit is TCheckEdit) then
    TCheckEdit(fEdit).fClickAnywhere := true;
end;

{------------------------------------------------------------------}

function  TDCPropCheckBox.UpDownSelect : boolean;
begin
  result := false;
end;

{------------------------------------------------------------------}


function  TDCPropCheckBox.GetEditType : TControlClass;
begin
  result := TCheckEdit;
end;

{------------------------------------------------------------------}

function  TDCPropCheckBox.GetPopupType : TWinControlClass;
begin
  result := nil;
end;

{------------------------------------------------------------------}

function  TDCPropCheckBox.GetDefaultEditorClass : TControlClass;
begin
  result := GetEditType;
end;

{------------------------------------------------------------------}

procedure TDCPropCheckBox.UpdateEditorState;

  function CheckedValueMatched : boolean;
  begin
    if fCheckValCaseSens then
      result := PropEditor.GetValue = fCheckedValue
    else
      result := CompareText(PropEditor.GetValue, fCheckedValue) = 0;
  end;

var
  propval : string;
begin
  inherited UpdateEditorState;
  if Assigned(PropEditor) then
    begin
      propval := PropEditor.GetValue;
      SetChecked((fCheckedValue = '') and ((CompareText(propval,'True') = 0) or (CompareText(propval,'Yes') = 0)) //don't resource
                 or CheckedValueMatched);
    end;
end;

{------------------------------------------------------------------}

procedure TDCPropCheckBox.SetCheckedValue(const val : string);
begin
  if val = fCheckedValue then
    exit;

  fCheckedValue := val;
  UpdateEditorState;
end;

{------------------------------------------------------------------}

procedure TDCPropCheckBox.SetCheckValCaseSens(val : boolean);
begin
  if val = fCheckValCaseSens then
    exit;

  fCheckValCaseSens := val;
  UpdateEditorState;
end;

{------------------------------------------------------------------}

function  TDCPropCheckBox.GetInvert : boolean;
begin
  result := (fEdit is TCheckEdit) and TCheckEdit(fEdit).Invert;
end;

{------------------------------------------------------------------}

procedure TDCPropCheckBox.SetInvert(val : boolean);
begin
  if val <> Invert then
    if fEdit is TCheckEdit then
      begin
        TCheckEdit(fEdit).Invert := val;
        UpdateEditorState;
      end;
end;

{------------------------------------------------------------------}

procedure TDCPropCheckBox.SetText(const val : string);
begin
  Checked := ((CompareText(val, 'True') = 0) or (CompareText(val, 'Yes') = 0)) xor Invert; //don't resource
end;

{------------------------------------------------------------------}

function  TDCPropCheckBox.GetText : string;
begin
  if checked xor Invert then
    result := 'True' //don't resource
  else
    result := 'False'; //don't resource
end;

{------------------------------------------------------------------}

procedure TDCPropCheckBox.DoTerm;
begin
  if fCheckedValue <> '' then
    begin
      if (checked xor Invert) and Assigned(PropEditor) then
        begin
          PropEditor.SetValue(fCheckedValue);
          BroadCastPropChange;
        end
    end
  else
    inherited DoTerm;
end;

function TDCPropRadioButton.GetEditType : TControlClass;
begin
  result := TRadioEdit;
end;

{------------------------------------------------------------------}

procedure TDCPropRadioButton.DblClick;
begin
  if not checked then
    inherited;
end;

{------------------------------------------------------------------}

procedure TDCPropRadioButton.DoTerm;
var
  i : integer;
  sibling : TControl;
begin
  inherited DoTerm;

  if checked and (Parent <> nil) then
    with Parent do
      for i := 0 to ControlCount - 1 do
      begin
        Sibling := Controls[I];
        if (Sibling <> Self) and (Sibling is TDCPropRadioButton) then
          TDCPropRadioButton(Sibling).Checked := false;
      end;
end;

{******************************************************************}

type
  THistComponent = class(TComponent)
  private
    fProp : string;
  published
    property Prop : string read fProp write fProp;
  end;

 THistoryStringEdit2 = class(THistoryStringEdit)
 private
    function GetHistoryEdit : TDCHistoryEdit;
 protected
    procedure  SaveHistory; override;
    procedure  LoadHistory; override;
 public
   function GetRegName : string; override;

   property HistoryEdit : TDCHistoryEdit read GetHistoryEdit;
 end;

{------------------------------------------------------------------}

function THistoryStringEdit2.GetRegName : string;
begin
  result := HistoryEdit.RegKey;
  if result = '' then
    result := inherited GetRegName;
end;

{------------------------------------------------------------------}

procedure  THistoryStringEdit2.SaveHistory;
begin
  with HistoryEdit do
    if Assigned(OnSaveHistory) then
      OnSaveHistory(HistoryEdit, List)
    else
      inherited;
end;

{------------------------------------------------------------------}

procedure  THistoryStringEdit2.LoadHistory;
begin
  with HistoryEdit do
    if Assigned(OnLoadHistory) then
      OnLoadHistory(HistoryEdit, List)
    else
      inherited;
end;

{------------------------------------------------------------------}

function THistoryStringEdit2.GetHistoryEdit : TDCHistoryEdit;
begin
  result := TDCHistoryEdit(TComponent(GetComponent(0)).Owner);
end;

{******************************************************************}

constructor TDCHistoryEdit.Create(AOwner : TComponent);
begin
  inherited;
  Component := THistComponent.Create(self);
  PropName := 'Prop'; //don't resource
end;


{****************************************************}

constructor TCompList.Create(AOwner : TComponent);
begin
  inherited;
  ReadOnly := true;
  fSelected := TList.Create;
  RegisterNotifier(self);
  fNoBroadCast := true;
  TabStop := false;
end;

{----------------------------------------------------------}

destructor TCompList.Destroy;
begin
  UnRegisterNotifier(self);
  fSelected.Free;
  inherited;
end;

{----------------------------------------------------------}

function DesignerAllowSelect(Designer : TFormDesigner; Instance : TComponent) : boolean;
begin
  result := not IsFDesigner(Designer) or IDCFDesigner(Designer).CanBeSelected(Instance)
            or IDCFDesigner(Designer).IsSelected(Instance);
end;

{----------------------------------------------------------}

procedure TCompList.AddComp(Instance : TComponent);
begin
  TPopupListBox(fDropWindow).Items.AddObject(BuildCompName(Instance, ''), Instance);
end;

{----------------------------------------------------------}

procedure TCompList.AddItem(Instance : TComponent);
var
  d : TFormDesigner;
begin
  d := GetFormDesigner(fOwnerComponent);
  if (Instance.Name <> '') and (DesignerAllowSelect(d, Instance) or (fOwnerComponent = Instance)) then
    AddComp(Instance);
end;

{----------------------------------------------------------}

procedure TCompList.SetOwnerComponent(val : TPersistent);
var
  i : integer;
  d : TFormDesigner;
begin
//  if fOwnerComponent = val then
//    exit;

  {$IFDEF D5}
  if fOwnerComponent is TComponent then
    TComponent(fOwnerComponent).RemoveFreeNotification(self);
  {$ENDIF}

  fOwnerComponent := val;

  TPopupListBox(fDropWindow).Sorted := true;

  if val = nil then
    begin
      TPopupListBox(fDropWindow).Items.Clear;
      fSelected.Clear;
      Text := '';
    end
  else if fOwnerComponent is TComponent then
    with TPopupListBox(fDropWindow).Items, TComponent(fOwnerComponent) do
      begin
        FreeNotification(self);
        d := GetFormDesigner(fOwnerComponent);

        Clear;
        for i := 0 to ComponentCount - 1 do
          AddItem(Components[i]);

        if IsFDesigner(d) then
          with IDCFDesigner(d) do
            if LimitControl <> nil then
              AddComp(LimitControl)
            else
              AddComp(TComponent(fOwnerComponent));

//        AddItem(TComponent(fOwnerComponent));
      end;
end;

{----------------------------------------------------------}

procedure TCompList.SetSelected(val : TList);
begin
  CopyList(val, fSelected);
  if fSelected.Count = 1 then
    Text := BuildCompName(fSelected[0], '')
  else
    Text := '';
end;

{----------------------------------------------------------}

type
  TCompListEditor = class(TDCSimpleEdit)
    constructor Create(AOwner : TComponent); override;
  end;

constructor TCompListEditor.Create(AOwner : TComponent);
begin
  inherited;
  Cursor := crArrow;
end;

{----------------------------------------------------------}

function TCompList.GetDefaultEditorClass : TControlClass;
begin
 result := TCompListEditor;
end;

{----------------------------------------------------------}

function TCompList.GetDefaultPopupClass : TWinControlClass;
begin
  result := TPopupListBox;
end;

{----------------------------------------------------------}

procedure TCompList.GetDropValue;
begin
  with TPopupListBox(fDropWindow) do
    if ItemIndex >= 0 then
      begin
        fSelected.Clear;
        fSelected.Add(Items.Objects[ItemIndex]);
        self.text := Items[ItemIndex];
      end;
  inherited Change;
end;

{----------------------------------------------------------}

procedure TCompList.WMSetFocus(var Message : TWMSetFocus);
begin
end;

{----------------------------------------------------------}

procedure TCompList.MouseDown(Button: TMouseButton; Shift: TShiftState;
                         X, Y: Integer);
begin
  DroppedDown := not DroppedDown;
end;

{----------------------------------------------------------}

procedure TCompList.EditWndProc(var Message: TMessage);
begin
  if Message.Msg = WM_SETFOCUS then
    FillChar(Message,sizeof(Message), 0);

  inherited;
end;

{----------------------------------------------------------}

procedure TCompList.CMNAMECHANGED(var Message : TMessage);
var
  i : integer;
  comp : TComponent;
  newname : string;
begin
  if csDesigning in ComponentState then
    exit;

  try
    fInChange := true;
    with Message, TPopupListBox(fDropWindow) do
      begin
        comp := TComponent(wParam);
        if (comp = fOwnerComponent) or
        ((TObject(wParam) is TComponent) and (comp.Owner = fOwnerComponent)) then
          begin
            SetOwnerComponent(fOwnerComponent);
            if (lParam = 0) or (pchar(lParam)^ = #0) then
              newname := ''
            else
              newname := BuildCompName(comp, pchar(lParam));

            if (fSelected.Count = 1) and (fSelected[0] = TObject(wParam)) then
              self.Text := newname;

            for i := 0 to Items.Count - 1 do
              if Items.Objects[i] = TObject(wParam) then
                begin
                  Items.Delete(i);
                  break;
                end;

            if newname <> '' then
              Items.AddObject(newname, comp);
          end;
      end;
  finally
    fInChange := false;
  end;
end;

{------------------------------------------------------------------}

procedure TCompList.Change;
begin
  if not (fInChange or DroppedDown) then
    inherited;
end;

{------------------------------------------------------------------}

procedure TCompList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (AComponent = fOwnerComponent) and (Operation = opRemove) then
    OwnerComponent := nil;
end;

{------------------------------------------------------------------}

procedure UpdatePropeditEnabled(Form : TCustomForm);
var
  i : Integer;
begin
  with Form do
    for i := 0 to ComponentCount - 1 do
      if (Components[i] is TDCCustomPropEditor) then
        with TDCCustomPropeditor(Components[i]) do
          Enabled := Component <> nil;
end;


{**********************************************************}

function  THistoryStringEdit.GetList : TStrings;
begin
  if fList = nil then
    begin
      fList := TStringList.Create;
      LoadHistory;
    end;

  result := fList;
end;

{----------------------------------------------------------}

destructor THistoryStringEdit.Destroy;
begin
  fList.Free;
  inherited;
end;

{----------------------------------------------------------}

procedure THistoryStringEdit.SetValue(const Value: string);
begin
  inherited SetValue(Value);
  AddToHistory(Value);
end;

{----------------------------------------------------------}

function THistoryStringEdit.GetAttributes: TPropertyAttributes;
begin
  result := inherited GetAttributes;
  Include(result, paValueList);
end;

{----------------------------------------------------------}

procedure THistoryStringEdit.GetValues(Proc: TGetStrProc);
begin
  StringsToProc(List, Proc);
end;

{----------------------------------------------------------}

procedure THistoryStringEdit.AddToHistory(const st : string);
var
  i : integer;
begin
  if st = '' then
    exit;

  i := List.IndexOf(st);
  if i >= 0 then
    List.Delete(i);

  List.Insert(0, st);
  SaveHistory;
end;

{----------------------------------------------------------}

function THistoryStringEdit.GetRegName : string;
var
  comp : TPersistent;
begin
  comp := GetComponent(0);
  result := GetCompName(GetOwner(comp)) + GetCompName(comp) + GetName;
  if result = '' then
    result := 'Default'; //don't resource
  result := 'EditHistory\' + result; //don't resource
end;

{----------------------------------------------------------}

procedure THistoryStringEdit.LoadHistory;
begin
  List.Text := ReadFromRegistry(GetRegName, '');
end;

{----------------------------------------------------------}

procedure THistoryStringEdit.SaveHistory;
begin
  WriteToRegistry(GetRegName, list.Text);
end;

{------------------------------------------------------------------}

{******************************************************************}

function _GetPopupClass(PropType : PTypeInfo; Instance : TPersistent; const PropName : string) : TWinControlClass;
var
  i : integer;
begin
  for i := PopupClasses.Count - 1 downto 0 do
    with TPopupClassInfo(PopupClasses[i]) do
      if ((ti = nil) or (ti = proptype) or ((proptype^.Kind = tkClass) and GetTypeData(proptype).ClassType.InheritsFrom(GetTypeData(ti).ClassType))) and
         ((CClass = nil) or (Instance is CClass)) and
         ((name = '') or (PropName = name)) then
        begin
          result := TWinControlClass(c);
          exit;
        end;

  result := TPopupListBox;
end;

{------------------------------------------------------------------}

{$IFDEF D6}
(*
type
  TMySetProperty = class(TSetProperty)
  public
    procedure GetProperties(Proc: TGetPropProc); override;
  end;

  TMySetElementProperty=class(TSetElementProperty,IPSCGetInstance)
  public
    {IPSCGetInstance}
    function GetIntfImplementer:TObject;
  end;
*)
{----------------------------------------------------------}
{
procedure TMySetProperty.GetProperties(Proc: TGetPropProc);
var
  I: Integer;
begin
  with GetTypeData(GetTypeData(GetPropType)^.CompType^)^ do
    for I := MinValue to MaxValue do
      Proc(TMySetElementProperty.Create(Self, I));
end;
}
{----------------------------------------------------------}
{
function TMySetElementProperty.GetIntfImplementer:TObject;
begin
  Result:=Self;
end;
}
{----------------------------------------------------------}
{
function MyPropertyMapperForSet(Obj: TPersistent;PropInfo: PPropInfo): TPropertyEditorClass;
begin
  If PropInfo.PropType^.Kind=tkSet then
    Result:=TMySetProperty
  else
    Result:=nil;
end;
}
{$ENDIF}

{----------------------------------------------------------}

{$IFDEF D6}
(*
type
  TDCEnumPropEditValues=class
  private
    FPropValues:TStrings;
  public
    constructor Create;
    destructor Destroy;override;
    procedure EnumProc(const S: string);
    property PropValues:TStrings Read FPropValues;
  end;

{-------------------------}

constructor TDCEnumPropEditValues.Create;
begin
  inherited;
  FPropValues:=TStringLIst.Create;
end;

{-------------------------}

destructor TDCEnumPropEditValues.Destroy;
begin
  FPropValues.Free;
  inherited;
end;

{-------------------------}

procedure TDCEnumPropEditValues.EnumProc(const S: string);
begin
  FPropValues.Add(S);
end;

{-------------------------}

function DCPropEditEnumsSetElementValues(PropEdit:TDCDsgnProp):boolean;
var
  V:TDCEnumPropEditValues;
  ATypeKind:TTypeKind;

  function PropValuesAreBoolean:boolean;
  begin
    Result:=(V.PropValues.Count=2) and (V.PropValues[0]=BooleanIdents[False]) and
     (V.PropValues[1]=BooleanIdents[True]);
  end;

begin
  V:=TDCEnumPropEditValues.Create;
  try
    If PropEdit<>nil then
      PropEdit.GetValues(V.EnumProc);

    ATypeKind:=PropEdit.GetPropInfo.PropType^.Kind;

    If (ATypeKind=tkEnumeration) and PropValuesAreBoolean then
      Result:=True
    else
      Result:=False;
  finally
    V.Free;
  end;
end;
*)
{$ENDIF}

{-------------------------}

function IsSetElementPropEdit(const PropEdit:TDCDsgnProp):boolean;
{$IFDEF D6}
var
  IntfInstance:TObject;
{$ENDIF}
begin
  {$IFDEF D6}
  IntfInstance:=PSCGetIntfInstance(PropEdit);
  Result:=IntfInstance is TSetElementProperty;
  {$ELSE}
  Result:=PropEdit is TSetElementProperty;
  {$ENDIF}
end;

{------------------------------------------------------------------}

function IsMultiSelectPropEdit(const PropEdit:TDCDsgnProp):boolean;
{$IFDEF D6}
var
  IntfInstance:TObject;
{$ENDIF}
begin
  {$IFDEF D6}
  IntfInstance:=PSCGetIntfInstance(PropEdit);
  Result:=IntfInstance is TMultiSelectPropEdit;
  {$ELSE}
  Result:=PropEdit is TMultiSelectPropEdit;
  {$ENDIF}
end;

{------------------------------------------------------------------}

{$IFDEF D6}
function GetPopupClass(PropEdit:TDCDsgnProp;AComp:TPersistent):TWinControlClass;
{$ELSE}
function GetPopupClass (PropEdit : TDCDsgnProp) : TWinControlClass;
{$ENDIF}
var
  A:TPropertyEditor;
  proptype : PTypeInfo;
  comp : TPersistent;
  pname : string;
begin
  with PropEdit do
    if IsSetElementPropEdit(PropEdit) then
      begin
        proptype := TypeInfo(Boolean);
        comp := nil;
        pname := '';
      end
    else
      begin
        if IsMultiSelectPropEdit(PropEdit) then
          begin
            {$IFDEF D6}
            A:=TPropertyEditor(PSCGetIntfInstance(PropEdit));
            {$ELSE}
            A:=PropEdit;
            {$ENDIF}
            proptype := TMultiSelectPropEdit(A).GetRealPropType;
          end
        else
          proptype := GetPropType;

        {$IFDEF D6}
        comp := AComp;
        {$ELSE}
        comp := GetComponent(0);
        {$ENDIF}
        pname := GetName;
      end;

  result := _GetPopupClass(proptype, comp, pname);
end;

{------------------------------------------------------------------}

function _GetEditClass(PropType : PTypeInfo; Instance : TPersistent; const PropName : string) : TControlClass;
var
  i : integer;
begin
  for i := EditClasses.Count - 1 downto 0 do
    with TEditClassInfo(EditClasses[i]) do
      if ((ti = nil) or (ti = proptype) or ((proptype^.Kind = tkClass) and GetTypeData(proptype).ClassType.InheritsFrom(GetTypeData(ti).ClassType))) and
         ((CClass = nil) or (Instance is CClass)) and
         ((name = '') or (PropName = name)) then
        begin
          result := TWinControlClass(c);
          exit;
        end;

  result := TDCSimpleEdit;
end;

{------------------------------------------------------------------}
{$IFDEF D6}
function GetEditClass(PropEdit:TDCDsgnProp;AComp:TPersistent):TControlClass;
{$ELSE}
function GetEditClass (PropEdit : TDCDsgnProp) : TControlClass;
{$ENDIF}
var
  A:TPropertyEditor;
  proptype : PTypeInfo;
  comp     : TPersistent;
  pname    : string;

begin
  with PropEdit do
    if IsSetElementPropEdit(PropEdit) then
      begin
        proptype := TypeInfo(Boolean);
        comp := nil;
        pname := '';
      end
    else
      begin
        if IsMultiSelectPropEdit(PropEdit) then
          begin
            {$IFDEF D6}
            A:=TPropertyEditor(PSCGetIntfInstance(PropEdit));
            {$ELSE}
            A:=PropEdit;
            {$ENDIF}
            proptype := TMultiSelectPropEdit(A).GetRealPropType;
          end
        else
          proptype := GetPropType;
        {$IFDEF D6}
        comp := AComp;
        {$ELSE}
        comp := GetComponent(0);
        {$ENDIF}
        pname := GetName;
      end;

  result := _GetEditClass(proptype, comp, pname);
end;

{----------------------------------------------------------}

function TMultiSelectPropEdit.GetIntfImplementer:TObject;
begin
  Result:=Self;
end;

{----------------------------------------------------------}

destructor TMultiSelectPropEdit.Destroy;
begin
  PropEditList.Free;
  inherited;
end;

{----------------------------------------------------------}

function   TMultiSelectPropEdit.AllEqual: Boolean;
var
  val : string;
  i   : integer;
begin
  val := PropEdit[0].GetValue;
  for i := 1 to PropEditList.Count - 1 do
    if PropEdit[i].GetValue <> val then
      begin
        result := false;
        exit;
      end;

  result := true;
end;

{----------------------------------------------------------}

procedure  TMultiSelectPropEdit.Edit;
begin

end;

{----------------------------------------------------------}

function   TMultiSelectPropEdit.GetAttributes: TPropertyAttributes;
var
  i : integer;
begin
  result := PropEdit[0].GetAttributes;
  for i := 1 to PropEditList.Count - 1 do
    result := result * PropEdit[1].GetAttributes;
end;

{----------------------------------------------------------}

function DCGetDsgnPropEditLimit(const Prop:TDCDsgnProp):Integer;
begin
  {$IFDEF D6}
  Result:=255;
  {$ELSE}
  Result:=Prop.GetEditLimit;
  {$ENDIF}
end;

{----------------------------------------------------------}

function   TMultiSelectPropEdit.GetEditLimit: Integer;
var
  i : integer;
begin
  result := DCGetDsgnPropEditLimit(PropEdit[0]);
  for i := 0 to PropEditList.Count - 1 do
    result := min(result, DCGetDsgnPropEditLimit(PropEdit[i]));
end;

{----------------------------------------------------------}

function   TMultiSelectPropEdit.GetName: string;
begin
  result := PropEdit[0].GetName;
end;

{----------------------------------------------------------}

procedure  TMultiSelectPropEdit.GetProperties(Proc: TGetPropEditProc);
begin
end;

{----------------------------------------------------------}

function   TMultiSelectPropEdit.GetValue: string;
begin
  result := PropEdit[0].GetValue;
end;

{----------------------------------------------------------}

procedure  TMultiSelectPropEdit.GetValues(Proc: TGetStrProc);
begin
  PropEdit[0].GetValues(Proc);
end;

{----------------------------------------------------------}

procedure  TMultiSelectPropEdit.SetValue(const Value: string);
var
  i : integer;
begin
  for i := 0 to PropEditList.Count - 1 do
    PropEdit[i].SetValue(Value);
end;

{----------------------------------------------------------}

function TMultiSelectPropEdit.GetPropEdit (index : integer) : TDCDsgnProp;
begin
 result := TDCDsgnProp(PropEditList[index]);
end;

{----------------------------------------------------------}

function   TMultiSelectPropEdit.GetRealPropType : PTypeInfo;
begin
  result := PropEdit[0].GetPropType;
end;

{****************************************************}

procedure _Register;
begin
  {$IFDEF D6}
  {RegisterPropertyMapper(MyPropertyMapperForSet);}
  {$ENDIF}

  RegisterTextEditClass(TypeInfo(TGraphic), nil, '', TImageEdit);
  TEditClassInfo(EditClasses.Last).Internal := true;
  RegisterTextEditClass(TypeInfo(TPicture), nil, '', TPictureEdit);
  TEditClassInfo(EditClasses.Last).Internal := true;

  RegisterPropertyEditor(TypeInfo(string), THistComponent,'Prop',THistoryStringEdit2);//don't resource
end;

initialization

_Register;

end.
