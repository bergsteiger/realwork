{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit EditUnit;

interface
{$I dc.inc}

uses
  dcsystem, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, dcmemo,Menus,dccommon, dcstring, dcconsts, dcdreamlib;


type
  TEditForm = class(TForm)
    StatusBar1: TStatusBar;
    PopupMenu1: TPopupMenu;
    OpenFileatCursor1: TMenuItem;
    PopupNewEditWindow: TMenuItem;
    BrowseSymbolatCursor1: TMenuItem;
    TopicSearch1: TMenuItem;
    N1: TMenuItem;
    ToggleBreakpoint1: TMenuItem;
    RuntoCursor1: TMenuItem;
    EvaluateModify1: TMenuItem;
    AddWatchatCursor1: TMenuItem;
    N2: TMenuItem;
    ViewasForm1: TMenuItem;
    ReadOnly1: TMenuItem;
    N3: TMenuItem;
    Properties1: TMenuItem;
    PopupClosePage: TMenuItem;
    TabControl: TTabControl;
    Memo: TDCMemo;
    VerbDispatcher1: TVerbDispatcher;
    PopupMessageView: TMenuItem;
    PopupSave: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MemoStateChange(Sender: TObject; State: TMemoStates);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabControlChange(Sender: TObject);
  private
    FFiles:TStringList;
    procedure UpdateCaption;
    procedure SourceFromPage(PageIndex:Integer);
    procedure RemoveSource(AComponent:TCustomMemoSource);
    procedure OnSourceChange(Sender:TObject;wParam,lParam:Integer);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure WMGETMINMAXINFO(Var Message:TMessage);message WM_GETMINMAXINFO;
    procedure CMIDECLOSEALL(Var Message:TMessage);message CM_IDECLOSEALL;
  end;

  TEditFormClass=class of TEditForm;
  
  TShowSourceParam=(spCenterOnLine,spMakeTop,spCreateNew);
  TShowSourceParams=set of TShowSourceParam;

const
  EditFormClass:TEditFormClass=TEditForm;

var
  EditForm: TEditForm;
  MaxToFullScreen : boolean = false;

function ShowMemoSource(MemoSource:TCustomMemoSource;Params:TShowSourceParams):TEditForm;
function SourceIsFocused(MemoSource:TCustomMemoSource):boolean;
procedure HideMemoSource(MemoSource:TCustomMemoSource);
function GetActiveSource:TCustomMemoSource;
procedure UpdateStatusBar(StatusBar:TStatusBar;Memo:TDCMemo;State:TMemoStates);

implementation
{$R *.DFM}
const
  cReadOnly : array[boolean] of string = ('', SStatReadOnly);
  
{------------------------------------------------------------------}

procedure TEditForm.CMIDECLOSEALL(Var Message:TMessage);
begin
  Release;
end;

{------------------------------------------------------------------}

procedure TEditForm.OnSourceChange(Sender:TObject;wParam,lParam:Integer);
Var
  i:Integer;
begin
  With TCustomMemoSource(Sender) do
  begin

    if not (msObjNameChanged in State) then
      exit;

    i:=FFiles.IndexOf(OldObjectName);
    If i>=0 then
    begin
      FFiles[i]:=ObjectName;
      TabControl.Tabs[i]:=ExtractFileName(ObjectName);
      Caption:=Memo.GetSource.ObjectName;
    end;
  end;
end;

{------------------------------------------------------------------}

function GetActiveSource:TCustomMemoSource;
Var
  EditForm:TEditForm;
begin
  EditForm:=TEditForm(FindFormWithClass(EditFormClass));
  If FormIsActive(EditForm) then
    Result:=EditForm.Memo.MemoSource
  else
    Result:=nil;
end;

{------------------------------------------------------------------}

function SourceIsFocused(MemoSource:TCustomMemoSource):boolean;
begin
  Result:=GetActiveSource=MemoSource;
end;

{------------------------------------------------------------------}

procedure TEditForm.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  If (Operation=opRemove) and (AComponent is TCustomMemoSource) then
    RemoveSource(TCustomMemoSource(Acomponent));
end;

{------------------------------------------------------------------}

procedure TEditForm.RemoveSource(AComponent:TCustomMemoSource);
Var
  i:Integer;
begin
  With TCustomMemoSource(AComponent),TabControl do
  begin
    i:=FFiles.IndexOf(ObjectName);
    If (i>=0) and (I<Tabs.Count) then
    begin
      FFiles.Delete(i);
      Tabs.Delete(i);
      TabIndex:=Min(i,Tabs.Count-1);
    end;
    If Tabs.Count=0 then
      Self.Release
    else
      If (Memo.MemoSource=nil) or (Memo.MemoSource=AComponent) then
        SourceFromPage(TabIndex);
  end;
end;

{------------------------------------------------------------------}

procedure TEditForm.SourceFromPage(PageIndex:Integer);
begin
  Memo.MemoSource:=MemoSourceByName(FFiles[PageIndex]);
  Caption:=Memo.GetSource.ObjectName;
end;

{------------------------------------------------------------------}

procedure TEditForm.WMGETMINMAXINFO(Var Message:TMessage);
begin
  inherited;
  CalcEditorMinMaxInfo(Message, Application.MainForm, MaxToFullScreen);
end;

{------------------------------------------------------------------}

procedure TEditForm.FormCreate(Sender: TObject);
begin
  SetFormFont(self);
  FFiles:=TStringList.Create;
  RegisterNotifier(self);
  ReadWinPosFromReg(Self,'CodeEdit'); //don't resource

  OpenFileatCursor1.Caption     := SOpenFileatCursor;
  PopupNewEditWindow.Caption    := SViewNewEditWindowMenu;
  BrowseSymbolatCursor1.Caption := SBrowseSymbolatCursor;
  TopicSearch1.Caption          := STopicSearch;
  ToggleBreakpoint1.Caption     := SToggleBreakpoint;
  RuntoCursor1.Caption          := SRuntoCursor;
  EvaluateModify1.Caption       := SEvaluateModifyMenu;
  AddWatchatCursor1.Caption     := SAddWatchatCursor;
  ViewasForm1.Caption           := SViewasForm;
  ReadOnly1.Caption             := SReadOnly;
  Properties1.Caption           := SVerbProperties;
  PopupClosePage.Caption        := SClosePage;
  PopupMessageView.Caption      := SMessageView;
  PopupSave.Caption             := SVerbSave;
end;

{------------------------------------------------------------------}

procedure TEditForm.FormDestroy(Sender: TObject);
begin
  UnRegisterNotifier(Self);
  FFiles.Free;
  WriteWinPosToReg(Self,'CodeEdit');  //don't resource
end;

{------------------------------------------------------------------}

procedure TEditForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_TAB:
      if (ssCtrl in Shift) then
      begin
        ChangeTab(TabControl,not(ssShift in Shift));
        SourceFromPage(TabControl.TabIndex);
      end;
    VK_F5:
      begin
        If WindowState=wsNormal then
          WindowState:=wsMaximized else
          WindowState:=wsNormal;
      end
    else
      exit;
  end;
end;

{------------------------------------------------------------------}

procedure TEditForm.UpdateCaption;
var
  idx : integer;
begin
  If Memo.MemoSource<>nil then
    With Memo.GetSource do
    begin
//      AddNewTab(TabControl,ObjectName);
      idx := FFiles.IndexOf(ObjectName);
      with TabControl do
      begin
        If idx < 0 then
          TabIndex := Tabs.Add(ExtractFileName(ObjectName))
        else
          TabIndex := idx;
        If idx < 0 then
          FFiles.Insert(tabIndex, ObjectName);
      end;
      Caption:=ObjectName;
    end;
end;

{------------------------------------------------------------------}

function ShowMemoSource(MemoSource:TCustomMemoSource;Params:TShowSourceParams):TEditForm;
begin
  Result:=TEditForm(FindFormWithClass(EditFormClass));
  If (Result=nil) or (spCreateNew in Params) then
    Result:=EditFormClass.Create(Application);

//  EditForm.Memo.Options:=EditForm.Memo.Options+[moLineNumbers];

  With Result do
  begin
    If WindowState=wsminimized then
      WindowState:=wsNormal;
    Memo.MemoSource:=MemoSource;
    If spCenterOnLine in Params then
      Memo.CenterScreenOnLine;
    FreeNotification(MemoSource);
    MemoSource.RegisterNotifier(OnSourceChange,False);
    UpdateCaption;

    If (spMakeTop in Params) or not Visible then
      Show;
  end;
end;

{---------------------------------}

procedure HideMemoSource(MemoSource:TCustomMemoSource);
Var
  i:Integer;
begin
  for i:=ScreenFormCount-1 downto 0 do
    if ScreenForms(i) is TEditForm then
      TEditForm(ScreenForms(i)).RemoveSource(MemoSource);
end;

{---------------------------------}

procedure UpdateStatusBar(StatusBar:TStatusBar;Memo:TDCMemo;State:TMemoStates);
var
  AText : string;
begin
  With StatusBar,Memo do
  begin
    If (Panels.Count>0) and (msPositionChanged in State) then
      Panels[0].Text:=CurPosText;

    if (Panels.Count>2) and (msInsState in State) then
      Panels[2].Text:=cOverwrite[GetOverwrite];



    if (Panels.Count>1) then
    begin
      AText := '' ;
      if ReadOnly then
        AText := cReadOnly[true];
      if GetSource.Modified and (AText = '') then
        AText := cModified[true];
      if Panels[1].Text <> AText then
        Panels[1].Text := AText;

    end;
    if (msModifiedChanged in State) then
      IDEChanged;

  end;
end;


{---------------------------------}

procedure TEditForm.MemoStateChange(Sender: TObject;
  State: TMemoStates);
begin
  UpdateStatusBar(StatusBar1,TDCMemo(Sender),State);
end;

{-------------------------------------------------------------------------}

procedure TEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

{-------------------------------------------------------------------------}

procedure TEditForm.TabControlChange(Sender: TObject);
begin
  SourceFromPage(TabControl.TabIndex);
end;

{-------------------------------------------------------------------------}

procedure ViewNewEditWindow;
Var
  EditForm:TEditForm;
begin
  EditForm:=TEditForm(FindFormWithClass(EditFormClass));
  If EditForm=nil then
    exit;
  ShowMemoSource(EditForm.Memo.GetSource,[spMakeTop,spCreateNew]);
end;

{-------------------------------------------------------------}

procedure CallActiveSource(P:Pointer);
Var
  Source:TCustomMemoSource;
begin
  Source:=GetActiveSource;
  If Source<>nil then
  begin
    ShowMemoSource(Source,[spMakeTop]);
    CallMethod(Source,P);
  end;
end;

{-------------------------------------------------------------}

procedure EditFind;
begin
  CallActiveSource(@TCustomMemoSource.ShowSearchDialog);
end;

{-------------------------------------------------------------}

procedure EditReplace;
begin
  CallActiveSource(@TCustomMemoSource.ShowReplaceDialog);
end;


{-------------------------------------------------------------}

procedure EditSearchAgain;
begin
  CallActiveSource(@TCustomMemoSource.FindNext);
end;

{-------------------------------------------------------------}

procedure EditGotoLine;
begin
  CallActiveSource(@TCustomMemoSource.ShowGoToLineDialog);
end;

{-------------------------------------------------------------}

procedure SourceIsActive(Var VerbStates:TVerbStates);
begin
  If GetActiveSource=nil then
    Exclude(VerbStates,vsEnabled);
end;

{-------------------------------------------------------------}
//BeginSkipConst
const
  VerbArray:Array[0..4] of TVerbData=(
    (Name:'Edit.Find';             GetState:SourceisActive;Execute:EditFind),
    (Name:'Edit.Replace';          GetState:SourceisActive;Execute:EditReplace),
    (Name:'Edit.SearchAgain';      GetState:SourceisActive;Execute:EditSearchAgain),
    (Name:'Edit.GotoLine';         GetState:SourceisActive;Execute:EditGotoLine),
    (Name:'View.NewEditWindow';    GetState:SourceisActive;Execute:ViewNewEditWindow));
//EndSkipConst
{-------------------------------------------------------------------------}

procedure _Register;
begin
//  RegisterOptionExt(TMemoEnvOptions);
  RegisterVerbArray(VerbArray);
end;

{-------------------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
end;

{-------------------------------------------------------------------------}

initialization
  RunRegister;
finalization
end.
