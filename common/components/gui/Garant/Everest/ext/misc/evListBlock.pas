unit evListBlock;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evListBlock -   }
{ Начат: 25.09.2001 17:21 }
{ $Id: evListBlock.pas,v 1.96 2016/02/26 23:40:51 lulin Exp $ }

// $Log: evListBlock.pas,v $
// Revision 1.96  2016/02/26 23:40:51  lulin
// -- вычищаем.
//
// Revision 1.95  2016/02/09 14:18:40  lulin
// - перегенерация.
//
// Revision 1.94  2016/02/07 16:27:27  kostitsin
// - чиню сборку
//
// Revision 1.93  2014/07/30 14:26:52  lulin
// - рисуем фабрики интерфейсов.
//
// Revision 1.92  2014/07/22 13:52:51  lulin
// - готовимся к рисованию фабрик.
//
// Revision 1.91  2014/04/21 12:22:16  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.90  2014/04/11 15:30:35  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.89  2014/04/10 12:09:54  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.88  2014/04/07 17:57:02  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.87  2014/04/04 06:59:45  dinishev
// Bug fix: не собирался Арчи.
//
// Revision 1.86  2014/03/28 12:15:26  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.85  2014/03/28 06:14:17  dinishev
// Bug fix: не собиралось почити ничего.
//
// Revision 1.84  2014/03/25 06:16:26  dinishev
// Bug fix: не компилировалось.
//
// Revision 1.83  2014/03/18 17:56:34  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.82  2014/03/11 16:57:00  lulin
// - причёсываем код.
//
// Revision 1.81  2014/02/20 12:08:45  lulin
// - выкидываем ненужное.
//
// Revision 1.80  2013/04/24 09:35:37  lulin
// - портируем.
//
// Revision 1.79  2012/04/20 14:56:42  lulin
// {RequestLink:283610570}
//
// Revision 1.78  2011/05/17 14:54:28  lulin
// {RequestLink:266409354}.
//
// Revision 1.77  2010/07/28 08:57:51  fireton
// - переводим TnevStringListPara на Il3CStringList (строки терялись при поиске в списке)
//
// Revision 1.76  2010/04/12 14:53:48  lulin
// {RequestLink:203129570}.
// - убираем ненужный тип подитеративной функции.
//
// Revision 1.75  2009/09/09 14:09:40  dinishev
// [$162596088]
//
// Revision 1.74  2009/07/23 13:42:17  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.73  2009/07/14 14:56:38  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.72  2009/07/13 12:31:45  lulin
// {RequestLink:141264340}. №23ac.
//
// Revision 1.71  2009/07/11 15:55:15  lulin
// {RequestLink:141264340}. №22.
//
// Revision 1.70  2009/07/11 12:46:26  lulin
// {RequestLink:141264340}. №14.
//
// Revision 1.69  2009/07/10 16:15:44  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.68  2009/07/07 09:09:43  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.67  2009/04/15 11:14:06  lulin
// [$143396720]. Убираем лишний параметр из конструкторов и фабричных методов.
//
// Revision 1.66  2009/04/09 14:12:43  lulin
// [$140837386]. №15.
//
// Revision 1.65  2009/04/06 09:45:29  lulin
// [$140837386]. Убираем старорежимную примесь для списков параграфов.
//
// Revision 1.64  2009/03/05 13:09:42  lulin
// - <K>: 137470629. Используем ссылки на типы.
//
// Revision 1.63  2009/03/04 18:54:46  lulin
// - <K>: 137470629. Подготавливаемся к генерации ссылок на типы.
//
// Revision 1.62  2009/03/04 16:25:54  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.61  2008/09/17 15:04:08  lulin
// - переносим TnevTextPara на модель.
//
// Revision 1.60  2008/09/17 14:43:47  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.59  2008/09/16 13:05:15  lulin
// - переносим TnevParaList на модель.
//
// Revision 1.58  2008/06/18 11:30:55  lulin
// - добавлена схема документа для Архивариуса.
//
// Revision 1.57  2008/06/17 21:27:01  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.56  2008/06/10 14:38:35  lulin
// - храним ссылки на типы в полях таблицы тегов.
//
// Revision 1.55  2008/06/10 10:54:52  fireton
// - не компилировалось
//
// Revision 1.54  2008/06/09 06:11:00  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.53  2008/04/14 13:46:42  lulin
// - <K>: 89096854.
//
// Revision 1.52  2008/04/10 17:34:28  lulin
// - <K>: 89097983.
//
// Revision 1.51  2008/04/09 17:57:14  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.50  2008/03/05 11:23:52  dinishev
// Починка поиска в списках
//
// Revision 1.49  2008/02/12 12:53:01  lulin
// - избавляемся от излишнего метода на базовом классе.
//
// Revision 1.48  2008/02/07 19:13:00  lulin
// - избавляемся от излишне универсальных методов базовых списков.
//
// Revision 1.47  2008/02/07 16:19:17  lulin
// - наводим порядок с наследованием и перекрытием методов.
//
// Revision 1.46  2007/12/24 13:25:46  lulin
// - модуль l3InternalInterfaces полностью перенесен на модель.
//
// Revision 1.45  2007/12/04 12:47:45  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.40.4.10  2007/11/28 13:04:32  dinishev
// Не компилировалось
//
// Revision 1.40.4.9  2007/06/22 19:19:01  lulin
// - cleanup.
//
// Revision 1.40.4.8  2007/06/22 18:59:58  lulin
// - cleanup.
//
// Revision 1.40.4.7  2007/06/20 09:17:02  dinishev
// bug fix: не компилировалось
//
// Revision 1.40.4.6  2007/01/05 14:37:25  lulin
// - cleanup.
//
// Revision 1.40.4.5  2006/02/09 13:54:28  lulin
// - пока безуспешные попытки собрать Archi с Эверестом из ветки.
//                                                                         
// Revision 1.40.4.4  2006/02/08 18:18:53  lulin
// - пока безуспешные попытки собрать Archi с Эверестом из ветки.
//
// Revision 1.40.4.3  2006/01/16 14:28:23  lulin
// - cleanup.
//
// Revision 1.40.4.2  2005/05/26 15:35:02  lulin
// - базовая канва вывода теперь избавлена от знания о контролах управления.
//
// Revision 1.40.4.1  2005/05/18 12:42:54  lulin
// - отвел новую ветку.
//
// Revision 1.37.2.1  2005/04/28 09:18:37  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.39.2.1  2005/04/25 14:05:00  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.39  2005/04/20 17:40:55  lulin
// - избавился от промежуточного интерфейса Ik2TagBoxQT.
//
// Revision 1.38  2005/04/19 15:41:29  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.37  2005/04/06 09:21:52  lulin
// - bug fix: не компилировалось.
//
// Revision 1.36  2005/04/04 10:15:17  lulin
// - bug fix: из-за блядства Delphi с неосвобождением глобальных ссылок на интерфейсы оставались неосвобожденные объекты.
//
// Revision 1.35  2005/04/04 06:44:05  lulin
// - в связи с появлением механизма событий и фасада библиотеки K-2, удалены глобальные "заплатки" связанные с созданием/уничтожением таблицы тегов.
//
// Revision 1.34  2005/03/30 15:56:28  lulin
// - _TevLocation теперь наследуется от Tk2Tool - базового класса для инструментов тегов.
//
// Revision 1.33  2005/03/28 11:32:15  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.32  2005/03/25 17:09:09  lulin
// - избавляемся от метода Tk2AtomW.sLong.
//
// Revision 1.31  2005/03/21 13:43:01  lulin
// - убраны ненужные методы.
//
// Revision 1.30  2005/03/19 16:39:59  lulin
// - спрятаны ненужные методы.
//
// Revision 1.29  2005/03/16 12:16:57  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.28  2005/03/14 16:43:28  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.27  2005/03/14 10:00:39  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.26  2005/03/11 16:26:42  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.25  2005/03/04 15:49:07  lulin
// - спрятана процедура Tk2Type.New.
//
// Revision 1.24  2004/06/17 13:57:45  law
// - bug fix: курсоры не владели параграфами - соответственно были потенциальные ошибки, когда параграфы умирали, а курсоры нет.
// - bug fix: в результате переделок механизма поиска перестал работать поиск в выборке.
//
// Revision 1.23  2004/06/09 11:09:02  law
// - change: переходим к типу TevPair от пары параметров Start, Finish.
//
// Revision 1.22  2004/06/04 16:02:08  law
// - интерфейс _Il3StringList сделан наследником от _Il3List.
//
// Revision 1.21  2004/05/07 08:37:25  law
// - bug fix: не компилировалось, в связи с переходом на IevReplacer.
//
// Revision 1.20  2004/03/17 11:14:12  voba
// - bug fix: не работал поиск в списке
//
// Revision 1.19  2003/11/06 09:30:10  voba
// no message
//
// Revision 1.18  2003/02/18 14:12:56  voba
// - change.
//
// Revision 1.17  2003/01/20 13:03:05  law
// - cleanup: избавляемся от прямого использования ev_msgMove.
//
// Revision 1.16  2002/12/25 11:59:16  law
// - cleanup.
//
// Revision 1.15  2002/12/19 16:59:40  voba
// - bug fix.
//
// Revision 1.14  2002/12/19 16:57:18  voba
// - bug fix.
//
// Revision 1.13  2002/12/02 17:30:25  voba
// no message
//
// Revision 1.12  2002/07/10 08:27:00  voba
// -bug fix : не компилировался
//
// Revision 1.11  2002/07/09 12:02:24  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.10  2002/02/08 11:13:01  voba
// - rename classes: IevBlock -> TevBlock, IevCursor -> _TevCursor.
//
// Revision 1.9  2001/09/28 12:24:48  narry
// - bug fix: AV после выхода после поиска по листу.
//
// Revision 1.8  2001/09/28 11:49:26  law
// - bug fix: были перепутаны базы индексов.
//
// Revision 1.7  2001/09/28 09:04:14  law
// - bug fix: поиск в таблице, в соответствии с задачей №1101  (см. _TestSet\Table\3.evd).
//
// Revision 1.6  2001/09/28 07:31:38  law
// - new proc: evSearchList и evMakeListCursor.
//
// Revision 1.5  2001/09/28 07:11:30  narry
// - bug fix: были ошибки в курсоре для списка строк.
//
// Revision 1.4  2001/09/25 15:15:26  law
// - new behavior: дополнена функциональность TevListCursor.
//
// Revision 1.3  2001/09/25 14:57:45  law
// - new proc: новая версия функции evSearchList.
//
// Revision 1.2  2001/09/25 14:39:42  law
// - new proc: evSearchList.
//
// Revision 1.1  2001/09/25 14:22:14  law
// - new unit: evListBlock - блоки и курсоры для _Il3StringList.
//

{$Include evDefine.inc }

interface

uses
  l3IID,
  l3Types,
  l3Variant,
  l3InternalInterfaces,
  l3Base,
  l3Interfaces,
  l3Units,
  l3ProtoObject,

  k2Interfaces,
  k2Base,
  k2ToolPrim,

  evInternalInterfaces,
  evParaListCursor,
  evParaListCursorPair,
  //evStdInt,

  nevBase,
  nevTools,
  nevParaList,
  nevTextPara,

  evPara_InterfaceFactory
  ;

type
  TevListBlock = class(TevParaListCursorPair)
    protected
    // internal methods
      procedure ArrangeFoundCursors(anIndex       : Long;
                                    var theStart  : InevBasePoint;
                                    var theFinish : InevBasePoint);
        override;
        {-}
      function  DoIterateChildrenF(Action     : Mk2Children_IterateChildrenF_Action;
                                aStart      : Tl3Index;
                                aHi         : Tl3Index;
                                aLoadedOnly : Boolean): Long;
        override;
        {-}
      function  DoGetBlockLength: Long;
        override;
        {-}
  end;//TevListBlock

  TevListCursor = class(TevParaListCursor)
    protected
    // internal methods
      function  DoGetBlockLength: Long;
        override;
        {-}
      procedure DoSetEntryPoint(Value         : Long;
                              const Context : IevCursorContext = nil);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
  end;//TevListCursor

  TevListInterfaceFactory = class(TevParaInterfaceFactory)
    public
    {public methods}
      function  QueryTool(aTag: Tl3Variant; const ID: Tl3IID; out I: Tk2ToolPrim): Bool;
        override;
        {-}
      function COMQueryTool(aTag       : Tl3Variant;
                            const IID        : Tl3GUID;
                            out Tool         ;
                            const aProcessor : InevProcessor): Boolean;
        override;
        {-}
  end;//TevListInterfaceFactory

  TevGetItemEvent = function(anIndex: Long): Il3CString of object;

  TevStringList = class(Tl3ProtoObject, Il3CStringList)
    private
    // internal fields
      f_Count     : Long;
      f_OnGetItem : TevGetItemEvent;
    protected
    // property methods
      function  pm_GetCount: Long;
      procedure pm_SetCount(aValue: Long);
        {-}
      procedure Delete(anIndex: Long);
        {* - Удаляет элемент по индексу Index. }
      function pm_GetItems(anIndex: Long): Il3CString;
        {-}
      procedure Clear;
        {-}
    public
    // public methods
      constructor Create(OnGetItem : TevGetItemEvent;
                         aCount    : Long);
        reintroduce;
        {-}                 
  end;//TevStringList

  TnevStringListPara = class(TnevParaList)
  private
   f_StringList: Il3CStringList;
    {* - Источник строк для параграфа. }
  protected
   function  GetParaCount: TnevParaIndex;
    override;
     {-}
   function  GetPara(anIndex: TnevParaIndex): InevPara;
    override;
     {-}
   function  GetIndexOfObj(const aPara: InevObject): TnevParaIndex;
    override;
     {-}
   function  GetModify: InevParaListModify;
    override;
     {-}
   procedure Cleanup;
    override;
     {-}
   procedure InitFields;
    override;
     {-}
  end;

function evMakeListBlock(const aList: Il3CStringList): InevRange;
  {-}
function evMakeListCursor(const aList : Il3CStringList; aPos : Long = 1): InevBasePoint;
  {-}
function evSearchList(const aList     : Il3CStringList;
                      const aSearcher : IevSearcher;
                      const aCursor   : InevBasePoint = nil;
                      const aReplacer : IevReplacer = nil): InevBasePoint;
  overload;
  {-}
function evSearchList(OnGetItem       : TevGetItemEvent;
                      aCount          : Long;
                      const aSearcher : IevSearcher;
                      const aCursor   : InevBasePoint = nil;
                      const aReplacer : IevReplacer = nil): InevBasePoint;
  overload;
  {-}
function evSearchList(OnGetItem       : TevGetItemEvent;
                      aCount          : Long;
                      const aSearcher : IevSearcher;
                      aPos            : Long = 1;
                      const aReplacer : IevReplacer = nil): Long;
  overload;
  {-}

implementation

uses
  l3MinMax,
  l3String,

  k2Tags,
  k2Facade,
  k2ParentedTypedSmallLeafTag,
  k2IUnknownTag,
  
  evOp,
  evConst,
  evMsgCode,
  evCursorConst,
  evCursorTools,

  nevConfirm,
  nevStringItemPara,

  arList_Const,
  TextPara_Const
  ;

function evMakeListBlock(const aList: Il3CStringList): InevRange;
  {-}
var
 l_Tag  : InevObject;
 l_Prop : Tk2CustomPropertyPrim;
begin
 if (aList = nil) then
  Result := nil
 else
 begin
  if k2_typList.MakeTag.AsObject.QT(InevObject, l_Tag) then
  try
   with l_Tag do
   begin
    l_Prop := Tk2Type(TagType).Prop[k2_tiObject];
    AttrW[l_Prop.TagIndex, nil] := Tk2IUnknownTag.Make(aList).AsObject;
    Result := Range;
   end;//with l_Tag
  finally
   l_Tag := nil;
  end;//try..finally
 end;//aList = nil 
end;

function evMakeListCursor(const aList : Il3CStringList; aPos : Long = 1): InevBasePoint;
  {-}
var
 l_Block : InevRange;
begin
 l_Block := evMakeListBlock(aList);
 try
  Result := l_Block.Obj.MakePoint;
  Result.PositionW := aPos;
 finally
  l_Block := nil;
 end;//try..finally
end;

function evSearchList(const aList     : Il3CStringList;
                      const aSearcher : IevSearcher;
                      const aCursor   : InevBasePoint = nil;
                      const aReplacer : IevReplacer = nil): InevBasePoint;
  {-}
var
 l_Block : InevRange;
begin
 if (aCursor = nil) then
  l_Block := evMakeListBlock(aList)
 else
  l_Block := aCursor.Obj.Range;
 try
  if (aCursor = nil) then
  begin
   Result := l_Block.Obj.MakePoint;
   Result.Move(nil, ev_ocTopLeft);
  end//aCursor = nil
  else
   Result := aCursor;
  try
   l_Block.SearchReplace(aSearcher, aReplacer, TnevConfirm.Make, Result);
  except
   Result := nil;
   raise;
  end;//try..except
 finally
  l_Block := nil;
 end;//try..finally
end;

function evSearchList(OnGetItem       : TevGetItemEvent;
                      aCount          : Long;
                      const aSearcher : IevSearcher;
                      const aCursor   : InevBasePoint = nil;
                      const aReplacer : IevReplacer = nil): InevBasePoint;
  //overload;
  {-}
var
 l_StringList : TevStringList;
begin
 l_StringList := TevStringList.Create(OnGetItem, aCount);
 try
  Result := evSearchList(l_StringList, aSearcher, aCursor, aReplacer);
 finally
  l3Free(l_StringList);
 end;//try..finally
end;

function evSearchList(OnGetItem       : TevGetItemEvent;
                      aCount          : Long;
                      const aSearcher : IevSearcher;
                      aPos            : Long = 1;
                      const aReplacer : IevReplacer = nil): Long;
  //overload;
  {-}
var
 l_StringList : TevStringList;
 l_Cursor     : InevBasePoint;
 l_NCursor    : InevBasePoint;
begin
 l_StringList := TevStringList.Create(OnGetItem, aCount);
 try
  l_Cursor := evMakeListCursor(l_StringList, aPos);
  try
   l_NCursor := nil;
   try
    l_NCursor := evSearchList(l_StringList, aSearcher, l_Cursor, aReplacer);
    Result := l_NCursor.Position;
   finally
    l_NCursor := nil;
   end;//try..finally
  finally
   l_Cursor := nil;
  end;//try..finally
 finally
  l3Free(l_StringList);
 end;//try..finally
end;

// start class TevListInterfaceFactory

function TevListInterfaceFactory.COMQueryTool(aTag: Tl3Variant;
  const IID: Tl3GUID; out Tool; const aProcessor: InevProcessor): Boolean;
begin
 if IID.EQ(InevParaList) then
 begin
  Result := True;
  InevParaList(Tool) := TnevStringListPara.Make(aTag)
 end
 else
  Result := inherited COMQueryTool(aTag, IID, Tool, aProcessor);
end;

function TevListInterfaceFactory.QueryTool(aTag: Tl3Variant; const ID: Tl3IID; out I: Tk2ToolPrim): Bool;
  //override;
  {-}
begin
 Result := True;
 if ID.EQ(ev_iidCursor) then
  I := TevListCursor.Create(aTag)
 else
 if ID.EQ(ev_iidBlock) then
  I := TevListBlock.Create(aTag)
 else
  Result := inherited QueryTool(aTag, ID, I);
end;

// start class TevListBlock

procedure TevListBlock.ArrangeFoundCursors(anIndex       : Long;
                                           var theStart  : InevBasePoint;
                                           var theFinish : InevBasePoint);
  //override;
  {-}
var
 l_Start  : InevBasePoint;
 l_Finish : InevBasePoint;
begin
 with ParaX do
 begin
  l_Start := MakePoint;
  try
   with l_Start do
   begin
    Inner := theStart;
    SetEntryPointPrim(anIndex);
    theStart := l_Start;
   end;//with cFStart
  finally
   l_Start := nil;
  end;//try..except
  l_Finish := MakePoint;
  try
   with l_Finish do
   begin
    Inner := theFinish;
    SetEntryPointPrim(anIndex);
    theFinish := l_Finish;
   end;//with cFStart
  finally
   l_Finish := nil;
  end;//try..except
 end;//with Obj
end;

function TevListBlock.DoIterateChildrenF(Action : Mk2Children_IterateChildrenF_Action;
                                       aStart : Tl3Index;
                                       aHi    : Tl3Index;
                                       aLoadedOnly : Boolean): Long;
  //override;
  {-}
var
 l_List    : Il3CStringList;
 l_Tag     : Tl3Variant;
 l_Index   : Long;
 l_Borders : TevPair;
 l_Count   : Integer;
begin
 Result := -1;
 try
 with GetRedirect do
  if l3IOk(Attr[k2_tiObject].QueryInterface(Il3CStringList, l_List)) then
   try
    l_Borders := Borders;
    aStart := Max(aStart, l_Borders.rStart);
    l_Count := Min(aHi, Min(l_Borders.rFinish - 1, l_List.Count - 1));
    for l_Index := aStart to l_Count do
    begin
     l_Tag := k2_typTextPara.MakeTag.AsObject;
     try
      l_Tag.Owner := Self;
      l_Tag.IntA[k2_tiHeight] := 1;
      // - типа видимый (для поиска)
      l_Tag.PCharLenA[k2_tiText] := l3PCharLen(l_List[l_Index]);
      Result := l_Index;
      if not Action(l_Tag, l_Index) then Break;
     finally
      l_Tag := nil;
     end;//try..finally
    end;//for l_Index
   finally
    l_List := nil;
   end;//try..finally
 finally
  k2FreeTIA(Action);
 end;//try..finally  
end;

function TevListBlock.DoGetBlockLength: Long;
  //override;
  {-}
var
 l_List : Il3CStringList;
begin
 with GetRedirect do
  if l3IOk(Attr[k2_tiObject].QueryInterface(Il3CStringList, l_List)) then
   try
    Result := l_List.Count;
   finally
    l_List := nil;
   end//try..finally
  else
   Result := 0;
end;

// start class TevListCursor

procedure TevListCursor.Cleanup;
begin
 Target := nil;
 inherited;
end;

function TevListCursor.DoGetBlockLength: Long;
  //override;
  {-}
var
 l_List : Il3CStringList;
begin
 with GetRedirect do
  if l3IOk(Attr[k2_tiObject].QueryInterface(Il3CStringList, l_List)) then
   try
    Result := l_List.Count;
   finally
    l_List := nil;
   end//try..finally
  else
   Result := 0;
end;

procedure TevListCursor.DoSetEntryPoint(Value         : Long;
                                      const Context : IevCursorContext = nil);
  //override;
  {-}
var
 l_ChildCursor : InevBasePoint;
 l_Count       : Long;
 l_Child       : InevPara;
begin
 if (Context <> nil) then
  Context.RecordCursor(Self);
 l_Count := GetBlockLength;
 if (Value = 0) then
  Value := 1
 else
  if (Value = High(Long)) then
   Value := l_Count
  else
   if (Value = ev_cpNull) then
    Value := 0;
 SetEntryPointPrim(Value, Context);
 SetInner(nil);
 if (Value <> ev_cpTop) AND (Value >= 1) AND (Value <= l_Count) then
 begin
  l_Child := ParaX[Value - 1];
  if (l_Child <> nil) and l_Child.IsValid then
   SetInner(l_Child.MakePoint);
 end;//Value <> ev_cpTop..
end;

// TevStringList

constructor TevStringList.Create(OnGetItem : TevGetItemEvent;
                                 aCount    : Long);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_Count := aCount;
 f_OnGetItem := OnGetItem;
end;

function TevStringList.pm_GetCount: Long;
  {-}
begin
 Result := f_Count;
end;

procedure TevStringList.pm_SetCount(aValue: Long);
begin
 Assert(False);
end;

procedure TevStringList.Delete(anIndex: Long);
  {* - Удаляет элемент по индексу Index. }
begin
 Assert(False);
end;

function TevStringList.pm_GetItems(anIndex: Long): Il3CString;
  {-}
begin
 Result := f_OnGetItem(anIndex);
end;

procedure TevStringList.Clear;
  {-}
begin
 Assert(False);
end;

{ TnevStringListPara }

procedure TnevStringListPara.Cleanup;
begin
  f_StringList := nil;
  inherited;
end;

procedure TnevStringListPara.InitFields;
begin
 TagInst.Attr[k2_tiObject].QueryInterface(Il3CStringList, f_StringList);
 inherited;
end;

function TnevStringListPara.GetIndexOfObj(
  const aPara: InevObject): TnevParaIndex;
begin
 Result := -1;//Если будут проблемы, то придется делать поиск по строкам...
end;

function TnevStringListPara.GetModify: InevParaListModify;
begin
 Result := nil;
end;

function TnevStringListPara.GetPara(anIndex: TnevParaIndex): InevPara;
var
 l_Tag : Tl3Variant;
begin
 with GetRedirect do
  l_Tag := k2_typTextPara.MakeTag.AsObject;
  try
   l_Tag.Owner := Self;
   l_Tag.IntA[k2_tiHeight] := 1;
   // - типа видимый (для поиска)
   l_Tag.PCharLenA[k2_tiText] := l3PCharLen(f_StringList[anIndex]);
   Result := TnevStringItemPara.Make(l_Tag, anIndex)
  finally
   l_Tag := nil;
  end;
end;

function TnevStringListPara.GetParaCount: TnevParaIndex;
begin
 Result := f_StringList.Count;
end;

end.

