unit InsDWin;

{$Include l3Define.inc}

{ $Id: INSDWIN.PAS,v 1.72 2015/11/25 14:01:28 lukyanets Exp $}

// $Log: INSDWIN.PAS,v $
// Revision 1.72  2015/11/25 14:01:28  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.71  2015/07/02 07:34:41  lukyanets
// Описываем словари
//
// Revision 1.70  2014/04/10 13:09:37  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.69  2014/04/07 17:56:21  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.68  2013/10/18 15:38:39  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.67  2012/10/29 16:55:34  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.66  2012/06/05 13:19:05  voba
// - убрал зоопарк инклюдов в опциями компиляции, оставил только ProjectDefine.inc
//
// Revision 1.65  2010/09/24 12:15:44  voba
// - k : 235046326
//
// Revision 1.64  2009/03/04 16:25:59  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.63  2008/11/27 08:28:26  dinishev
// Обобщаем код в модуле InsDWin
//
// Revision 1.62  2008/11/25 14:57:09  dinishev
// Bug fix: вернулась "порча" иерархии словарей комментариев  в Head'е - после переноса дерева на модель поменялись местами параметры
//
// Revision 1.61  2008/11/25 14:53:17  dinishev
// CleanUp
//
// Revision 1.60  2008/10/21 06:07:06  dinishev
// Bug fix: <K>: 121149989 - перестала компилироваться ветка.
//
// Revision 1.59  2008/10/20 14:13:39  lulin
// - работаем над <K>: 121149989.
//
// Revision 1.58  2008/10/13 13:33:56  dinishev
// <K> : 84640081
//
// Revision 1.57  2008/10/10 08:39:41  lulin
// - bug fix: в Архивариусе падала вставка комментариев.
//
// Revision 1.56  2008/10/09 11:26:39  dinishev
// Подготавливаемся к <K> : 89103144
//
// Revision 1.55  2008/10/08 11:07:25  lulin
// - избавляемся от ненужных зависимостей между интерфейсами.
//
// Revision 1.54  2008/06/17 11:50:10  dinishev
// По возможности вычищаем ARCHI_OLD_EVEREST
//
// Revision 1.53  2008/05/20 10:52:01  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.52  2008/04/23 09:52:42  lulin
// - <K>: 89105866.
//
// Revision 1.51  2008/04/15 17:14:32  lulin
// - автоматизируем переключение между версиями редактора.
//
// Revision 1.50  2008/04/15 08:38:26  dinishev
// Восстанавливаем старый редактор
//
// Revision 1.49  2008/04/14 07:04:17  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.48  2008/04/11 10:30:32  lulin
// - <K>: 89099090.
//
// Revision 1.47  2007/12/26 07:28:57  dinishev
// Bug fix: забытый параметр в HEAD - отъехала иерархия словарей в Арчи
//
// Revision 1.46  2007/12/26 00:09:43  lulin
// - модуль l3Tree_TLB полностью перенесен на модель.
//
// Revision 1.45  2007/12/03 09:53:24  dinishev
// Используем редактор из ветки
//
// Revision 1.44  2007/03/01 15:09:26  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.43  2006/12/24 14:13:44  lulin
// - текст ноды - теперь структура с длиной и кодовой страницей.
//
// Revision 1.42  2006/12/07 11:24:12  voba
// - remove l3Control, l3InputControl;
//
// Revision 1.41  2005/11/25 13:32:40  voba
// no message
//
// Revision 1.40  2005/07/25 13:06:45  lulin
// - исправлено имя класса компонента для записи EVD.
//
// Revision 1.39  2005/07/25 12:42:48  lulin
// - исправлено имя класса компонента для записи EVD.
//
// Revision 1.38  2005/06/15 15:02:41  fireton
// - bug fix: срезалось оформление при вставке evd-элементов
//
// Revision 1.37  2005/06/15 09:06:13  mmorozov
// change: TevTreeDataObject теперь работатет с TreeStruct;
//
// Revision 1.36  2005/06/15 08:55:42  lulin
// - bug fix: не компилировалось.
//
// Revision 1.35  2005/06/06 09:24:05  mmorozov
// change: TevTreeDataObject получает информацию используя Il3SimpleTree;
//
// Revision 1.34  2005/05/30 10:28:39  lulin
// - компонент "Заголовок" переехал в модуль с "правильным" названием.
//
// Revision 1.33  2005/05/27 14:44:18  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.32  2005/04/05 08:29:19  fireton
// - merge: слияние с веткой archi_evd_insert_dict
//
// Revision 1.31.4.1  2005/03/03 15:07:57  fireton
// - change: перевод словаря вставок в формат evd
//
// Revision 1.31  2005/01/11 09:19:03  voba
// no message
//
// Revision 1.30  2004/12/23 11:47:04  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.29  2004/12/17 11:48:52  fireton
// - вставлены директивы CVS
//

interface

uses
  Windows, 
  Messages, 
  SysUtils, 
  Classes, 
  Graphics, 
  Controls, 
  Forms, 
  Dialogs,
  ExtCtrls, 
  ComCtrls, 
  Menus, 
  StdCtrls, 
  Buttons, 

  DictMetaForm, 

  OvcBase,

  l3Tree_TLB,
  
  vtlister,
  vtOutliner, 
  vtStatusBar, 
  vtCtrls, 
  vtHeader, 
  
  evTextSource,
  evTextSourcePublished,

  afwControl, 
  afwInputControl, ActnList, afwControlPrim, afwBaseControl;

type                
  TInsertTextDictForm = class(TDictMetaForm)
   procedure FormDestroy(Sender: TObject);
   procedure DictOutlinerActionElement(Sender: TObject; Index: Integer);
   procedure OKClick(Sender: TObject);
  private
   InsertDictPath : string;
   { Private declarations }
   procedure AddItem;    override;
   procedure DeleteItem; override;
   procedure EditItem(aIndex : Longint);  override;
   procedure UpdateNodeData(aNode: Il3Node; aTextSource: TevTextSource);
  public
    { Public declarations }
   constructor Create(AOwner: TComponent; aShowMode : TDictShowMode);
   procedure LoadFromEVD(aFName : TFileName);
   procedure LoadFromOldFormat(aFName : TFileName);
  end;

 function GetInsTextNode(var aNode: Il3Node): Boolean;
 function GetInsText(var anInsText: string): Boolean;

implementation

{$INCLUDE ProjectDefine.inc}

{$R *.DFM}

uses     
 l3Tree, 
 l3Nodes,
 l3Base, 
 l3Types, 
 l3String, 
 l3Chars,
 l3IniFile,
 l3Filer, 
 l3Stream,
 
 StrShop, 
 IniShop,

 k2Base,
 k2Tags,
 k2Const,
 k2TagGen,
 k2Interfaces,

 evFacadeUtils,
 evCommonTypes,
 evParaDrawNode,
 evTreeGenerator,
 evEvdRd,
 evTxtRd,
 evdWriter,
 evTreeDataObject,
 evNodeUpdateGenerator,
 evInternalInterfaces,
 evTreeStorable,

 nevTools,
     
 dt_AttrSchema,
 DictsSup,

 Main,      
     
 vtDialogs,

 D_InsTextEdit,
     
 daTypes,
 daSchemeConsts,

 Dt_Serv,
 DT_Const,
 DT_Types,

 BtnDlg,

 Document_Const
 ;

constructor TInsertTextDictForm.Create(AOwner: TComponent; aShowMode : TDictShowMode);
var
 l_MaybeEvd: string;
begin
 inherited Create(AOwner, da_dlTextInsert, aShowMode);
 if ShowMode = dmShow then
  Caption := 'ВСТАВИТЬ КОММЕНТАРИЙ'
 else
  Visible := True;
 DictOutliner.CTree.CRootNode.Text := l3PCharLen('КОММЕНТАРИИ');

 MainForm.SetDictEditorEnable(da_dlTextInsert, False);

 if FileExists(IniRec.InsertDict) then
  InsertDictPath := IniRec.InsertDict
 else
  InsertDictPath := GlobalHtServer.FamilyTbl.FamilyPath(MainTblsFamily) + 'Insert.lst';

 l_MaybeEvd := ChangeFileExt(InsertDictPath, '.evd');
 if FileExists(l_MaybeEvd) then
 begin
  InsertDictPath := l_MaybeEvd;
  LoadFromEVD(InsertDictPath);
 end
 else
 begin
  LoadFromOldFormat(InsertDictPath);
  InsertDictPath := l_MaybeEvd;
 end; 

 DictOutliner.CTree.Modified := False;

 DictOutliner.ShowRoot := ShowMode = dmEdit;
end;

procedure TInsertTextDictForm.FormDestroy(Sender: TObject);
var
 l_Writer : TevdNativeWriter;
 l_Filer  : Tl3CustomFiler;
begin
 if DictOutliner.IsTreeAssign and DictOutliner.CTree.Modified then
 begin
  l_Writer := TevdNativeWriter.Create;
  try
   l_Filer := Tl3CustomDOSFiler.Make(InsertDictPath, l3_fmWrite);
   try
    l_Writer.Filer := l_Filer;
    evStoreTreeDataObject(l_Writer, DictOutliner.TreeStruct, k2_tiContentsLevel, 0);
   finally
    l3Free(l_Filer);
   end;//try..finally
  finally
   l3Free(l_Writer);                           
  end;//try..finally
 end;
end;

procedure TInsertTextDictForm.AddItem;
var
 CN      : Il3Node;
 NewNode : Il3Node;
 l_Dlg   : TInsTextEditDlg;
begin
 CN := DictOutliner.CurrentCNode; 
 l_Dlg := TInsTextEditDlg.Create(Application);
 try
  l_Dlg.Caption := 'Новый';
  if l_Dlg.Execute then
  begin
   NewNode := DictOutliner.CTree.InsertNode(CN, TevParaDrawNode.Make(k2NullTag));
   UpdateNodeData(NewNode, l_Dlg.TextSource);
  end;
 finally
  l_Dlg.Free;
 end;
end;      

procedure TInsertTextDictForm.LoadFromOldFormat(aFName : TFileName);
var
 G: Tk2TagGenerator;
begin
 if FileExists(aFName) then
 begin
  G := TevTreeGenerator.Create(DictOutliner.CTree.CRootNode, k2_tiFirstIndent);
  try
   (G as TevTreeGenerator).ZeroLevel := 1;
   TevCustomTxtReader.SetTo(G, aFName);
   with (G as TevCustomTxtReader) do
   begin
    PlainText := True;
    Tabs2FirstIndent := True;
    Execute;
   end; 
  finally
   l3Free(G);
  end; {try..finally}
 end; {if..}
end;


procedure TInsertTextDictForm.LoadFromEVD(aFName : TFileName);
var
 G: Tk2TagGenerator;
begin
 if FileExists(aFName) then
 begin
  G := TevTreeGenerator.Create(DictOutliner.CTree.CRootNode, k2_tiContentsLevel);
  try
   TevEvdReader.SetTo(G, aFName);
   (G as TevCustomEvdReader).Execute;
  finally
   l3Free(G);
  end; {try..finally}
 end; {if..}
end;

procedure TInsertTextDictForm.DeleteItem;
var
 CNode : Il3Node;
begin
 if ShowMode <> dmEdit then Exit;
 CNode := DictOutliner.CurrentCNode;
 if vtMessageDlg(l3Fmt(sidDelQst,[l3PCharLen2String(CNode.Text)]),
                   mtConfirmation, [mbYes,mbNo], 0) <> mrYes then Exit;
 Screen.Cursor := crHourglass;
 try
  CNode.Delete;
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TInsertTextDictForm.EditItem(aIndex : Longint);
var
 l_TreeDO      : IevTreeDataObject;
 l_CurrentNode : Il3Node;
 l_Dlg         : TInsTextEditDlg;
 G : TevGenerator;
begin
 l_CurrentNode := DictOutliner.CurrentCNode;
 l_Dlg := TInsTextEditDlg.Create(Application);
 try
  G := evGetNewTextGenerator(l_Dlg.TextSource);
  try
   G.Start;
   G.StartChild(k2_typDocument);
   if Supports(l_CurrentNode, IevTreeDataObject, l_TreeDO) then
   try
    l_TreeDO.Store(G, k2_tiVoid, 0);
   finally
    l_TreeDO := nil;
   end;
   G.Finish;
   G.Finish;
  finally
   evFreeGenerator(G);
  end;
  l_Dlg.Caption := 'Редактирование';
  if l_Dlg.Execute then
  begin
   UpdateNodeData(l_CurrentNode, l_Dlg.TextSource);
   DictOutliner.FullRedraw;
  end;
 finally
  l_Dlg.Free;
 end;
end;

procedure TInsertTextDictForm.DictOutlinerActionElement(Sender: TObject; Index: Integer);
begin
 case ShowMode of
  dmEdit : if Index > 0 then EditItem(Index);
  dmShow : ModalResult := mrOK;
 end;
end;

procedure TInsertTextDictForm.OKClick(Sender: TObject);
begin
 DictOutlinerActionElement(Sender, DictOutliner.Current);
end;

procedure TInsertTextDictForm.UpdateNodeData(aNode: Il3Node; aTextSource: TevTextSource);
var
 G: Tk2TagGenerator;  
begin
 G := TevNodeUpdateGenerator.Create(aNode);
 try
  evReadDataEX(aTextSource, G);
 finally
  l3Free(G);
 end;
end;            

function GetInsText(var anInsText: string): Boolean;
var
 l_CurrentNode : Il3Node;
begin
 Result := GetInsTextNode(l_CurrentNode);
 if Result then
  anInsText := l3PCharLen2String(l_CurrentNode.Text);
end;

function GetInsTextNode(var aNode: Il3Node): Boolean;
var
 l_CurrentNode : Il3Node;
begin
 aNode := nil;
 with TInsertTextDictForm.Create(MainForm, dmShow) do
  try
   Result := ShowModal = mrOk;
   if Result then
   begin
    l_CurrentNode := DictOutliner.CurrentCNode;
    try
     aNode := l_CurrentNode;
    except                                         
     Result := False;
    end;
   end;
  finally
   Free;
  end;
end;

end.

