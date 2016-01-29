unit D_TemplateEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, Buttons, ExtCtrls, OvcBase,
  afwControlPrim, afwBaseControl, afwControl, nevControl,
  evCustomEditorWindowPrim, evCustomEditorWindow,
  evCustomEditorWindowModelPart, evMultiSelectEditorWindow,
  evCustomEditorModelPart, evCustomEditor, evEditorWithOperations,
  evCustomMemo, evMemo, ActnList, Menus;

type
  TTemplateEditor = class(TBottomBtnDlg)
    memTemplateText: TevMemo;
    sbMacros: TSpeedButton;
    sbSave: TSpeedButton;
    ActionList: TActionList;
    acSave: TAction;
    pmMacros: TPopupMenu;
    subnum1: TMenuItem;                                                                                      
    subname1: TMenuItem;
    fromdoc1: TMenuItem;
    fromsubnum1: TMenuItem;
    fromsubname1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    cbSavedTemplates: TComboBox;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    subfname1: TMenuItem;
    fromsubfname1: TMenuItem;
    N10: TMenuItem;
    sbDelete: TSpeedButton;
    acDelete: TAction;
    procedure acDeleteExecute(Sender: TObject);
    procedure acSaveExecute(Sender: TObject);
    procedure cbSavedTemplatesSelect(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure InsertMacros(Sender: TObject);
    procedure memTemplateTextTextSourceTevMemo_memTemplateTextChangeModified(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure sbMacrosClick(Sender: TObject);
  private
    procedure DoInsertMacros(const aValue: AnsiString; aFrom: Integer = 0; aLen: Integer = 0);
    procedure ReloadSavedTemplates;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TemplateEditor: TTemplateEditor;

implementation

{$R *.dfm}

uses
 l3String,

 vtDialogs,
 
 evCommonTypes,
 evFacadeCursor,
 evFacadeSelection,
 evFacadeUtils,

 arTemplateProcessor;

procedure TTemplateEditor.acDeleteExecute(Sender: TObject);
var
 l_Idx : Integer;
 l_Name: AnsiString;
 l_TS: TarTemplateStorage;
begin
 l_Name := cbSavedTemplates.Text;
 if vtMessageDlg(l3Fmt('Вы действительно хотите удалить шаблон "%s"?', [l_Name]), mtConfirmation, [mbYes, mbNo]) = mrYes then
 begin
  l_TS := GetTemplateStorage;
  l_TS.DeleteSavedTemplate(l_Name);
  memTemplateText.Text := '';
  ReloadSavedTemplates;
 end;
end;

procedure TTemplateEditor.acSaveExecute(Sender: TObject);
var
 l_TS: TarTemplateStorage;
 l_Name: AnsiString;
begin
 l_Name := '';
 if vtInputQuery('Сохранение шаблона', 'Введите имя', l_Name) then
 begin
  l_TS := GetTemplateStorage;
  l_TS.SavedTemplate[l_Name] := memTemplateText.Text;
  ReloadSavedTemplates;
  cbSavedTemplates.ItemIndex := cbSavedTemplates.Items.IndexOf(l_Name);
  acDelete.Enabled := cbSavedTemplates.ItemIndex >= 0;
 end;
end;

procedure TTemplateEditor.cbSavedTemplatesSelect(Sender: TObject);
var
 l_TS: TarTemplateStorage;
begin
 l_TS := GetTemplateStorage;
 memTemplateText.Text := l_TS.SavedTemplate[cbSavedTemplates.Items[cbSavedTemplates.ItemIndex]];
 acDelete.Enabled := True;
end;

procedure TTemplateEditor.DoInsertMacros(const aValue: AnsiString; aFrom: Integer = 0; aLen: Integer = 0);
var
 l_Block: TnevIRange;
 l_InsPos: Integer;
 l_SelPos: Integer;
 l_SelStr: AnsiString;
 l_ToInsert: AnsiString;
begin
 l_Block  := evGetSel(memTemplateText);
 l_SelStr := evGetSelString(l_Block);
 l_SelPos := evGetMostInnerEntryPos(memTemplateText);
 l_InsPos := Pos('@', aValue);
 if l_InsPos = 0 then
  l_ToInsert := aValue
 else
 begin
  l_ToInsert := System.Copy(aValue, 1, l_InsPos-1) + l_SelStr + System.Copy(aValue, l_InsPos+1, MaxInt);
  if (aFrom > 0) or (aLen > 0) then
   if aFrom >= l_InsPos then
    aFrom := aFrom + Length(l_SelStr);
 end;

 EvInsertText2Memo(memTemplateText, l_Block, l_ToInsert);
 if (aFrom > 0) or (aLen > 0) then
  evAssignSelection(memTemplateText, l_SelPos + aFrom, aLen);
end;

procedure TTemplateEditor.FormShow(Sender: TObject);
begin
 inherited;
 ReloadSavedTemplates;
end;

procedure TTemplateEditor.InsertMacros(Sender: TObject);
var
 l_Idx: Integer;
begin
 l_Idx := TMenuItem(Sender).Tag;
 case l_Idx of
  1: DoInsertMacros('%subnum%');
  2: DoInsertMacros('%subname%');
  3: DoInsertMacros('%fromdoc%');
  4: DoInsertMacros('%fromsubnum%');
  5: DoInsertMacros('%fromsubname%');
  6: DoInsertMacros('%%значение%', 2, 8);
  7: DoInsertMacros('%subfname%');
  8: DoInsertMacros('%fromsubfname%');
 else
  Assert(False, 'Неверный макрос!');
 end;
end;

procedure TTemplateEditor.memTemplateTextTextSourceTevMemo_memTemplateTextChangeModified(Sender: TObject);
begin
 cbSavedTemplates.ItemIndex := -1;
 acDelete.Enabled := False;
end;

procedure TTemplateEditor.N10Click(Sender: TObject);
begin
 DoInsertMacros('[@|%fromreldoc%]');
end;

procedure TTemplateEditor.N4Click(Sender: TObject);
begin
 DoInsertMacros('[@|%fromdoc%.%fromsubnum%]');
end;

procedure TTemplateEditor.N5Click(Sender: TObject);
begin
 DoInsertMacros('[@|.%subnum%]', 3, 0);
end;

procedure TTemplateEditor.N6Click(Sender: TObject);
begin
 DoInsertMacros('[@|]', 3, 0);
end;

procedure TTemplateEditor.N8Click(Sender: TObject);
begin
 DoInsertMacros('%subname:род%');
end;

procedure TTemplateEditor.N9Click(Sender: TObject);
begin
 DoInsertMacros('%subname:вин%');
end;

procedure TTemplateEditor.ReloadSavedTemplates;
var
 l_TS : TarTemplateStorage;
begin
 l_TS := GetTemplateStorage;
 cbSavedTemplates.Items.BeginUpdate;
 try
  l_TS.FillListWithSavedTemplateNames(cbSavedTemplates.Items);
 finally
  cbSavedTemplates.Items.EndUpdate;
 end;
 acDelete.Enabled := False;
end;

procedure TTemplateEditor.sbMacrosClick(Sender: TObject);
var
 l_Point: TPoint;
begin
 l_Point.X := sbMacros.Left;
 l_Point.Y := sbMacros.Top + sbMacros.Height;
 l_Point := Panel1.ClientToScreen(l_Point);
 pmMacros.Popup(l_Point.X, l_Point.Y);
end;

end.
