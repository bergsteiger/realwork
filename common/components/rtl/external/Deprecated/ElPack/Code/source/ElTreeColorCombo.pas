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

unit ElTreeColorCombo;

interface

uses

  Windows,
  Messages,
  Controls,
  Forms,
  Graphics,
  SysUtils,
  Classes,
{$ifdef VCL_6_USED}
Types,
{$endif}
{$ifdef ELPACK_USE_STYLEMANAGER}
  ElStyleMan,
{$endif}

  ElTree,
  ElHeader,
  ElClrCmb
  ;

type

    THackInplaceColorCombo = class(TElColorCombo)
      procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer); override;
    end;

    TElTreeInplaceColorCombo = class(TElTreeInplaceEditor)
    private
      SaveWndProc: TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
    protected
      FEditor: TElColorCombo;
      FInitiallyDropped : boolean;
      FIgnoreKillFocus  : boolean;
      procedure SetEditorParent; override;
      procedure DoStartOperation; override;
      procedure DoStopOperation(Accepted : boolean); override;
      function GetVisible: Boolean; override;
      procedure ColorDialogShow(Sender : TObject; AfterShow : boolean);
      procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
          boolean); override;
      procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
      {$ifdef ELPACK_USE_STYLEMANAGER}
      function GetStyleManager: TElStyleManager;
      procedure SetStyleManager(Value: TElStyleManager);
      function GetStyleName: string;
      procedure SetStyleName(const Value: string);
      {$endif}
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      property Editor: TElColorCombo read FEditor;
    published
      {$ifdef ELPACK_USE_STYLEMANAGER}
      property StyleManager: TElStyleManager read GetStyleManager write
          SetStyleManager;
      property StyleName: string read GetStyleName write SetStyleName;
      {$endif}
      property InitiallyDropped : boolean read FInitiallyDropped write FInitiallyDropped;
    end;

implementation

constructor TElTreeInplaceColorCombo.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := THackInplaceColorCombo.Create(Self);
  FEditor.Visible := false;
  FEditor.ParentCtl3D := false;
  FEditor.Ctl3D := false;
  FEditor.HandleDialogKeys := true;

  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FEditor.OnColorDialogShow := ColorDialogShow;
  //FEditor.ListWindowProc := ListWndProc;
  //FEditor.EditWindowProc := EditWndProc;
  FTypes := [sftEnum];
end;

destructor TElTreeInplaceColorCombo.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceColorCombo.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElTreeInplaceColorCombo.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
  if InitiallyDropped then
    FEditor.Perform(CB_SHOWDROPDOWN, 1, 0);
end;

procedure TElTreeInplaceColorCombo.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

type THackElTree = class(TCustomElTree);

procedure TElTreeInplaceColorCombo.EditorWndProc(var Message : TMessage);
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
      end;
    end;
  end
  else
  if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      ((Message.lParam = 0) or
      ((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor)) and
      (TObject(Pointer(Message.lParam)) <> Editor))) or
     ((Message.Msg = WM_KILLFOCUS) and (not FIgnoreKillFocus))then
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

function TElTreeInplaceColorCombo.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceColorCombo.TriggerAfterOperation(var Accepted : boolean;
    var DefaultConversion : boolean);
begin
  FEditor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := ColorToString(FEditor.SelectedColor);
end;

procedure TElTreeInplaceColorCombo.TriggerBeforeOperation(var DefaultConversion :
    boolean);
begin
  inherited;
  if DefaultConversion then
    FEditor.SelectedColor := StringToColor(ValueAsText);
  FEditor.BoundsRect := FCellRect;
end;

procedure TElTreeInplaceColorCombo.ColorDialogShow(Sender : TObject; AfterShow : boolean);
begin
  FIgnoreKillFocus := not AfterShow;
end;

{$ifdef ELPACK_USE_STYLEMANAGER}
function TElTreeInplaceColorCombo.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

procedure TElTreeInplaceColorCombo.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

function TElTreeInplaceColorCombo.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElTreeInplaceColorCombo.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;
{$endif}

procedure THackInplaceColorCombo.ComboWndProc(var Message: TMessage; ComboWnd:
    HWnd; ComboProc: Pointer);
var InputValid : boolean;
begin
  with TElTreeInplaceColorCombo(Owner) do
  begin
    if Message.Msg = WM_KEYDOWN then
    begin
      if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
      begin
        if TWMKey(Message).CharCode = VK_RETURN then
        begin
          InputValid := true;
          TriggerValidateResult(InputValid);
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

end.
