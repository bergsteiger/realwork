Unit vtMenus;

{$I vtDefine.inc }

Interface
Uses Messages, Windows, Menus, ActnList;

Type
 TMessageKind = (mkCut, mkCopy, mkPaste, mkClear, mkUndo, mkCustom);

 TvtStdMsgAction = class(TAction)
 private
  fMessageValue : Integer;
 protected
  function  GetMessageKind : TMessageKind;
  procedure SetMessageKind(aValue : TMessageKind);

  function  GetMessageValue : Integer;
  procedure SetMessageValue(aValue : Integer);
 public
  procedure ExecuteTarget(Target: TObject); override;
  function  HandlesTarget(Target: TObject): Boolean; override;

 published
  property MessageKind : TMessageKind read GetMessageKind write SetMessageKind stored false;
  property MessageValue : Integer read GetMessageValue write SetMessageValue;
 end;

 TvtActionList = class(TCustomActionList)
 public
  procedure EnableAllCategory(aCategoryName : String; aEnabled : Boolean);
 end;


 procedure vtVisibleAndEnabled(Const aItem : TMenuItem; aValue : Boolean); overload;
 procedure vtVisibleAndEnabled(Const aItem : TAction;   aValue : Boolean); overload;

Implementation
 Uses
  l3Base;

procedure vtVisibleAndEnabled(Const aItem : TMenuItem; aValue : Boolean);
 begin
  with aItem do
  begin
   Visible := aValue;
   Enabled := aValue;
  end;
 end;

procedure vtVisibleAndEnabled(Const aItem : TAction;   aValue : Boolean);
 begin
  with aItem do
  begin
   Visible := aValue;
   Enabled := aValue;
  end;
 end;

{TvtActionList}
procedure TvtActionList.EnableAllCategory(aCategoryName : String; aEnabled : Boolean);
 var
  I : Integer;
 begin
  For I:=0 to ActionCount do
   with TAction(Actions[I]) do
    If Category = aCategoryName then
    begin
     Enabled := aEnabled;
    end;
 end;

function  TvtStdMsgAction.GetMessageKind : TMessageKind;
 begin
  case fMessageValue of
   WM_CUT   : Result := mkCut;
   WM_COPY  : Result := mkCopy;
   WM_PASTE : Result := mkPaste;
   WM_CLEAR : Result := mkClear;
   WM_UNDO  : Result := mkUndo
   else       Result := mkCustom;
  end;
 end;

procedure TvtStdMsgAction.SetMessageKind(aValue : TMessageKind);
 begin
  case aValue of
   mkCut    : fMessageValue := WM_CUT;
   mkCopy   : fMessageValue := WM_COPY;
   mkPaste  : fMessageValue := WM_PASTE;
   mkClear  : fMessageValue := WM_CLEAR;
   mkUndo   : fMessageValue := WM_UNDO;
   mkCustom : fMessageValue := 0;
  end;

 end;

function  TvtStdMsgAction.GetMessageValue : Integer;
 begin
  Result := fMessageValue;
 end;

procedure TvtStdMsgAction.SetMessageValue(aValue : Integer);
 begin
  fMessageValue := aValue;
 end;

function TvtStdMsgAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := True;
end;

procedure TvtStdMsgAction.ExecuteTarget(Target: TObject);
var
 lWnd : HWND;
 lResult : Boolean;
begin
 lResult := false;
 lWnd := GetFocus;
 While (lWnd <> 0) and (not lResult) do
 begin
  lResult := SendMessage(lWnd, fMessageValue, 0, 0) <> 0;
  //l3System._Send
  lWnd := GetParent(lWnd);
 end;
end;

end.