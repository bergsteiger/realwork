unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OvcBase, afwControlPrim, afwBaseControl, afwControl,
  afwTextControlPrim, afwTextControl, vtPanel, nevControl,
  evEditorWindow, evMultiSelectEditorWindow, evCustomEditor,
  evEditorWithOperations, evCustomMemo, evMemo, StdCtrls, vtLabel, vtCtrls,
  vtSaveDialog, tcInterfaces, l3Interfaces, eeCheckBox,
  evCustomEditorWindowPrim, evCustomEditorWindowModelPart,
  evCustomEditorModelPart;

type
  TfmMain = class(TForm)
    TopPanel: TvtPanel;
    BottomPanel: TvtPanel;
    ResultsMemo: TevMemo;
    SourceLabel: TvtLabel;
    TargetLabel: TvtLabel;
    RunBtn: TButton;
    NewEdit: TvtComboBox;
    SourceEdit: TvtComboBox;
    SourceBtn: TButton;
    NewBtn: TButton;
    OpenDialog: TOpenDialog;
    ClearBtn: TButton;
    SourceCheck: TeeCheckBox;
    NewCheck: TeeCheckBox;
    procedure SourceBtnClick(Sender: TObject);
    procedure NewBtnClick(Sender: TObject);
    procedure RunBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    f_SomePrinted: Boolean;
    f_FullToolBarDesc: Il3CString;
    f_ShortToolBarDesc: Il3CString;
    f_ChildToolBarPrefix: Il3CString;
    f_EditableMap: array[Boolean] of Il3CString;
    f_OperationPrefix: Il3CString;
    f_OperationDesc: Il3CString;
    f_BecomeEditableStr: Il3CString;
    f_RevokeEditableStr: Il3CString;
    f_AddedToolBarPrefix: Il3CString;
    f_DeletedToolBarPrefix: Il3CString;
    f_AddedOperationPrefix: Il3CString;
    f_DeletedOperationPrefix: Il3CString;
    f_RenamedDesc: Il3CString;
    f_Sorter: Il3StringsEx;
    procedure SelectFile(const aTarget: TvtComboBox; const aTitle: String);
    procedure PrintAdded(const aList: ItcAddedToolBarsList);
    procedure PrintChanged(const aList: ItcChangedToolBarsList);
    procedure PrintChildToolBars(const aList: ItcToolBarsList; const aTitle: Il3CString);
    procedure PrintOperations(const aList: ItcOperationsList; const aTitle: Il3CString);
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses
 l3Base,
 l3Chars,
 l3String,
 l3VCLStrings,

 tcBuilder,
 tcDifference
 ;

procedure TfmMain.SourceBtnClick(Sender: TObject);
begin
 SelectFile(SourceEdit,'Выберите изначальный файл')
end;

procedure TfmMain.NewBtnClick(Sender: TObject);
begin
 SelectFile(NewEdit,'Выберите обновленный файл')
end;

procedure TfmMain.SelectFile(const aTarget: TvtComboBox; const aTitle: String);
begin
 with OpenDialog do
 begin
  Title := aTitle;
  FileName := '';
  if Execute then
   aTarget.Text := FileName;
 end;
end;

procedure TfmMain.RunBtnClick(Sender: TObject);
var
 l_Source: ItcToolBarsList;
 l_New: ItcToolBarsList;
 l_Added: ItcAddedToolBarsList;
 l_Changed: ItcChangedToolBarsList;
begin
 with ResultsMemo do
 begin
  TextSource.New;
  InsertBuf(l3CStr('Сравнение файлов с описанием тулбаров:'+cc_EOL));
  InsertBuf(l3CStr(Format('  Изначальный файл - %s'+cc_EOL,[SourceEdit.Text])));
  InsertBuf(l3CStr(Format('  Обновленный файл - %s'+cc_EOL,[NewEdit.Text])));
  InsertBuf(l3CStr(cc_EOLStr));
  try
   if not FileExists(SourceEdit.Text) then
   begin
    InsertBuf(l3CStr(Format('Файл %s не найден'+cc_EOL,[SourceEdit.Text])));
    Exit;
   end;
   if not FileExists(NewEdit.Text) then
   begin
    InsertBuf(l3CStr(Format('Файл %s не найден'+cc_EOL,[NewEdit.Text])));
    Exit;
   end;
   if SourceEdit.Text = NewEdit.Text then
   begin
    InsertBuf(l3CStr('Файлы идентичны'+cc_EOL));
    Exit;
   end;
   try
    l_Source := tcBuildToolbarList(SourceEdit.Text, SourceCheck.Checked);
   except
   on EEmptyToolBar do
    begin
     InsertBuf(l3CStr(Format('Нет тулбара для размещения операций. Возможно файл %s старого формата',[SourceEdit.Text])+cc_EOL));
     Exit;
    end;
   else
   begin
    InsertBuf(l3CStr(Format('В файле %s отсутствуют описания тулбаров',[SourceEdit.Text])+cc_EOL));
    Exit;
   end;
   end;
   try
    l_New := tcBuildToolbarList(NewEdit.Text, NewCheck.Checked);
   except
   on EEmptyToolBar do
    begin
     InsertBuf(l3CStr(Format('Нет тулбара для размещения операций. Возможно файл %s старого формата',[NewEdit.Text])+cc_EOL));
     Exit;
    end;
   else
   begin
    InsertBuf(l3CStr(Format('В файле %s отсутствуют описания тулбаров',[NewEdit.Text])+cc_EOL));
    Exit;
   end; 
   end;
   tcBuildDifference(l_Source, l_New, SourceCheck.Checked or NewCheck.Checked, l_Added, l_Changed);
   l_Source := nil;
   l_New := nil;
   f_SomePrinted := False;
   PrintAdded(l_Added);
   l_Added := nil;
   PrintChanged(l_Changed);
   l_Changed := nil;
   if not f_SomePrinted then
    InsertBuf(l3CStr('Файлы идентичны'+cc_EOL));
  finally
   InsertBuf(l3CStr(cc_EOLStr));
   InsertBuf(l3CStr('Сравнение закончено'+cc_EOL));
   InsertBuf(l3CStr(cc_EOLStr));
   l_Source := nil;
   l_New := nil;
   l_Added := nil;
   l_Changed := nil;
  end;
 end;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
 f_FullToolBarDesc := nil;
 f_EditableMap[False] := nil;
 f_EditableMap[True] := nil;
 f_ShortToolBarDesc := nil;
 f_ChildToolBarPrefix := nil;
 f_OperationPrefix := nil;
 f_OperationDesc := nil;
 f_BecomeEditableStr := nil;
 f_RevokeEditableStr := nil;
 f_AddedToolBarPrefix := nil;
 f_DeletedToolBarPrefix := nil;
 f_AddedOperationPrefix := nil;
 f_DeletedOperationPrefix := nil;
 f_RenamedDesc := nil;
 f_Sorter := nil;
 l3System.CheckClipboard;
end;

procedure TfmMain.ClearBtnClick(Sender: TObject);
begin
 ResultsMemo.Text := '';
end;

procedure TfmMain.PrintChanged(const aList: ItcChangedToolBarsList);
var
 l_IDX: Integer;
begin
 if aList.Count = 0 then
  Exit;
 if f_SomePrinted then
  ResultsMemo.InsertBuf(l3CStr(cc_EOLStr));
 f_SomePrinted := True;
 with ResultsMemo do
 begin
  InsertBuf(l3CStr('Измененные тулбары:'+cc_EOL));
  for l_IDX := 0 to aList.Count - 1 do
   with aList.ToolBar[l_IDX] do
   begin
    InsertBuf(l3Fmt(f_FullToolBarDesc, [ToolBar.Caption, f_EditableMap[ToolBar.Editable], ToolBar.ID]));
    case EditableChange of
     ecBecomeEditable: InsertBuf(f_BecomeEditableStr);
     ecRevokeEditable: InsertBuf(f_RevokeEditableStr);
    end;
    if not l3IsNil(OldCaption) then
     InsertBuf(l3Fmt(f_RenamedDesc,[OldCaption]));
    PrintChildToolBars(AddedChildren, f_AddedToolBarPrefix);
    PrintChildToolBars(DeletedChildren, f_DeletedToolBarPrefix);
    PrintOperations(AddedOperations, f_AddedOperationPrefix);
    PrintOperations(DeletedOperations, f_DeletedOperationPrefix);
   end;
 end;
end;

procedure TfmMain.PrintAdded(const aList: ItcAddedToolBarsList);
var
 l_IDX: Integer; 
begin
 if aList.Count = 0 then
  Exit;
 f_SomePrinted := True;
 with ResultsMemo do
 begin
  InsertBuf(l3CStr('Новые тулбары:'+cc_EOL));
  for l_IDX := 0 to aList.Count - 1 do
   with aList.ToolBar[l_IDX].ToolBar do
   begin
    InsertBuf(l3Fmt(f_FullToolBarDesc,[Caption, f_EditableMap[Editable], ID]));
    PrintChildToolBars(ChildToolBars, f_ChildToolBarPrefix);
    PrintOperations(Operations, f_OperationPrefix);
   end;
 end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
 l_List: Tl3Strings;
begin
 f_FullToolBarDesc := l3CStr('  "%s"%s (%s)'+cc_EOL);
 f_EditableMap[False] := l3CStr(' НЕРЕДАКТИРУЕМЫЙ');
 f_EditableMap[True] := l3CStr('');
 f_ShortToolBarDesc := l3CStr('      "%s" (%s)'+cc_EOL);
 f_ChildToolBarPrefix := l3CStr('    Является источником настроек для:'+cc_EOL);
 f_OperationPrefix := l3CStr('    Содержит операции:'+cc_EOL);
 f_OperationDesc := f_ShortToolBarDesc;
 f_BecomeEditableStr := l3CStr('    Стал редактируемым'+cc_EOL);
 f_RevokeEditableStr := l3CStr('    Стал НЕРЕДАКТИРУЕМЫМ'+cc_EOL);
 f_AddedToolBarPrefix := l3CStr('    Стал источником настроек для:'+cc_EOL);
 f_DeletedToolBarPrefix := l3CStr('    Перестал быть источником настроек для:'+cc_EOL);
 f_AddedOperationPrefix := l3CStr('    Новые операции:'+cc_EOL);
 f_DeletedOperationPrefix := l3CStr('    Удаленные операции:'+cc_EOL);
 f_RenamedDesc := l3CStr('    Переименован из "%s"'+cc_EOL);
 l_List := Tl3Strings.MakeSorted;
 try
  f_Sorter := l_List;
 finally
  FreeAndNil(l_List);
 end;
end;

procedure TfmMain.PrintChildToolBars(const aList: ItcToolBarsList;
  const aTitle: Il3CString);
var
 l_IDX: Integer;
begin
 if aList.Count = 0 then
  Exit;
 f_SomePrinted := True;
 with ResultsMemo do
 begin
  InsertBuf(aTitle);
  f_Sorter.Clear;
  for l_IDX := 0 to aList.Count - 1 do
   with aList.ToolBar[l_IDX] do
    f_Sorter.Add(l3Fmt(f_ShortToolBarDesc, [Caption, ID]));
  for l_IDX := 0 to f_Sorter.Count - 1 do
   InsertBuf(f_Sorter.ItemC[l_IDX]);
 end;
end;

procedure TfmMain.PrintOperations(const aList: ItcOperationsList;
  const aTitle: Il3CString);
var
 l_IDX: Integer;
begin
 if aList.Count = 0 then
  Exit;
 f_SomePrinted := True;
 with ResultsMemo do
 begin
  InsertBuf(aTitle);
  f_Sorter.Clear;
  for l_IDX := 0 to aList.Count - 1 do
   with aList.Operation[l_IDX] do
    f_Sorter.Add(l3Fmt(f_OperationDesc, [Caption, ID]));
  for l_IDX := 0 to f_Sorter.Count - 1 do
   InsertBuf(f_Sorter.ItemC[l_IDX]);
 end;
end;

end.