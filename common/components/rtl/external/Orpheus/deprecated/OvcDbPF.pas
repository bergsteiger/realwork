{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                   OVDBPF.PAS 2.17                     *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcDbPF;
  {-Data aware picture field visual componnent}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, DB, DbConsts, DbCtrls, DbTables, Forms, Graphics,
  Menus, Messages, SysUtils,
  OvcBase, OvcCaret, OvcCmd, OvcColor, OvcConst, OvcData,
  OvcEf, OvcExcpt, OvcIntl{!!!}, OvcMisc, OvcPb, OvcPf, STDate;

type
  TDateOrTime = (ftUseDate, ftUseTime, ftUseBothEditDate, ftUseBothEditTime);

const
  dpDefDateOrTime    = ftUseDate;
  dpDefParentColor   = False;
  dpDefTabStop       = True;
  dpDefUseTFieldMask = False;
  dpDefZeroAsNull    = False;

const
  {field types supported by the data aware picture field}
  SupportedFieldTypes : set of  TFieldType =
    [ftString, ftSmallInt, ftInteger, ftWord, ftBoolean,
     ftFloat, ftCurrency, ftDate, ftTime, ftDateTime, ftBCD];

type
  TOvcDbPictureField = class(TOvcCustomPictureField)
  {.Z+}
  protected {private}
    {property variables}
    FCanvas        : TControlCanvas;
    FDataLink      : TFieldDataLink;
    FDateOrTime    : TDateOrTime;
    FFieldType     : TFieldType;
    FUseTFieldMask : Boolean;                                          {!!.01}
    FZeroAsNull    : Boolean;        {True to store zero value as null}

    {internal variables}
    efdbBusy       : Boolean;                                          {11.16}
    pfdbState      : TDbEntryFieldState;

    {property methods}
    function GetDataField : string;
    function GetDataSource : TDataSource;
    function GetField : TField;
    procedure SetDataField(const Value : string);
    procedure SetDataSource(Value : TDataSource);
    procedure SetDateOrTime(Value : TDateOrTime);
    procedure SetFieldType(Value : TFieldType);
    procedure SetUseTFieldMask(Value : Boolean);                       {!!.01}
    procedure SetZeroAsNull(Value : Boolean);

    {internal methods}
    procedure pfdbDataChange(Sender : TObject);
    procedure pfdbEditingChange(Sender : TObject);
    procedure pfdbGetFieldValue;
    procedure pfdbSetFieldProperties;
    procedure pfdbSetFieldValue;
    procedure pfdbUpdateData(Sender : TObject);

    {vcl methods}
    procedure CMEnter(var Msg : TMessage);
      message CM_ENTER;
    procedure CMExit(var Msg : TMessage);
      message CM_EXIT;
    {$IFDEF Win32}
    procedure CMGetDataLink(var Msg : TMessage);
      message CM_GETDATALINK;
    {$ENDIF}

    {windows message methods}
    (*!!.13
    procedure WMChar(var Msg : TWMChar);
      message WM_CHAR; *)
    procedure WMKeyDown(var Msg : TWMKeyDown);
      message WM_KEYDOWN    ;
    procedure WMKillFocus(var Msg : TWMKillFocus);
      message WM_KILLFOCUS;
    procedure WMLButtonDblClk(var Msg : TWMLButtonDblClk);
      message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg : TWMLButtonDown);
      message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg : TWMLButtonUp);
      message WM_LBUTTONUP;
    procedure WMPaint(var Msg : TWMPaint);
      message WM_PAINT;
    procedure WMSetFocus(var Msg : TWMSetFocus);
      message WM_SETFOCUS;

  protected
    procedure CreateWnd;
      override;
    procedure Notification(AComponent : TComponent; Operation : TOperation);
      override;

    procedure DoOnChange;
      override;
      {-perform OnChange notification}

    procedure efEdit(var Msg : TMessage; Cmd : Word);
      override;
      {-process the specified editing command}
    procedure efGetSampleDisplayData(T : PChar);
      override;
      {-return a design time display string}
    procedure efIncDecValue(Wrap : Boolean; Delta : Double);
      override;
      {-increment field by Delta}
    function efIsReadOnly : Boolean;
      override;
      {-get the field's read-only status}
    procedure pfSetPictureMask(const Value : string);
      override;
      {-set the picture mask}

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;
    procedure Restore;                                                 {!!.D4}
      override;
      {-restore the field contents}
  {.Z-}

    procedure CutToClipboard;
      override;
      {-copy highlighted text to the clipboard and then delete it}
    procedure PasteFromClipboard;
      override;
      {-paste the contents of the clipboard}

    property Field : TField
      read GetField;

  published
    property DataField : string
      read GetDataField
      write SetDataField;

    property DataSource : TDataSource
      read GetDataSource
      write SetDataSource;

    property FieldType : TFieldType
      read FFieldType
      write SetFieldType;

    {load after FieldType}
    property DateOrTime : TDateOrTime
      read FDateOrTime
      write SetDateOrTime
      default dpDefDateOrTime;

    property UseTFieldMask : Boolean                                   {!!.01}
      read FUseTFieldMask
      write SetUseTFieldMask
      default dpDefUseTFieldMask;

    property ZeroAsNull : Boolean
      read FZeroAsNull
      write SetZeroAsNull
      default dpDefZeroAsNull;

    {inherited properties}
    property ArrowIncDec;                                              {!!.10}
    property AutoAdvanceChar;
    property AutoAdvanceLeftRight;
    property AutoAdvanceUpDown;
    property AutoSelect;
    property AutoSize;
    property BeepOnError;
    property BorderStyle;
    property CaretIns;
    property CaretOvr;
    property CaretToEnd;
    property Color;
    property ControlCharColor;
    property Controller;
    property Ctl3D;
    property DecimalPlaces;
    property DisabledColors;                                           {!!.12}
    property DragCursor;
    property DragMode;
    property Enabled;
    property Epoch;
    property ErrorColors;
    property Font;
    property ForceInsert;
    property ForceOvertype;
    property HighlightColors;
    property InputRequired;
    property InsertPushes;
    property MaxLength;
    property PadChar;
    property ParentColor default dpDefParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PasswordMode;
    property PictureMask;
    property PopupMenu;
    property RangeHi stored False;
    property RangeLo stored False;
    property ReadOnly;
    property RightAlign;                                               {!!.10}
    property RightJustify;
    property ShowHint;
    property SoftValidation;
    property StripLiterals;
    property TabOrder;
    property TabStop default dpDefTabStop;
    property Tag;
    property TextMargin;
    property TrimBlanks;
    property Visible;

    {inherited events}
    property AfterEnter;                                               {!!.12}
    property AfterExit;                                                {!!.12}
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnError;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF Win32}
    property OnStartDrag;
    {$ENDIF}
    property OnUserCommand;
    property OnUserValidation;
  end;


implementation


procedure TOvcDbPictureField.CMEnter(var Msg : TMessage);
begin
  Include(pfDbState, esSelected);

  inherited;
end;

{!!.12} {revised}
procedure TOvcDbPictureField.CMExit(var Msg : TMessage);
begin
  inherited;
end;

{$IFDEF Win32}
procedure TOvcDbPictureField.CMGetDataLink(var Msg : TMessage);
begin
  Msg.Result := LongInt(FDataLink);
end;
{$ENDIF}

constructor TOvcDbPictureField.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {$IFDEF Win32}
  ControlStyle := ControlStyle + [csReplicatable];
  {$ENDIF}

  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;

  FDataLink.OnDataChange    := pfdbDataChange;
  FDataLink.OnEditingChange := pfdbEditingChange;
  FDataLink.OnUpdateData    := pfdbUpdateData;
  FDateOrTime               := dpDefDateOrTime;
  FUseTFieldMask            := dpDefUseTFieldMask;                     {!!.01}

  {clear all states}
  pfdbState := [];
end;

procedure TOvcDbPictureField.CreateWnd;
begin
  inherited CreateWnd;

  if Field <> nil then begin                                           {!!.01}
    FieldType := Field.DataType;
    pfdbSetFieldValue;                                                 {!!.01}
  end;                                                                 {!!.01}
end;

procedure TOvcDbPictureField.CutToClipboard;
begin
  if not FDataLink.Editing then
    {$IFDEF VERSION3}                                                  {!!.16}
    DatabaseError(SNotEditing);
    {$ELSE}
    DbError(SNotEditing);
    {$ENDIF}

  inherited CutToClipboard;

  pfdbGetFieldValue;
end;

destructor TOvcDbPictureField.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FCanvas.Free;
  FCanvas := nil;

  inherited Destroy;
end;

procedure TOvcDbPictureField.DoOnChange;
begin
  FDataLink.Modified;

  {clear uninitialized flag}                                           {!!.11}
  if InputRequired then                                                {!!.11}
    Uninitialized := False;                                            {!!.11}

  inherited DoOnChange;
end;

procedure TOvcDbPictureField.efEdit(var Msg : TMessage; Cmd : Word);
begin
  if DataSource = nil then
    Exit;

  if (Cmd = ccPaste) or (Cmd = ccCut) then begin
    if DataSource.AutoEdit then begin
      FDataLink.Edit;
      Exclude(pfdbState, esSelected);
    end;
    if FDataLink.Editing then
      inherited efEdit(Msg, Cmd);
  end else
    inherited efEdit(Msg, Cmd);
end;

procedure TOvcDbPictureField.efGetSampleDisplayData(T : PChar);
var
  S : string[MaxEditLen];
  P : Integer;
begin
  {overridden to supply live data for the field display}
  if (Field <> nil) and FDataLink.Active then begin
    if FFieldType in SupportedFieldTypes then  begin
      pfdbSetFieldValue;
      efGetDisplayString(T, MaxEditLen+1);
    end else begin
      S := Field.ClassName;
      S[1] := '(';
      P := Pos('Field', S);
      if P > 0 then begin
        S[P] := ')';
        S[0] := Char(P);
      end else
        S := Concat(S, ')');
      StrPCopy(T, S);
    end;
  end else
    inherited efGetSampleDisplayData(T);
end;

procedure TOvcDbPictureField.efIncDecValue(Wrap : Boolean; Delta : Double);
begin
  if DataSource = nil then
    Exit;

  if DataSource.AutoEdit and (Delta <> 0) then begin
    FDataLink.Edit;
    Exclude(pfdbState, esSelected);
  end;

  if FDataLink.Editing or (Delta = 0) then
    inherited efIncDecValue(Wrap, Delta);
end;

function TOvcDbPictureField.efIsReadOnly : Boolean;
  {-get the fields read-only status}
begin
  if csDesigning in ComponentState then
    Result := inherited efIsReadOnly
  else begin
    Result := inherited efIsReadOnly or (DataSource = nil) or (not FDataLink.CanModify);
    if not (FFieldType in SupportedFieldTypes) then
      Result := True;
    if not Result and Enabled then
      Result := not (DataSource.State in [dsEdit, dsInsert]);
  end;
end;

function TOvcDbPictureField.GetDataField : string;
begin
  Result := FDataLink.FieldName;
end;

function TOvcDbPictureField.GetDataSource : TDataSource;
begin
  if Assigned(FDataLink) then
    Result := FDataLink.DataSource
  else
    Result := nil;
end;

function TOvcDbPictureField.GetField : TField;
begin
  Result := FDataLink.Field;

  {Result will be nil if the datasource is not active. At design-time}
  {the field information can be obtained if a corresponding field    }
  {component has been added to the form (by using the Fields Editor).}
  if (Result = nil) and (csDesigning in ComponentState) then begin
    if (DataSource <> nil) and (DataSource.DataSet <> nil) then
      try
        Result := DataSource.DataSet.FieldByName(FDataLink.FieldName);
      except
        {ignore errors}
      end;
  end;
end;

procedure TOvcDbPictureField.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FDataLink <> nil) and
     (AComponent = DataSource) then begin
    DataSource := nil;
    pfdbSetFieldProperties;
    Refresh;
  end;
end;

procedure TOvcDbPictureField.PasteFromClipboard;
begin
  if not FDataLink.Editing then
    {$IFDEF VERSION3}                                                  {!!.16}
    DatabaseError(SNotEditing);
    {$ELSE}
    DbError(SNotEditing);
    {$ENDIF}

  inherited PasteFromClipboard;

  pfdbGetFieldValue;
end;

procedure TOvcDbPictureField.pfdbDataChange(Sender : TObject);
begin
  if Field <> nil then begin
    {if field data type has changed, reset properties}
    if Field.DataType <> FFieldType then
      pfdbSetFieldProperties;

    {force field to reset highlight and caret position}
    if not (DataSource.State in [dsEdit, dsInsert]) then begin
      Include(pfdbState, esReset);
      Include(pfdbState, esSelected);
    end;

    pfdbSetFieldValue;
  end else                                                             {!!.01}
    efSetInitialValue;                                                 {!!.01}

  Invalidate;
end;

procedure TOvcDbPictureField.pfdbEditingChange(Sender : TObject);
begin
  if (DataSource = nil) or (DataSource.State <> dsEdit) then
    Include(pfdbState, esSelected);
end;

procedure TOvcDbPictureField.pfdbGetFieldValue;
var
  S  : string[MaxEditLen];
  I  : SmallInt absolute S;
  L  : LongInt absolute S;
  W  : Word absolute S;
  B  : Boolean absolute S;
  E  : Extended absolute S;
  DT : TDateTime absolute S;
  H  : TDateTime;

  function FieldIsZero : Boolean;
  begin
    case FFieldType of
      ftSmallInt : Result := I = 0;
      ftInteger  : Result := L = 0;
      ftWord     : Result := W = 0;
      ftFloat    : Result := E = 0;
      ftCurrency : Result := E = 0;
      ftBCD      : Result := E = 0;
    else
      Result := False;
    end;
  end;

begin
  {if the field contents are invalid, exit}
  if not Controller.ErrorPending then {avoid multiple error reports}
    if not ValidateSelf then
      Exit;

  if Field <> nil then begin
    {get the entry field value}
    case FFieldType of
      ftDate,
      ftTime,
      ftDateTime : DT := Self.AsDateTime;
    else
      FLastError := Self.GetValue(S);
    end;

    {if error, don't update the field object}
    if FLastError <> 0 then
      Exit;

    {if the entry field is empty, just clear the db field}
    if (efFieldIsEmpty or (ZeroAsNull and FieldIsZero)) {and}          {!!.01}
       {(Field.DataType <> ftDateTime)} then                           {!!.01}
      Field.Clear
    else
      case Field.DataType of
        ftString   : Field.AsString := S;
        ftSmallInt : Field.AsInteger := I;
        ftInteger  : Field.AsInteger := L;
        ftWord     : Field.AsInteger := W;
        ftBoolean  : Field.AsBoolean := B;
        ftFloat    : Field.AsFloat := E;
        ftCurrency : Field.AsFloat := E;
        ftBCD      : Field.AsFloat := E;
        ftDate,
        ftTime     : Field.AsDateTime := DT;
        ftDateTime :
          begin
            {preserve unedited date or time portion of field value}
            H := Field.AsDateTime;
            case DataType of
              pftDate : Field.AsDateTime := Trunc(DT) + Frac(H);
              pftTime : Field.AsDateTime := Frac(DT) + Trunc(H);
            end;
          end;
      end;

  end;
end;

procedure TOvcDbPictureField.pfdbSetFieldProperties;
begin
  case FFieldType of
    ftString   :
      begin
        DataType := pftString;
        if Field <> nil then begin                                     {!!.13}
          MaxLength := Field.DisplayWidth;
          if Length(PictureMask) > MaxLength then                      {!!.13}
            PictureMask := Copy(PictureMask, 1, MaxLength);            {!!.13}
        end;                                                           {!!.13}
      end;
    ftSmallInt : DataType := pftInteger;
    ftInteger  : DataType := pftLongInt;
    ftWord     : DataType := pftWord;
    ftBoolean  : DataType := pftBoolean;
    ftFloat    : DataType := pftExtended;
    ftCurrency : DataType := pftExtended;
    ftBCD      : DataType := pftExtended;
    ftDate     : DataType := pftDate;
    ftTime     : DataType := pftTime;
    ftDateTime :
      case DateOrTime of
        ftUseDate, ftUseBothEditDate : DataType := pftDate;
        ftUseTime, ftUseBothEditTime : DataType := pftTime;
      end;
  else
    {default to string}
    DataType := pftString;
  end;

  {save current field type}
  if Field <> nil then
    FieldType := Field.DataType;

  {clear all states}
  pfdbState := [];
end;

procedure TOvcDbPictureField.pfdbSetFieldValue;
var
  S  : string[MaxEditLen];
  I  : SmallInt absolute S;
  L  : LongInt absolute S;
  W  : Word absolute S;
  B  : Boolean absolute S;
  E  : Extended absolute S;
  DT : TDateTime absolute S;
  P  : Integer;
  SS : Integer;
  SE : Integer;
  M  : Boolean;                                                        {!!.13}
  EM : Boolean;                                                        {!!.13}
  F  : array[0..255] of Char; {used to compare old and new value}
begin
  if efdbBusy then                                                     {!!.16}
    Exit;                                                              {!!.16}

  {clear to insure match before transfer}
  FillChar(S, SizeOf(S), 0);

  if Field <> nil then begin
    case FFieldType of
      ftString   : begin
                     S := Field.AsString;
                     if (S = '') and not StripLiterals then begin
                       {new or empty field. create display string w/ literals}
                       FillChar(F[0], MaxLength, ' ');
                       F[MaxLength{+1}] := #0;                         {!!.13}
                       pbInitPictureFlags;                             {!!.12}
                       pbMergePicture(F, F);
                       S := StrPas(F);
                     end else if not TrimBlanks and not StripLiterals then
                       while Length(S) < MaxLength do
                         S := S + ' ';
                   end;
      ftSmallInt : I := Field.AsInteger;
      ftInteger  : L := Field.AsInteger;
      ftWord     : W := Field.AsInteger;
      ftBoolean  : B := Field.AsBoolean;
      ftFloat    : E := Field.AsFloat;
      ftCurrency : E := Field.AsFloat;
      ftBCD      : E := Field.AsFloat;
      ftTime     : if (Field.IsNull) then
                     DT := BadTime
                   else
                     DT := Field.AsDateTime;
      ftDate,
      ftDateTime : if (Field.IsNull) then
                     DT := BadDate
                   else
                     DT := Field.AsDateTime;
    else
      S := Field.AsString;
    end;
    P := efHPos;

    {clear to insure match before transfer}
    FillChar(F, SizeOf(F), 0);

    Include(sefOptions, sefNoUserValidate);
    efdbBusy := True;                                                  {!!.16}
    try
      {get copy of current field value}
      Self.GetValue(F);

      SS := efSelStart;
      SE := efSelEnd;

      {store current modified states}                                  {!!.13}
      EM := EverModified;                                              {!!.13}
      M := Modified;                                                   {!!.13}

      {set field value}
      case Field.DataType of
        ftDate     : Self.AsDateTime := DT;
        ftTime     : Self.AsDateTime := DT;
        ftDateTime : Self.AsDateTime := DT;
      else
        Self.SetValue(S);
      end;

      {restore modified states}                                        {!!.13}
      if M then Include(sefOptions, sefModified);                      {!!.13}
      if EM then Include(sefOptions, sefEverModified);                 {!!.13}

    finally
      Exclude(sefOptions, sefNoUserValidate);
      efdbBusy := False;                                               {!!.16}
    end;

    {if field value changed, call DoOnChange}
    if CompStruct(S, F, Self.DataSize) <> 0 then
      inherited DoOnChange;

    if not (esSelected in pfdbState) and not (csDesigning in ComponentState) then begin
      SetSelection(P, P);
      efHPos := P;
      efPositionCaret(False);
    end else if (esSelected in pfdbState) then
      SetSelection(SS, SE);

    {adjust highlight and caret position}
    if (esReset in pfdbState) then begin
      if AutoSelect then
        SetSelection(0, MaxEditLen);
      efHOffset := 0;
      efResetCaret;
      efPositionCaret(True);
      Exclude(pfdbState, esReset);
    end;
  end;
end;

procedure TOvcDbPictureField.pfdbUpdateData(Sender : TObject);
var
  Valid : Boolean;
begin
  if Field <> nil then begin
    if not Modified or not (sefHaveFocus in sefOptions) then
      Include(sefOptions, sefNoUserValidate);
    try
      if Modified then
        Valid := ValidateContents(not Controller.ErrorPending) = 0     {!!.01}
      else
        Valid := True;

      Include(sefOptions, sefNoUserValidate);
      if Modified and Valid then
        pfdbGetFieldValue;

      {raise an exception to halt any BDE scroll actions}
      if not Valid then
        SysUtils.Abort;

    finally
      Exclude(sefOptions, sefNoUserValidate);
    end;
  end;
end;

procedure TOvcDbPictureField.pfSetPictureMask(const Value : string);
  {-set the picture mask}
begin
  inherited pfSetPictureMask(Value);

  if csDesigning in ComponentState then
    RecreateWnd;
end;

procedure TOvcDbPictureField.Restore;
  {-restore the field contents}
begin
  inherited Restore;

  Include(pfdbState, esSelected);
  FDataLink.Reset;
end;

procedure TOvcDbPictureField.SetDataField(const Value : string);
begin
  try
    FDataLink.FieldName := Value;
  except
    FDataLink.FieldName := '';
    raise;
  end;
  pfdbSetFieldProperties;
  Refresh;
  if csDesigning in ComponentState then
    RecreateWnd;
end;

procedure TOvcDbPictureField.SetDataSource(Value : TDataSource);
begin
  FDataLink.DataSource := Value;
  {$IFDEF Win32}
  if Value <> nil then
    Value.FreeNotification(Self);
  {$ENDIF}
  pfdbSetFieldProperties;
  Refresh;
end;

procedure TOvcDbPictureField.SetDateOrTime(Value : TDateOrTime);
begin
  if Value <> FDateOrTime then begin
    FDateOrTime := Value;
    pfdbSetFieldProperties;
    RecreateWnd;
    Restore;
  end;
end;

procedure TOvcDbPictureField.SetFieldType(Value : TFieldType);
begin
  if (Value <> FFieldType) and (Value in SupportedFieldTypes) then begin
    FFieldType := Value;
    pfdbSetFieldProperties;
  end;

  if not (csLoading in ComponentState) then
    if (csDesigning in ComponentState) and not (Value in SupportedFieldTypes) then
      raise EOvcException.Create(GetOrphStr(SCInvalidFieldType));
end;

{!!.01} {added}
procedure TOvcDbPictureField.SetUseTFieldMask(Value : Boolean);
begin
  if (Value <> FUseTFieldMask) then begin
    FUseTFieldMask := Value;
    Invalidate;
  end;
end;

procedure TOvcDbPictureField.SetZeroAsNull(Value : Boolean);
begin
  if Value <> FZeroAsNull then
    FZeroAsNull := Value;
end;

(*!!.13
procedure TOvcDbPictureField.WMChar(var Msg : TWMChar);
begin
  with Msg do begin
    if (CharCode in [32..255]) and (Field <> nil) and
       not Field.IsValidChar(Char(Lo(CharCode))) then
      efConditionalBeep
    else
      inherited;
  end;
end;
*)

procedure TOvcDbPictureField.WMKeyDown(var Msg : TWMKeyDown);
var
  Shift  : Boolean;
  Insert : Boolean;
begin
  case Msg.CharCode of
    VK_F1..VK_F12,                                              {!!.01}{!!.12}
    VK_RETURN,
    VK_ESCAPE,
    VK_NONE,
    VK_SHIFT,
    VK_CONTROL,
    VK_ALT,
    VK_CAPITAL,
    VK_NUMLOCK,
    VK_SCROLL,
    VK_PRIOR,                                                          {!!.11}
    VK_NEXT,                                                           {!!.11}
    VK_TAB      : {};
    VK_HOME,
    VK_END,
    VK_UP,
    VK_DOWN,
    VK_LEFT,
    VK_RIGHT    : Exclude(pfdbState, esSelected);
  else
    if (DataSource <> nil) and DataSource.AutoEdit then begin
      if not inherited efIsReadOnly then begin
        {special handling for <Ins> and <Shift><Ins> key sequences}
        Shift := (GetAsyncKeyState(VK_SHIFT) and $8000 <> 0);
        Insert := (Msg.CharCode = VK_INSERT);
        if not Insert or (Shift and Insert) then begin
          FDataLink.Edit;
          Exclude(pfdbState, esSelected);
        end;
      end;
    end;
  end;

  inherited;
end;

{!!.12} {revised}
procedure TOvcDbPictureField.WMKillFocus(var Msg : TWMKillFocus);
begin
  Exclude(pfdbState, esFocused);

  inherited;

  if (LastError = 0) and FDataLink.Editing then
    if Modified and not Controller.ErrorPending then                   {!!.13}
      if not Controller.IsSpecialButton(Msg.FocusedWnd) then           {!!.13}
        pfdbGetFieldValue;
end;

procedure TOvcDbPictureField.WMLButtonDblClk(var Msg : TWMLButtonDblClk);
begin
  inherited;

  Include(pfdbState, esSelected);
end;

procedure TOvcDbPictureField.WMLButtonDown(var Msg : TWMLButtonDown);
begin
  inherited;

  Exclude(pfdbState, esSelected);
end;

procedure TOvcDbPictureField.WMLButtonUp(var Msg : TWMLButtonUp);
begin
  inherited;

  if SelectionLength > 0 then
    Include(pfdbState, esSelected);
end;

procedure TOvcDbPictureField.WMPaint(var Msg : TWMPaint);
var
  Indent   : Integer;
  R        : TRect;
  DC       : hDC;
  bError   : Boolean;                                                  {!!.11}
  bActive  : Boolean;                                                  {!!.11}
  bFocused : Boolean;                                                  {!!.11}
  bNotMask : Boolean;                                                  {!!.11}
  PS       : TPaintStruct;
  S        : string;
  T        : TEditString;
begin
{!!.11} {revised}
{$IFDEF Win32}
  bError := (LastError <> 0);
  bActive := (FDataLink.DataSet <> nil) and FDataLink.Active;
  bFocused := (esFocused in pfdbState) and not (csPaintCopy in ControlState);
  bNotMask := not UseTFieldMask and not (csPaintCopy in ControlState);
  if not bActive or bError or bFocused or bNotMask then begin
    inherited;
    Exit;
  end;
{$ELSE}
  bError := (LastError <> 0);
  bActive := (FDataLink.DataSet <> nil) and FDataLink.Active;
  bFocused := (esFocused in pfdbState);
  bNotMask := not UseTFieldMask;
  if not bActive or bError or bFocused or bNotMask then begin
    inherited;
    Exit;
  end;
{$ENDIF}

  if FCanvas = nil then begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;

  DC := Msg.DC;
  if DC = 0 then
    DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;

    if not Enabled and (Color <> clGrayText) then
      FCanvas.Font.Color := clGrayText;

    with FCanvas do begin
      R := ClientRect;
      Brush.Color := Color;

      {get text to display}
      if Field <> nil then begin
        if Field.IsNull then
          S := ''                                                    
        {!!.17} {revised}
        else if (FFieldType = ftDateTime) and not UseTFieldMask then begin
          case FDateOrTime of
            ftUseDate : S := OvcIntlSup.DateToDateString(PictureMask,
                             DateTimeToStDate(Field.AsDateTime), True);
            ftUseTime : S := OvcIntlSup.TimeToTimeString(PictureMask,
                             DateTimeToStTime(Field.AsDateTime), True);
          else
            S := Field.DisplayText
          end;
        end else
          S := Field.DisplayText
        {!!.17} {end revision}
      end else begin
        efGetSampleDisplayData(T);
        S := StrPas(T);
      end;

      if PasswordMode then
        FillChar(S[1], Length(S), PasswordChar);

      if Field <> nil then begin
        case Field.Alignment of
          taLeftJustify  :
            Indent := TextMargin - 1;                                  {!!.11}
          taRightJustify :
            Indent := ClientWidth - TextWidth(S) - TextMargin - 1;     {!!.11}
        else
          Indent := (ClientWidth - TextWidth(S)) div 2;
        end;
      end else
        Indent := TextMargin - 1;                                      {!!.11}

      {TextRect(R, Indent, efTopMargin, S);}                           {!!.11}
      FillRect(R);                                                     {!!.11}
      StrPLCopy(T, S, MaxEditLen);                                     {!!.11}
      SetBkColor(FCanvas.Handle, Graphics.ColorToRGB(Color));   {!!.11}{!!.12}
      ExtTextOut(FCanvas.Handle, Indent, efTopMargin,           {!!.11}{!!.12}
        ETO_CLIPPED, @R, T, StrLen(T), nil);                           {!!.11}
    end;
  finally
    FCanvas.Handle := 0;
    if Msg.DC = 0 then
      EndPaint(Handle, PS);
  end;
end;

procedure TOvcDbPictureField.WMSetFocus(var Msg : TWMSetFocus);
begin
  Include(pfdbState, esFocused);

  if LastError = 0 then                                                {!!.11}
    pfdbSetFieldValue;                                                 {!!.11}

  inherited;
end;


end.