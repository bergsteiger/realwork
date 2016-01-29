unit ddTuneTOCDialog;

// $Id: ddTuneTOCDialog.pas,v 1.38 2013/04/11 16:46:29 lulin Exp $ 

// $Log: ddTuneTOCDialog.pas,v $
// Revision 1.38  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.37  2012/02/17 09:28:21  kostitsin
// Переименовываем NumOfSelect в SelectedCount
//
// Revision 1.36  2008/03/21 14:09:22  lulin
// - cleanup.
//
// Revision 1.35  2008/03/20 09:48:29  lulin
// - cleanup.
//
// Revision 1.34  2008/02/20 17:22:59  lulin
// - упрощаем строки.
//
// Revision 1.33  2008/02/07 19:13:09  lulin
// - избавляемся от излишне универсальных методов базовых списков.
//
// Revision 1.32  2008/02/07 14:44:37  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.31  2008/02/05 09:58:00  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.30  2007/02/19 15:20:00  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.29  2006/12/24 13:33:40  lulin
// - текст ноды - теперь структура с длиной и кодовой страницей.
//
// Revision 1.28  2006/12/07 11:37:31  voba
// - remove l3Control, l3InputControl;
//
// Revision 1.27  2005/05/30 13:53:00  lulin
// - bug fix: не компилировалось.
//
// Revision 1.26  2005/05/27 14:42:34  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.25  2004/06/01 16:51:23  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.24  2004/03/15 15:45:57  narry
// - bug fix: лишняя точка после цифры
//
// Revision 1.23  2004/03/05 13:02:28  voba
// TCustomVLister -> TvtCustomLister
//
// Revision 1.22  2003/09/15 14:06:03  narry
// - bug fix: после удаления всех элементов списка кнопка "Удалить" оставалась активной, что приводило к ошибке
//
// Revision 1.21  2003/07/28 12:45:40  narry
// - update: после удаления нескольких элементов оглавления, подсветка перемещалась на произвольный элемент.
//
// Revision 1.20  2003/07/25 14:50:03  narry
// - update: обработка "неправильных" номеров статей (e.g. 12-1, 14.5)
//
// Revision 1.19  2003/04/19 12:30:38  law
// - new file: ddDefine.inc.
//
// Revision 1.18  2003/04/15 15:22:45  law
// - bug fix: не компилировался Эверест.
//
// Revision 1.17  2002/11/20 10:30:23  narry
// - update: поддержка изменения размеров
//
// Revision 1.16  2002/11/10 15:48:40  law
// - use directive: evNotArchi.
//
// Revision 1.15  2002/10/01 12:11:20  narry
// - update : автоматический посчет пунктов и статей, возможность редактирования текста пункта оглавления
//
// Revision 1.14  2002/03/14 13:53:18  narry
// - bug fix & update
//
// Revision 1.13  2002/02/12 14:35:11  narry
// - update: новый шаблон, три подуровня, отступы подуровней два пробела
//
// Revision 1.12  2001/10/31 08:04:44  narry
// - update: исправление и добавление текста, вставляемого в оглавление
//
// Revision 1.11  2001/09/28 11:22:37  narry
// - update: удалены ссылки на RX
//
// Revision 1.10  2001/09/28 07:11:28  narry
// - bug fix: были ошибки в курсоре для списка строк.
//
// Revision 1.9  2001/07/20 15:08:51  narry
// update : удлен временный объект с формы
//
// Revision 1.8  2001/07/20 07:35:19  narry
// -bug fix: удаление неправильных элементов в случае повторения
//    названий элементо
//
// Revision 1.7  2001/07/10 08:22:40  narry
// -update: восстановление функциональности по работе с выделением
//
// Revision 1.6  2001/07/05 12:33:22  narry
// -new behavior: замена RxListBox на vtlister
//
// Revision 1.5  2001/07/03 08:56:40  narry
// -update: замена стандартного компонента ListBox на компонент из
//    библиотеки Rx
//
// Revision 1.4  2001/06/21 15:40:39  law
// - new CVS directives: ID, Log.
//

{$I ddDefine.inc }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, l3Base,
  ddTOCTypes, OvcBase, vtLister, D_Base, ExtCtrls, vtStringLister,
  afwControl, afwInputControl,
  l3ObjectRefList,
  l3StringList
  ;

type
  TddTuneTOCDlg = class(TBaseDlg)
    TOCListBox: TvtStringLister;
    Label1: TLabel;
    cbAddBefore: TCheckBox;
    comboAddSpec: TComboBox;
    cbFindNearest: TCheckBox;
    cbInsertSubTOC: TCheckBox;
    PromoteButton: TButton;
    DemoteButton: TButton;
    DeleteButton: TButton;
    EditButton: TButton;
    procedure PromoteButtonClick(Sender: TObject);
    procedure DemoteButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure TOCLIstBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TOCListBoxGetStrItem(Sender: TObject; Index: Integer;
      var ItemString: AnsiString);
    procedure EditButtonClick(Sender: TObject);
    procedure TOCListBoxActionElement(Sender: TObject; Index: Integer);

  private
    { Private declarations }
    f_TOC: Tl3StringList;
    procedure SetTOC(Value: Tl3StringList);
    function GetTOCItems(Index: Integer): TddContentItem;
    function GetTOC: Tl3StringList;
  public
    { Public declarations }
    function Execute: Boolean;

    property TOC: Tl3StringList read GetTOC write SetTOC;
    property TOCItems[Index: Integer]: TddContentItem
      read GetTOCItems;
  end;

var
  ddTuneTOCDlg: TddTuneTOCDlg;


implementation

{$R *.DFM}

uses
  Math,

  l3String,
  l3LongintList,

  ddTOCItemDialog
  ;


procedure TddTuneTOCDlg.FormCreate(Sender: TObject);
begin
  f_TOC:= Tl3StringList.Make;
end;

procedure TddTuneTOCDlg.FormDestroy(Sender: TObject);
begin
  l3Free(f_TOC);
end;

function TddTuneTOCDlg.Execute: Boolean;
begin
  Result:= ShowModal = mrOk;
end;

function TddTuneTOCDlg.GetTOCItems(Index: Integer): TddContentItem;
begin
  Result:= TddContentItem(f_TOC.Items[index]);
end;

// Повышаем уровень выделенным элементам
procedure TddTuneTOCDlg.PromoteButtonClick(Sender: TObject);
  procedure _PromoteItem(Index: Integer);
  var
    l_CI: TddContentItem;
    l_S : AnsiString;
  begin
    l_CI:= TOCItems[Index];
    if l_CI.Level >= 2 then
    begin
      l_CI.Level:= l_CI.Level-1;
      l_S:= TOCListBox.Items.Strings[Index];
      System.Delete(l_S, 1, 3);
      TOCListBox.Items.Strings[Index]:= l_S;
    end;
  end;
var
  i: Integer;
begin
  if TOCListBox.SelectedCount > 0 then
  begin
    for i:= 0 to TOCListBox.Items.Count - 1 do
      if TOCListBox.Selected[i] then
        _PromoteItem(i);
  end
  else
    _PromoteItem(TOCListBox.Current);
  TOCListBox.Invalidate;
end;

//Понижаем уровень выделенным элементам
procedure TddTuneTOCDlg.DemoteButtonClick(Sender: TObject);

  procedure _DemoteItem(Index: Integer);
  var
    l_CI: TddContentItem;
    l_S : AnsiString;
  begin
    l_CI:= TOCItems[Index];
    if l_CI.Level <= 2 then
    begin
      l_CI.Level:= l_CI.Level+1;
      l_S:= TOCListBox.Items.Strings[Index];
      TOCListBox.Items.Strings[Index]:= '   '+ l_S;
    end;
  end;
var
  i: Integer;
begin
  if TOCListBox.SelectedCount > 0 then
  begin
    for i:= 0 to TOCListBox.Items.Count - 1 do
      if TOCListBox.Selected[i] then
        _DemoteItem(i);
  end
  else
    _DemoteItem(TOCListBox.Current);
  TOCListBox.Invalidate;
end;

procedure TddTuneTOCDlg.SetTOC(Value: Tl3StringList);
var
 i: Integer;
 l_TI: TddContentItem;
 l_Max: Integer;
 l_Type: TddContentType;
begin
 f_TOC.Assign(Value);
 TOCListBox.Items.Clear;
 l_Max:= 0;
 l_Type:= dd_ctNone;
 for i:= 0 to TOC.Hi do
 begin
  l_TI:= TddContentItem(TOC.Items[i]);
  TOCListBox.Items.Add(l_TI.AsString);
  if (l_Type = dd_ctNone) and (l_TI.ItemType in [dd_ctArticle, dd_ctPoint]) then
   l_Type:= l_TI.ItemType;
  l_Max:= Max(l_Max, Length(l_TI.StopNo));
 end;
 TOCListBox.Current:= 0;
 TOCListBox.Total:= f_TOC.Count;
 case l_Type of
  dd_ctArticle:
   if l_Max < 3 then
    comboAddSpec.ItemIndex:= 1
   else
    comboAddSpec.ItemIndex:= 2;
  dd_ctPoint  :
   if l_Max < 3 then
    comboAddSpec.ItemIndex:= 3
   else
    comboAddSpec.ItemIndex:= 4;
 else
  comboAddSpec.ItemIndex:= 0;
 end; 
end;


procedure TddTuneTOCDlg.DeleteButtonClick(Sender: TObject);
  procedure _Delete(Index: Integer);
  begin
    TOCListBox.Items.Delete(Index);
    TOC.Delete(Index);
  end;
var
 i: Integer;
 l_SelItems: Tl3LongintList;
 l_Cur: Integer;
begin
  if TOCListBox.SelectedCount > 0 then
  begin
   l_Cur:= -1;
   l_SelItems:= Tl3LongintList.Create;
   try
    for i:= 0 to  Pred(TOCListBox.Total) do
    begin
     if TOCListBox.Selected[i] then
     begin
      l_SelItems.Add(Longint(i));
      if l_Cur = -1 then
       l_Cur:= Pred(i);
     end;
    end;
    for i:= l_SelItems.Count-1 downto 0 do
     _Delete(Longint(l_SelItems.Items[i]));
    TOCListBox.Current:= Max(0, l_Cur); 
   finally
    l3Free(l_SelItems);
   end;
  end
  else
   _Delete(TOCListBox.Current);
  DeleteButton.Enabled:= TOCListBox.Items.Count <> 0;
  TOCListBox.Invalidate;
end;




procedure TddTuneTOCDlg.TOCLIstBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_DELETE: DeleteButtonClick(Sender);
    VK_LEFT  : begin
                if ssCtrl in Shift then
                 PromoteButtonClick(Sender);
                Key:= 0;
               end;
    VK_RIGHT : begin
                if ssCtrl in Shift then
                 DemoteButtonClick(Sender);
                Key := 0;
               end;
  end; //case
end;

procedure TddTuneTOCDlg.TOCListBoxGetStrItem(Sender: TObject;
  Index: Integer; var ItemString: AnsiString);
begin
 ItemString:= TddContentItem(TOC.Items[Index]).AsString;
end;

procedure TddTuneTOCDlg.EditButtonClick(Sender: TObject);
var
 S: AnsiString;
begin
 S:= l3Str(TOCListBox.Strings[TOCListBox.Current]);
 with TTOCItemEditDlg.Create(Application) do
 begin
  memoItemEdit.Text:= S;
  if Execute then
  begin
   TOCListBox.Items.Strings[TOCListBox.Current]:= memoItemEdit.Text;
   TOCItems[TOCListBox.Current].AsString:= memoItemEdit.Text;
   TOCListBox.Invalidate;
  end; // Execute
  Free;
 end; // with TTOCItemEditDlg
end;

procedure TddTuneTOCDlg.TOCListBoxActionElement(Sender: TObject;
  Index: Integer);
begin
 EditButtonClick(Sender);
end;

function TddTuneTOCDlg.GetTOC: Tl3StringList;
begin
  Result := f_TOC;
end;

end.
