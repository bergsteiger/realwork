unit eePara;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: eePara -        }
{ Начат: 12.02.2003 18:12 }
{ $Id: eePara.pas,v 1.18 2015/01/19 18:36:39 lulin Exp $ }

// $Log: eePara.pas,v $
// Revision 1.18  2015/01/19 18:36:39  lulin
// {RequestLink:580710025}
//
// Revision 1.17  2014/12/05 14:51:03  kostitsin
// {requestlink: 570118718 } - eeInterfaces
//
// Revision 1.16  2014/04/25 15:58:48  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.15  2014/04/10 13:09:47  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.14  2014/04/09 13:12:08  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.13  2014/04/07 17:57:06  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.12  2014/04/04 17:53:42  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.11  2014/04/03 17:10:31  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.10  2014/03/28 12:15:32  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.9  2014/03/20 12:23:58  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.8  2014/03/18 15:57:05  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.7  2014/03/04 13:16:54  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.6  2013/10/21 15:43:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.5  2013/10/21 10:30:51  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.4  2012/04/26 11:38:26  lulin
// {RequestLink:361400131}
//
// Revision 1.3  2012/03/19 13:37:39  lulin
// {RequestLink:342860007}
//
// Revision 1.2  2010/11/16 09:02:20  dinishev
// [$234357754]
//
// Revision 1.1  2010/04/21 16:52:40  lulin
// {RequestLink:144575972}.
// - переходим к абсолютным путям для включаемых файлов.
//
// Revision 1.2  2010/02/11 13:45:33  lulin
// - выкидываем неудавшийся фасад.
//
// Revision 1.1  2009/09/14 11:28:08  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.63  2009/07/23 13:42:13  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.62  2009/07/23 08:14:42  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.61  2009/06/25 12:57:33  lulin
// - вычищаем ненужный контекст.
//
// Revision 1.60  2009/04/06 17:51:28  lulin
// [$140837386]. №11.
//
// Revision 1.59  2009/03/25 15:57:37  lulin
// [$136937722]. Делаем возможность искать версионные комментарии.
//
// Revision 1.58  2009/03/04 13:32:52  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.57  2009/03/03 17:42:02  lulin
// - <K>: 137470629. Убран ненужный промежуточный модуль.
//
// Revision 1.56  2008/12/12 19:19:17  lulin
// - <K>: 129762414.
//
// Revision 1.55  2008/06/20 14:48:54  lulin
// - используем префиксы элементов.
//
// Revision 1.54  2008/06/20 14:02:47  lulin
// - используем префиксы элементов.
//
// Revision 1.53  2008/06/09 12:16:51  lulin
// - bug fix: не собирался Немезис.
//
// Revision 1.52  2007/12/04 12:47:33  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.50.4.17  2007/09/14 13:26:09  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.50.4.16.2.1  2007/09/12 19:56:50  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.50.4.16  2007/09/11 18:50:00  lulin
// - удален ненужный параметр.
//
// Revision 1.50.4.15  2007/02/16 17:54:08  lulin
// - избавляемся от стандартного строкового типа.
//
// Revision 1.50.4.14  2006/06/22 09:19:24  lulin
// - cleanup: вычищены устаревшие методы.
//
// Revision 1.50.4.13  2006/06/22 08:06:03  lulin
// - bug fix: при удалении комментария не сбрасывалось выделение (CQ OIT5-19367).
//
// Revision 1.50.4.12  2006/04/24 09:29:45  oman
// - new beh: перевод на обобщенный механизм поиска ближайшего
//  листьевого параграфа
//
// Revision 1.50.4.11  2006/03/30 11:49:24  lulin
// - cleanup: вытираем код для редактирования комментариев не в виде дерева.
//
// Revision 1.50.4.10  2005/11/21 09:56:57  lulin
// - удален ненужный глобальный метод.
//
// Revision 1.50.4.9  2005/11/09 15:28:27  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.50.4.8  2005/11/04 16:48:00  lulin
// - базовый объект теперь поддерживает свое удаление.
//
// Revision 1.50.4.7  2005/10/28 08:57:05  mmorozov
// new: const cee_UndefenedParaID;
//
// Revision 1.50.4.6  2005/09/15 13:37:01  lulin
// - bug fix: комментарии после SBS не записывались в базу.
//
// Revision 1.50.4.5  2005/09/15 13:08:53  lulin
// - по типу параграфа решаем какой интерфейс обертки создавать.
//
// Revision 1.50.4.4  2005/07/15 12:41:59  lulin
// - теперь процеесор операций знает не про безликого Owner'а, а про вполне конкретный DocumentContainer.
//
// Revision 1.50.4.3  2005/07/15 10:14:05  lulin
// - избавляемся от использования самостийной функции преобразования интерфейсов.
//
// Revision 1.50.4.2  2005/06/06 15:36:12  lulin
// - продолжаем бороться со знанием о природе реализации курсоров.
//
// Revision 1.50.4.1  2005/05/18 12:42:49  lulin
// - отвел новую ветку.
//
// Revision 1.48.2.1  2005/04/28 09:18:32  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.49.2.1  2005/04/23 16:07:28  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.49  2005/04/21 05:11:41  lulin
// - используем _Box (пока из-за постоянных преобразований туда и обратно - по скорости стало только хуже).
//
// Revision 1.48  2005/03/30 11:56:24  lulin
// - bug fix: не удалялся комментарий из документа, который лежит в кеше (CQ OIT5-13060).
//
// Revision 1.47  2005/03/28 11:32:10  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.46  2005/03/24 14:10:34  lulin
// - удалены ненужные методы.
//
// Revision 1.45  2005/03/21 16:28:19  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.44  2005/03/21 06:44:56  lulin
// - убраны ненужные методы.
//
// Revision 1.43  2005/03/19 16:39:54  lulin
// - спрятаны ненужные методы.
//
// Revision 1.42  2005/03/17 17:57:05  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.41  2005/03/16 17:04:23  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.40  2005/03/16 12:16:55  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.39  2005/03/10 11:35:12  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.38  2005/03/09 18:40:22  lulin
// - remove method: Tk2AtomR.DeleteChild.
// - new method: _Ik2Tag.DeleteChild.
//
// Revision 1.37  2005/01/27 08:42:07  lulin
// - new behavior: не показываем операции с коментариями в контекстном меню, если они недоступны пользователю.
//
// Revision 1.36  2004/11/17 17:32:06  lulin
// - окончательно починена синхронизация вставки/удаления комментариев, отъехавшая в связи с переходом на блоки.
//
// Revision 1.35  2004/11/16 09:14:16  lulin
// - new behavior: учитываем, что комментарии теперь "живут" в особом блоке.
//
// Revision 1.34  2004/11/11 17:35:24  lulin
// - new behavior: для блока с комментарием сделано нормальное сохранение и рисование человечков на полях.
//
// Revision 1.33  2004/10/18 10:54:58  lulin
// - bug fix: AV при синхронизации удаления комментариев когда документ в кеше не показывался в окне редактора.
//
// Revision 1.32  2004/10/13 10:33:33  lulin
// - new behavior: синхронизируем удаление комментариев.
//
// Revision 1.31  2004/09/24 14:43:56  am
// change: вынес на интерфейс IeePara свойство IndexInParent
//
// Revision 1.30  2004/05/01 10:17:16  law
// - new behavior: свойства IeeLeafPara.Next, Prev - теперь представляют собой линейную структуру (CQ OIT5-5388).
//
// Revision 1.29  2004/04/08 19:19:41  law
// - optimization: убраны директивы stdcall.
//
// Revision 1.28  2004/02/03 15:04:10  law
// - bug fix: некорректно отдавался интерфейс IevHyperlink.
//
// Revision 1.27  2004/01/10 12:32:01  law
// - bug fix:  CQ OIT5-4347:
// demon (12.09.2003): Ошибка только в том, что эти вставленные параграфы оказываются не комментариями пользователя, а просто текстом.
// А вставлять, думаю можно....
//
// Revision 1.26  2004/01/09 15:34:04  law
// - new behavior: удаляем все параграфы, относящиеся к "одному" комментарию (CQ OIT5-5834).
//
// Revision 1.25  2004/01/06 14:20:34  law
// - bug fix: не учитывалась кодировка параграфа (CQ OIT5-5776).
//
// Revision 1.24  2003/12/29 16:11:18  law
// - new prop: IeePara.Marks.
//
// Revision 1.23  2003/12/04 10:42:26  law
// - new method version: _IeeStyledLeafPara.IsComment.
//
// Revision 1.22  2003/12/04 10:10:28  law
// - bug fix: проверяем наличие детей у списка сегментов.
//
// Revision 1.21  2003/12/04 09:46:59  law
// - new behavior: при проверке комментариев учитываем и сегменты тоже.
//
// Revision 1.20  2003/12/04 09:01:50  law
// - new method: _IeeStyledLeafPara.IsComment.
//
// Revision 1.19  2003/12/03 15:50:51  law
// - bug fix: не вызывалось событие OnUserCommentDelete, не исчезала иконка в SubPanel (CQ OIT5-4675).
//
// Revision 1.18  2003/11/05 14:51:44  law
// - new behavior: у IeePara теперь можно спросить интерфейс _IeePicture.
//
// Revision 1.17  2003/10/21 11:13:37  law
// - bug fix: TeeStyledLeafPara не поддерживал интерфейс _IeeStyledLeafPara.
//
// Revision 1.16  2003/10/20 16:02:04  law
// - change: начата поддержка "листьевых" параграфов.
// - new behavior: задел на неудаление параграфом (картинок в частности).
//
// Revision 1.15  2003/09/11 14:20:23  law
// - new method: IeePara.Delete.
//
// Revision 1.14  2003/09/11 13:32:30  law
// - new prop: TeeEditor.OnUserCommentDelete.
//
// Revision 1.13  2003/09/11 10:23:48  law
// - new method: IeePara.Next.
// - bug fix: не дописывался конец комментария.
//
// Revision 1.12  2003/09/10 18:08:04  law
// - new prop: TeeEditor.OnUserCommentChange.
//
// Revision 1.11  2003/09/10 17:37:21  law
// - new interface: IeeTextPara.
//
// Revision 1.10  2003/09/10 17:15:30  law
// - new prop: IeePara.Prev.
//
// Revision 1.9  2003/09/10 17:09:15  law
// - new method: TeePara.IndexInParent.
//
// Revision 1.8  2003/09/10 16:58:18  law
// - new method: IeePara.IsSame.
// - change: задел на отслеживание ухода с пользовательского комментария.
//
// Revision 1.7  2003/09/08 14:12:43  law
// - new method: TeeSubList.Make.
// - new prop: IeeDocument.Bookmarks.
//
// Revision 1.6  2003/09/02 12:26:25  law
// - new method: TeeHotSpot.Make.
//
// Revision 1.5  2003/09/02 11:58:12  law
// - new method: TeePara.Make.
//
// Revision 1.4  2003/09/01 16:35:05  law
// - new prop: IeePara.ID.
//
// Revision 1.3  2003/09/01 16:24:18  law
// - new prop: IeePara.Bookmarks.
//
// Revision 1.2  2003/04/18 09:30:59  law
// - new unit: eeBaseInterfaces.
//
// Revision 1.1  2003/02/12 15:29:17  law
// - new units.
//

{$Include evDefine.inc }

interface

uses
  Windows,

  l3Interfaces,
  l3Types,
  l3IID,
  l3Base,

  k2Interfaces,
  k2Base,

  nevBase,

  eeBaseInterfaces,
  eeInterfaces,
  eeInterfacesEx,
  eeTagEditorTool
  ;

type
  TeePara = class(TeeTagEditorTool, IeePara)
    protected
    // internal methods
      function Get_Document: IeeDocument;
        {-}
      function Get_Parent: IeePara;
        {-}
      function Get_Block: IeeBlock;
        {* - родительский блок. }
      function Get_Subs: IeeSubList;
        {-}
      function Get_Markers: IeeSubList;
        {-}
      function Get_Bookmarks: IeeSubList;
        {-}
      function Get_Marks: IeeSubList;
        {-}
      function Get_ID: Integer;
        virtual;
        {-}
      function Get_IndexInParent: Integer;
        {-}  
      function Get_Prev: IeePara;
        virtual;
        {-}
      function Get_Next: IeePara;
        virtual;
        {-}
      function TagOwner: Tl3Variant;
        {-}
      function IndexInParent: Integer;
        virtual;
        {-}
      function PredIndexInParent: Integer;
        virtual;
        {-}
      function SuccIndexInParent: Integer;
        virtual;
        {-}
    public
    // public methods
      class function Make(aTagWrap   : Tl3Variant;
                          const aDocument  : IeeDocumentEx;
                          const aProcessor : InevProcessor = nil): IeePara;
        reintroduce;
        {-}
      function IsKindOf(aType: Tk2Type): Boolean;
        {-}
      function IsSame(const aPara: IeePara): Boolean;
        reintroduce;
        {-}
      function Delete: Boolean;
        {-}
      function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
      function IsUserComment: Boolean;
        {-}
      function IsVersionComment: Boolean;
        {-}
  end;//TeePara

  TeeLeafPara = class(TeePara, IeeLeafPara)
    protected
    // inhernal methods
      function Get_Prev: IeePara;
        override;
        {-}
      function Get_Next: IeePara;
        override;
        {-}
  end;//TeeLeafPara

  TeeStyledLeafPara = class(TeeLeafPara, IeeStyledLeafPara)
    protected
    // interface methods
      // IeeStyledLeafPara
      function IsComment: Boolean;
        overload;
        {-}
      function IsComment(aType: TeeCommentType): Boolean;
        overload;
        {-}
    public
    // public methods
      class function Make(aTagWrap   : Tl3Variant;
                          const aDocument  : IeeDocumentEx;
                          const aProcessor : InevProcessor = nil): IeeStyledLeafPara;
        reintroduce;
        {-}
  end;//TeeStyledLeafPara

  TeeTextPara = class(TeeStyledLeafPara, IeeTextPara)
    protected
    // interface methods
      // IeeTextPara
      function Get_Text: Il3CString;
        {-}
  end;//TeeTextPara

  TeeParaList = class(TeePara)
  end;//TeeParaList

  TeeSBS = class(TeeParaList)
      function Get_ID: Integer;
        override;
        {-}
  end;//TeeSBS

const
  cee_UndefenedParaID = -1;
    {* - идентификатор параграфа не определен. }

implementation

uses
  SysUtils,

  l3InterfacesMisc,
  l3Chars,
  l3String,
  l3Variant,

  evdTypes,

  k2Tags,
  k2Except,
  k2OpMisc,

  evMsgCode,
  evdStyles,
  evParaTools,

  nevTools,

  eeSubList,
  eePicture,
  eeParaTools,

  SBS_Const,
  ParaList_Const,
  Document_Const,
  Block_Const,
  TextPara_Const,
  LeafPara_Const,
  StyledLeafPara_Const,
  BitmapPara_Const,
  CommentPara_Const
  ;

// start class TeePara

class function TeePara.Make(aTagWrap   : Tl3Variant;
                            const aDocument  : IeeDocumentEx;
                            const aProcessor : InevProcessor = nil): IeePara;
  //reintroduce;
  {-}
var
 l_Para : TeePara;
begin
 if (aTagWrap = nil) then
  Result := nil
 else
 begin
  if aTagWrap.IsKindOf(k2_typSBS) then
   l_Para := TeeSBS.Create(aTagWrap, aDocument, aProcessor)
  else 
  if aTagWrap.IsKindOf(k2_typParaList) then
   l_Para := TeeParaList.Create(aTagWrap, aDocument, aProcessor)
  else
   l_Para := Create(aTagWrap, aDocument, aProcessor);
  try
   Result := l_Para;
  finally
   l3Free(l_Para);
  end;//try..finally
 end;//aTagWrap = nil
end;

function TeePara.IsKindOf(aType: Tk2Type): Boolean;
  {-}
begin
 Result := TagInst.IsKindOf(aType);
end;

function TeePara.IsSame(const aPara: IeePara): Boolean;
  {-}
begin
 Result := l3IEQ(Self, aPara);
 if not Result then
  Result := TagInst.IsSame(aPara.AsObject);
end;

function TeePara.Delete: Boolean;
  {-}

 procedure DeletePrim;
 var
  l_Para : InevPara;
  l_Op   : InevOp;
 begin//DeletePrim
  if (TagInst <> nil) AND TagInst.QT(InevPara, l_Para, Processor) then
  begin
   l_Op := k2StartOp(Processor, ev_msgDeletePara);
   try
    Result := l_Para.Edit.Delete(False, l_Op);
    if Result AND (Document <> nil) then
     Document.Selection.Unselect;
   finally
    l_Op := nil;
   end;//try..finally
  end//TagInst <> nil
  else
   Result := false;
 end;//DeletePrim

begin
 DeletePrim;
end;

function TeePara.IndexInParent: Integer;
  {-}
var
 l_Para : InevPara;
begin
 if (TagInst = nil) then
  Result := -1
 else
  try
   if not TagInst.QT(InevPara, l_Para, Processor) then
    Assert(false);
   Result := l_Para.PID;
  except
   on Ek2ConversionError do
    Result := -1;
  end;//try..except
end;
  
function TeePara.PredIndexInParent: Integer;
  //virtual;
  {-}
begin
 Result := Pred(IndexInParent);
end;

function TeePara.SuccIndexInParent: Integer;
  //virtual;
  {-}
begin
 Result := Succ(IndexInParent);
end;

function TeePara.Get_Document: IeeDocument;
  {-}
begin
 Result := Document; 
end;

function TeePara.Get_Parent: IeePara;
  {-}
begin
 if (Document = nil) OR IsKindOf(k2_typDocument) OR (TagInst = nil) OR
    not TagOwner.IsValid then
  Result := nil
 else
  Result := TeePara.Make(TagOwner, Document, Processor);
end;

function TeePara.Get_Block: IeeBlock;
  {* - родительский блок. }
var
 l_Parent : Tl3Variant;
begin
 Result := nil;
 if not IsKindOf(k2_typDocument) then
 begin
  l_Parent := TagOwner.AsObject;
  while l_Parent.IsValid do
  begin
   with l_Parent do
    if IsKindOf(k2_typBlock) then
    begin
     if (Document = nil) then
     begin
      //Assert(false);
     end
     else
      Result := IeeDocument(Document).BlockEx[IntA[k2_tiHandle], IntA[k2_tiLayerID]];
     break;
    end
    else
     l_Parent := l_Parent.Owner;
  end;//while l_Parent.IsValid
 end;//not IsKindOf(k2_typDocument)
end;

function TeePara.Get_Subs: IeeSubList;
  {-}
begin
 Result := TeeSubList.Make(TagInst, Document, Ord(ev_sbtSub));
end;

function TeePara.Get_Markers: IeeSubList;
  {-}
begin
 Result := TeeSubList.Make(TagInst, Document, Ord(ev_sbtMarker));
end;

function TeePara.Get_Bookmarks: IeeSubList;
  {-}
begin
 Result := TeeSubList.Make(TagInst, Document, Ord(ev_sbtBookmark));
end;

function TeePara.Get_Marks: IeeSubList;
  {-}
begin
 Result := TeeSubList.Make(TagInst, Document, Ord(ev_sbtMark));
end;

function TeePara.Get_ID: Integer;
  {-}
begin
 with TagInst.Attr[k2_tiHandle] do
  if IsValid then
   Result := AsLong
  else
   Result := cee_UndefenedParaID;
end;

function TeePara.Get_Prev: IeePara;
  {-}
var
 l_Index : Integer;
begin
 l_Index := PredIndexInParent;
 if (l_Index >= 0) then
  Result := Make(TagOwner.Child[l_Index], Document, Processor)
 else
  Result := nil;
end;

function TeePara.Get_Next: IeePara;
  {-}
var
 l_Index : Integer;
begin
 l_Index := SuccIndexInParent;
 with TagOwner do
  if (l_Index >= 0) AND (l_Index < ChildrenCount) then
   Result := Make(Child[l_Index], Document, Processor)
  else
   Result := nil;
end;

function TeePara.TagOwner: Tl3Variant;
  {-}
begin
 if (TagInst = nil) then
  Result := k2NullTag
 else
  Result := TagInst.Owner; 
end;

function TeePara.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  //override;
  {-}
begin
 if IID.EQ(IeeTextPara) then
 begin
  if IsKindOf(k2_typTextPara) then
  begin
   Result.SetOk;
   IeeTextPara(Obj) := TeeTextPara.Make(TagInst, Document, Processor) As IeeTextPara;
  end
  else
   Result.SetNoInterface;
 end//IeeTextPara
 else
 if IID.EQ(IeeLeafPara) then
 begin
  if IsKindOf(k2_typLeafPara) then
  begin
   Result.SetOk;
   IeeLeafPara(Obj) := TeeLeafPara.Make(TagInst, Document, Processor) As IeeLeafPara;
  end
  else
   Result.SetNoInterface;
 end//IeeLeafPara
 else
 if IID.EQ(IeeStyledLeafPara) then
 begin
  if IsKindOf(k2_typStyledLeafPara) then
  begin
   Result.SetOk;
   IeeStyledLeafPara(Obj) := TeeStyledLeafPara.Make(TagInst, Document, Processor);
  end
  else
   Result.SetNoInterface;
 end//IeeStyledLeafPara
 else
 if IID.EQ(IeePicture) then
 begin
  if IsKindOf(k2_typBitmapPara) then
  begin
   Result.SetOk;
   IeePicture(Obj) := TeePicture.Make(TagInst, Document, Processor) As IeePicture;
  end
  else
   Result.SetNoInterface;
 end//IeePicture
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

function TeePara.IsUserComment: Boolean;
  {-}
begin
 if (TagInst = nil) then
  Result := false
 else
 begin
  if evInPara(TagInst, k2_typCommentPara) then
  // - это на тот случай, если мы сами блок
  begin
   Result := true;
   Exit;
  end;//evInPara(TagInst, k2_idCommentPara)
  with TagInst do
  begin
   with Attr[k2_tiStyle] do
    if IsValid then
     Result := (AsLong = ev_saUserComment)
    else
     Result := false;
  end;//TagInst
 end;//TagInst = nil
end;

function TeePara.IsVersionComment: Boolean;
  {-}
begin
 if (TagInst = nil) then
  Result := false
 else
  with TagInst do
  begin
   with Attr[k2_tiStyle] do
    if IsValid then
     Result := (AsLong = ev_saVersionInfo)
    else
     Result := false;
   if not Result then
    with rAtomEx([k2_tiSegments,
                k2_tiChildren, k2_tiHandle, Ord(ev_slView)]) do
     if IsValid AND (ChildrenCount > 0) then
      with Child[0] do
       if IsValid then
       begin
        with Attr[k2_tiStyle] do
         if IsValid then
          Result := (AsLong = ev_saVersionInfo)
         else
          Result := false;
       end;//IsValid
  end;//TagInst
end;

// start class TeeTextPara

function TeeTextPara.Get_Text: Il3CString;
  {-}
begin
 if (TagInst = nil) then
  Result := nil
 else
  Result := l3CStr(TagInst.PCharLenA[k2_tiText]);
end;

// start class TeeStyledLeafPara

class function TeeStyledLeafPara.Make(aTagWrap   : Tl3Variant;
                                      const aDocument  : IeeDocumentEx;
                                      const aProcessor : InevProcessor = nil): IeeStyledLeafPara;
  //reintroduce;
  {-}
begin
 Result := inherited Make(aTagWrap, aDocument, aProcessor) As IeeStyledLeafPara;
end;

function TeeStyledLeafPara.IsComment: Boolean;
  {-}
begin
 if (TagInst = nil) then
  Result := false
 else
  with TagInst do
  begin
   with Attr[k2_tiStyle] do
    if IsValid then
     Result := (AsLong = ev_saTxtComment) OR (AsLong = ev_saContents)
    else
     Result := false;
   if not Result then
    with rAtomEx([k2_tiSegments,
                k2_tiChildren, k2_tiHandle, Ord(ev_slView)]) do
     if IsValid AND (ChildrenCount > 0) then
      with Child[0] do
       if IsValid then
       begin
        with Attr[k2_tiStyle] do
         if IsValid then
          Result := (AsLong = ev_saTxtComment) OR (AsLong = ev_saContents)
         else
          Result := false;
       end;//IsValid
  end;//TagInst
end;

function TeeStyledLeafPara.IsComment(aType: TeeCommentType): Boolean;
  //overload;
  {-}
begin
 Case aType of
  ee_ctUsual:
   Result := IsComment;
  ee_ctUser:
   Result := IsUserComment;
  ee_ctVersion:
   Result := IsVersionComment;
  else
   Result := false;
 end;//Case aType
end;

// start class TeeLeafPara

function TeeLeafPara.Get_Prev: IeePara;
  //override;
  {-}
begin
 Result := eePrevOverallPara(Self, Document);
end;

function TeeLeafPara.Get_Next: IeePara;
  //override;
  {-}
begin
 Result := eeNextOverallPara(Self, Document);
end;

function TeePara.Get_IndexInParent: Integer;
begin
 Result := IndexInParent;
end;

// start class TeeSBS

function TeeSBS.Get_ID: Integer;
  //override;
  {-}
begin
 Result := 0;
 with TagInst.Child[0].Child[0].Child[0].Attr[k2_tiHandle] do
  if IsValid then
  begin
   Result := AsLong;
   Exit;
  end;//IsValid
 with TagInst.Child[0].Child[1].Child[0].Attr[k2_tiHandle] do
  if IsValid then
  begin
   Result := AsLong;
   Exit;
  end;//IsValid
end;

end.

