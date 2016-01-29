{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{   Copyright (c) 2002, Elizabeth Krivonos,          }
{                       Alexander Hramov             }
{                                                    }
{====================================================}
{$INCLUDE elpack2.inc} 
{$IFDEF ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$ELSE}
{$IFDEF LINUX}
{$I ../ElPack.inc}
{$ELSE}
{$I ..\ElPack.inc}
{$ENDIF}
{$ENDIF}

(*

Version History

08/02/2003

  add TElDBTreeWideStringEdit

06/01/2003

  fixed the incorrect processing of var Assepted value in
  method AfterOperation

*)
unit ElDBTreeEditors;


interface

uses
  Windows,
  Messages,

  StdCtrls,
  Controls,
  Forms,
  Dialogs,
  SysUtils,
  Classes,
  db,
  dbctrls,
{$IFDEF VCL_6_USED}
  Types,
{$ENDIF}
  ElTree,
  ElHeader,
  ElTools,
  ElEdits,
  ElDBSpin,
  ElDBCurrEdit,
  ElDBTree,
  ElDBCtrls,
  ElDBDTPick;

type

  THackElTree = class (TCustomElTree)
  end;
  
  THackElDBTreeItem = class (TElDBTreeItem)
  end;

  THackElDBEdit = class (TElDBEdit)
  end;

  {$IFDEF ELPACK_UNICODE}
  THackElWideDBEdit = class (TElWideDBEdit)
  end;
  {$ENDIF}

  THackDBInplaceCurrencyEdit = class (TElDBCurrencyEdit)
  end;

  THackControl = class (TControl)
  end;

  {$IFDEF ELPACK_UNICODE}
  TElDBTreeWideStringEdit = class (TElDBTreeInplaceEditor)
  private
    FAccepted: Boolean;
    SaveWndProc: TWndMethod;
    procedure EditorWndProc(var Message: TMessage);
  protected
    FEditor: TElWideDBEdit;
    procedure CompleteOperation(Accepted: boolean); override;
    procedure StartOperation; override;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted: boolean); override;
    function GetVisible: Boolean; override;
    procedure SetEditorParent; override;
    procedure TriggerAfterOperation(var Accepted: boolean; var
            DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Editor: TElWideDBEdit read FEditor;
  end;
  {$ENDIF}

  TElDBTreeSpinEdit = class (TElDBTreeInplaceEditor)
  private
    FAccepted1: Boolean;
    SaveWndProc: TWndMethod;
    procedure EditorWndProc(var Message: TMessage);
  protected
    FEditor: TElDBSpinEdit;
    procedure CompleteOperation(Accepted: boolean); override;
    procedure StartOperation; override;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted: boolean); override;
    function GetVisible: Boolean; override;
    procedure SetEditorParent; override;
    procedure TriggerAfterOperation(var Accepted: boolean; var
            DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Editor: TElDBSpinEdit read FEditor;
  end;

  TElDBTreeFloatSpinEdit = class (TElDBTreeInplaceEditor)
  private
    FAccepted1: Boolean;
    SaveWndProc: TWndMethod;
    procedure EditorWndProc(var Message: TMessage);
  protected
    FEditor: TElDBFloatSpinEdit;
    procedure CompleteOperation(Accepted: boolean); override;
    procedure StartOperation; override;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted: boolean); override;
    function GetVisible: Boolean; override;
    procedure SetEditorParent; override;
    procedure TriggerAfterOperation(var Accepted: boolean; var
            DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Editor: TElDBFloatSpinEdit read FEditor;
  end;

  TElDBTreeEdit = class (TElDBTreeInplaceEditor)
  private
    FAccepted: Boolean;
    SaveWndProc: TWndMethod;
    procedure EditorWndProc(var Message: TMessage);
  protected
    FEditor: TElDBEdit;
    procedure CompleteOperation(Accepted: boolean); override;
    procedure StartOperation; override;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted: boolean); override;
    function GetVisible: Boolean; override;
    procedure SetEditorParent; override;
    procedure TriggerAfterOperation(var Accepted: boolean; var
            DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Editor: TElDBEdit read FEditor;
  end;

  TElDBTreeMemoEdit = class (TElDBTreeInplaceEditor)
  private
    FAccepted: Boolean;
    SaveWndProc: TWndMethod;
    procedure EditorWndProc(var Message: TMessage);
  protected
    FEditor: TElDBMemo;
    procedure CompleteOperation(Accepted: boolean); override;
    procedure StartOperation; override;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted: boolean); override;
    function GetVisible: Boolean; override;
    procedure SetEditorParent; override;
    procedure TriggerAfterOperation(var Accepted: boolean; var
            DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Editor: TElDBMemo read FEditor;
  end;

  TElDBTreeCheckBoxEdit = class (TElDBTreeInplaceEditor)
  private
    FAccepted: Boolean;
    SaveWndProc: TWndMethod;
    procedure EditorWndProc(var Message: TMessage);
  protected
    FEditor: TElDBCheckBox;
    procedure CompleteOperation(Accepted: boolean); override;
    procedure StartOperation; override;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted: boolean); override;
    function GetVisible: Boolean; override;
    procedure SetEditorParent; override;
    procedure TriggerAfterOperation(var Accepted: boolean; var
            DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Editor: TElDBCheckBox read FEditor;
  end;

  TElDBTreeDateTimePickerEdit = class (TElDBTreeInplaceEditor)
  private
    FAccepted: Boolean;
    SaveWndProc: TWndMethod;
    procedure EditorWndProc(var Message: TMessage);
  protected
    FEditor: TElDBDateTimePicker;
    procedure CompleteOperation(Accepted: boolean); override;
    procedure StartOperation; override;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted: boolean); override;
    function GetVisible: Boolean; override;
    procedure SetEditorParent; override;
    procedure TriggerAfterOperation(var Accepted: boolean; var
            DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Editor: TElDBDateTimePicker read FEditor;
  end;

  TElDBTreeCurrencyEdit = class (TElDBTreeInplaceEditor)
  private
    FAccepted: Boolean;
    SaveIntWndProc: array[1..2] of TWndMethod;
    SaveWndProc: TWndMethod;
    procedure EditorWndProc(var Message: TMessage);
    procedure IntEditorWndProc1(var Message: TMessage);
    procedure IntEditorWndProc2(var Message: TMessage);
  protected
    FEditor: TElDBCurrencyEdit;
    procedure CompleteOperation(Accepted: boolean); override;
    procedure StartOperation; override;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted: boolean); override;
    function GetVisible: Boolean; override;
    procedure RealWndProc(var Message: TMessage);
    procedure SetEditorParent; override;
    procedure TriggerAfterOperation(var Accepted: boolean; var
            DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Editor: TElDBCurrencyEdit read FEditor;
  end;
  
implementation

{ TElDBTreeInplaceEdit }

{
******************************** TElDBTreeEdit *********************************
}

constructor TElDBTreeEdit.Create(AOwner: TComponent);
begin
  inherited;
  FEditor := TElDBEdit.Create(Self);
  FEditor.Visible := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := Self.EditorWndProc;
  FTypes := [sftText];
end;

destructor TElDBTreeEdit.Destroy;
begin
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElDBTreeEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSource;
  fieldname, oldv: string;
begin
  DS := TDataSource.Create(Owner);
  DS.DataSet := FEditor.DataSource.DataSet;
  oldv := FEditor.Text;
  fieldname := FEditor.Field.FieldName;
  DS.DataSet.DisableControls;
  THackElDBEdit(FEditor).Reset;
  inherited CompleteOperation(accepted);
  DS.DataSet.EnableControls;
  if (FAccepted) and (Accepted) and (DS.DataSet.FieldByName(fieldname).AsString <> oldv) then
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(fieldname).AsString := oldv;
  end;
  DS.DataSet.CheckBrowseMode;
  DS.Free;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeEdit.DoStopOperation(Accepted: boolean);
begin
  FEditor.Visible := false;
  FEditor.DataField := '';
  FEditor.DataSource := nil;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElDBTreeEdit.EditorWndProc(var Message: TMessage);
var
  InputValid: Boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        CompleteOperation(true);
      end
      else
        if TWMKey(Message).CharCode = VK_ESCAPE then
        begin
          CompleteOperation(false);
        end;
    end;
  end
  else
    if (Message.Msg = WM_CANCELMODE) or
      ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)
      ) or
      (Message.Msg = WM_KILLFOCUS) then
      if FEditing then
      begin
        if THackElTree(Tree).ExplorerEditMode then
        begin
          InputValid := true;
          TriggerValidateResult(InputValid);
          CompleteOperation(InputValid)
        end
        else
          CompleteOperation(false);
      end;
  SaveWndProc(Message);
end;

function TElDBTreeEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeEdit.TriggerAfterOperation(var Accepted: boolean; var 
        DefaultConversion: boolean);
begin
  FEditor.OnExit := nil;
  inherited;
  FAccepted := Accepted;
end;

procedure TElDBTreeEdit.TriggerBeforeOperation(var DefaultConversion: boolean);
begin
  inherited;
  FEditor.BoundsRect := FCellRect;
end;

                

{ TElDBTreeMemoEdit }
{
****************************** TElDBTreeMemoEdit *******************************
}
constructor TElDBTreeMemoEdit.Create(AOwner: TComponent);
begin
  inherited;
  FEditor := TElDBMemo.Create(Self);
  FEditor.Visible := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := Self.EditorWndProc;
  FTypes := [sftMemo];
end;

destructor TElDBTreeMemoEdit.Destroy;
begin
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElDBTreeMemoEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSource;
  fieldname: string;
  oldv: TStringList;
begin
  DS := TDataSource.Create(Owner);
  DS.DataSet := FEditor.DataSource.DataSet;
  fieldname := FEditor.Field.FieldName;
  oldv := TStringList.Create;
  oldv.Text := DS.DataSet.FieldByName(fieldname).AsString;
  if not Accepted then FEditor.DataSource.DataSet.Cancel;
  inherited CompleteOperation(Accepted);
  if not FAccepted then
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(fieldname).AsString := oldv.Text;
  end;
  DS.DataSet.CheckBrowseMode;
  oldv.Free;
  DS.Free;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeMemoEdit.DoStopOperation(Accepted: boolean);
begin
  FEditor.Visible := false;
  FEditor.DataField := '';
  FEditor.DataSource := nil;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElDBTreeMemoEdit.EditorWndProc(var Message: TMessage);
var
  InputValid: Boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        CompleteOperation(true);
      end
      else
        if TWMKey(Message).CharCode = VK_ESCAPE then
          CompleteOperation(false);
    end;
  end
  else
    if (Message.Msg = WM_CANCELMODE) or
      ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)
      ) or
      (Message.Msg = WM_KILLFOCUS) then
      if FEditing then
      begin
        if THackElTree(Tree).ExplorerEditMode then
        begin
          InputValid := true;
          TriggerValidateResult(InputValid);
          CompleteOperation(InputValid)
        end
        else
          CompleteOperation(false);
      end;
  SaveWndProc(Message);
end;

function TElDBTreeMemoEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeMemoEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeMemoEdit.TriggerAfterOperation(var Accepted: boolean; var 
        DefaultConversion: boolean);
begin
  FEditor.OnExit := nil;
  inherited;
  FAccepted := Accepted;
end;

procedure TElDBTreeMemoEdit.TriggerBeforeOperation(var DefaultConversion:
        boolean);
begin
  inherited;
  FEditor.BoundsRect := FCellRect;
end;

{ TElDBTreeCheckBoxEdit }
{
**************************** TElDBTreeCheckBoxEdit *****************************
}
constructor TElDBTreeCheckBoxEdit.Create(AOwner: TComponent);
begin
  inherited;
  FEditor := TElDBCheckBox.Create(Self);
  FEditor.Visible := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := Self.EditorWndProc;
  FTypes := [sftBool];
end;

destructor TElDBTreeCheckBoxEdit.Destroy;
begin
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElDBTreeCheckBoxEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSource;
  fieldname: string;
  oldv: variant;
begin
  DS := TDataSource.Create(Owner);
  DS.DataSet := FEditor.DataSource.DataSet;
  fieldname := FEditor.Field.FieldName;
  oldv := DS.DataSet.FieldByName(fieldname).Value;
  //  DS.DisableControls;
  //  FEditor.DataSource.DataSet.Cancel;
  inherited CompleteOperation(accepted);
  //  DS.EnableControls;
  if (not FAccepted) and (DS.DataSet.FieldByName(FieldName).Value <> oldv) then
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := oldv;
  end;
  DS.DataSet.CheckBrowseMode;
  Ds.Free;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeCheckBoxEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElDBTreeCheckBoxEdit.DoStopOperation(Accepted: boolean);
begin
  FEditor.Visible := false;
  FEditor.DataField := '';
  FEditor.DataSource := nil;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElDBTreeCheckBoxEdit.EditorWndProc(var Message: TMessage);
var
  InputValid: Boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        CompleteOperation(true);
      end
      else
        if TWMKey(Message).CharCode = VK_ESCAPE then
        begin
          CompleteOperation(false);
        end;
    end;
  end
  else
    if (Message.Msg = WM_CANCELMODE) or
      ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)
      ) or
      (Message.Msg = WM_KILLFOCUS) then
      if FEditing then
      begin
        if THackElTree(Tree).ExplorerEditMode then
        begin
          InputValid := true;
          TriggerValidateResult(InputValid);
          CompleteOperation(InputValid)
        end
        else
          CompleteOperation(false);
      end;
  SaveWndProc(Message);
end;

function TElDBTreeCheckBoxEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeCheckBoxEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeCheckBoxEdit.TriggerAfterOperation(var Accepted: boolean; 
        var DefaultConversion: boolean);
begin
  FEditor.OnExit := nil;
  inherited;
  FAccepted := Accepted;
end;

procedure TElDBTreeCheckBoxEdit.TriggerBeforeOperation(var DefaultConversion: 
        boolean);
begin
  inherited;
  FEditor.BoundsRect := FCellRect;
end;

{ TElDBTreeDateTimePickerEdit }

{
************************* TElDBTreeDateTimePickerEdit **************************
}
constructor TElDBTreeDateTimePickerEdit.Create(AOwner: TComponent);
begin
  inherited;
  FEditor := TElDBDateTimePicker.Create(Self);
  FEditor.ParentCtl3D := false;
  FEditor.Ctl3D := false;
  FEditor.Visible := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := Self.EditorWndProc;
  FTypes := [sftDateTime, sftTime, sftDate];
end;

destructor TElDBTreeDateTimePickerEdit.Destroy;
begin
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElDBTreeDateTimePickerEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSource;
  fieldname: string;
  oldv: variant;
begin
  DS := TDataSource.Create(Owner);
  DS.DataSet := FEditor.DataSource.DataSet;
  fieldname := FEditor.Field.FieldName;
  oldv := DS.DataSet.FieldByName(FieldName).Value;
  //  DS.DisableControls;
  //  FEditor.DataSource.DataSet.Cancel;
  inherited CompleteOperation(accepted);
  //  DS.EnableControls;
  if (not FAccepted) and (DS.DataSet.FieldByName(fieldname).AsDateTime <> oldv) then
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := oldv;
  end;
  DS.DataSet.CheckBrowseMode;
  Ds.Free;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeDateTimePickerEdit.DoStopOperation(Accepted: boolean);
begin
  FEditor.Visible := false;
  FEditor.DataField := '';
  FEditor.DataSource := nil;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElDBTreeDateTimePickerEdit.EditorWndProc(var Message: TMessage);
var
  InputValid: Boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        CompleteOperation(true);
      end
      else
        if TWMKey(Message).CharCode = VK_ESCAPE then
        begin
          CompleteOperation(false);
        end;
    end;
  end
  else
    if (Message.Msg = WM_CANCELMODE) or
      ((Message.Msg = CM_CANCELMODE) and
      ((Message.lParam = 0) or
      ((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor) and
      (TObject(Pointer(Message.lParam)) <> Editor)))
      ) or
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

function TElDBTreeDateTimePickerEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeDateTimePickerEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeDateTimePickerEdit.TriggerAfterOperation(var Accepted: 
        boolean; var DefaultConversion: boolean);
begin
  FEditor.OnExit := nil;
  inherited;
  FAccepted := Accepted;
end;

procedure TElDBTreeDateTimePickerEdit.TriggerBeforeOperation(var 
        DefaultConversion: boolean);
begin
  inherited;
  FEditor.BoundsRect := FCellRect;
end;

{ TElDBTreeCurrencyEdit }
{
**************************** TElDBTreeCurrencyEdit *****************************
}
constructor TElDBTreeCurrencyEdit.Create(AOwner: TComponent);
begin
  inherited;
  FEditor := TElDBCurrencyEdit.Create(Self);
  FEditor.Visible := false;
  FEditor.ParentCtl3D := false;
  FEditor.Ctl3D := false;
  FEditor.HandleDialogKeys := true;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FTypes := [sftCurrency];
  SaveIntWndProc[1] := THackControl(THackDBInplaceCurrencyEdit(FEditor).FPartEditors[1]).WindowProc;
  SaveIntWndProc[2] := THackControl(THackDBInplaceCurrencyEdit(FEditor).FPartEditors[2]).WindowProc;
  THackControl(THackDBInplaceCurrencyEdit(FEditor).FPartEditors[1]).WindowProc := IntEditorWndProc1;
  THackControl(THackDBInplaceCurrencyEdit(FEditor).FPartEditors[2]).WindowProc := IntEditorWndProc2;
end;

destructor TElDBTreeCurrencyEdit.Destroy;
begin
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElDBTreeCurrencyEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSet;
  fieldname: string;
  oldv, newv: variant;
  // pr : Boolean;
begin
  DS := FEditor.DataSource.DataSet;
  // pr := true;
  oldv := FEditor.Field.Value ;
  newv := FEditor.AbsoluteValue;
  fieldname := FEditor.Field.FieldName;
  DS.DisableControls;
  inherited CompleteOperation(Accepted);
  DS.EnableControls;
  if (FAccepted) and (Accepted) then
  begin
    DS.Edit;
    DS.FieldByName(FieldName).Value := newv
  end
  else
  begin
    DS.Edit;
    DS.FieldByName(FieldName).Value := oldv
  end;
  DS.CheckBrowseMode;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeCurrencyEdit.DoStopOperation(Accepted: boolean);
begin
  if Accepted then FEditor.Visible := false;
  FEditor.DataSource := nil;
  FEditor.DataField := '';
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElDBTreeCurrencyEdit.EditorWndProc(var Message: TMessage);
begin
  RealWndProc(Message);
  SaveWndProc(Message);
end;

function TElDBTreeCurrencyEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeCurrencyEdit.IntEditorWndProc1(var Message: TMessage);
begin
  RealWndProc(Message);
  SaveIntWndProc[1](Message);
end;

procedure TElDBTreeCurrencyEdit.IntEditorWndProc2(var Message: TMessage);
begin
  RealWndProc(Message);
  SaveIntWndProc[2](Message);
end;

procedure TElDBTreeCurrencyEdit.RealWndProc(var Message: TMessage);
var
  InputValid: Boolean;
  ACtl: TWinControl;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        CompleteOperation(true);
        exit;
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
      ((Message.lParam = 0) or
      (((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor) and
      (TObject(Pointer(Message.lParam)) <> Editor))))
      ) or
      (Message.Msg = WM_KILLFOCUS) then
    begin
      if Message.Msg = WM_KILLFOCUS then
      begin
        ACtl := FindControl(TWMKillFocus(Message).FocusedWnd);
        if (ACtl <> nil) and (ACtl.Parent = Editor) then
        begin
          SaveWndProc(Message);
          exit;
        end;
      end;
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
    end;
end;

procedure TElDBTreeCurrencyEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeCurrencyEdit.TriggerAfterOperation(var Accepted: boolean; 
        var DefaultConversion: boolean);
begin
  FEditor.OnExit := nil;
  inherited;
  FAccepted := Accepted;
end;

procedure TElDBTreeCurrencyEdit.TriggerBeforeOperation(var DefaultConversion:
        boolean);
begin
  inherited;
  FEditor.BoundsRect := FCellRect;
end;


{ TElDBTreeInplaceSpinEdit }

{
****************************** TElDBTreeSpinEdit *******************************
}
constructor TElDBTreeSpinEdit.Create(AOwner: TComponent);
begin
  inherited;
  FEditor := TElDBSpinEdit.Create(Self);
  FEditor.Visible := false;
  FEditor.ParentCtl3D := false;
  FEditor.Ctl3D := false;
  FEditor.AutoSelect := true;
  FEditor.HandleDialogKeys := true;
  Feditor.MaxValue := 10000000;
  FEditor.MinValue := -10000000;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FTypes := [sftNumber];
  FAccepted1 := True;
end;

destructor TElDBTreeSpinEdit.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElDBTreeSpinEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSource;
  fieldname: string;
  oldv, newv: variant;
begin
  DS := TDataSource.Create(Owner);
  DS.DataSet := FEditor.DataSource.DataSet;
  fieldname := FEditor.Field.FieldName;
  oldv := DS.DataSet.FieldByName(FieldName).Value;
  newv := FEditor.Value;
  DS.DataSet.DisableControls;
  inherited CompleteOperation(true);
  DS.DataSet.EnableControls;
  if (not FAccepted1) and (DS.DataSet.FieldByName(fieldname).AsInteger <> oldv) then
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := oldv;
  end
  else
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := newv;
  end;
  DS.DataSet.CheckBrowseMode;
  Ds.Free;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeSpinEdit.DoStopOperation(Accepted: boolean);
begin
  FEditor.Visible := false;
  FEditor.DataField := '';
  FEditor.DataSource := nil;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElDBTreeSpinEdit.EditorWndProc(var Message: TMessage);
var
  InputValid: Boolean;
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
        exit;
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
      ((Message.lParam = 0) and
      ((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor) and
      (TObject(Pointer(Message.lParam)) <> Editor)))
      ) or
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

function TElDBTreeSpinEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeSpinEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeSpinEdit.TriggerAfterOperation(var Accepted: boolean; var 
        DefaultConversion: boolean);
begin
  FEditor.OnExit := nil;
  inherited;
  FAccepted1 := Accepted;
end;

procedure TElDBTreeSpinEdit.TriggerBeforeOperation(var DefaultConversion: 
        boolean);
begin
  inherited;
  FEditor.BoundsRect := FCellRect;
end;

{ TElDBTreeFloatSpinEdit }

{
**************************** TElDBTreeFloatSpinEdit ****************************
}
constructor TElDBTreeFloatSpinEdit.Create(AOwner: TComponent);
begin
  inherited;
  FEditor := TElDBFloatSpinEdit.Create(Self);
  FEditor.Visible := false;
  FEditor.ParentCtl3D := false;
  FEditor.Ctl3D := false;
  FEditor.AutoSelect := true;
  FEditor.HandleDialogKeys := true;
  Feditor.MaxValue := 10000000;
  FEditor.MinValue := -10000000;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FTypes := [sftFloating];
  FAccepted1 := True;
end;

destructor TElDBTreeFloatSpinEdit.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElDBTreeFloatSpinEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSource;
  fieldname: string;
  oldv, newv: variant;
begin
  DS := TDataSource.Create(Owner);
  DS.DataSet := FEditor.DataSource.DataSet;
  fieldname := FEditor.Field.FieldName;
  oldv := DS.DataSet.FieldByName(FieldName).Value;
  newv := FEditor.Value;
  DS.DataSet.DisableControls;
  inherited CompleteOperation(Accepted);
  DS.DataSet.EnableControls;
  if (not FAccepted1) and (DS.DataSet.FieldByName(fieldname).AsFloat <> oldv) then
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := oldv;
    DS.DataSet.CheckBrowseMode;
  end
  else
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := newv;
    DS.DataSet.CheckBrowseMode;
  end;
  Ds.Free;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeFloatSpinEdit.DoStopOperation(Accepted: boolean);
begin
  FEditor.Visible := false;
  FEditor.DataField := '';
  FEditor.DataSource := nil;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElDBTreeFloatSpinEdit.EditorWndProc(var Message: TMessage);
var
  InputValid: Boolean;
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
      ((Message.lParam = 0) or
      (((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor) and
      (TObject(Pointer(Message.lParam)) <> Editor))))
      ) or
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

function TElDBTreeFloatSpinEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeFloatSpinEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeFloatSpinEdit.TriggerAfterOperation(var Accepted: boolean; 
        var DefaultConversion: boolean);
begin
  FEditor.OnExit := nil;
  inherited;
  FAccepted1 := Accepted;
end;

procedure TElDBTreeFloatSpinEdit.TriggerBeforeOperation(var DefaultConversion:
        boolean);
begin
  inherited;
  FEditor.BoundsRect := FCellRect;
end;

{ TElDBTreeInplaceEdit }
{$IFDEF ELPACK_UNICODE}
{
*************************** TElDBTreeWideStringEdit ****************************
}
constructor TElDBTreeWideStringEdit.Create(AOwner: TComponent);
begin
  inherited;
  FEditor := TElWideDBEdit.Create(Self);
  FEditor.Visible := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := Self.EditorWndProc;
  FTypes := [sftText];
end;

destructor TElDBTreeWideStringEdit.Destroy;
begin
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElDBTreeWideStringEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSource;
  fieldname: string;
  oldv: Variant;
begin
  DS := TDataSource.Create(Owner);
  DS.DataSet := FEditor.DataSource.DataSet;
  oldv := FEditor.Lines.Text;
  fieldname := FEditor.Field.FieldName;
  DS.DataSet.DisableControls;
  THackElWideDBEdit(FEditor).Reset;
  inherited CompleteOperation(accepted);
  DS.DataSet.EnableControls;
  if (FAccepted) and (Accepted) and (DS.DataSet.FieldByName(fieldname).AsString <> oldv) then
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := oldv;
  end;
  DS.DataSet.CheckBrowseMode;
  DS.Free;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeWideStringEdit.DoStopOperation(Accepted: boolean);
begin
  FEditor.Visible := false;
  FEditor.DataField := '';
  FEditor.DataSource := nil;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElDBTreeWideStringEdit.EditorWndProc(var Message: TMessage);
var
  InputValid: Boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        CompleteOperation(true);
      end
      else
        if TWMKey(Message).CharCode = VK_ESCAPE then
        begin
          CompleteOperation(false);
        end;
    end;
  end
  else
    if (Message.Msg = WM_CANCELMODE) or
      ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)
      ) or
      (Message.Msg = WM_KILLFOCUS) then
      if FEditing then
      begin
        if THackElTree(Tree).ExplorerEditMode then
        begin
          InputValid := true;
          TriggerValidateResult(InputValid);
          CompleteOperation(InputValid)
        end
        else
          CompleteOperation(false);
      end;
  SaveWndProc(Message);
end;

function TElDBTreeWideStringEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeWideStringEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeWideStringEdit.TriggerAfterOperation(var Accepted: boolean;
        var DefaultConversion: boolean);
begin
  FEditor.OnExit := nil;
  inherited;
  FAccepted := Accepted;
end;

procedure TElDBTreeWideStringEdit.TriggerBeforeOperation(var DefaultConversion:
        boolean);
begin
  inherited;
  FEditor.BoundsRect := FCellRect;
end;

procedure TElDBTreeWideStringEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElDBTreeWideStringEdit.StartOperation;
var
  MItem: TElDBTreeItem;
begin
  MItem := FItem as TElDBTreeItem;
  if THackElDBTreeItem(MItem).FRecNum <> THackElDBTreeItem(Mitem).DataSource.DataSet.RecNo then
    THackElDBTreeItem(MItem).DataSource.DataSet.GotoBookmark(THackElDBTreeItem(MItem).FBookmark);
  FEditor.DataSource := THackElDBTreeItem(MItem).DataSource;
  FEditor.DataField := MItem.EditingField;
  inherited;
end;

{$ENDIF}

procedure TElDBTreeSpinEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElDBTreeFloatSpinEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElDBTreeEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElDBTreeMemoEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElDBTreeDateTimePickerEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElDBTreeCurrencyEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElDBTreeSpinEdit.StartOperation;
var
  MItem: TElDBTreeItem;
begin
  MItem := FItem as TElDBTreeItem;
  if THackElDBTreeItem(MItem).FRecNum <> THackElDBTreeItem(Mitem).DataSource.DataSet.RecNo then
    THackElDBTreeItem(MItem).DataSource.DataSet.GotoBookmark(THackElDBTreeItem(MItem).FBookmark);
  FEditor.DataSource := THackElDBTreeItem(MItem).DataSource;
  FEditor.DataField := MItem.EditingField;
  inherited;
end;

procedure TElDBTreeFloatSpinEdit.StartOperation;
var
  MItem: TElDBTreeItem;
begin
  MItem := FItem as TElDBTreeItem;
  if THackElDBTreeItem(MItem).FRecNum <> THackElDBTreeItem(Mitem).DataSource.DataSet.RecNo then
    THackElDBTreeItem(MItem).DataSource.DataSet.GotoBookmark(THackElDBTreeItem(MItem).FBookmark);
  FEditor.DataSource := THackElDBTreeItem(MItem).DataSource;
  FEditor.DataField := MItem.EditingField;
  inherited;
end;

procedure TElDBTreeEdit.StartOperation;
var
  MItem: TElDBTreeItem;
begin
  MItem := FItem as TElDBTreeItem;
  if THackElDBTreeItem(MItem).FRecNum <> THackElDBTreeItem(Mitem).DataSource.DataSet.RecNo then
    THackElDBTreeItem(MItem).DataSource.DataSet.GotoBookmark(THackElDBTreeItem(MItem).FBookmark);
  FEditor.DataSource := THackElDBTreeItem(MItem).DataSource;
  FEditor.DataField := MItem.EditingField;
  inherited;
end;

procedure TElDBTreeMemoEdit.StartOperation;
var
  MItem: TElDBTreeItem;
begin
  MItem := FItem as TElDBTreeItem;
  if THackElDBTreeItem(MItem).FRecNum <> THackElDBTreeItem(Mitem).DataSource.DataSet.RecNo then
    THackElDBTreeItem(MItem).DataSource.DataSet.GotoBookmark(THackElDBTreeItem(MItem).FBookmark);
  FEditor.DataSource := THackElDBTreeItem(MItem).DataSource;
  FEditor.DataField := MItem.EditingField;
  inherited;
end;

procedure TElDBTreeCheckBoxEdit.StartOperation;
var
  MItem: TElDBTreeItem;
begin
  MItem := FItem as THackElDBTreeItem;
  if THackElDBTreeItem(MItem).FRecNum <> THackElDBTreeItem(Mitem).DataSource.DataSet.RecNo then
    THackElDBTreeItem(MItem).DataSource.DataSet.GotoBookmark(THackElDBTreeItem(MItem).FBookmark);
  FEditor.DataSource := THackElDBTreeItem(MItem).DataSource;
  if MItem.ShowCheckBox then FEditor.DataField := THackElDBTreeItem(MItem).FCheckBoxField;
  inherited;
end;

procedure TElDBTreeDateTimePickerEdit.StartOperation;
var
  MItem: TElDBTreeItem;
begin
  MItem := FItem as TElDBTreeItem;
  if THackElDBTreeItem(MItem).FRecNum <> THackElDBTreeItem(Mitem).DataSource.DataSet.RecNo then
    THackElDBTreeItem(MItem).DataSource.DataSet.GotoBookmark(THackElDBTreeItem(MItem).FBookmark);
  FEditor.DataSource := THackElDBTreeItem(MItem).DataSource;
  FEditor.DataField := MItem.EditingField;
  inherited;
end;

procedure TElDBTreeCurrencyEdit.StartOperation;
var
  MItem: TElDBTreeItem;
begin
  MItem := FItem as TElDBTreeItem;
  if THackElDBTreeItem(MItem).FRecNum <> THackElDBTreeItem(Mitem).DataSource.DataSet.RecNo then
    THackElDBTreeItem(MItem).DataSource.DataSet.GotoBookmark(THackElDBTreeItem(MItem).FBookmark);
  FEditor.DataSource := THackElDBTreeItem(MItem).DataSource;
  FEditor.DataField := MItem.EditingField;
  inherited;
end;

end.
