unit main;

{ $Id: main.pas,v 1.13 2009/07/23 17:40:14 lulin Exp $ }

// $Log: main.pas,v $
// Revision 1.13  2009/07/23 17:40:14  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.12  2007/12/24 15:25:13  lulin
// - удалены ненужные файлы.
//
// Revision 1.11  2007/08/14 14:31:47  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.10  2005/05/27 14:44:34  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.9  2003/02/18 17:24:29  law
// - new project: cs.
//
// Revision 1.8  2002/09/18 12:52:01  law
// no message
//
// Revision 1.7  2002/08/02 08:18:25  law
// no message
//
// Revision 1.6  2002/03/13 15:36:16  law
// - new project: IndexOldCon.
//
// Revision 1.5  2002/03/05 16:36:31  law
// - new behavior: реализован простейший поиск по полной базе документов.
//
// Revision 1.4  2002/03/01 10:07:25  law
// - change type: IStorage -> Im3IndexedStorage.
//
// Revision 1.3  2002/01/09 15:07:30  law
// - new behavior: сделан вывод времени поиска.
//
// Revision 1.2  2002/01/08 08:33:19  law
// - сделана определенная подготовка для профайлинга поиска по названию.
//
// Revision 1.1  2001/12/25 13:15:32  law
// - _move projects: expr и sexpr в папку с проектами.
//
// Revision 1.9  2001/12/25 13:08:49  law
// - new unit: m4SearchExEx.
//
// Revision 1.8  2001/12/20 16:41:29  law
// - some cosmetics: сделано переключение цвета шрифта панели pnFooter.
//
// Revision 1.7  2001/12/20 16:35:52  law
// - some cosmetics: возможность задавать параметр командной строки - имя файла индекса.
//

interface

uses
  Windows, Messages, ActiveX, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, OvcBase,  evEdWnd, evEditor, evMemo, StdCtrls,
  m4SearchEx, l3InterfacedComponent;

type
  TMainForm = class(TForm)
    Memo: TevMemo;
    pnFooter: TPanel;
    OvcController1: TOvcController;
    btDoIt: TButton;
    outMemo: TevMemo;
    Splitter: TSplitter;
    OpenDialog: TOpenDialog;
    btOpen: TButton;
    btCheck: TButton;
    procedure btDoItClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btOpenClick(Sender: TObject);
    procedure btCheckClick(Sender: TObject);
  private
    { Private declarations }
    f_SearchEngine : Tm4SearchEngine;
    procedure CreateSearchEngine(const aName: String);
      {-}
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  l3Types,
  l3Chars,
  l3Base,
  l3String,

  m2COMLib,

  m3StorageInterfaces,
  m3StgMgr,

  m4Search,
  m4SearchFormula,
  m4SearchExEx,
  m4DocumentAddress,

  m4FoundSelector
  ;

{$R *.dfm}

procedure TMainForm.btDoItClick(Sender: TObject);
var
 l_Expr   : Tm4BaseExpression;
 l_Result : Tl3LongintList;
 l_Index  : Long;
 l_Op     : InevOp;
 l_Time   : TDateTime;
 l_Addresses : Tm4Addresses;
 l_Selector  : Tm4FoundSelector;
begin
 l_Expr := m4ParseSearchFormula(Memo.Buffer);
 try
  l_Time := Now;
  l_Addresses := nil;
  l_Result := f_SearchEngine.Search(l_Expr, @l_Addresses);
  try
   l_Time := Now - l_Time;
   // .. здесь выводим результат поиска
   Caption := TimeToStr(l_Time);
   with outMemo do begin
    l_Op := StartOp(0);
    try
     if l_Result.Empty then
      Text := 'Ничего не найдено.'
     else begin
      l_Selector := Tm4FoundSelector.Create(2, l_Addresses);
      try
      finally
       l3Free(l_Selector);
      end;//try..finally
      Text := '';
      with l_Result do begin
       if (Count <= 5000) OR
          (MessageDlg('Найдено ' + IntToStr(Count) + ' документов. Показать?',
                      mtConfirmation,
                      [mbYes, mbNo], 0) = mrYes) then
        for l_Index := Lo to Hi do
         InsertBuf(l3PCharLen(IntToStr(Items[l_Index])+cc_EOL));
      end;//with l_Result
     end;//l_Result.Empty
    finally
     l_Op := nil;
    end;//try..finally
   end;//with outMemo
  finally
   try
    l3Free(l_Result);
   finally
    l3Free(l_Addresses);
   end;//try..finally 
  end;//try..finally
 finally
  l3Free(l_Expr);
 end;//try..finally
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
 l3Free(f_SearchEngine);
end;

procedure TMainForm.CreateSearchEngine(const aName: String);
  {-}
var
 l_Storage      : Im3IndexedStorage;
 l_IndexStorage : Im3IndexedStorage;
begin
 try
  l_Storage := Tm3ReadModeStorageManager.MakeInterface(aName);
  try
   l3Free(f_SearchEngine);
   try
    l_IndexStorage := m2COMOpenStorage(l_Storage,
                                       'index',
                                       STGM_READ or STGM_SHARE_EXCLUSIVE,
                                       false) As Im3IndexedStorage;
   except
    l_IndexStorage := l_Storage;
   end;//try..except
   f_SearchEngine := Tm4SearchEngine.Create(l_IndexStorage);
   with pnFooter do begin
    Caption := aName;
    Font.Color := clWindowText;
   end;//with pnFooter
  finally
   l_Storage := nil;
  end;//try..finally
 except
  on E: Exception do
   if (f_SearchEngine = nil) then
    with pnFooter do begin
     Caption := 'Индекс не загружен : ' + E.Message;
     Font.Color := clRed;
    end;//with pnFooter
 end;//try..except
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 if (ParamCount > 0) then
  OpenDialog.FileName := ParamStr(1);
 if (ParamCount > 1) then
  Memo.Text := ParamStr(2); 
 CreateSearchEngine(OpenDialog.FileName);
end;

procedure TMainForm.btOpenClick(Sender: TObject);
begin
 with OpenDialog do
  if Execute then
   CreateSearchEngine(FileName);
end;

procedure TMainForm.btCheckClick(Sender: TObject);
var
 l_Expr   : Tm4BaseExpression;
begin
 l_Expr := m4ParseSearchFormula(Memo.Buffer);
 try
  if (l_Expr = nil) then
   outMemo.Text := 'Ошибка.'
  else
   outMemo.Text := l3ChangeCodePage(l_Expr.Evaluate, CP_OEM, CP_ANSI);
 finally
  l3Free(l_Expr);
 end;//try..finally
end;

end.
