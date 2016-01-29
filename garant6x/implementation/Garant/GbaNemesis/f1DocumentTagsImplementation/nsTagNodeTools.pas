unit nsTagNodeTools;

// $Id: nsTagNodeTools.pas,v 1.19 2015/09/14 12:13:17 dinishev Exp $

// $Log: nsTagNodeTools.pas,v $
// Revision 1.19  2015/09/14 12:13:17  dinishev
// {Requestlink:606809267}
//
// Revision 1.18  2014/04/21 17:21:27  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.17  2014/04/07 17:55:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.16  2014/04/04 17:53:37  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.15  2014/03/04 13:11:59  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.14  2012/02/08 12:04:07  lulin
// {RequestLink:330139802}
//
// Revision 1.13  2011/09/14 07:52:01  lulin
// {RequestLink:278824896}.
//
// Revision 1.12  2011/06/08 16:06:31  lulin
// {RequestLink:267326476}.
//
// Revision 1.11  2011/02/15 11:25:34  lulin
// {RequestLink:231670346}.
//
// Revision 1.10  2011/02/14 18:09:53  lulin
// {RequestLink:231670346}.
// - при всякого рода навигациях по тексту учитываем, что параграфы могут быть схлопнутыми.
//
// Revision 1.9  2011/01/12 10:03:50  lulin
// [$249340573].
// - восстановил функциональность.
//
// Revision 1.8  2011/01/11 14:51:56  lulin
// [$249340573].
// - добиваемся собираемости.
//
// Revision 1.7  2010/12/27 18:23:00  lulin
// {RequestLink:245204099}.
//
// Revision 1.6  2010/12/24 16:59:43  lulin
// {RequestLink:248195558}.
//
// Revision 1.5  2010/12/23 15:22:47  lulin
// {RequestLink:248195558}.
//
// Revision 1.4  2010/12/21 10:34:46  lulin
// {RequestLink:248187301}.
//
// Revision 1.3  2010/12/10 11:21:15  lulin
// {RequestLink:245204099}.
// - не учитывали последний элемент итератора.
//
// Revision 1.2  2010/12/03 16:53:59  lulin
// {RequestLink:245204099}.
//
// Revision 1.1  2010/11/23 12:38:51  lulin
// {RequestLink:238945411}.
// - выделяем отдельный и наводим порядок.
//
// Revision 1.3  2010/09/24 14:46:11  lulin
// {RequestLink:235055410}. №1.
//
// Revision 1.2  2010/09/22 12:10:13  lulin
// {RequestLink:235055410}. №2.
//
// Revision 1.1  2010/08/23 11:34:02  lulin
// {RequestLink:232100720}.
// - рисуем на модели ноду документа.
//
// Revision 1.2  2010/05/07 11:10:19  oman
// - new: {RequestLink:210043512}
//
// Revision 1.1  2009/12/01 17:31:08  lulin
// - контейнеры документов перенесены в правильное место.
//
// Revision 1.1  2009/09/14 11:28:55  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.57  2009/09/04 13:25:14  lulin
// {RequestLink:161120766}.
//
// Revision 1.56  2009/09/02 10:02:11  lulin
// {RequestLink:161120766}.
//
// Revision 1.55  2009/08/27 12:01:51  lulin
// {RequestLink:160006680}.
//
// Revision 1.54  2009/07/29 08:45:29  lulin
// {RequestLink:158336720}.
//
// Revision 1.53  2009/07/14 14:56:42  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.52  2009/07/13 12:31:46  lulin
// {RequestLink:141264340}. №23ac.
//
// Revision 1.51  2009/07/11 15:55:28  lulin
// {RequestLink:141264340}. №22.
//
// Revision 1.50  2009/06/29 10:52:11  lulin
// {RequestLink:154075236}. №3.
//
// Revision 1.49  2009/05/14 07:34:05  oman
// - new: Зачистка - [$147488842]
//
// Revision 1.48  2009/05/04 11:10:54  oman
// - new: Выпиливаем общий код - [$136939327]
//
// Revision 1.47  2009/05/04 10:56:09  oman
// - new: Пытаемся возвращатся - [$136939327]
//
// Revision 1.46  2009/03/31 12:00:57  lulin
// [$140286997].
//
// Revision 1.45  2008/11/11 11:23:34  lulin
// - <K>: 122672539.
//
// Revision 1.44  2008/10/30 15:09:15  lulin
// - <K>: 121159648.
//
// Revision 1.43  2008/10/08 15:32:50  lulin
// - вычищаем ссылку на ненужные данные.
//
// Revision 1.42  2008/05/28 07:58:11  lulin
// - <CQ>: 29146.
//
// Revision 1.41  2008/04/24 12:26:22  lulin
// - изменения в рамках <K>: 89106312.
//
// Revision 1.40  2008/04/15 11:00:41  lulin
// - правильно обрабатываем спрятанность параграфов.
//
// Revision 1.39  2008/04/15 08:24:04  lulin
// - передаём вью в качестве параметра.
//
// Revision 1.38  2008/04/14 15:42:07  lulin
// - bug fix: не собирался Немезис.
//
// Revision 1.37  2008/04/11 12:01:40  lulin
// - <K>: 89100701.
//
// Revision 1.36  2008/03/20 14:13:15  lulin
// - <K>: 87590293.
//
// Revision 1.35  2008/01/10 07:22:58  oman
// Переход на новый адаптер
//
// Revision 1.34.4.5  2007/12/05 12:43:46  oman
// Перепиливаем на новый адаптер - фабрики контейнеров
//
// Revision 1.34.4.4  2007/11/23 10:41:15  oman
// cleanup
//
// Revision 1.34.4.3  2007/11/22 14:20:26  oman
// Перепиливаем на новый адаптер
//
// Revision 1.34.4.2  2007/11/20 15:07:07  oman
// Перепиливаем на новый адаптер
//
// Revision 1.34.4.1  2007/11/20 13:16:17  oman
// Перепиливаем на новый адаптер
//
// Revision 1.34  2007/10/10 17:40:31  lulin
// - в метод подсчета суперпозиции сегментов теперь передаем карту форматирования.
//
// Revision 1.33  2007/09/07 13:23:39  oman
// - new: Дерево типов СКР для сабпанели получаем сразу с ноды, а не
//  с документа
//
// Revision 1.32  2007/05/17 12:04:18  oman
// cleanup
//
// Revision 1.31  2007/05/17 10:33:54  oman
// cleanup
//
// Revision 1.30  2007/04/18 12:16:14  oman
// - new: При поиске контекста пользуем FoundBlock - первое
//  приближение (cq22752)
//
// Revision 1.29  2007/03/30 11:04:29  oman
// Унифицируем способ формирования фильтра при контекстном
// поиске
//
// Revision 1.28  2007/02/02 08:39:03  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.27  2006/11/22 15:08:34  lulin
// - bug fix: при поиске не вседа показывали фразу целиком (CQ OIT5-23725).
//
// Revision 1.26  2006/11/03 09:45:43  oman
// Merge with B_NEMESIS_6_4_0
//
// Revision 1.25.2.2  2006/11/01 13:11:19  demon
// - change: изменен метод nsFindPathByID на nsCreateFilterForFindTagByID
//
// Revision 1.25.2.1  2006/10/31 14:04:05  demon
// - new: Выделен дополнительный метод nsFindPathByID
//
// Revision 1.25  2006/07/28 10:53:21  mmorozov
// - new: точность при поиска контекста (предложение, абзац, весь текст), CQ: 00021918;
//
// Revision 1.24  2006/07/06 11:08:45  lulin
// - при контекстном поиске открываем пачку операций - чтобы выделение не мерцало.
//
// Revision 1.23  2006/06/13 12:43:43  lulin
// - bug fix: искалось не точно в пределах выделенного текста (CQ OIT5-18758).
//
// Revision 1.22  2006/05/12 13:38:43  lulin
// - сделана возможность искать в выделении (CQ OIT5-20843).
//
// Revision 1.21  2006/05/06 12:27:49  lulin
// - new behavior: при поиске ставим курсор за первым найденным словом, а не за последним.
//
// Revision 1.20  2006/05/06 12:10:48  lulin
// - cleanup.
//
// Revision 1.19  2006/04/28 13:14:28  lulin
// - bug fix: неправильно вставлялись комментарии после контекстного поиска.
//
// Revision 1.18  2006/04/26 14:20:14  lulin
// - сделано указание места поиска контекста для базы без морфологии.
//
// Revision 1.17  2006/04/13 12:35:11  lulin
// - bug fix: поиск не начинался сначала (CQ OIT5-20449).
//
// Revision 1.16  2006/04/11 17:56:23  lulin
// - new behavior: не показываем найденный контекст, если он попадает в скрытый текст (CQ OIT5-20302).
//
// Revision 1.15  2006/04/11 15:53:27  lulin
// - изменена логика работы с итератором, в связи с изменением его поведения в адаптере.
//
// Revision 1.14  2006/04/11 15:34:04  lulin
// - new behavior: сделал показ дополнительных параметров поиска (CQ OIT5-20299).
//
// Revision 1.13  2006/04/10 14:41:29  lulin
// - bug fix: подавалась неправильная позиция курсора.
//
// Revision 1.12  2006/04/05 09:21:13  lulin
// - bug fix: неправильно подсвечивали найденные слова в автореферате, т.к. курсор строился не для документа, а для поддокумента.
//
// Revision 1.11  2006/04/04 16:42:05  lulin
// - bug fix: к ноде типизировали неправильный объект.
//
// Revision 1.10  2006/04/04 16:01:39  lulin
// - new behavior: подаем позицию - с которой надо продолжать поиск.
//
// Revision 1.9  2006/04/04 15:48:04  lulin
// - new behavior: подаем позицию - с которой надо начинать поиск.
//
// Revision 1.8  2006/03/31 09:16:45  lulin
// - new behavior: при контекстном поиске стараемся, чтобы и начало и конец блока были видны на экране.
//
// Revision 1.7  2006/03/29 13:43:59  lulin
// - вчерне подключен морфопоиск в документе.
//
// Revision 1.6  2006/03/28 13:12:30  lulin
// - инициализируем необходимые поля.
//
// Revision 1.5  2006/03/27 16:06:23  lulin
// - задаем область поиска.
//
// Revision 1.4  2006/03/27 15:33:28  lulin
// - cleanup.
//
// Revision 1.3  2006/03/27 15:17:43  lulin
// - добавлена функция, возвращающая итератор по контексту.
//
// Revision 1.2  2006/03/27 14:48:43  lulin
// - добавлена функция подсвечивания найденного контекста.
//
// Revision 1.1  2005/11/30 17:45:44  lulin
// - выделен утилитный модуль.
//

{$Include nsDefine.inc }

interface

uses
  l3Interfaces,
  l3TreeInterfaces,
  
  afwInterfaces,
  
  k2Interfaces,

  nevTools,

  DocTreeUnit,
  DynamicTreeUnit,

  nsTypes
  ;

function nsFindTagByNode(const aDocNode  : INodeBase;
                         const aNode     : INodeBase;
                         aDocument : Tl3Variant): Tl3Variant;
  {-}
function nsCreateFilterForFindTagByID(aType           : Integer;
                                      anID            : Integer): IFilterList;
  {-}
function nsIteratorToRange(const aDocument    : InevObject;
                           const anIter       : IFindIterator;
                           const aView        : InevSelectionView;
                           const anEnd        : InevBasePoint;
                           const aPosOnFirst  : Boolean;
                           const aCommentSwitcher: InevCommentSwitcher;
                           out theFoundBlock  : InevRange;
                           out theCaretPoint  : InevBasePoint): Boolean;
  {* - выделить найденные слова.
       aPosOnFirst:
        - устанавливать текущую позицию после первого найденного слова. Если
          пользователь ищет контекст во всем тексте SA_IN_ALL_TEXT, то
          позиционироваться нужно после последнего найденного слова. }
function nsFindBackToRange(const aDocument    : InevObject;
                           const anIter       : IFindIterator;
                           const aView        : InevSelectionView;
                           const anEnd        : InevBasePoint;
                           const aPosOnFirst  : Boolean;
                           const aCommentSwitcher: InevCommentSwitcher;
                           out theFoundBlock  : InevRange;
                           out theCaretPoint  : InevBasePoint): Boolean;
  {* - выделить найденные слова.
       aPosOnFirst:
        - устанавливать текущую позицию после первого найденного слова. Если
          пользователь ищет контекст во всем тексте SA_IN_ALL_TEXT, то
          позиционироваться нужно после последнего найденного слова. }
function nsGetFilteredCorrespondentsTypeTree(const aSub: IevSub): Il3SimpleNode;
  {* - Построить по ноде дерево типов корреспондентов }


implementation

uses
  SysUtils,

  l3Variant,
  
  k2Tags,

  nevBase,
  nevRangeList,
  evParaTools,
  evMultiSelectionBlock,

  vcmBase,

  DataAdapter,

  nsContextSearchParams,
  nsINodeWrap,
  
  nsTagNodeToolsNew,
  DocumentUnit,

  evdTypes
  ;

function nsCreateFilterForFindTagByID(aType           : Integer;
                                      anID            : Integer): IFilterList;
  {-}
var
 l_Filter: IDocNodeFilter;
begin
 l_Filter := defDataAdapter.NativeAdapter.MakeDocNodeFilter;
  l_Filter.SetType(aType);
  l_Filter.SetId(anID);
  l_Filter.SetInheritable(true);
 Result := defDataAdapter.NativeAdapter.MakeFilterList;
 Result.Add(l_Filter);
end;

function nsFindTagByNode(const aDocNode  : INodeBase;
                         const aNode     : INodeBase;
                         aDocument : Tl3Variant): Tl3Variant;
  {-}
var
 l_Path : INodeIndexPath;
begin//DoFind
 Result := nil;
 if (aDocNode <> nil) then
 begin
  aDocNode.FindNodePath(aNode, l_Path);
  Result := nsTagByPath(aDocument, l_Path, false);
 end;//aDocNode <> nil
end;//DoFind

function nsSelectByIterator(const aDocument: InevObject;
                            const anIter: IFindIterator;
                            const aView: InevSelectionView;
                            const anEnd: InevBasePoint;
                            const aProc: InevProcessor;
                            const aPosOnFirst: Boolean;
                            const aCommentSwitcher: InevCommentSwitcher;
                            out theFoundBlock: InevRange;
                            out theCaretPoint: InevBasePoint): Boolean;
var
 l_Poses  : IFindPositionList;
 l_Selected : TnevRangeList;
 l_Index  : Integer;
 l_Pos    : TFindPosition;
 l_Para   : InevPara;
 l_Start  : InevBasePoint;
 l_Finish : InevBasePoint;
begin
 Result := True;
 anIter.GetPosition(l_Poses);
 l_Selected := TnevRangeList.Make;
 try
  for l_Index := 0 to Pred(l_Poses.Count) do
  begin
   l_Poses.pm_GetItem(l_Index, l_Pos);
   if (l_Pos.rNode = nil) then
   begin
   // - это для ДРУГОЙ статьи толкового словаря
    Assert(false, 'По-моему это уже устарело');
    continue;
   end;//l_Pos.rNode = nil
   if not nsTagByPath(aDocument.AsObject, l_Pos.rNode, true).QT(InevPara, l_Para, aProc) then
    Assert(false);
   if EvExpandedText(l_Para.OwnerPara.AsObject) and aView.IsObjectCollapsed[l_Para.OwnerPara] then
    aView.IsObjectCollapsed[l_Para.OwnerPara] := false;
   if Assigned(aCommentSwitcher) and
      aView.FormatInfoByPara(l_Para).IsHidden(true, true) then
   begin
    if l_Para.IsLegalComment then
    begin
     if l_Para.IsComment then
      aCommentSwitcher.ShowComments := True
     else
     begin
      {$IfDef evNeedCollapsedVersionComments}
      aView.IsObjectCollapsed[l_Para] := false;
      {$Else evNeedCollapsedVersionComments}
      aCommentSwitcher.ShowVersionComments := True;
      {$EndIf evNeedCollapsedVersionComments}
     end;//l_Para.IsComment
    end//l_Para.IsLegalComment
    else
    //http://mdp.garant.ru/pages/viewpage.action?pageId=330139802
    if aView.IsObjectCollapsed[l_Para] then
     aView.IsObjectCollapsed[l_Para] := false;
     // - раскрываем "баллон"
   end;//Assigned(aCommentSwitcher)

   if aView.FormatInfoByPara(l_Para).IsHidden(true, true) then
    Result := false
   else
   begin
    l_Start := l_Para.MakePoint;
    l_Start.PositionW := l_Pos.rBegin;
    l_Finish := l_Para.MakePoint;
    l_Finish.PositionW := l_Pos.rEnd;
    l_Start := l_Start.PointToParent(aDocument);
    l_Finish := l_Finish.PointToParent(aDocument);
    if (anEnd <> nil) AND
       ((anEnd.Compare(l_Start) < 0) OR
        (anEnd.Compare(l_Finish) < 0)) then
     Result := false
    else
    begin
     l_Selected.Add(aDocument.Range(l_Start, l_Finish));
     // Запомним позицию первого или последнего слова:
     if not aPosOnFirst or (theCaretPoint = nil) then
      theCaretPoint := l_Finish;
    end;//anEnd <> nil
   end;//l_Para.Shape.IsHidden[true]
  end;//for l_Index
  if not l_Selected.Empty then
   theFoundBlock := TevMultiSelectionBlock.Make(aDocument.AsObject, l_Selected)
  else
   Result := false;  
 finally
  vcmFree(l_Selected);
 end;//try
end;


function nsIteratorToRange(const aDocument    : InevObject;
                           const anIter       : IFindIterator;
                           const aView        : InevSelectionView;
                           const anEnd        : InevBasePoint;
                           const aPosOnFirst  : Boolean;
                           const aCommentSwitcher: InevCommentSwitcher;
                           out theFoundBlock  : InevRange;
                           out theCaretPoint  : InevBasePoint): Boolean;
  {-}
var
 l_Proc   : InevProcessor;
 l_Op     : InevOp;
begin
 Result := false;
 theFoundBlock := nil;
 if (aView <> nil) AND (aView.Control <> nil) then
  l_Proc := aView.Control.Processor
 else
  l_Proc := nil;
 if (l_Proc = nil) then
  l_Op := nil
 else
  l_Op := l_Proc.StartOp;
 try
  if (anIter <> nil) then
   while not Result do
   begin
    theCaretPoint := nil;
    anIter.Next;
    Result := anIter.IsGood;
    if Result then
     Result := nsSelectByIterator(aDocument,
                                  anIter,
                                  aView,
                                  anEnd,
                                  l_Proc,
                                  aPosOnFirst,
                                  aCommentSwitcher,
                                  theFoundBlock,
                                  theCaretPoint)
    else
     break;
   end;//while not Result
 finally
  l_Op := nil;
 end;//try..finally
end;

function nsFindBackToRange(const aDocument    : InevObject;
                           const anIter       : IFindIterator;
                           const aView        : InevSelectionView;
                           const anEnd        : InevBasePoint;
                           const aPosOnFirst  : Boolean;
                           const aCommentSwitcher: InevCommentSwitcher;
                           out theFoundBlock  : InevRange;
                           out theCaretPoint  : InevBasePoint): Boolean;
  {-}
var
 l_Proc   : InevProcessor;
 l_Op     : InevOp;
begin
 Result := false;
 theFoundBlock := nil;
 if (aView <> nil) AND (aView.Control <> nil) then
  l_Proc := aView.Control.Processor
 else
  l_Proc := nil;
 if (l_Proc = nil) then
  l_Op := nil
 else
  l_Op := l_Proc.StartOp;
 try
  while not Result do
  begin
   theCaretPoint := nil;
   anIter.Prev;
   Result := anIter.IsGood;
   if Result then
    Result := nsSelectByIterator(aDocument,
                                 anIter,
                                 aView,
                                 anEnd,
                                 l_Proc,
                                 aPosOnFirst,
                                 aCommentSwitcher,
                                 theFoundBlock,
                                 theCaretPoint)
   else
    break;
  end;//while not Result
 finally
  l_Op := nil;
 end;//try..finally
end;

function nsGetFilteredCorrespondentsTypeTree(const aSub: IevSub): Il3SimpleNode;
  {* - Построить по ноде дерево типов корреспондентов }
var
 l_Root : INodeBase;
 l_EmptyTree : ByteBool;
 //l_DTN : IDocTagNode;
 l_DTP : IDocumentTextProvider;
 l_Para : Tl3Tag;
begin
 if (aSub.LayerID <> Ord(ev_sbtSub)) then
  Result := nil
 else
 begin
  l_Para := aSub.Para.Box;
(*  if Supports(l_Para, IDocTagNode, l_DTN) then
   try
    l_DTN.GetPrefixTree(l_Root, l_EmptyTree);
    if not l_EmptyTree then
    begin
     Assert(Assigned(l_Root));
     Result := TnsINodeWrap.Make(l_Root);
    end//l_EmptyTree
    else
     Result := nil;
   finally
    l_DTN := nil;
   end//try..finally
  else*)
  if l_Para.QI(IDocumentTextProvider, l_DTP) then
   try
    l_DTP.GetPrefixTree(aSub.ID, l_Root);
    if (l_Root = nil) then
     Result := nil
    else
     Result := TnsINodeWrap.Make(l_Root); 
   finally
    l_DTP := nil;
   end//try..finally
  else
   Result := nil;
 end;//aSub.LayerID <> ev_sbtSub
end;

end.
