{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

unit ElTreeStdEditors;

interface

uses

  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Menus,
  ExtCtrls,
  StdCtrls,
  ComCtrls,
{$ifdef VCL_6_USED}
  Types,
{$endif}

{$IFDEF VCL_4_USED}
  ImgList,
{$ENDIF}

  SysUtils,
  Classes,
  {$ifndef LITE}
  ElEdits,
  {$endif}
  ElTree,
  ElHeader
  ;

type

    TElTreeInplaceEdit = class(TElTreeInplaceEditor)
    private
      SaveWndProc : TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
    protected
      {$ifdef LITE}
      FEditor: TEdit;
      {$else}
      FEditor: TElEdit;
      {$endif}
      procedure DoStartOperation; override;
      procedure DoStopOperation(Accepted : boolean); override;
      function GetVisible: Boolean; override;
      procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
          boolean); override;
      procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
      procedure SetEditorParent; override;
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      {$ifdef LITE}
      property Editor: TEdit read FEditor;
      {$else}
      property Editor: TElEdit read FEditor;
      {$endif}
    end;

    TElTreeInplaceMemo = class(TElTreeInplaceEditor)
    private
      SaveWndProc: TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
    protected
      FEditor: TMemo;
      function GetVisible: Boolean; override;
      procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
          boolean); override;
      procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
      procedure DoStartOperation; override;
      procedure DoStopOperation(Accepted : boolean); override;
      procedure SetEditorParent; override;
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      property Editor: TMemo read FEditor;
    end;

    {$ifndef ELPACK_COMPLETE}
    TElTreeInplaceDateTimePicker = class(TElTreeInplaceEditor)
    private
      SaveWndProc: TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
    protected
      FEditor: TDateTimePicker;
      function GetVisible: Boolean; override;
      procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
          boolean); override;
      procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
      procedure DoStartOperation; override;
      procedure DoStopOperation(Accepted : boolean); override;
      procedure SetEditorParent; override;
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      property Editor: TDateTimePicker read FEditor;
    end;
    {$endif}

    TElTreeInplaceCheckBox = class(TElTreeInplaceEditor)
    private
      SaveWndProc: TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
    protected
      FEditor: TCheckBox;
      procedure DoStartOperation; override;
      procedure DoStopOperation(Accepted : boolean); override;
      function GetVisible: Boolean; override;
      procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
          boolean); override;
      procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
      procedure SetEditorParent; override;
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      property Editor: TCheckBox read FEditor;
    end;

    {$ifndef ELPACK_COMPLETE}
    THackInplaceComboBox = class(TComboBox)
      procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer); override;
    protected
      procedure KeyPress(var Key: Char); override;
      procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    end;

    TElTreeInplaceComboBox = class(TElTreeInplaceEditor)
    private
      SaveWndProc: TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
    protected
      FInitiallyDropped : boolean;
      FEditor: TComboBox;
      procedure DoStartOperation; override;
      procedure DoStopOperation(Accepted : boolean); override;
      function GetVisible: Boolean; override;
      procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
          boolean); override;
      procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
      procedure SetEditorParent; override;
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      property Editor: TComboBox read FEditor;
    published
      property InitiallyDropped : boolean read FInitiallyDropped write FInitiallyDropped;
    end;
    {$endif}
implementation

type

  THackElTree = class(TCustomElTree);

  {$ifdef LITE}
  TElInpEdit = class(TEdit)
  {$else}
  TElInpEdit = class(TElEdit)
  {$endif}
  private
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure KeyPress(var Key: Char); override;
  end;

  TElInpMemo = class(TMemo)
  private
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure KeyPress(var Key: Char); override;
  end;

  TElInpCheckBox = class(TCheckBox)
  private
    procedure KeyPress(var Key: Char); override;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  end;
  {$ifndef ELPACK_COMPLETE}
  TElInpDateTimePicker = class(TDateTimePicker)
  private
    procedure KeyPress(var Key: Char); override;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  end;
  {$endif}

procedure TElInpMemo.KeyPress(var Key: Char);
begin                                      // get rid of Windows beep
  if Key = Chr(VK_RETURN) then
    key := Chr(0);
  if Key = Chr(VK_ESCAPE) then
    key := Chr(0);
  if Key <> #0 then
    inherited KeyPress(Key);
end;


procedure TElInpMemo.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := Message.Result or DLGC_WANTARROWS or DLGC_WANTALLKEYS; // we want the RETURN key
end;

procedure TElInpEdit.WMGetDlgCode(var Message: TWMGetDlgCode); // CNS
begin
  Message.Result := Message.Result or DLGC_WANTARROWS or DLGC_WANTALLKEYS; // we want the RETURN key
end;

procedure TElInpEdit.KeyPress(var Key: Char); // CNS
begin                                   // get rid of Windows beep
  if Key = Chr(VK_RETURN) then
    key := Chr(0);
  if Key = Chr(VK_ESCAPE) then
    key := Chr(0);
  if Key <> #0 then
    inherited KeyPress(Key);
end;

procedure TElTreeInplaceEdit.TriggerAfterOperation(var Accepted : boolean; var
    DefaultConversion : boolean);
begin
  FEditor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := FEditor.Text;
end;

procedure TElTreeInplaceEdit.TriggerBeforeOperation(var DefaultConversion :
    boolean);
begin
  inherited;
  if DefaultConversion then
    FEditor.Text := ValueAsText;
  FEditor.BoundsRect := FCellRect;
end;

procedure TElTreeInplaceEdit.EditorWndProc(var Message : TMessage);
var InputValid : boolean;
begin
  if Message.Msg = WM_GETDLGCODE then
  begin
    inherited;
    Message.Result := Message.Result or DLGC_WANTCHARS or DLGC_WANTARROWS or DLGC_WANTALLKEYS;
  end
  else
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          CompleteOperation(true);
          TWMKey(Message).CharCode := 0;
          exit;
        end
        else
          Editor.SetFocus;
        TWMKey(Message).CharCode := 0;
      end
      else
      if TWMKey(Message).CharCode = VK_ESCAPE then
      begin
        CompleteOperation(false);
        TWMKey(Message).CharCode := 0;
        exit;
      end;
    end;
  end
  else
  if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)) or
     (Message.Msg = WM_KILLFOCUS) then
    if FEditing then
    begin
      if THackElTree(Tree).ExplorerEditMode then
      begin
        InputValid := true;
        TriggerValidateResult(InputValid);
        CompleteOperation(InputValid);
      end
      else
        CompleteOperation(false);
    end;
  SaveWndProc(Message);
end;

procedure TElTreeInplaceEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElTreeInplaceEdit.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

function TElTreeInplaceEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

constructor TElTreeInplaceEdit.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := TElInpEdit.Create(Self);
  FEditor.ParentCtl3D := false;
  FEditor.Ctl3D := false;
  FEditor.AutoSelect := true;
  FEditor.Visible := false;
  FEditor.AutoSize := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := Self.EditorWndProc;
  FTypes := [sftText];
end;

destructor TElTreeInplaceEdit.Destroy;
begin
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

function TElTreeInplaceMemo.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceMemo.TriggerAfterOperation(var Accepted : boolean; var
    DefaultConversion : boolean);
begin
  FEditor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := FEditor.Text;
end;

procedure TElTreeInplaceMemo.TriggerBeforeOperation(var DefaultConversion :
    boolean);
begin
  inherited;
  if DefaultConversion then
    FEditor.Text := ValueAsText;
  FEditor.BoundsRect := FCellRect;
end;

constructor TElTreeInplaceMemo.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := TElInpMemo.Create(Self);
  FEditor.ParentCtl3D := false;
  FEditor.Ctl3D := false;
  FEditor.Visible := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FTypes := [sftMemo];
end;

destructor TElTreeInplaceMemo.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceMemo.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElTreeInplaceMemo.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElTreeInplaceMemo.EditorWndProc(var Message : TMessage);
var InputValid : boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          CompleteOperation(true);
          TWMKey(Message).CharCode := 0;
          exit;
        end
        else
          Editor.SetFocus;
        TWMKey(Message).CharCode := 0;
      end
      else
      if TWMKey(Message).CharCode = VK_ESCAPE then
      begin
        CompleteOperation(false);
        TWMKey(Message).CharCode := 0;
        exit;
      end;
    end;
  end
  else
  if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)) or
     (Message.Msg = WM_KILLFOCUS) then
    if FEditing then
    begin
      if THackElTree(Tree).ExplorerEditMode then
      begin
        InputValid := true;
        TriggerValidateResult(InputValid);
        CompleteOperation(InputValid);
      end
      else
        CompleteOperation(false);
    end;
  SaveWndProc(Message);
end;

procedure TElTreeInplaceMemo.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

{$ifndef ELPACK_COMPLETE}
function TElTreeInplaceDateTimePicker.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceDateTimePicker.TriggerAfterOperation(var Accepted :
    boolean; var DefaultConversion : boolean);
begin
  FEditor.OnExit := nil;
  inherited;
  if DefaultConversion then
  begin
    case Self.DataType of
      sftDate: ValueAsText := DateToStr(FEditor.Date);
      sftTime: ValueAsText := TimeToStr(FEditor.Time);
    end;
  end;
end;

procedure TElTreeInplaceDateTimePicker.TriggerBeforeOperation(var
    DefaultConversion : boolean);
begin
  inherited;
  if DefaultConversion then
    case Self.DataType of
      sftDate: FEditor.Date := StrToDate(ValueAsText);
      sftTime: FEditor.Time := StrTotime(ValueAsText);
    end;
  FEditor.BoundsRect := FCellRect;
end;

constructor TElTreeInplaceDateTimePicker.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := TElInpDateTimePicker.Create(Self);
  FEditor.Visible := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FTypes := [sftDate, sftTime];
end;

destructor TElTreeInplaceDateTimePicker.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceDateTimePicker.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElTreeInplaceDateTimePicker.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElTreeInplaceDateTimePicker.EditorWndProc(var Message : TMessage);
var InputValid : boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          CompleteOperation(true);
          TWMKey(Message).CharCode := 0;
          exit;
        end
        else
          Editor.SetFocus;
        TWMKey(Message).CharCode := 0;
      end
      else
      if TWMKey(Message).CharCode = VK_ESCAPE then
      begin
        CompleteOperation(false);
        TWMKey(Message).CharCode := 0;
        exit;
      end;
    end;
  end
  else
  if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)) or
     (Message.Msg = WM_KILLFOCUS) then
    if FEditing then
    begin
      if THackElTree(Tree).ExplorerEditMode then
      begin
        InputValid := true;
        TriggerValidateResult(InputValid);
        CompleteOperation(InputValid);
      end
      else
        CompleteOperation(false);
    end;
  SaveWndProc(Message);
end;

procedure TElTreeInplaceDateTimePicker.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;
{$endif}

{$ifndef ELPACK_COMPLETE}
constructor TElTreeInplaceComboBox.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := THackInplaceComboBox.Create(Self);
  FEditor.Visible := false;
  FEditor.ParentCtl3D := false;
  FEditor.Ctl3D := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FTypes := [sftEnum];
end;

destructor TElTreeInplaceComboBox.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceComboBox.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
  if InitiallyDropped then
    FEditor.Perform(CB_SHOWDROPDOWN, 1, 0);
end;

procedure TElTreeInplaceComboBox.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElTreeInplaceComboBox.EditorWndProc(var Message : TMessage);
var InputValid : boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          CompleteOperation(true);
          TWMKey(Message).CharCode := 0;
          exit;
        end
        else
          Editor.SetFocus;
        TWMKey(Message).CharCode := 0;
      end
      else
      if TWMKey(Message).CharCode = VK_ESCAPE then
      begin
        CompleteOperation(false);
        TWMKey(Message).CharCode := 0;
        exit;
      end;
    end;
  end
  else
  if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)) or
     (Message.Msg = WM_KILLFOCUS) then
  begin
    if FEditing then
      PostMessage(Editor.Handle, TM_CLOSEINPLACEEDITOR, 0, 0);
  end
  else
  if (Message.Msg = TM_CLOSEINPLACEEDITOR) then
    if THackElTree(Tree).ExplorerEditMode then
    begin
      InputValid := true;
      TriggerValidateResult(InputValid);
      CompleteOperation(InputValid);
    end
    else
      CompleteOperation(false);
  SaveWndProc(Message);
end;

function TElTreeInplaceComboBox.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceComboBox.TriggerAfterOperation(var Accepted : boolean;
    var DefaultConversion : boolean);
begin
  FEditor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := FEditor.Text;
end;

procedure TElTreeInplaceComboBox.TriggerBeforeOperation(var DefaultConversion :
    boolean);
begin
  inherited;
  if DefaultConversion then
    FEditor.Text := ValueAsText;
  FEditor.BoundsRect := FCellRect;
end;

procedure TElTreeInplaceComboBox.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure THackInplaceComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer);
var InputValid : boolean;
begin
  with TElTreeInplaceComboBox(Owner) do
  begin
    if Message.Msg = WM_KEYDOWN then
    begin
      if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
      begin
        if TWMKey(Message).CharCode = VK_RETURN then
        begin
          InputValid := true;
          FEditing := false;
          TriggerValidateResult(InputValid);
          FEditing := true;
          if InputValid then
        begin
          CompleteOperation(true);
          TWMKey(Message).CharCode := 0;
          exit;
        end
        else
          Editor.SetFocus;
        TWMKey(Message).CharCode := 0;
        end
        else
        if TWMKey(Message).CharCode = VK_ESCAPE then
        begin
          CompleteOperation(false);
          TWMKey(Message).CharCode := 0;
          exit;
        end;
      end;
    end
    else
    if (Message.Msg = WM_KILLFOCUS) then
    begin
      if FEditing then
        PostMessage(Editor.Handle, TM_CLOSEINPLACEEDITOR, 0, 0);
    end
    else
    if (Message.Msg = TM_CLOSEINPLACEEDITOR) then
      if THackElTree(Tree).ExplorerEditMode then
      begin
        InputValid := true;
        TriggerValidateResult(InputValid);
        CompleteOperation(InputValid);
      end
      else
        CompleteOperation(false);
  end;
  inherited;
end;

procedure THackInplaceComboBox.KeyPress(var Key: Char);
begin                                      // get rid of Windows beep
  if Key = Chr(VK_RETURN) then
    key := Chr(0);
  if Key = Chr(VK_ESCAPE) then
    key := Chr(0);
  if Key <> #0 then
    inherited KeyPress(Key);
end;

procedure THackInplaceComboBox.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := Message.Result or DLGC_WANTALLKEYS; // we want the RETURN key
end;
{$endif}

constructor TElTreeInplaceCheckBox.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := TElInpCheckBox.Create(Self);
  FEditor.Visible := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FDefaultValueAsText := '*';
  FTypes := [sftBool];
end;

destructor TElTreeInplaceCheckBox.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceCheckBox.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElTreeInplaceCheckBox.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElTreeInplaceCheckBox.EditorWndProc(var Message : TMessage);
var InputValid : boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          CompleteOperation(true);
          exit;
        end
        else
          Editor.SetFocus;
        TWMKey(Message).CharCode := 0;
      end
      else
      if TWMKey(Message).CharCode = VK_ESCAPE then
      begin
        CompleteOperation(false);
        TWMKey(Message).CharCode := 0;
        exit;
      end;
    end;
  end
  else
  if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)) or
     (Message.Msg = WM_KILLFOCUS) then
    if FEditing then
    begin
      if THackElTree(Tree).ExplorerEditMode then
      begin
        InputValid := true;
        TriggerValidateResult(InputValid);
        CompleteOperation(InputValid);
      end
      else
        CompleteOperation(false);
    end;
  SaveWndProc(Message);
end;

function TElTreeInplaceCheckBox.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceCheckBox.TriggerAfterOperation(var Accepted : boolean;
    var DefaultConversion : boolean);
begin
  FEditor.OnExit := nil;
  inherited;
  if DefaultConversion then
  begin
    if Editor.Checked then
      ValueAsText := FDefaultValueAsText
    else
      ValueAsText := '';
  end;
end;

procedure TElTreeInplaceCheckBox.TriggerBeforeOperation(var DefaultConversion :
    boolean);
begin
  inherited;
  if DefaultConversion then
    FEditor.Checked := ValueAsText <> '';
  FEditor.BoundsRect := FCellRect;
end;

procedure TElTreeInplaceCheckBox.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElInpCheckBox.KeyPress(var Key: Char);
begin                                      // get rid of Windows beep
  if Key = Chr(VK_RETURN) then
    key := Chr(0);
  if Key = Chr(VK_ESCAPE) then
    key := Chr(0);
  if Key <> #0 then
    inherited KeyPress(Key);
end;

procedure TElInpCheckBox.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := Message.Result or DLGC_WANTALLKEYS; // we want the RETURN key
end;

{$ifndef ELPACK_COMPLETE}
procedure TElInpDateTimePicker.KeyPress(var Key: Char);
begin                                      // get rid of Windows beep
  if Key = Chr(VK_RETURN) then
    key := Chr(0);
  if Key = Chr(VK_ESCAPE) then
    key := Chr(0);
  if Key <> #0 then
    inherited KeyPress(Key);
end;

procedure TElInpDateTimePicker.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := Message.Result or DLGC_WANTALLKEYS; // we want the RETURN key
end;
{$endif}

end.
