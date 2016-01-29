unit evTableRowHotSpot;
{* Реализация интерфейсов IevHotSpotTester и IevHotSpot для строки таблицы. }

{ Библиотека "Эверест"        }
{ Автор: Люлин А.В. ©         }
{ Модуль: evTableRowHotSpot - }
{ Начат: 01.11.2000 13:15 }
{ $Id: evTableRowHotSpot.pas,v 1.72 2015/01/19 18:36:36 lulin Exp $ }

// $Log: evTableRowHotSpot.pas,v $
// Revision 1.72  2015/01/19 18:36:36  lulin
// {RequestLink:580710025}
//
// Revision 1.71  2014/04/29 13:38:51  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.70  2014/04/21 11:45:00  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.69  2014/04/07 17:56:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.68  2013/10/25 10:52:41  morozov
// {RequestLink: 254939874}
//
// Revision 1.67  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.66  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.65  2013/04/24 09:35:36  lulin
// - портируем.
//
// Revision 1.64  2011/11/29 13:46:26  dinishev
// {Requestlink:109904163}
//
// Revision 1.63  2011/11/25 12:20:42  dinishev
// {Requestlink:109904163}. Самая сложная для нахождения ошибка. ;-)
//
// Revision 1.62  2011/09/13 10:48:06  lulin
// {RequestLink:278839709}.
//
// Revision 1.61  2011/02/22 19:41:04  lulin
// {RequestLink:182157315}.
//
// Revision 1.60  2011/02/15 11:24:49  lulin
// {RequestLink:231670346}.
//
// Revision 1.59  2010/06/24 15:16:27  lulin
// {RequestLink:219125149}.
// - пытаемся скроллировать окно, если ушли за его пределы.
//
// Revision 1.58  2010/04/08 08:11:16  dinishev
// [$201490621]
//
// Revision 1.57  2010/04/06 09:20:42  dinishev
// Задел для задачи [$201490621]. Из-за кривого определения границ не всегдя можно было поставить курсор.
//
// Revision 1.56  2010/03/23 12:16:28  dinishev
// [$198673290]
//
// Revision 1.55  2010/03/02 13:34:35  lulin
// {RequestLink:193823544}.
//
// Revision 1.54  2010/03/01 14:02:56  lulin
// {RequestLink:193823544}.
// - первый шаг.
//
// Revision 1.53  2009/07/23 08:14:39  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.52  2009/07/14 14:56:28  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.51  2009/07/13 12:31:37  lulin
// {RequestLink:141264340}. №23ac.
//
// Revision 1.50  2009/07/11 15:55:09  lulin
// {RequestLink:141264340}. №22.
//
// Revision 1.49  2009/06/25 12:57:30  lulin
// - вычищаем ненужный контекст.
//
// Revision 1.48  2009/06/02 06:25:58  dinishev
// [$148571693] - избавляемся от лишних линий.
//
// Revision 1.47  2009/05/29 17:18:25  lulin
// [$142610853].
//
// Revision 1.46  2009/05/26 11:14:50  dinishev
// [$146905510]. Не срабатывали на случае, описанном в ошибке.
//
// Revision 1.45  2009/05/26 07:25:27  dinishev
// [$146905510]
//
// Revision 1.44  2009/04/14 18:11:55  lulin
// [$143396720]. Подготовительная работа.
//
// Revision 1.43  2009/04/06 09:45:27  lulin
// [$140837386]. Убираем старорежимную примесь для списков параграфов.
//
// Revision 1.42  2009/03/31 12:04:36  lulin
// [$140286997].
//
// Revision 1.41  2009/03/04 13:32:47  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.40  2008/04/15 08:23:46  lulin
// - передаём вью в качестве параметра.
//
// Revision 1.39  2008/04/14 07:48:09  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.38  2008/04/10 14:34:05  lulin
// - <K>: 89098970.
//
// Revision 1.37  2008/04/09 17:57:08  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.36  2008/04/08 16:41:20  lulin
// - передаём View в AssignPoint. <K>: 89096854.
//
// Revision 1.35  2008/04/04 16:17:59  lulin
// - теперь у базового вью нельзя получить курсор по точке.
//
// Revision 1.34  2008/02/29 10:55:23  dinishev
// Bug fix: неправильно расширяли выделение строки
//
// Revision 1.33  2008/02/27 17:24:58  lulin
// - подгоняем код под модель.
//
// Revision 1.32  2007/12/04 12:47:05  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.27.4.46  2007/11/28 15:43:47  dinishev
// Убираем устаревший код и корректно инициализируем выделение
//
// Revision 1.27.4.45  2007/09/14 13:26:06  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.27.4.44.2.1  2007/09/12 15:23:02  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.27.4.44  2007/07/18 15:07:19  lulin
// - выпрямляем зависимости. Схема документа, теперь не зависит от Эвереста.
//
// Revision 1.27.4.43  2007/02/12 18:06:13  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.27.4.42  2007/02/12 17:15:59  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.27.4.41  2007/02/12 16:40:20  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.27.4.40  2007/01/24 10:21:42  oman
// - new: Локализация библиотек - ev (cq24078)
//
// Revision 1.27.4.39  2006/11/03 11:00:07  lulin
// - объединил с веткой 6.4.
//
// Revision 1.27.4.38.2.8  2006/10/31 09:39:37  lulin
// - используем карту форматирования переданную сверху, а не привязанную к курсору.
//
// Revision 1.27.4.38.2.7  2006/10/31 09:21:18  lulin
// - при поиске горячей точки подаем уже вычисленную карту форматирования.
//
// Revision 1.27.4.38.2.6  2006/10/25 10:47:11  lulin
// - с видимой точки убрана горизонтальная координата.
//
// Revision 1.27.4.38.2.5  2006/10/23 08:58:09  lulin
// - теперь при определении "горячей точки" передаем базовый курсор.
//
// Revision 1.27.4.38.2.4  2006/10/19 13:33:18  lulin
// - переводим курсоры и подсказки на новые рельсы.
//
// Revision 1.27.4.38.2.3  2006/10/19 12:05:43  lulin
// - добавлен метод для выяснения информации о позиции курсора.
//
// Revision 1.27.4.38.2.2  2006/10/19 10:56:17  lulin
// - параметры курсора переехали в более общую библиотеку.
//
// Revision 1.27.4.38.2.1  2006/10/18 13:06:34  lulin
// - вычищены ненужные данные.
//
// Revision 1.27.4.38  2006/10/10 12:06:14  lulin
// - cleanup.
//
// Revision 1.27.4.37  2006/10/06 08:24:09  lulin
// - убрано предупреждение.
//
// Revision 1.27.4.36  2006/10/06 08:19:42  lulin
// - выкидываем ненужный параметр - класс горячей точки.
//
// Revision 1.27.4.35.2.2  2006/10/04 15:17:08  lulin
// - выкидываем ненужный параметр - класс горячей точки.
//
// Revision 1.27.4.35.2.1  2006/10/04 14:10:20  lulin
// - упрощаем механизм получения горячих точек.
//
// Revision 1.27.4.35  2006/10/04 11:23:02  lulin
// - при получении горячей точки передаем "состояние" курсора.
//
// Revision 1.27.4.34  2006/10/04 08:32:06  lulin
// - теперь умолчательное поведение при действиях мышью описывается структурой - чтобы проще было расширять интерфейс.
//
// Revision 1.27.4.33  2006/10/04 06:23:44  lulin
// - точку мыши упаковываем в состояние мыши.
//
// Revision 1.27.4.32  2006/10/04 04:33:51  lulin
// - избавляемся от возвращаемого результа в стиле OLE.
//
// Revision 1.27.4.31  2006/08/02 10:51:53  lulin
// - объединил с веткой в которой боролся со скроллингом.
//
// Revision 1.27.4.30.2.1  2006/08/01 10:51:37  lulin
// - у отображаемых объектов убрано свойство "ширина".
//
// Revision 1.27.4.30  2006/07/21 11:43:31  lulin
// - имя метода убрано из комментариев - чтобы не находилось контекстным поиском.
//
// Revision 1.27.4.29  2006/07/20 18:36:56  lulin
// - имя метода убрано из комментариев - чтобы не находилось контекстным поиском.
//
// Revision 1.27.4.28  2006/07/20 12:55:46  lulin
// - имя метода убрано из комментариев - чтобы не находилось контекстным поиском.
//
// Revision 1.27.4.27  2006/07/03 11:58:53  lulin
// - передаем не множество клавиш, а "состояние мыши".
//
// Revision 1.27.4.26  2005/11/21 09:56:54  lulin
// - удален ненужный глобальный метод.
//
// Revision 1.27.4.25  2005/11/08 06:39:37  lulin
// - с текстового параграфа и списка параграфов вычищены ненужные методы получения сложной формы параграфа.
//
// Revision 1.27.4.24  2005/11/07 06:25:22  lulin
// - выделяем у якоря и у курсора общую функциональность.
//
// Revision 1.27.4.23  2005/11/05 07:55:29  lulin
// - cleanup: убраны ненужные преобразования объекта к параграфу.
//
// Revision 1.27.4.22  2005/10/07 10:29:01  lulin
// - недоделки помечены специальной меткой.
//
// Revision 1.27.4.21  2005/08/31 12:04:34  lulin
// - удален ненужный модуль.
//
// Revision 1.27.4.20  2005/08/25 14:12:52  lulin
// - new behavior: для КЗ не выводим Hint'ы и прочее для строк и ячеек таблицы с контролами.
//
// Revision 1.27.4.19  2005/07/20 18:21:14  lulin
// - убран переходный интерфейс.
//
// Revision 1.27.4.18  2005/07/18 11:22:37  lulin
// - методу, возвращаещему выделение на параграфе дано более подходящее название.
//
// Revision 1.27.4.17  2005/07/07 15:10:38  lulin
// - new behavior: теперь HotSpot запоминает точку в которой находился курсор.
//
// Revision 1.27.4.16  2005/07/07 13:09:28  lulin
// - упорядочены названия интерфейсов.
//
// Revision 1.27.4.15  2005/07/07 11:41:17  lulin
// - передаем в _GetAdvancedHotSpot специальный интерфейс InevViewPoint.
//
// Revision 1.27.4.14  2005/07/05 16:02:44  lulin
// - bug fix: восстановлен скроллинг при выделении текста мышью.
//
// Revision 1.27.4.13  2005/06/20 15:42:10  lulin
// - cleanup: избавляемся от абсолютных координат.
//
// Revision 1.27.4.12  2005/06/16 11:24:12  lulin
// - убрана косвенная типизация параграфов (при помощи _QI и QT).
//
// Revision 1.27.4.11  2005/06/15 17:23:52  lulin
// - remove proc: _evMoveCursor.
//
// Revision 1.27.4.10  2005/06/14 14:51:51  lulin
// - new interface: _InevSelection.
// - remove interface: IevSelection.
//
// Revision 1.27.4.9  2005/06/14 12:38:58  lulin
// - избавился от передачи безликого интерфейса (теперь передается View).
//
// Revision 1.27.4.8  2005/06/14 10:01:31  lulin
// - избавился от передачи безликого интерфейса (теперь передается View).
//
// Revision 1.27.4.7  2005/06/11 08:55:38  lulin
// - в какой-то мере восстановлена работоспособность HotSpot'ов.
//
// Revision 1.27.4.6  2005/06/06 15:36:09  lulin
// - продолжаем бороться со знанием о природе реализации курсоров.
//
// Revision 1.27.4.5  2005/06/02 12:33:08  lulin
// - вчерне заменил прямое создание блока выделения на его получение от фабрики.
//
// Revision 1.27.4.4  2005/06/01 16:22:25  lulin
// - remove unit: evIntf.
//
// Revision 1.27.4.3  2005/05/31 17:46:39  lulin
// - изживаем остатки объектов в качестве курсоров.
//
// Revision 1.27.4.2  2005/05/31 14:48:01  lulin
// - cleanup: при работе с курсорами используем интерфейсы, а не объекты.
//
// Revision 1.27.4.1  2005/05/18 12:42:47  lulin
// - отвел новую ветку.
//
// Revision 1.25.2.4  2005/05/18 12:32:10  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.25.2.3  2005/04/28 09:18:30  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.25.2.2  2005/04/09 12:48:37  lulin
// - метод ParaByOffset переименован в _ShapeByPt и перенесен на интерфейс InevComplexShape.
//
// Revision 1.25.2.1  2005/04/08 13:35:05  lulin
// - _Processor стал обязательным параметром.
//
// Revision 1.26.2.1  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.26  2005/04/21 05:11:38  lulin
// - используем _Box (пока из-за постоянных преобразований туда и обратно - по скорости стало только хуже).
//
// Revision 1.27  2005/04/28 15:03:38  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.26.2.1  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.26  2005/04/21 05:11:38  lulin
// - используем _Box (пока из-за постоянных преобразований туда и обратно - по скорости стало только хуже).
//
// Revision 1.25  2005/04/07 15:42:05  lulin
// - cleanup.
//
// Revision 1.24  2005/04/07 15:12:30  lulin
// - удалены ненужные формальные параметры.
//
// Revision 1.23  2005/04/07 14:59:56  lulin
// - new method: _InevShape._TranslatePt.
//
// Revision 1.22  2005/04/07 14:32:49  lulin
// - remove proc: evGetTopPara.
//
// Revision 1.21  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.20  2005/03/24 13:14:37  lulin
// - уделена ненужная функция преобразования Tk2AtomR к _Ik2Tag.
//
// Revision 1.19  2005/03/16 12:16:52  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.18  2005/03/10 16:40:10  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.17  2005/03/10 16:22:32  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.16  2005/03/10 14:58:38  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.15  2005/03/10 07:05:11  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.14  2005/03/09 18:40:19  lulin
// - remove method: Tk2AtomR.DeleteChild.
// - new method: _Ik2Tag.DeleteChild.
//
// Revision 1.13  2003/10/02 16:33:24  law
// - rename unit: evBseCur -> evBaseCursor.
//
// Revision 1.12  2003/01/14 16:47:11  law
// - new proc: evTagIndex.
//
// Revision 1.11  2003/01/13 16:34:04  law
// - bug fix: не учитывалось объединение ячеек.
//
// Revision 1.10  2003/01/13 16:16:32  law
// - new behavior: возможность выделения таблицы при DoubleClick на строку.
//
// Revision 1.9  2003/01/13 15:58:31  law
// - new behavior: возможность выделения строки таблицы целиком.
//
// Revision 1.8  2002/07/09 12:02:21  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.7  2002/01/29 16:46:25  law
// - new behavior:  повышаем точность рисования строба.
//
// Revision 1.6  2002/01/29 16:18:14  law
// - new behavior:  повышаем точность рисования строба.
//
// Revision 1.5  2001/04/03 14:13:48  law
// - new behavior: теперь evTable_GetMergeHead возвращает все ID начиная с нуля (а не единицы). Также добавлен параметр pRowID.
//
// Revision 1.4  2001/03/22 15:22:27  law
// - сделана трансляция HotSpot'а к головной ячейке.
//
// Revision 1.3  2000/12/15 15:10:38  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3IID,

  l3Units,

  afwInterfaces,

  k2Interfaces,
  k2InternalInterfaces,

  evInternalInterfaces,
  evTableColumnHotSpot,
  evParaListHotSpotTester,
  evSelectingHotSpot,

  nevTools,
  nevGUIInterfaces
  ;

type
  TevTableRowHotSpotTester = class(TevParaListHotSpotTester)
    {* - реализует интерфейс IevHotSpotTester для строки таблицы }
    protected
    // internal methods
      function GetTableColumnHotSpot: RevTableColumnHotSpot;
        virtual;
         {-}
      function NeedRowSpot: Boolean;
        virtual;
        {-}
    public
    //public methods
      function GetChildHotSpot(const aView  : InevControlView;
                               const aState : TevCursorState;
                               const aPt    : InevBasePoint;
                               const aMap   : InevMap;
                               const aChild : InevObject;
                               out theSpot  : IevHotSpot): Boolean;
        override;
        {-}
  end;//TevTableRowHotSpotTester

  TevTableRowHotSpot = class(TevSelectingHotSpot)
  private
   {* - реализует интерфейс IevAdvancedHotSpot для ячейки таблицы. }
    protected
    // internal fields
      f_StartPoint : InevBasePoint;
       {* - Начальная точка. }
    protected
    //property methods
      procedure DoHitTest(const aView  : InevControlView;
                        const aState : TafwCursorState;
                        var theInfo  : TafwCursorInfo);
        override;
        {-}
    protected
    // internal methods
      function  InitSelection(const aView : InevControlView;
                              const aPt : InevBasePoint;
                              const theStart  : InevBasePoint;
                              const theFinish : InevBasePoint): Bool;
        override;
        {-}
      function SelectionTable: InevParaList;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    //public methods
      function MouseAction(const aView : InevControlView;
                           aButton     : TevMouseButton;
                           anAction    : TevMouseAction;
                           const Keys  : TevMouseState;
                           var Effect  : TevMouseEffect): Bool;
        override;
        {* - обрабатывает событие мыши. }
  end;//TevTableRowHotSpot

implementation

uses
  l3Const,
  l3String,

  k2Tags,

  evdTypes,
  
  evOp,
  evConst,
  evParaTools,
  evTableTools,
  evCursorTools,
  evHotSpotMisc,

  nevInterfaces,

  TableRow_Const
  ;

// start class TevTableRowHotSpotTester

function TevTableRowHotSpotTester.NeedRowSpot: Boolean;
  //virtual;
  {-}
begin
 Result := True;
end;

function TevTableRowHotSpotTester.GetChildHotSpot(const aView  : InevControlView;
                                                  const aState : TevCursorState;
                                                  const aPt    : InevBasePoint;
                                                  const aMap   : InevMap;
                                                  const aChild : InevObject;
                                                  out theSpot  : IevHotSpot): Boolean;
  //override;
  {-}
var
 l_Map   : InevMap;
 l_X     : Integer;
 l_Delta : Integer;
begin
 if NeedRowSpot then
 begin
  Result := True;
  l_Map := aMap;
  if (l_Map <> nil) then
  begin
   if not l_Map.rVisible then
    l_Map := aView.MapByPoint(aChild.MakePoint, True);
   Assert(l_Map <> nil); 
   l_X := aState.rPoint.X - l_Map.Bounds.Left;
   if (l_X < 0) then
    theSpot := TevHotSpotWrap.Make(TevTableRowHotSpot.Make(aChild.OwnerObj.AsObject, Processor))
   else
   begin
    l_Delta := l_X - l_Map.FI.Width; 
    if (Abs(l_Delta) <= 4 * evEpsilon) then
     theSpot :=  TevHotSpotWrap.Make(
                       GetTableColumnHotSpot.Make(aView, aChild.OwnerObj.AsObject,
                                                  aChild.PID + 1,
                                                  str_nevmhCellSize.AsCStr,
                                                  l_Delta))
    else
     Result := inherited GetChildHotSpot(aView, aState, aPt, aMap, aChild, theSpot);
   end//l_X < 0
  end//l_Map <> nil
  else
   Result := inherited GetChildHotSpot(aView, aState, aPt, aMap, aChild, theSpot);
 end//NeedRowSpot
 else
  Result := inherited GetChildHotSpot(aView, aState, aPt, aMap, aChild, theSpot);
end;

// start class TevTableRowHotSpot

procedure TevTableRowHotSpot.DoHitTest(const aView  : InevControlView;
                                     const aState : TafwCursorState;
                                     var theInfo  : TafwCursorInfo);
  //override;
  {-}
begin
 inherited;
 theInfo.rCursor := ev_csSelectLine;
 theInfo.rHint := str_nevmhhTableRow.AsCStr;
end;

function TevTableRowHotSpot.InitSelection(const aView : InevControlView;
                                          const aPt       : InevBasePoint;
                                          const theStart  : InevBasePoint;
                                          const theFinish : InevBasePoint): Bool;
  //override;
  {-}
var
 l_Point : InevBasePoint;
begin
 Result := True;
 Assert(aView <> nil);
 l_Point := aPt;
 while (l_Point <> nil) do
 begin
  if l_Point.AsObject.IsKindOf(k2_typTableRow) then Break;
  l_Point := l_Point.Inner;
 end;//while (l_Point <> nil)
 if (l_Point <> nil) then
 begin
  if ((f_StartPoint.Obj.PID) > l_Point.Obj.PID) then
  begin
   theFinish.AssignPoint(aView, f_StartPoint);
   theFinish.Move(aView, ev_ocBottomRight);
   theStart.AssignPoint(aView, l_Point);
   theStart.Move(aView, ev_ocTopLeft);
  end//if (l_Start > l_Finish) then
  else
  begin
   theStart.AssignPoint(aView, f_StartPoint);
   theStart.Move(aView, ev_ocTopLeft);
   theFinish.AssignPoint(aView, l_Point);
   theFinish.Move(aView, ev_ocBottomRight);
  end;//(f_StartPoint.Obj.PID) > l_Point.Obj.PID
 end//l_Point <> nil
 else
  Result := False;
end;

function TevTableRowHotSpot.MouseAction(const aView : InevControlView;
                                        aButton     : TevMouseButton;
                                        anAction    : TevMouseAction;
                                        const Keys  : TevMouseState;
                                        var Effect  : TevMouseEffect): Bool;
  {* - Обрабатывает событие мыши. }
begin
 Result := inherited MouseAction(aView, aButton, anAction, Keys, Effect);
 case aButton of
  ev_mbLeft :
  begin
   case anAction of
    ev_maDown :
    begin
     f_StartPoint := ParaX.MakePoint;
     f_StartPoint.SetAtStart(aView, True);
     Result := evSelectTablePara(aView.Control.Selection, ParaX);
    end;//ev_maDown
    ev_maDouble :
    begin
     Result := evSelectTablePara(aView.Control.Selection, SelectionTable);
     if Result then
      Effect.rNeedAsyncLoop := False;
    end;//ev_maDouble
   end;//case anAction
  end;//ev_mbLeft
 end;//case aButton
end;

function TevTableRowHotSpot.SelectionTable: InevParaList;
begin
 Result := ParaX.OwnerPara;
end;

procedure TevTableRowHotSpot.Cleanup;
begin
 f_StartPoint := nil;
 inherited;
end;

function TevTableRowHotSpotTester.GetTableColumnHotSpot: RevTableColumnHotSpot;
begin
 Result := TevTableColumnHotSpot;
end;

end.

