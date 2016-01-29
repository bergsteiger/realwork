{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dbinsp;

interface
{$I dc.inc}
uses
  sysutils, Windows, messages, Classes, Controls, Forms, typinfo,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcpedit,stdctrls, db, dbctrls, oinspect, dcedit, dcdbctl,dbconsts, dialogs, glyphed,
  maskpr,dcstrled, dcgen,  graphics, dcsystem,dcdreamlib,
  dcconsts{$IFDEF USEBDE} ,dbtables{$ENDIF}
  {$IFDEF D6} ,Variants {$ENDIF}
  ;

type
  TCustomDSInspector = class;

  TItemButtonStyle = (ibsAuto, ibsEllipsis, ibsNone);

  TGetEditorClassProc = procedure (const PropEdit : TDCDsgnProperty; var EditorClass : TControlClass) of object;
  TGetPopupClassProc = procedure (const PropEdit : TDCDsgnProperty; var PopupClass : TWinControlClass) of object;

  TInspectorItem = class(TDCNamedItem)
  private
    fField        : TField;
    fFieldName    : string;
    fTitle        : string;
    fPickList     : TStrings;
    fInspector    : TCustomDSInspector;
    fButtonStyle  : TItemButtonStyle;
    fReadonly     : boolean;

    function  GetPickList: TStrings;
    procedure SetButtonStyle(Value: TItemButtonStyle);
    procedure SetField(Value: TField); virtual;
    procedure SetFieldName(const Value: String);
    procedure SetPickList(Value: TStrings);
    procedure SetReadOnly(Value : boolean);
    procedure SetTitle(Value : string);

    procedure RescanInspector;
  protected
    {$IFDEF D3}
    function  GetDisplayName: string; override;
    {$ENDIF}
  public
    constructor Create(Collection: TCollection); override;
    property  Field: TField read fField write SetField;
    property  Inspector: TCustomDSInspector read fInspector;
  published
    property  ButtonStyle: TItemButtonStyle read fButtonStyle write SetButtonStyle default ibsAuto;
    property  FieldName: String read FFieldName write SetFieldName;
    property  PickList: TStrings read GetPickList write SetPickList;
    property  ReadOnly: Boolean read fReadOnly write SetReadOnly default false;
    property  Title : string read fTitle write SetTitle;
  end;

  TDCInspectorItems = class (TDCNamedItems)
  private
   function GetItem (index : integer) : TInspectorItem;
   procedure SetItem(index : integer; Value : TInspectorItem);
   function GetInspector : TCustomDSInspector;
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    property Inspector : TCustomDSInspector read GetInspector;
    property Items[Index: Integer]: TInspectorItem read GetItem write SetItem; default;
  end;

  TFieldEditor = class(TPropertyEditor{$IFDEF D6},IPSCGetInstance{$ENDIF})
  private
    fField    : TField;
    fTitle    : string;
    fDataLink : TDataLink;
    fItem     : TInspectorItem;

    procedure EditGraphicField;
    procedure EditMemoField;

    function isGraphicField : boolean;
    function isMemoField : boolean;
  protected
    {IPSCGetInstance}
    function GetIntfImplementer:TObject;
  public
    function  GetName: string; override;
    function  GetValue: string; override;
    function  GetAttributes : TPropertyAttributes; override;
    procedure SetValue(const AValue: string); override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure Edit; override;

    property  Field : TField read fField;
  end;

  TCustomDSInspector = class(TCustomObjectInspector)
  private
    fDataSource : TDataSource;
    fDataLink   : TDataLink;
    fFake       : TComponent;
    fFakeList   : TComponentList;
    fedit       : TFieldEditor;
    fItems      : TDCInspectorItems;
    fLookupSource : TDataSource;
    fOnGetEditorClass : TGetEditorClassProc;
    fOnGetPopupClass : TGetPopupClassProc;
    fConfirmDelete : boolean;
    fMessagePosted : boolean;
    fUseFieldNames  : boolean;

    procedure SetDataSource(val : TDataSource);
    {$IFDEF D6}
    procedure GetPropEdit(const Prop: TDCDsgnProp);
    {$ELSE}
    procedure GetPropEdit(Prop: TDCDsgnProp);
    {$ENDIF}

    procedure SetItems(val : TDCInspectorItems);
    procedure SetUseFieldNames(val : boolean);
  protected
    procedure CreateHandle; override;

    procedure Loaded; override;
    procedure CMInspectorRescan(var Message: TMessage); message CM_INSPECTORRESCAN;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function  IsInspectorKey(key : word; Shift : TShiftState) : boolean; override;
    procedure GetAllPropertyEditors(Components: TComponentList;
                Filter: TTypeKinds; Designer: TFormDesigner; Proc: TGetPropEditProc); override;

    function  IsEmpty : boolean; override;
    function  GetInplaceEditClass : TInplaceEditClass; override;

    procedure UpdateEditorState(Editor : TCustomDCEdit; const propedit : TDCDsgnProp); override;
    function  GetEditorClass(const PropEdit : TDCDsgnProp) : TControlClass; override;
    function  GetPopupClass(const PropEdit : TDCDsgnProp) : TWinControlClass; override;
    function  GetRealName(const Prop : TDCDsgnProp) : string; override;

    function  CanHaveSubNodes : boolean; override;
    procedure RescanFields;
    procedure PostRescan;
    procedure UpdateEditorValue; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;

    property ConfirmDelete : boolean read fConfirmDelete write fConfirmDelete default true;
    property DataSource : TDataSource read fDataSource write SetDataSource;
    property Items : TDCInspectorItems read fItems write SetItems;
    property OnGetEditorClass : TGetEditorClassProc read fOnGetEditorClass write fOnGetEditorClass;
    property OnGetPopupClass : TGetPopupClassProc read fOnGetPopupClass write fOnGetPopupClass;
    property UseFieldNames : boolean read fUseFieldNames write SetUseFieldNames;
  end;

  TDataSetInspector = class(TCustomDSInspector)
  published
    property ConfirmDelete;
    property DataSource;
    property Items;
    property Options;

    property Aliases;
    property Align;
    property BorderStyle;
    property Colors;
    property Ctl3D;
    property DefaultRowHeight;
    property DragCursor;
    property DragMode;
    property Enabled;
    property ExpandMode;
    property Font;
    property LineStyle;
    property OtherGroupName;
    property UseOtherGroup;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property ShowHints;
    property SmartRefresh;
    property Style;
    property TabOrder;
    property TabStop;
    property UseFieldNames;
    property Visible;
    property OnActivePropertyChanged;
    property OnChangePropValue;
    property OnChangedPropValue;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawCell;
    property OnEditButtonClick;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetCellParams;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property OnShowProperty;
    property OnSplitterMoving;
    property OnSplitterMoved;
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
    property OnGetEditorClass;
    property OnGetPopupClass;
  end;

  TDataSetInspectorEdit = class(TDefaultEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

implementation

type
  TFake = class(TComponent)
  private
    fA : TField;
  published
    property A : TField read fA;
  end;

  TInspectDataLink = class(TDataLink)
  private
    fInspector : TCustomDSInspector;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure LayoutChanged; override;
  public
    constructor Create(Inspector : TCustomDSInspector);
  end;

 type
   TDSInplaceEdit = class(TOInplaceEdit)
   protected
     function  GetEditType : TControlClass; override;
     function  GetPopupType : TWinControlClass; override;
   public
     constructor Create(AOwner : TComponent); override;
   end;

{-------------------}

function __GetEditClass(const PropEdit : TDCDsgnProp) : TControlClass;
var
  proptype : PTypeInfo;
  comp     : TPersistent;
  pname    : string;
  A        : TFieldEditor;
begin
  {$IFDEF D6}
  A:=TFieldEditor(PSCGetIntfInstance(PropEdit));
  {$ELSE}
  A:=TFieldEditor(PropEdit);
  {$ENDIF}

  with TFieldEditor(A) do
    begin
      if fField = nil then
        begin
          result := TDCSimpleEdit;
          exit;
        end;
      proptype := ffield.ClassInfo;
      comp := GetComponent(0);
      pname := GetName;
    end;

  result := _GetEditClass(proptype, comp, pname);
end;

{------------------------------------------------------------------}

function  __GetPopupClass (const PropEdit : TDCDsgnProp): TWinControlClass;
var
  proptype : PTypeInfo;
  comp     : TPersistent;
  pname    : string;
  A        : TFieldEditor;
begin
  {$IFDEF D6}
  A:=TFieldEditor(PSCGetIntfInstance(PropEdit));
  {$ELSE}
  A:=TFieldEditor(PropEdit);
  {$ENDIF}

  with TFieldEditor(A) do
    begin
      if fField = nil then
        begin
          result := nil;
          exit;
        end;

      proptype := ffield.ClassInfo;
      comp := GetComponent(0);
      pname := GetName;
    end;

  result := _GetPopupClass(proptype, comp, pname);
end;

{******************************************************************}

constructor TDSInplaceEdit.Create(AOwner : TComponent);
begin
  inherited;
  TrackPropChange := false;
end;

{------------------------------------------------------------------}

function  TDSInplaceEdit.GetEditType : TControlClass;
begin
  result := __GetEditClass(PropEditor);
end;

{------------------------------------------------------------------}

function  TDSInplaceEdit.GetPopupType : TWinControlClass;
begin
  result := __GetPopupClass(PropEditor);
end;

{******************************************************************}

constructor TInspectDataLink.Create(Inspector : TCustomDSInspector);
begin
  inherited Create;
  fInspector := Inspector;
end;

{------------------------------------------------------------------}

procedure TInspectDataLink.DataSetChanged;
begin
  fInspector.UpdateValues;
end;

{------------------------------------------------------------------}

procedure TInspectDataLink.RecordChanged(Field: TField);
begin
  fInspector.UpdateValues;
end;

{------------------------------------------------------------------}

procedure TInspectDataLink.ActiveChanged;
begin
  with fInspector do
    if HandleAllocated then
//      if csLoading in ComponentState then
        PostRescan
//      else
//        Rescan;
end;

{------------------------------------------------------------------}

procedure TInspectDataLink.LayoutChanged;
begin
  fInspector.Rescan;
end;

{******************************************************************}

type
  TMComponentList=class(TComponentList)
  end;

constructor TCustomDSInspector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fItems := TDCInspectorItems.Create(self, TInspectorItem);
  fDataLink := TInspectDataLink.Create(self);
  fLookupSource := TDataSource.Create(nil);
  fFake := TFake.Create(nil);
  fFakeList := TComponentList.Create;
  TMComponentList(fFakeList).Add(fFake);
  SetControl(self);
  Options := Options + [oiUnSorted, oiEnterMoveDown, oiTabMoveDown];
  fConfirmDelete := true;
end;

{------------------------------------------------------------------}

destructor TCustomDSInspector.Destroy;
begin
  fDataLink.Free;
  fFake.Free;
  fFakeList.Free;
  fItems.Free;
  fLookupSource.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

function  TCustomDSInspector.GetEditorClass(const PropEdit : TDCDsgnProp) : TControlClass;
begin
  result := __GetEditClass(PropEdit);
  if Assigned(OnGetEditorClass) then
    OnGetEditorClass(TDCDsgnProperty(PropEdit), result);
end;

{------------------------------------------------------------------}

function  TCustomDSInspector.GetPopupClass(const PropEdit : TDCDsgnProp) : TWinControlClass;
begin
  result := __GetPopupClass(PropEdit);
  if Assigned(OnGetPopupClass) then
    OnGetPopupClass(TDCDsgnProperty(PropEdit), result);
end;

{------------------------------------------------------------------}

function  TCustomDSInspector.GetInplaceEditClass : TInplaceEditClass;
begin
  result := TDSInplaceEdit;
end;

{------------------------------------------------------------------}

{$IFDEF D6}
procedure TCustomDSInspector.GetPropEdit(const Prop: TDCDsgnProp);
{$ELSE}
procedure TCustomDSInspector.GetPropEdit(Prop: TDCDsgnProp);
{$ENDIF}
var
  A:TPropertyEditor;
begin
  A:=DCDsgnPropToPropEdit(Prop);

  if A is TFieldEditor then
    begin
      fEdit := TFieldEditor(A);
      AddEditorToEditorList(fEdit);
    end
  {$IFNDEF D6}
  else
    A.Free;
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure TCustomDSInspector.GetAllPropertyEditors(Components: TComponentList;
            Filter: TTypeKinds; Designer: TFormDesigner; Proc: TGetPropEditProc);

  procedure CreateEdit;
  begin
    GetComponentProperties(ffakelist, tkAny, InternalDesigner, GetPropEdit);
    fEdit.fDataLink := fDataLink;
  end;

var
  i        : integer;
  IsActive : boolean;
begin
  if not (Assigned(fDataSource) and Assigned(fDataSource.DataSet)) then
    exit;

  IsActive := fDataSource.DataSet.Active;

  if (fItems.Count = 0) then
    begin
      if IsActive then
        with fDataSource.DataSet do
          for i := 0 to FieldCount - 1 do
            if Fields[i].Visible then
              begin
                CreateEdit;
                fedit.fField := Fields[i];
                Proc(fedit);
              end
    end
  else
    for i := 0 to fItems.Count - 1 do
      with TInspectorItem(fItems[i]) do
        begin
          CreateEdit;
          if IsActive then
            fEdit.fField := Field;

          fEdit.fTitle := Title;
          fEdit.fItem := fItems[i];
          Proc(fedit);
        end;
end;

{------------------------------------------------------------------}

function  TCustomDSInspector.IsEmpty : boolean;
begin
  result := not (Assigned(fDataSource) and fDataSource.Enabled and
            Assigned(fDataSource.DataSet) and (fDataSource.DataSet.Active or (fItems.Count > 0))) or fEmptyList;
end;

{------------------------------------------------------------------}

procedure TCustomDSInspector.SetDataSource(val : TDataSource);
begin
  if fDataSource = val then
    exit;

  fDataSource := val;
  fDataLink.DataSource := val;

  if Val <> nil then
    Val.FreeNotification(Self);

  Rescan;
end;

{------------------------------------------------------------------}

procedure TCustomDSInspector.RescanFields;
var
  i : integer;
begin
  BeginUpdate;
  try
    for i := 0 to fItems.Count - 1 do
      with TInspectorItem(fItems[i]) do
        SetFieldName(FieldName);

    Rescan;

  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDSInspector.Loaded;
begin
  inherited;
  RescanFields;
end;

{------------------------------------------------------------------}

procedure TCustomDSInspector.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = DataSource) then
    DataSource := nil
end;

{------------------------------------------------------------------}

procedure TCustomDSInspector.UpdateEditorState(Editor : TCustomDCEdit; const propedit : TDCDsgnProp);
var
  item : TInspectorItem;
  f    : TField;
  MasterField : TField;
  A:TPropertyEditor;
begin
  if (csDesigning in ComponentState) then
    exit;

  A:=DCDsgnPropToPropEdit(PropEdit);

  if A is TFieldEditor then
    begin
      f := TFieldEditor(A).fField;
      if (Editor.Edit is TDBEdit) then
        begin
          TDBEdit(Editor.Edit).DataSource := fDataSource;
          if Assigned(f) then
            TDBEdit(Editor.Edit).DataField := f.FieldName;
        end;

      item := TFieldEditor(A).fItem;
      if Assigned(item) then
        begin
          Editor.ReadOnly := item.fReadOnly;
          f := item.fField;
        end;

      if (f <> nil) and ((item = nil) or (item.ButtonStyle = ibsAuto)) then
        begin
          if Assigned(f.LookupDataSet) then
            begin
              MasterField := DataSource.Dataset.FieldByName(f.KeyFields);
              if Assigned(MasterField) and MasterField.CanModify then
               if not ReadOnly and fDataLink.Active and not fDatalink.ReadOnly then
                 with Editor do
                   begin
                     Button1.Kind := bkDropDown;
                     OnButton1Click := nil;
                     NumButtons := 1;
                     PopupClass := TPopupDBGrid;
                     TPopupDBGrid(DropWindow).DisplayField := f.LookupResultField;
                     fLookupSource.DataSet := f.LookupDataSet;
                     TPopupDBGrid(DropWindow).FieldSource := fLookupSource;
                   end;
            end;
        end
      else if (item.ButtonStyle = ibsEllipsis) then
        with Editor do
          begin
            Button1.Kind := bkDots;
            NumButtons := 1;
            OnButton1Click := EditClick;
          end;
    end;
end;

{------------------------------------------------------------------}

procedure TCustomDSInspector.SetItems(val : TDCInspectorItems);
begin
  fItems.Assign(val);
end;

{------------------------------------------------------------------}

procedure TCustomDSInspector.SetUseFieldNames(val : boolean);
begin
  if val <> fUseFieldNames then
    begin
      fUseFieldNames := val;
      Rescan;
    end;
end;

{------------------------------------------------------------------}

procedure TCustomDSInspector.PostRescan;
begin
  PostMessage(handle, CM_INSPECTORRESCAN, 0, 0);
  fMessagePosted := true;
end;

{------------------------------------------------------------------}

procedure TCustomDSInspector.CreateHandle;
begin
  inherited;
  if fMessagePosted then
    PostRescan;
end;

{------------------------------------------------------------------}

procedure TCustomDSInspector.KeyDown(var Key: Word; Shift: TShiftState);
var
  processed : boolean;

  function DeletePrompt: Boolean;
  begin
    Result := not ConfirmDelete or
      (MessageDlg(ResStr(SDeleteRecordQuestion), mtConfirmation, mbOKCancel, 0) <> idCancel);
  end;

begin
  if IsEmpty or (csDesigning in ComponentState) then
    exit;

  processed := true;

  with fDataSource.DataSet do
    if ssCtrl in Shift then
      begin
        case key of
          VK_UP    : Prior;
          VK_DOWN  : Next;
          VK_PRIOR : First;
          VK_NEXT  : Last;
          VK_DELETE : if not ReadOnly and CanModify and DeletePrompt then
                        Delete;
        else
          processed := false;
        end;
      end
    else
      begin
        case key of
          VK_INSERT : if not ReadOnly and CanModify then
                        Insert;
          VK_ESCAPE : Cancel;
        else
          processed := false;
        end;
      end;

  if not processed then
    inherited
  else
    key := 0;
end;

{------------------------------------------------------------------}

function  TCustomDSInspector.IsInspectorKey(key : word; Shift : TShiftState) : boolean;
begin
  result := ((key = VK_DELETE) and (ssCtrl in Shift)) or
            (key = VK_INSERT) or
            ((key = VK_ESCAPE) and not
              (Editor.Modified and (DataSource.State = dsInsert))) or
            inherited IsInspectorKey(key, Shift);
end;

{------------------------------------------------------------------}

function  TCustomDSInspector.CanHaveSubNodes : boolean;
begin
  result := Aliases.Count <> 0;
end;

{------------------------------------------------------------------}

procedure TCustomDSInspector.CMInspectorRescan(var Message: TMessage);
begin
  fMessagePosted := false;
  RescanFields;
end;

{------------------------------------------------------------------}

function  TCustomDSInspector.GetRealName(const Prop : TDCDsgnProp) : string;
var
  A:TPropertyEditor;
begin

  A:=DCDsgnPropToPropEdit(Prop);

  if UseFieldNames and (A is TFieldEditor) then
    with TFieldEditor(A) do
      if (fTitle = '') and Assigned(fField) then
        result := fField.FieldName
      else
        result := fTitle
  else
    result := inherited GetRealName(A);
end;

{------------------------------------------------------------------}

procedure TCustomDSInspector.UpdateEditorValue;
begin
  if (Editor <> nil) and (Editor.EditorClass = TCheckEdit) then
    inherited;
end;

{------------------------------------------------------------------}

function TFieldEditor.GetIntfImplementer:TObject;
begin
  Result:=Self;
end;

{------------------------------------------------------------------}

function TFieldEditor.isGraphicField : boolean;
var
  p : TPicture;
begin
  result := ffield is TBlobField;
  if not result then
    exit;

  if ffield is TGraphicField then
    exit;

  if ffield is TMemoField then
    begin
      result := false;
      exit;
    end;

  p := TPicture.Create;
  result := true;
  try
    try
      P.Assign(ffield);
    finally
      P.Free;
    end;
  except
    result := false;
  end;
end;

{------------------------------------------------------------------}

function TFieldEditor.isMemoField : boolean;
var
  p : TStringList;
begin
  result := ffield is TBlobField;
  if not result then
    exit;

  if ffield is TMemoField then
    exit;

  p := TStringList.Create;
  try
    try
      P.Assign(ffield);
    finally
      P.Free;
    end;
  except
    result := false;
  end;
end;

{------------------------------------------------------------------}

function TFieldEditor.GetAttributes : TPropertyAttributes;
begin
  result := inherited GetAttributes;
  if Assigned(fitem) and (fItem.PickList.Count > 0) and (fItem.ButtonStyle = ibsAuto) then
    Include(Result, paValueList)
  else
    if fField is TBlobField then
      begin
        Include(Result, paReadOnly);
        if isGraphicField or isMemoField then
          Include(Result, paDialog);
      end;
end;

{------------------------------------------------------------------}

function TFieldEditor.GetName: string;
begin
  if (fTitle = '') and Assigned(fField) then
    result := fField.DisplayName
  else
    result := fTitle;
end;

{------------------------------------------------------------------}

function TFieldEditor.GetValue: string;
begin
  if Assigned(fField) then
    result := fField.DisplayText
  else
    result := '';
end;

{------------------------------------------------------------------}

procedure TFieldEditor.SetValue(const AValue: string);
begin
  if fField = nil then
    exit;

  if fDataLink.Edit then
    with fField do
      if Lookup and (LookupDataSet <> nil) then
        DataSet.FieldByName(KeyFields).Value := LookupDataSet.Lookup(LookupResultField, AValue, LookupKeyFields)
      else
        if fField is TBooleanField then
          AsBoolean := (CompareText(AValue, 'true') = 0) //don't resource
        else
          begin
            if Assigned(OnSetText) then
              OnSetText(fField, AValue)
            else
              AsString := AValue;
          end;
end;

{------------------------------------------------------------------}

procedure TFieldEditor.GetValues(Proc: TGetStrProc);
var
  i : integer;
begin
  if Assigned(fItem) then
    for i := 0 to fItem.PickList.Count - 1 do
      Proc(fItem.PickList[i]);
end;

{------------------------------------------------------------------}

procedure TFieldEditor.EditGraphicField;
var
  form : TGlyphEditForm;
begin
  form := TGlyphEditForm.Create(nil);
  with form, Image do
    try
      Caption := GetName;
      Picture.Assign(ffield);
      if (ShowModal = idOk) and fDataLink.Edit then
        if Picture.Graphic <> nil then
          ffield.Assign(Picture)
        else
          ffield.AsVariant := NULL;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

procedure TFieldEditor.EditMemoField;
begin
  with TStringsEditForm.Create(Application) do
    try
      CodeButton.Visible := false;
      EditName := GetName;
      memo1.Lines.Text := fField.AsString;
      memo1.ScrollBars := ssVertical;
      memo1.WordWrap := true;
      if (ShowModal = idOk) and fDataLink.Edit then
        fField.AsString := memo1.Lines.Text;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

procedure TFieldEditor.Edit;
begin
  if isGraphicField then
    EditGraphicField
  else if isMemoField then
    EditMemoField;
end;

{******************************************************************}

constructor TInspectorItem.Create(Collection: TCollection);
begin
  if Assigned(Collection) and (Collection is TDCInspectorItems) then
    finspector := TDCInspectorItems(Collection).Inspector;

  inherited Create(Collection);
  FButtonStyle := ibsAuto;

  RescanInspector;
end;

{------------------------------------------------------------------}

procedure TInspectorItem.RescanInspector;
begin
  if Assigned(fInspector) then
    fInspector.Rescan;
end;

{------------------------------------------------------------------}

{$IFDEF D3}
function TInspectorItem.GetDisplayName: string;
begin
  result := fFieldName;

  if result = '' then
    result := Title;

  if result = '' then
    Result := inherited GetDisplayName;
end;
{$ENDIF}

{------------------------------------------------------------------}

function TInspectorItem.GetPickList: TStrings;
begin
  if fPickList = nil then
    fPickList := TStringList.Create;

  Result := fPickList;
end;

{------------------------------------------------------------------}

procedure TInspectorItem.SetButtonStyle(Value: TItemButtonStyle);
begin
  if Value = fButtonStyle then
    exit;

  fButtonStyle := Value;
  Changed(False);
end;

{------------------------------------------------------------------}

procedure TInspectorItem.SetField(Value: TField);
begin
  if fField = Value then
    exit;

  fField := Value;
  if Assigned(Value) then
    fFieldName := Value.FieldName;

  RescanInspector;
end;

{------------------------------------------------------------------}

procedure TInspectorItem.SetFieldName(const Value: string);
var
  field : TField;
begin
  field := nil;
  if Assigned(fInspector) and Assigned(fInspector.fDataLink.DataSet) and
    not (csLoading in fInspector.ComponentState) and (Length(Value) > 0) then
      field := fInspector.fDataLink.DataSet.FindField(Value);

  FFieldName := Value;
  SetField(field);
  RescanInspector;
end;

{------------------------------------------------------------------}

procedure TInspectorItem.SetPickList(Value: TStrings);
begin
  if Value = nil then
    begin
      fPickList.Free;
      fPickList := nil;
    end
  else
    PickList.Assign(Value);
end;

{------------------------------------------------------------------}

procedure TInspectorItem.SetReadOnly(Value : boolean);
begin
  if fReadOnly = Value then
    exit;

  fReadOnly := Value;
end;

{------------------------------------------------------------------}

procedure TInspectorItem.SetTitle(Value : string);
begin
  if fTitle = Value then
    exit;

  fTitle := Value;
  RescanInspector;
end;

{******************************************************************}

function TDCInspectorItems.GetInspector:TCustomDSInspector;
begin
  Result:=TCustomDSInspector(Owner);
end;

{------------------------------------------------------------------}

procedure TDCInspectorItems.Update(Item: TCollectionItem);
begin
  Inspector.Rescan;
end;

{------------------------------------------------------------------}

function TDCInspectorItems.GetItem (index : integer) : TInspectorItem;
begin
  result := TInspectorItem(inherited Items[Index]);
end;

{------------------------------------------------------------------}

procedure TDCInspectorItems.SetItem(index : integer; Value : TInspectorItem);
begin
  Items[Index].Assign(Value);
end;

{******************************************************************}

procedure TDataSetInspectorEdit.ExecuteVerb(Index: Integer);
begin
  CallPropertyEdit(Component, 'Items'); //don't resource
end;

{------------------------------------------------------------------}

function TDataSetInspectorEdit.GetVerb(Index: Integer): string;
begin
  result := SVerbItemsEditor;
end;

{------------------------------------------------------------------}

function TDataSetInspectorEdit.GetVerbCount: Integer;
begin
  result := 1;
end;

{------------------------------------------------------------------}

procedure _InstantRegister;
begin
  RegisterPropertyEditor(TypeInfo(string), TDBEdit, 'EditMask', TEditMaskPropEdit);//don't resource
  RegisterPropertyEditor(TypeInfo(string), TField, 'EditMask', TEditMaskPropEdit);//don't resource
end;

{------------------------------------------------------------------}

procedure _Register;
begin
  RegisterEditClass(TypeInfo(TBooleanField), nil, '', TCheckEdit);
  RegisterPopupClass(TypeInfo(TBooleanField), nil, '', nil);
  RegisterPropertyEditor(TypeInfo(TField), TFake,  '', TFieldEditor);
(*
  {$IFDEF D3}
  RegisterTextEditClass(TypeInfo(TDateTimeField), nil, '', TDCDateEdit);
  RegisterTextEditClass(TypeInfo(TDateField), nil, '', TDCDateEdit);
  RegisterTextEditClass(TypeInfo(TTimeField), nil, '', TDCTimeEdit);
  {$ENDIF}
*)
end;

{------------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
  RegisterForInstant(_InstantRegister);
end;

{******************************************************************}

initialization
 RunRegister;
end.
