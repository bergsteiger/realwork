unit evControlsBlockHotSpotTester;

{ Библиотека "Эверест"    }
{ Начал: Инишев Д.А.      }
{ Модуль: evControlsBlockHotSpot - }
{ Начат: 24.01.2005 14:00 }
{ $Id: evControlsBlockHotSpotTester.pas,v 1.16 2015/02/26 09:28:58 kostitsin Exp $ }

// $Log: evControlsBlockHotSpotTester.pas,v $
// Revision 1.16  2015/02/26 09:28:58  kostitsin
// List*ner -> Listener
//
// Revision 1.15  2015/02/25 13:53:17  kostitsin
// List*ner -> Listener
//
// Revision 1.14  2014/04/30 11:23:52  lulin
// - выпрямляем зависимости.
//
// Revision 1.13  2014/04/10 15:26:07  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.12  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.11  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.10  2012/07/06 09:31:04  dinishev
// {Requestlink:375030261}
//
// Revision 1.9  2012/04/24 09:49:13  dinishev
// {Requestlink:360025064}
//
// Revision 1.8  2011/10/19 14:29:10  lulin
// {RequestLink:290267525}.
//
// Revision 1.7  2011/10/19 14:21:42  lulin
// {RequestLink:290267525}.
//
// Revision 1.6  2011/09/14 07:51:44  lulin
// {RequestLink:278824896}.
//
// Revision 1.5  2011/09/13 10:48:06  lulin
// {RequestLink:278839709}.
//
// Revision 1.4  2011/09/01 13:44:25  lulin
// {RequestLink:280006084}.
//
// Revision 1.3  2011/07/08 17:05:07  lulin
// {RequestLink:228688745}.
//
// Revision 1.2  2011/07/08 10:14:36  lulin
// {RequestLink:273587124}.
//
// Revision 1.1  2011/07/06 11:05:51  lulin
// {RequestLink:254944102}.
//
// Revision 1.33  2011/02/15 11:24:48  lulin
// {RequestLink:231670346}.
//
// Revision 1.32  2009/07/23 08:14:38  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.31  2009/07/10 16:15:41  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.30  2009/06/04 12:29:21  lulin
// - переносим классы на модель.
//
// Revision 1.29  2009/06/03 13:00:53  lulin
// - переименовываем интерфейс, т.к. он становится универсальным.
//
// Revision 1.28  2009/05/29 17:18:25  lulin
// [$142610853].
//
// Revision 1.27  2009/04/16 09:11:57  lulin
// [$143396720]. №2.
//
// Revision 1.26  2009/04/06 09:45:26  lulin
// [$140837386]. Убираем старорежимную примесь для списков параграфов.
//
// Revision 1.25  2009/03/31 12:04:35  lulin
// [$140286997].
//
// Revision 1.24  2008/06/17 20:44:42  lulin
// - рисуем схему EVD на модели.
//
// Revision 1.23  2008/05/07 13:04:22  lulin
// - изменения в рамках <K>: 90441635.
//
// Revision 1.22  2008/04/24 12:26:18  lulin
// - изменения в рамках <K>: 89106312.
//
// Revision 1.21  2008/04/11 14:26:16  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.20  2008/02/27 18:19:50  lulin
// - подгоняем код под модель.
//
// Revision 1.19  2008/02/27 17:24:57  lulin
// - подгоняем код под модель.
//
// Revision 1.18  2007/12/04 12:47:00  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.13.8.52  2007/09/14 13:26:04  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.13.8.51.2.3  2007/09/12 17:02:04  lulin
// - убран ненужный параметр по-умолчанию.
//
// Revision 1.13.8.51.2.2  2007/09/12 16:36:15  lulin
// - переименовано свойство.
//
// Revision 1.13.8.51.2.1  2007/09/12 16:14:07  lulin
// - убран ненужный параметр по-умолчанию.
//
// Revision 1.13.8.51  2007/06/08 12:15:14  lulin
// - избавился от прямого обращения к тегу с контролом модели (<K>-17335138).
//
// Revision 1.13.8.50  2007/06/04 13:33:28  lulin
// - избавляемся от сложной конструкции доступа к атрибуту в котором лежит ссылка на объект модели (<K>-15958514).
//
// Revision 1.13.8.49  2007/01/05 14:37:18  lulin
// - cleanup.
//
// Revision 1.13.8.48  2006/11/03 11:00:03  lulin
// - объединил с веткой 6.4.
//
// Revision 1.13.8.47.2.9  2006/11/01 14:11:52  lulin
// - убираем использование неправильного метода.
//
// Revision 1.13.8.47.2.8  2006/10/31 09:39:36  lulin
// - используем карту форматирования переданную сверху, а не привязанную к курсору.
//
// Revision 1.13.8.47.2.7  2006/10/31 09:21:18  lulin
// - при поиске горячей точки подаем уже вычисленную карту форматирования.
//
// Revision 1.13.8.47.2.6  2006/10/23 08:58:08  lulin
// - теперь при определении "горячей точки" передаем базовый курсор.
//
// Revision 1.13.8.47.2.5  2006/10/19 13:33:17  lulin
// - переводим курсоры и подсказки на новые рельсы.
//
// Revision 1.13.8.47.2.4  2006/10/19 12:05:43  lulin
// - добавлен метод для выяснения информации о позиции курсора.
//
// Revision 1.13.8.47.2.3  2006/10/19 10:56:16  lulin
// - параметры курсора переехали в более общую библиотеку.
//
// Revision 1.13.8.47.2.2  2006/10/18 14:43:15  lulin
// - не храним ненужные данные.
//
// Revision 1.13.8.47.2.1  2006/10/18 12:33:14  lulin
// - типы для обработки мыши переехали в более общую библиотеку.
//
// Revision 1.13.8.47  2006/10/06 15:26:44  lulin
// - теперь возможность автоматического выделения получается из структуры, описывающей поведение горячей точки.
//
// Revision 1.13.8.46  2006/10/06 08:19:41  lulin
// - выкидываем ненужный параметр - класс горячей точки.
//
// Revision 1.13.8.45.2.3  2006/10/04 15:21:10  lulin
// - выкидиываем ненужный метод.
//
// Revision 1.13.8.45.2.2  2006/10/04 15:17:07  lulin
// - выкидываем ненужный параметр - класс горячей точки.
//
// Revision 1.13.8.45.2.1  2006/10/04 14:10:19  lulin
// - упрощаем механизм получения горячих точек.
//
// Revision 1.13.8.45  2006/10/04 11:23:02  lulin
// - при получении горячей точки передаем "состояние" курсора.
//
// Revision 1.13.8.44  2006/10/04 08:32:05  lulin
// - теперь умолчательное поведение при действиях мышью описывается структурой - чтобы проще было расширять интерфейс.
//
// Revision 1.13.8.43  2006/10/04 06:23:43  lulin
// - точку мыши упаковываем в состояние мыши.
//
// Revision 1.13.8.42  2006/10/04 04:33:50  lulin
// - избавляемся от возвращаемого результа в стиле OLE.
//
// Revision 1.13.8.41  2006/09/11 13:57:02  oman
// - fix: Более правильная реализация IevCommonControl
//
// Revision 1.13.8.40  2006/08/28 14:30:35  lulin
// - bug fix: был AV  в КЗ - при пересеченью мышью границы окна (CQ OIT5-22186).
//
// Revision 1.13.8.39  2006/08/02 10:51:52  lulin
// - объединил с веткой в которой боролся со скроллингом.
//
// Revision 1.13.8.38.2.3  2006/07/31 16:41:39  lulin
// - предельную ширину храним в карте форматирования, а не в теге параграфа.
//
// Revision 1.13.8.38.2.2  2006/07/28 13:00:34  lulin
// - bug fix: падали с AV при попытке свернуть/развернуть ггруппу.
//
// Revision 1.13.8.38.2.1  2006/07/28 12:10:39  lulin
// - практически восстановлено поведение КЗ.
//
// Revision 1.13.8.38  2006/07/20 18:36:55  lulin
// - имя метода убрано из комментариев - чтобы не находилось контекстным поиском.
//
// Revision 1.13.8.37  2006/07/19 15:50:23  lulin
// - переименован метод - в соответствии с его параметрами.
//
// Revision 1.13.8.36  2006/07/19 14:24:13  lulin
// - теперь для определения прямоугольника вывода работаем с исходным объектом, а не с формой.
//
// Revision 1.13.8.35  2006/07/03 11:58:52  lulin
// - передаем не множество клавиш, а "состояние мыши".
//
// Revision 1.13.8.34  2006/02/13 14:58:35  dinishev
// Cleanup
//
// Revision 1.13.8.33  2005/12/27 14:18:10  dinishev
// Cleanup
//
// Revision 1.13.8.32  2005/12/14 15:55:26  dinishev
// Cleanup
//
// Revision 1.13.8.31  2005/11/29 12:57:50  lulin
// - вычищенно слишком сложное приведение типов.
//
// Revision 1.13.8.30  2005/11/29 12:37:51  dinishev
// Bug fix: функция _pm_GetCursor не всегда возвращала результат
//
// Revision 1.13.8.29  2005/11/23 08:57:34  dinishev
// Подправлена реакция кнопок на движение мыши
//
// Revision 1.13.8.28  2005/11/09 16:14:28  lulin
// - bug fix: с Shift'ом была возможность выделить всю группу контролов.
//
// Revision 1.13.8.27  2005/11/09 15:28:23  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.13.8.26  2005/10/22 13:47:07  dinishev
// Bug fix: кнопка на панели появляется только при наведении на неё
//
// Revision 1.13.8.25  2005/10/22 09:53:47  dinishev
// Bug fix: кнопка на панели не всплывает, если панель нельзя свернуть
//
// Revision 1.13.8.24  2005/10/07 14:51:28  dinishev
// Событие о движение мыши теперь попадает в BlockHotSpot
//
// Revision 1.13.8.23  2005/10/05 17:33:51  dinishev
// Контекстные меню
//
// Revision 1.13.8.22  2005/09/28 12:40:07  dinishev
// no message
//
// Revision 1.13.8.21  2005/09/22 09:16:14  lulin
// - bug fix: по Double-Click выделялась вся группа контролов.
//
// Revision 1.13.8.20  2005/09/20 15:54:52  dinishev
// Bug fix: при щелчке на заголовке группы не пропадал выпадающий контрол
//
// Revision 1.13.8.19  2005/09/13 13:56:38  lulin
// - bug fix: неправильно определялось, что мышь находится в кнопке.
//
// Revision 1.13.8.18  2005/09/07 14:24:49  dinishev
// Bug fix: AV + не было реакции на кнопки
//
// Revision 1.13.8.17  2005/09/07 09:05:11  dinishev
// Remove interface InevInputListener
//
// Revision 1.13.8.16  2005/08/25 15:29:34  lulin
// - bug fix: не возвращался результат.
//
// Revision 1.13.8.15  2005/07/28 10:54:28  lulin
// - упрощен путь получения пользовательских данных для контрола.
//
// Revision 1.13.8.14  2005/07/27 19:25:36  lulin
// - избавился от глобальных объектов для КЗ - теперь с каждым редактором связана своя обвязка для карточки запроса.
//
// Revision 1.13.8.13  2005/07/27 16:07:03  lulin
// - переупорядочил наименование и расположение интерфейсов для КЗ.
//
// Revision 1.13.8.12  2005/07/22 14:59:41  dinishev
// Поддержка промежуточного слоя
//
// Revision 1.13.8.11  2005/07/18 10:26:12  lulin
// - удален ненужный интерфейс окна.
//
// Revision 1.13.8.10  2005/07/07 17:46:58  lulin
// - new behavior: транслируем экранные координаты в координаты параграфа, используя информацию от View.
//
// Revision 1.13.8.9  2005/07/07 16:54:01  lulin
// - cleanup.
//
// Revision 1.13.8.8  2005/07/07 11:41:16  lulin
// - передаем в _GetAdvancedHotSpot специальный интерфейс InevViewPoint.
//
// Revision 1.13.8.7  2005/07/05 16:02:44  lulin
// - bug fix: восстановлен скроллинг при выделении текста мышью.
//
// Revision 1.13.8.6  2005/06/21 13:54:53  lulin
// - cleanup: удалены ненужные методы.
//
// Revision 1.13.8.5  2005/06/21 13:13:08  lulin
// - cleanup: удалены ненужные методы.
//
// Revision 1.13.8.4  2005/06/20 15:42:09  lulin
// - cleanup: избавляемся от абсолютных координат.
//
// Revision 1.13.8.3  2005/06/14 12:38:58  lulin
// - избавился от передачи безликого интерфейса (теперь передается View).
//
// Revision 1.13.8.2  2005/06/14 10:01:30  lulin
// - избавился от передачи безликого интерфейса (теперь передается View).
//
// Revision 1.13.8.1  2005/06/11 08:55:38  lulin
// - в какой-то мере восстановлена работоспособность HotSpot'ов.
//
// Revision 1.13  2005/03/28 06:37:08  lulin
// - remove object: Tk2AtomW.
//
// Revision 1.12  2005/03/24 12:08:12  lulin
// - remove method: Ik2TagBox._Tag.
// - new method: Ik2TagBox._Target.
//
// Revision 1.11  2005/03/23 11:48:03  lulin
// - вызов метода заменен на обращение к свойству.
//
// Revision 1.10  2005/03/23 09:51:58  lulin
// - new prop: _Ik2Tag.BoolA.
//
// Revision 1.9  2005/03/19 16:39:50  lulin
// - спрятаны ненужные методы.
//
// Revision 1.8  2005/03/16 10:20:23  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.7  2005/03/10 17:44:02  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.6  2005/03/10 14:58:38  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.5  2005/02/25 07:10:10  dinishev
// no message
//
// Revision 1.4  2005/02/11 08:12:27  dinishev
// Более продвинутая версия
//
// Revision 1.4  2000/12/15 15:10:33  dinishev
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

uses
  l3IID,
  l3Types,
  l3Units,
  l3Interfaces,

  afwInterfaces,

  evTypes,
  evInternalInterfaces,
  evQueryCardInt,
  evControlsBlockConst,
  evDocumentPartHotSpotTester,

  nevTools,
  nevGUIInterfaces,
  evControlsBlockHotSpotTesterPrim
  ;

type
  TevControlsBlockHotSpotTester = class(TevControlsBlockHotSpotTesterPrim)
  private
   f_ActionFlag : TContrBlockActFlags;
  protected
      procedure DoHitTest(const aView  : InevControlView;
                        const aState : TafwCursorState;
                        var theInfo  : TafwCursorInfo);
        override;
        {-}
  protected
  public
   //public methods
   function DoGetAdvancedHotSpot(const aView  : InevControlView;
                               const aState : TevCursorState;
                               const aPt    : InevBasePoint;
                               const aMap   : InevMap;
                               out theSpot  : IevHotSpot) : Boolean;
    override;
     {-}
   function DoMouseAction(const aView : InevControlView;
                        aButton     : TevMouseButton;
                        anAction    : TevMouseAction;
                        const Keys  : TevMouseState;
                        var Effect  : TevMouseEffect): Bool;
    override;
     {-}
   function  PointInBtn(const aPt: TafwPoint): Boolean;
     {-}
  end;//TevContolsBlockHotSpotTester

implementation

uses
  SysUtils,

  k2Base,
  k2Tags,
  
  l3String,
  l3MinMax,

  evParaTools,
  evHotSpotMisc,

  Cloak_Const
  ;

// start class TevControlsBlockHotSpotTester 

function TevControlsBlockHotSpotTester.DoGetAdvancedHotSpot(const aView  : InevControlView;
                                                          const aState : TevCursorState;
                                                          const aPt    : InevBasePoint;
                                                          const aMap   : InevMap;
                                                          out theSpot  : IevHotSpot) : Boolean;
begin
 f_ActionFlag := ev_cbNoAction;
 thisMap := aMap;
 if l3IsNil(ParaX.AsObject.PCharLenA[k2_tiShortName]){ AND
    not ParaX.IsKindOf(k2_typCloak)} then
  Result := inherited DoGetAdvancedHotSpot(aView, aState, aPt, aMap, theSpot)
 else
 if PointInBtn(aState.rPoint) then
 begin
  f_ActionFlag := ev_cbMainSurface;
  theSpot := TevHotSpotWrap.Make(Self);
  Result := true;
 end//if (aPt.Y < evControlBlockBefore) then
 else
 begin
  if (thisMap <> nil) AND
     ParaX.AsObject.IsKindOf(k2_typCloak) AND
     (Tl3Point(aState.rPoint).Sub(Tl3Rect(thisMap.Bounds).TopLeft).Y <=
      (evControlBlockBefore - evControlBlockTop)) then
  begin
   f_ActionFlag := ev_cbMainSurface;
   theSpot := TevHotSpotWrap.Make(Self);
   Result := true;
  end//..ParaX.IsKindOf(k2_typCloak)..
  else
   Result := inherited DoGetAdvancedHotSpot(aView, aState, aPt, aMap, theSpot);
 end;//PointInBtn(aState.rPoint)
end;

function TevControlsBlockHotSpotTester.DoMouseAction(const aView : InevControlView;
                                                     aButton     : TevMouseButton;
                                                     anAction    : TevMouseAction;
                                                     const Keys  : TevMouseState;
                                                     var Effect  : TevMouseEffect): Bool;
var
 l_Pt : TnevPoint;
 l_CL : IevQueryGroup;
begin
 l_Pt := aView.FormatInfoByPara(ParaX).ParentToClient(Tl3Point(Keys.rPoint));
 case aButton of
  ev_mbRight :
  begin
   Result := False;
   if anAction = ev_maDown then
   begin
    l_CL := GetControl;
    if (l_CL <> nil) then
     l_CL.QueryCard.RememberState(l_CL);
   end;
  end;
  ev_mbLeft :
  begin
   case anAction of
    ev_maDown:
    begin
      l_CL := GetControl;
      if (l_CL = nil) then
      begin
       if ParaX.AsObject.IsKindOf(k2_typCloak) then
       begin
        Effect.rNeedAsyncLoop := false;
        Result := true;
       end//ParaX.IsKindOf(k2_typCloak)
       else
        Result := false;
      end//l_CL = nil
      else
       try
        Result := l_CL.LMouseBtnDown(aView, nil,
                                     Tl3Point(Keys.rPoint), Keys, thisMap);
        if Result then
         Effect.rNeedAsyncLoop := false;
       finally
        l_CL := nil;
       end;//try..finally
    end;//ev_maDown
    ev_maMove:
    begin
     CommonControl.Checked := MouseInBtn(Tl3Point(l_Pt));
     Result := True;
    end;//ev_maMove
    ev_maUp: begin
     l_CL := GetControl;
     if (l_CL = nil) then
     begin
      if ParaX.AsObject.IsKindOf(k2_typCloak) then
      begin
       Effect.rNeedAsyncLoop := false;
       Result := true;
       ParaX.AsObject.BoolW[k2_tiCollapsed, aView.Control.Processor.StartOp] :=
        not ParaX.AsObject.BoolA[k2_tiCollapsed]; 
      end//ParaX.IsKindOf(k2_typCloak)
      else
       Result := False;
     end//l_CL = nil
     else 
      try
       Result := l_CL.LMouseBtnUp(aView, nil, Tl3Point(Keys.rPoint), Keys);
      finally
       l_CL := nil;
      end;//try..finally
    end;//ev_maUp
    {.$IfNDef Nemesis}
    ev_maDouble :
    begin
     Result := true; //Выключаем обработку сообщений как у предка
     Effect.rNeedAsyncLoop := false;
     Effect.rAllowAutoSelect := false;
    end;//ev_maDouble
    {.$EndIf  Nemesis}
    else
     Result := False;
   end;//case anAction
  end;//ev_mbLeft
  else
   //if not Result then
    Result := inherited DoMouseAction(aView, aButton, anAction, Keys, Effect);
 end;//case aButton
end;

procedure TevControlsBlockHotSpotTester.DoHitTest(const aView  : InevControlView;
                                                const aState : TafwCursorState;
                                                var theInfo  : TafwCursorInfo);
  //override;
  {-}
begin
 inherited;
 if (f_ActionFlag <> ev_cbNoAction) then
 begin
  if ParaX.AsObject.IsKindOf(k2_typCloak) then
   theInfo.rCursor := ev_csHandPoint
  else
   theInfo.rCursor := ev_csArrow;
 end;//f_ActionFlag <> ev_cbNoAction
end;

function TevControlsBlockHotSpotTester.PointInBtn(const aPt: TafwPoint): Boolean;
var
 l_Width : Integer;
 l_Pt    : Tl3Point;
begin
 if (thisMap = nil) then
  Result := false
 else
 begin
  l_Pt := Tl3Point(aPt).Sub(Tl3Rect(thisMap.Bounds).TopLeft);
  l_Width := thisMap.FI.rLimitWidth;
  Result := (l_Pt.X >= evControlBlockLeft) and (l_Pt.Y >= evControlBlockTop) and
     (l_Pt.Y <= (evControlBlockBefore - evControlBlockTop)) and
     (l_Pt.X <= l_Width);
 end;///thisMap = nil
end;

end.
