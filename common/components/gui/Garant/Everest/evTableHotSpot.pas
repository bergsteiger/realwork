unit evTableHotSpot;
{* Реализация интерфейсов IevHotSpotTester и IevAdvancedHotSpot для таблицы. }

{ Библиотека "Эверест"     }
{ Автор: Люлин А.В. ©      }
{ Модуль: evTableHotSpot - }
{ Начат: 03.11.2000 14:12  }
{ $Id: evTableHotSpot.pas,v 1.58 2015/01/19 18:36:36 lulin Exp $ }

// $Log: evTableHotSpot.pas,v $
// Revision 1.58  2015/01/19 18:36:36  lulin
// {RequestLink:580710025}
//
// Revision 1.57  2014/04/30 11:23:52  lulin
// - выпрямляем зависимости.
//
// Revision 1.56  2014/04/29 13:38:51  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.55  2014/04/21 11:45:00  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.54  2014/04/07 17:56:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.53  2014/01/14 08:59:58  dinishev
// Чистка кода.
//
// Revision 1.52  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.51  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.50  2011/09/13 10:48:06  lulin
// {RequestLink:278839709}.
//
// Revision 1.49  2011/02/22 19:41:04  lulin
// {RequestLink:182157315}.
//
// Revision 1.48  2011/02/15 11:24:49  lulin
// {RequestLink:231670346}.
//
// Revision 1.47  2010/06/24 15:16:27  lulin
// {RequestLink:219125149}.
// - пытаемся скроллировать окно, если ушли за его пределы.
//
// Revision 1.46  2010/06/24 12:52:54  lulin
// {RequestLink:219125149}.
//
// Revision 1.45  2010/03/02 13:34:35  lulin
// {RequestLink:193823544}.
//
// Revision 1.44  2010/03/01 14:50:06  lulin
// {RequestLink:193823544}.
// - шаг второй.
//
// Revision 1.43  2009/07/23 08:14:39  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.42  2009/07/14 14:56:28  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.41  2009/07/13 12:31:37  lulin
// {RequestLink:141264340}. №23ac.
//
// Revision 1.40  2009/07/11 17:11:05  lulin
// {RequestLink:141264340}. №19.
//
// Revision 1.39  2009/07/11 15:55:09  lulin
// {RequestLink:141264340}. №22.
//
// Revision 1.38  2009/05/29 17:18:25  lulin
// [$142610853].
//
// Revision 1.37  2009/05/22 10:22:42  dinishev
// [$146905496]
//
// Revision 1.36  2009/05/22 06:39:40  dinishev
// Cleanup
//
// Revision 1.35  2009/04/14 18:11:55  lulin
// [$143396720]. Подготовительная работа.
//
// Revision 1.34  2009/04/06 09:45:27  lulin
// [$140837386]. Убираем старорежимную примесь для списков параграфов.
//
// Revision 1.33  2009/03/31 12:04:36  lulin
// [$140286997].
//
// Revision 1.32  2009/03/04 13:32:47  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.31  2008/05/05 12:56:39  lulin
// - <K>: 90439843.
//
// Revision 1.30  2008/04/24 12:26:19  lulin
// - изменения в рамках <K>: 89106312.
//
// Revision 1.29  2008/04/09 17:57:08  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.28  2008/04/04 16:17:59  lulin
// - теперь у базового вью нельзя получить курсор по точке.
//
// Revision 1.27  2008/02/29 10:54:50  dinishev
// Bug fix: не выдылялась ячейка при щечлке
//
// Revision 1.26  2008/02/27 17:24:58  lulin
// - подгоняем код под модель.
//
// Revision 1.25  2007/12/04 12:47:05  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.22.8.35  2007/11/28 15:41:22  dinishev
// Корректная работа с выделением ячейки
//
// Revision 1.22.8.34  2007/06/22 19:18:57  lulin
// - cleanup.
//
// Revision 1.22.8.33  2007/02/12 17:15:59  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.22.8.32  2007/02/12 16:40:20  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.22.8.31  2007/01/24 10:21:42  oman
// - new: Локализация библиотек - ev (cq24078)
//
// Revision 1.22.8.30  2006/11/20 15:55:11  lulin
// - cleanup: не используем позицию курсора по вертикали, вне _View_.
//
// Revision 1.22.8.29  2006/11/03 11:00:07  lulin
// - объединил с веткой 6.4.
//
// Revision 1.22.8.28.2.9  2006/10/31 09:39:37  lulin
// - используем карту форматирования переданную сверху, а не привязанную к курсору.
//
// Revision 1.22.8.28.2.8  2006/10/31 09:21:18  lulin
// - при поиске горячей точки подаем уже вычисленную карту форматирования.
//
// Revision 1.22.8.28.2.7  2006/10/25 14:30:48  lulin
// - визуальная точка изничтожена как класс.
//
// Revision 1.22.8.28.2.6  2006/10/24 11:57:04  lulin
// - cleanup: используем позицию, а не дочерний объект.
//
// Revision 1.22.8.28.2.5  2006/10/23 08:58:09  lulin
// - теперь при определении "горячей точки" передаем базовый курсор.
//
// Revision 1.22.8.28.2.4  2006/10/19 13:33:18  lulin
// - переводим курсоры и подсказки на новые рельсы.
//
// Revision 1.22.8.28.2.3  2006/10/19 12:05:43  lulin
// - добавлен метод для выяснения информации о позиции курсора.
//
// Revision 1.22.8.28.2.2  2006/10/19 10:56:17  lulin
// - параметры курсора переехали в более общую библиотеку.
//
// Revision 1.22.8.28.2.1  2006/10/18 13:06:34  lulin
// - вычищены ненужные данные.
//
// Revision 1.22.8.28  2006/10/06 08:19:42  lulin
// - выкидываем ненужный параметр - класс горячей точки.
//
// Revision 1.22.8.27.2.2  2006/10/04 15:17:08  lulin
// - выкидываем ненужный параметр - класс горячей точки.
//
// Revision 1.22.8.27.2.1  2006/10/04 14:10:20  lulin
// - упрощаем механизм получения горячих точек.
//
// Revision 1.22.8.27  2006/10/04 11:23:02  lulin
// - при получении горячей точки передаем "состояние" курсора.
//
// Revision 1.22.8.26  2006/10/04 08:32:06  lulin
// - теперь умолчательное поведение при действиях мышью описывается структурой - чтобы проще было расширять интерфейс.
//
// Revision 1.22.8.25  2006/10/04 06:23:44  lulin
// - точку мыши упаковываем в состояние мыши.
//
// Revision 1.22.8.24  2006/10/04 04:33:51  lulin
// - избавляемся от возвращаемого результа в стиле OLE.
//
// Revision 1.22.8.23  2006/07/21 11:43:31  lulin
// - имя метода убрано из комментариев - чтобы не находилось контекстным поиском.
//
// Revision 1.22.8.22  2006/07/20 18:36:56  lulin
// - имя метода убрано из комментариев - чтобы не находилось контекстным поиском.
//
// Revision 1.22.8.21  2006/07/20 12:55:46  lulin
// - имя метода убрано из комментариев - чтобы не находилось контекстным поиском.
//
// Revision 1.22.8.20  2006/07/03 11:58:53  lulin
// - передаем не множество клавиш, а "состояние мыши".
//
// Revision 1.22.8.19  2005/11/05 07:55:29  lulin
// - cleanup: убраны ненужные преобразования объекта к параграфу.
//
// Revision 1.22.8.18  2005/11/04 16:47:58  lulin
// - базовый объект теперь поддерживает свое удаление.
//
// Revision 1.22.8.17  2005/08/31 12:04:34  lulin
// - удален ненужный модуль.
//
// Revision 1.22.8.16  2005/08/25 14:12:52  lulin
// - new behavior: для КЗ не выводим Hint'ы и прочее для строк и ячеек таблицы с контролами.
//
// Revision 1.22.8.15  2005/07/20 18:36:11  lulin
// - модуль переименован в сответствии с названием интерфейса.
//
// Revision 1.22.8.14  2005/07/18 11:22:37  lulin
// - методу, возвращаещему выделение на параграфе дано более подходящее название.
//
// Revision 1.22.8.13  2005/07/07 17:15:46  lulin
// - InevAnchor и InevViewPoint теперь наследуются от InevLocation.
//
// Revision 1.22.8.12  2005/07/07 15:38:05  lulin
// - InevViewPoint теперь не наследуется от InevAnchor.
//
// Revision 1.22.8.11  2005/07/07 11:41:17  lulin
// - передаем в _GetAdvancedHotSpot специальный интерфейс InevViewPoint.
//
// Revision 1.22.8.10  2005/07/05 16:02:44  lulin
// - bug fix: восстановлен скроллинг при выделении текста мышью.
//
// Revision 1.22.8.9  2005/06/20 15:42:10  lulin
// - cleanup: избавляемся от абсолютных координат.
//
// Revision 1.22.8.8  2005/06/14 14:51:51  lulin
// - new interface: _InevSelection.
// - remove interface: IevSelection.
//
// Revision 1.22.8.7  2005/06/14 12:38:58  lulin
// - избавился от передачи безликого интерфейса (теперь передается View).
//
// Revision 1.22.8.6  2005/06/14 10:01:31  lulin
// - избавился от передачи безликого интерфейса (теперь передается View).
//
// Revision 1.22.8.5  2005/06/11 08:55:38  lulin
// - в какой-то мере восстановлена работоспособность HotSpot'ов.
//
// Revision 1.22.8.4  2005/06/07 13:43:48  lulin
// - удален ненужный модуль.
//
// Revision 1.22.8.3  2005/06/02 12:33:08  lulin
// - вчерне заменил прямое создание блока выделения на его получение от фабрики.
//
// Revision 1.22.8.2  2005/06/01 16:22:25  lulin
// - remove unit: evIntf.
//
// Revision 1.22.8.1  2005/05/18 12:42:47  lulin
// - отвел новую ветку.
//
// Revision 1.22.2.2  2005/04/09 12:48:37  lulin
// - метод ParaByOffset переименован в _ShapeByPt и перенесен на интерфейс InevComplexShape.
//
// Revision 1.22.2.1  2005/04/08 13:35:05  lulin
// - _Processor стал обязательным параметром.
//
// Revision 1.22  2005/04/07 15:42:05  lulin
// - cleanup.
//
// Revision 1.21  2005/04/07 15:12:30  lulin
// - удалены ненужные формальные параметры.
//
// Revision 1.20  2005/04/07 14:59:56  lulin
// - new method: _InevShape._TranslatePt.
//
// Revision 1.19  2005/04/07 14:32:49  lulin
// - remove proc: evGetTopPara.
//
// Revision 1.18  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.17  2005/03/19 16:39:51  lulin
// - спрятаны ненужные методы.
//
// Revision 1.16  2005/03/16 12:16:52  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.15  2005/03/10 16:40:10  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.14  2005/03/10 16:22:32  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.13  2003/10/02 16:33:24  law
// - rename unit: evBseCur -> evBaseCursor.
//
// Revision 1.12  2003/01/13 15:58:31  law
// - new behavior: возможность выделения строки таблицы целиком.
//
// Revision 1.11  2002/07/09 12:02:21  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.10  2002/02/08 12:52:19  law
// - new unit: evParaListTools.
//
// Revision 1.9  2002/02/08 12:14:48  law
// - new unit: evParaList.
//
// Revision 1.8  2002/02/07 15:22:30  law
// - rename class: IevBlock -> TevBlock, для того чтобы не путать его с интерфейсом.
//
// Revision 1.7  2002/02/07 15:05:25  law
// - rename class: IevCursor -> _TevCursor, для того чтобы не путать его с интерфейсом.
//
// Revision 1.6  2002/02/06 13:33:50  law
// - new behavior: возможность выделения столбцов таблицы при помощи мыши.
//
// Revision 1.5  2001/11/26 14:31:04  law
// - change type: Keys: Long -> Keys: TShiftState.
//
// Revision 1.4  2001/04/12 16:35:26  law
// - new behavior: сделаны стробы при операциях с мышью.
//
// Revision 1.3  2001/04/04 06:59:00  law
// - bug fix: доделано рисование ячеек таблицы, объединенных по вертикали.
//
// Revision 1.2  2000/12/15 15:10:38  law
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

  evInternalInterfaces,
  evParaListHotSpotTester,
  evSelectingHotSpot,

  nevTools,
  nevGUIInterfaces
  ;

type
  TevTableHotSpotTester = class(TevParaListHotSpotTester)
   {* - Реализует интерфейс IevHotSpotTester для таблицы. }
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
  end;//TevTableHotSpotTester

  TevTableHotSpot = class(TevSelectingHotSpot)
   {* - Реализует интерфейс IevAdvancedHotSpot для таблицы. }
    private
    //internal fields
      f_ColumnIndex : Long;
    protected
    //property methods
      procedure DoHitTest(const aView  : InevControlView;
                        const aState : TafwCursorState;
                        var theInfo  : TafwCursorInfo);
        override;
        {-}
    protected
    // internal methods
      function  InitSelection(const aView     : InevControlView;
                              const aPt       : InevBasePoint;
                              const theStart  : InevBasePoint;
                              const theFinish : InevBasePoint): Bool;
        override;
        {-}
    public
    //public methods
      constructor Create(aTag       : Tl3Variant;
                         const aProcessor : Ik2Processor;
                         aColumnIndex     : Integer);
        reintroduce;
        {-}
      class function Make(aTag       : Tl3Variant;
                          const aProcessor : Ik2Processor;
                          aColumnIndex     : Integer): IevHotSpot;
        reintroduce;
        {-}
      function MouseAction(const aView : InevControlView;
                           aButton     : TevMouseButton;
                           anAction    : TevMouseAction;
                           const Keys  : TevMouseState;
                           var Effect  : TevMouseEffect): Bool;
        override;
        {* - Обрабатывает событие мыши. }
    public
    //public properties
      property ColumnIndex: Long
        read f_ColumnIndex
        write f_ColumnIndex;
        {* - Индекс колонки таблицы над которой находится мышь. }
  end;//TevTableHotSpot

implementation

uses
  l3MinMax,
  l3Const,
  l3String,
  l3InterfacesMisc,

  k2Tags,

  evOp,
  evConst,
  evCursorTools,
  evHotSpotMisc,

  nevBase,
  nevInterfaces,

  ReqRow_Const,
  TableCell_Const
  ;

// start class TevTableHotSpotTester

function TevTableHotSpotTester.GetChildHotSpot(const aView  : InevControlView;
                                               const aState : TevCursorState;
                                               const aPt    : InevBasePoint;
                                               const aMap   : InevMap;
                                               const aChild : InevObject;
                                               out theSpot  : IevHotSpot): Boolean;
  //override;
  {* - Возвращает IevAdvancedHotSpot для точки aPt таблицы. }
var
 l_Map : InevMap;
begin
 l_Map := aMap;
 if (l_Map <> nil) then
  if (aChild.PID = 0) AND
     (aState.rPoint.Y - l_Map.Bounds.Top < evEpsilon * 5) then
  begin
   {$IfDef Nemesis}
   if not aChild.AsObject.IsKindOf(k2_typReqRow) then
   {$EndIf Nemesis}
   begin
    if aPt.HasInner then
    begin
     Result := True;
     theSpot := TevTableHotSpot.Make(aChild.OwnerObj.AsObject, Processor, aPt.Inner.Obj.PID);
     Exit;
    end;//aPt.HasInner
   end;//not aChild.IsKindOf(k2_typReqRow)
  end;//aPt.Y < evEpsilon * 5
 Result := inherited GetChildHotSpot(aView, aState, aPt, aMap, aChild, theSpot);
end;

// start class TevTableHotSpot

constructor TevTableHotSpot.Create(aTag       : Tl3Variant;
                                   const aProcessor : Ik2Processor;
                                   aColumnIndex     : Integer);
  //reintroduce;
  {-}
begin
 inherited Create(aTag, aProcessor);
 ColumnIndex := aColumnIndex;
end;

class function TevTableHotSpot.Make(aTag       : Tl3Variant;
                                    const aProcessor : Ik2Processor;
                                    aColumnIndex     : Integer): IevHotSpot;
  //reintroduce;
  {-}
var
 l_Spot : TevTableHotSpot;
begin
 l_Spot := Create(aTag, aProcessor, aColumnIndex);
 try
  Result := TevHotSpotWrap.Make(l_Spot);
 finally
  l3Free(l_Spot);
 end;//try..finally
end;

procedure TevTableHotSpot.DoHitTest(const aView  : InevControlView;
                                  const aState : TafwCursorState;
                                  var theInfo  : TafwCursorInfo);
  //override;
  {-}
begin
 inherited;
 theInfo.rCursor := ev_csSelectColumn;
 theInfo.rHint := str_nevmhhTableColumn.AsCStr;
end;

function TevTableHotSpot.MouseAction(const aView : InevControlView;
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
     Result := evSelectTableColumn(aView.Control.Selection, ParaX, ColumnIndex);
    ev_maDouble :
    begin
     Result := evSelectTablePara(aView.Control.Selection, ParaX);
     if Result then
      Effect.rNeedAsyncLoop := False;
    end;//ev_maDouble
   end;//case anAction
  end;//ev_mbLeft
 end;//case aButton
end;

function TevTableHotSpot.InitSelection(const aView: InevControlView;
  const aPt: InevBasePoint; const theStart, theFinish: InevBasePoint): Bool;
var
 l_Point  : InevBasePoint;
 l_Start  : Integer;
 l_Finish : Integer;
begin
 Result := True;
 Assert(aView <> nil);
 l_Point := aPt;
 while (l_Point <> nil) do
 begin
  if l_Point.AsObject.IsKindOf(k2_typTableCell) then Break;
  l_Point := l_Point.Inner;
 end;//while (l_Point <> nil)
 if (l_Point <> nil) then
 begin
  theStart.SetAtStart(aView, True);
  theFinish.SetAtEnd(aView, True);
  l_Start := Min(f_ColumnIndex, l_Point.Obj.PID);
  if theStart.HasInner then
   theStart.Inner.SetEntryPoint(l_Start + 1);
  l_Finish := Max(f_ColumnIndex, l_Point.Obj.PID);
  if theFinish.HasInner then
   theFinish.Inner.SetEntryPoint(l_Finish + 1);
 end//l_Point <> nil
 else
  Result := False;  
end;

end.

