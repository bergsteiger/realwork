unit evRuler;
{* Реализация компонентов линеек. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evRuler - реализация горизонтальной и вертикальной линеек }
{ Начат: 17.03.1997 14:56 }
{ $Id: evRuler.pas,v 1.84 2015/06/03 12:43:15 lulin Exp $ }

// $Log: evRuler.pas,v $
// Revision 1.84  2015/06/03 12:43:15  lulin
// - пытаемся разрулить зависимости.
//
// Revision 1.83  2014/12/02 10:13:41  kostitsin
// {requestlink: 570118718 } - evVisualInterfaces
//
// Revision 1.82  2014/12/02 09:32:56  kostitsin
// {requestlink: 570118718 } - evVisualInterfaces
//
// Revision 1.81  2012/08/10 18:19:08  lulin
// {RequestLink:382421301}.
//
// Revision 1.80  2009/06/02 16:12:53  lulin
// - выделяем внутренние интерфейсы в отдельные модули.
//
// Revision 1.79  2009/04/23 06:14:41  dinishev
// <K> : 142613601
//
// Revision 1.78  2009/04/16 05:29:45  oman
// Не собиралась библиотека
//
// Revision 1.77  2008/09/26 10:10:47  dinishev
// <K>: 77235630 для Head'а
//
// Revision 1.76  2008/06/09 11:45:47  lulin
// - <K>: 93264011.
//
// Revision 1.75  2008/04/11 13:54:04  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.74  2008/03/19 14:23:34  lulin
// - cleanup.
//
// Revision 1.73  2008/03/03 15:49:17  lulin
// - типизируем список маркеров параграфа.
//
// Revision 1.72  2008/03/03 13:35:31  lulin
// - nevTools перенесён на модель. Теперь всё компилируется.
//
// Revision 1.71  2008/02/04 08:51:24  lulin
// - класс _Tl3InterfaceList выделен в отдельный модуль.
//
// Revision 1.70  2008/01/31 18:53:27  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.69  2007/12/18 10:06:02  fireton
// - ev_CmInInch -> ev_MmInInch (неправильно называлась константа)
//
// Revision 1.68  2007/12/04 12:47:04  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.63.8.13  2007/08/14 19:31:30  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.63.8.12  2007/06/22 19:32:23  lulin
// - cleanup.
//
// Revision 1.63.8.11  2007/06/19 08:53:28  dinishev
// восстанавливаем функциональность для ветки
//
// Revision 1.63.8.10  2007/02/13 17:32:55  lulin
// - избавляемся от использования стандартной функции поиска подстроки в строке.
//
// Revision 1.63.8.9  2007/02/12 18:06:13  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.63.8.8  2005/10/25 11:05:44  lulin
// - не получаем напрямую информационную канву экрана, а получаем ее через фасад.
//
// Revision 1.63.8.7  2005/10/06 09:17:50  lulin
// - базовый класс панелей переехал в более правильное место.
//
// Revision 1.63.8.6  2005/07/19 12:50:06  lulin
// - часть базовых интерфейсов переехала в модуль nevTools.
//
// Revision 1.63.8.5  2005/07/15 10:14:03  lulin
// - избавляемся от использования самостийной функции преобразования интерфейсов.
//
// Revision 1.63.8.4  2005/05/31 14:48:01  lulin
// - cleanup: при работе с курсорами используем интерфейсы, а не объекты.
//
// Revision 1.63.8.3  2005/05/26 13:19:28  lulin
// - new unit: _l3ScreenIC.
//
// Revision 1.63.8.2  2005/05/24 14:50:01  lulin
// - готовим модуль evGraph к переезду в L3.
//
// Revision 1.63.8.1  2005/05/24 12:48:15  lulin
// - для канвы используем интерфейс, а не объект.
//
// Revision 1.63  2005/02/22 12:27:39  lulin
// - рефакторинг работы с Tl3Point и Tl3Rect.
//
// Revision 1.62  2004/11/03 10:39:32  lulin
// - new unit: l3Region.
//
// Revision 1.61  2004/09/16 12:20:50  lulin
// - удалено большинство нечитабельных include'ов.
//
// Revision 1.60  2004/09/16 09:24:59  lulin
// - bug fix: наследники от evCtrl убивались в DesignTime произвольным образом.
//
// Revision 1.59  2004/09/15 16:44:56  lulin
// - в зависимости от DesignTimeLibrary перекрываем Destroy или Cleanup.
//
// Revision 1.58  2004/09/15 16:20:37  lulin
// - bug fix: AllEverestComponents7 не собирался из-за Str_Man'а.
// - bug fix: AllEverestComponents7 не загружался из-за шаблонов.
//
// Revision 1.57  2004/09/02 15:04:30  fireton
// - bug fix: ошибка прорисовки Bevel у TvtCustomPanel
//
// Revision 1.56  2004/06/02 10:20:33  law
// - удален конструктор Tl3VList.MakeIUnknown - пользуйтесь _Tl3InterfaceList.Make.
//
// Revision 1.55  2004/05/25 16:14:40  law
// - change: правильнее определяем необходимость записывания свойства BGap.
//
// Revision 1.54  2003/05/28 16:15:52  law
// - chage: развязал модули evEdWnd и evRuler.
//
// Revision 1.53  2003/05/23 16:33:45  law
// - cleanup: используем IevMarker вместо TevMarker.
//
// Revision 1.52  2003/05/23 15:56:38  law
// - cleanup.
//
// Revision 1.51  2003/05/23 15:00:10  law
// - new behavior: в исполнении WordLike не даем изменять размер бумаги и отступы на странице.
//
// Revision 1.50  2003/05/23 13:14:42  law
// - new prop: TevCustomRuler.DrawTabs.
// - new proc: TevCustomRuler.NeedDrawTabs.
//
// Revision 1.49  2003/05/23 12:56:54  law
// - new proc: TevCustomRuler.GetTabsHeight.
//
// Revision 1.48  2003/05/22 17:31:20  law
// - new behavior: засечки на линейке теперь изменяются кратно единицам измерения.
//
// Revision 1.47  2003/05/22 15:53:20  law
// - new proc: TevCustomRuler.GetUnitsParam.
//
// Revision 1.46  2003/05/22 13:10:09  law
// - cleanup.
//
// Revision 1.45  2003/05/20 13:09:59  law
// - new behavior: используем стандартные цвета.
//
// Revision 1.44  2003/05/19 17:19:12  law
// - bug fix: используем стандартный цвет.
//
// Revision 1.43  2003/05/19 11:04:47  law
// - rename proc: evChar2Pixel -> evChar2Inch.
//
// Revision 1.42  2003/05/15 13:54:43  law
// - bug fix: на вертикальной линейке "мусорно" рисовались цифры.
//
// Revision 1.41  2003/05/15 13:41:54  law
// - new behavior: на горизонтальной линейке рисуем позиции табуляции.
// - new prop: TevCustomRuler.WordLike.
//
// Revision 1.40  2003/04/15 13:26:43  law
// - new unit: evUnits.
//
// Revision 1.39  2002/08/02 08:32:13  law
// no message
//
// Revision 1.38  2002/07/09 12:02:21  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.37  2001/11/27 14:59:02  law
// - change behavior: вместо TevMarker используем IevMarker.
//
// Revision 1.36  2001/11/26 12:16:29  law
// - cleanup.
//
// Revision 1.35  2001/11/23 17:25:21  law
// - cleanup.
//
// Revision 1.34  2001/11/23 16:44:54  law
// - change: замена использования TevMarker на IevMarker.
//
// Revision 1.33  2001/11/23 09:25:09  law
// - cleanup: убраны зависимости от K-2.
//
// Revision 1.32  2001/09/07 08:53:01  law
// - rename procedures: evPointX -> l3PointX, evPointY -> l3PointY.
//
// Revision 1.31  2001/04/24 12:40:44  law
// - new behavior:
//  1. Немного поправлена линейка - иногда не перерисовывались засечки.
//  2. Немного изменен алгоритм вычисления шрифта выделения - теперь выделение на больших файлах появляется без задержки.
//
// Revision 1.30  2001/04/18 13:25:23  law
// - comments: добавлены комментарии для xHelpGen.
//
// Revision 1.29  2001/04/17 17:01:13  law
// - bug fix: поправлена ошибка точности при вычислении числа символов на линейке.
//
// Revision 1.28  2001/04/17 14:55:47  law
// - new behavior: для линейки, привязанной к редактору, для непреформатированных параграфов, ширина символа сделана равной псевдосимволу в NSRC.
//
// Revision 1.27  2001/04/09 13:51:14  law
// - new behavior: сделан перенос начала координат на линейке, относительно текущего параграфа.
//
// Revision 1.26  2001/03/27 08:01:58  law
// - TevPoint -> Tl3Point, TevRect -> Tl3Rect.
//
// Revision 1.25  2001/02/26 14:06:12  law
// - дописаны комментарии.
//
// Revision 1.24  2001/01/31 15:20:58  law
// - _TevParaCursor -> IevMarkerSource.
//
// Revision 1.23  2001/01/31 10:37:30  law
// - оптимизировано использование QueryInterface.
//
// Revision 1.22  2000/12/19 15:52:40  law
// - убраны ненужные директивы компиляции.
//
// Revision 1.21  2000/12/15 15:10:37  law
// - вставлены директивы Log.
//
// переделан Люлиным А.В. 9 февраля 1996
//
// By Bill Murto, 73730,2505 No Copyright. Free. Enjoy.


{$Include evDefine.inc }

interface

uses
  Windows,
  Messages,
  Classes,
  Graphics,
  Controls,
  Forms,

  l3Types,
  l3InternalInterfaces,
  l3Base,
  l3Units, {- работа с различными единицами измерения}
  l3InterfaceList,
  
  evTypes,
  evDef,
  evLinkedToolPanel,
  evVisualInterfaces,
  evMarkersList,

  nevTools
  ;

const
 StrobWidth = 1;

const
 cM = 1000;

type
  TevCustomRuler = class(TevCustomLinkedToolPanel,
                         IevZoomedLinkedToolWindow,
                         IevRuler)
   {* Базовый класс для линеек. }
    private
    // private fields
      fl_Markers       : TevMarkersList;
      fl_SmallFont     : Bool;
      fl_OldUnits      : TevUnits;
      fl_OldCharWidth  : Long;
      fl_HintMarker    : Long;
      // Поля для обработки перемещения маркера:
      fl_MoveInProcess : Boolean;
      FirstPos         : Integer;
      fl_MouseDelta    : Integer;
      // - Смещение позиции мыши относительно маркера
      fl_PrevRect      : Tl3SRect;
      fl_DragDC        : HDC;
      fl_DragMarker    : Long;
    private
    // property fields
      f_Margin        : TevPixel;
      f_Delta         : TevInch;
      f_Units         : TevUnits;
      f_CharWidth     : Word;
      f_Zoom          : SmallInt;
      f_SmallFont     : TFont;
      f_BGap          : TevPixel;
      f_AdjustBGap    : Bool;
      f_WordLike      : Bool;
      f_DrawTabs      : Bool;
    private
    // event fields
      f_OnSetMarker   : TevOnSetMarker;
    private
    // message handlers
      procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd);
        message WM_ERASEBKGND;
        {-}
      // Обработка движения маркеров мышью:
      procedure WMLButtonDown(var Msg: TWMLButtonDown);
        message WM_LBUTTONDOWN;
        {-}
      procedure WMLButtonUp(var Msg: TWMLButtonUp);
        message WM_LBUTTONUP;
        {-}
      procedure WMMouseMove(var Msg: TWMMouseMove);
        message WM_MOUSEMOVE;
        {-}
      procedure WMSize(var Msg: TWMSize);
        message WM_Size;
        {-}
      procedure WMNCHitTest(var Msg: TWMNCHitTest);
        message WM_NCHitTest;
        {-}
    protected
    // property methods
      { Процедуры для работы со свойствами. }
      function  pm_GetUnits: TevUnits;
      procedure pm_SetUnits(Value: TevUnits);
        {-}
      function  pm_GetCharWidth : Word;
      procedure pm_SetCharWidth(Value : Word);
        {-}
      procedure pm_SetMarkerValue(Index: Long; Value: TevInch);
        virtual;
        {* - Устанавливает позицию макркера с индексом Index. }
      function  pm_GetMarkerValue(Index: Long) : TevInch;
        virtual;
        {* - Возвращает позицию макркера с индексом Index. }
      function  pm_GetMarkerStyle(ParaMarker: Long): TevParaMarkerStyle;
        {-}
      function  pm_GetMarkerCount: Long;
        {-}
      procedure pm_SetOnSetMarker(aValue: TevOnSetMarker);
        {-}
      procedure ViewChanged(const aView: InevView);
        {* - нотификация об изменении View'а для макросов. }
    protected
    // internal methods
      // Процедуры рисования маркеров:
      function  GetMarkerRect(ParaMarker: Long) : Tl3SRect;
        {-}
      function  GetMarkerRectPrim(MV   : TevInch;
                                  MS   : TevParaMarkerStyle;
                                  Incr : Bool): Tl3SRect;
        {-}
      function  MarkerByPos(const aPos : Tl3SPoint): Long;
        {-}
      procedure DrawMarker(const aCanvas: Il3Canvas; ParaMarker : Long);
        {-}
      procedure BeginDrag(nX, nY: Integer);
        {-}
      procedure EndDrag(nX, nY: Integer);
        {-}
      procedure Drag(nX, nY: Integer);
        {-}
      procedure Paint(const aCanvas: Il3Canvas);
        override;
        {-}
      function  NeedInvalidateAll: Bool;
        {-}
      function  GetNullOffset: Long;
        {-}
      procedure GetUnitsParam(var theOneUnit, theDivizor, theMultiplier: Long;
                              InInch : Bool);
        {-}
      function  GetTabsHeight: Long;
        {-}
      function  NeedDrawTabs: Bool;
        {-}
    protected
    // property methods
      procedure pm_SetDelta(Value: TevInch);
        {-}
      function  pm_GetZoom: SmallInt;
      procedure pm_SetZoom(Value: SmallInt);
        {-}
      procedure pm_SetSmallFont(Value: TFont);
        {-}
      procedure pm_SetBGap(Value: TevPixel);
        {-}
      procedure pm_SetMargin(Value: TevPixel);
        {-}
      procedure pm_SetAdjustBGap(Value: Bool);
        {-}
      procedure pm_SetWordLike(aValue: Bool);
        {-}
      procedure pm_SetDrawTabs(aValue: Bool);
        {-}
      function  BGapStored: Boolean;
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(AOwner: TComponent);
        override;
        {-}
      procedure DoScroll(iD: TevInch);
        override;
        {-}
      procedure ControlMoved;
        {* - Нотификация о движении Control'а к которому привязана линейка. }
      procedure MarkersChanged(const aView : InevView;
                               const aCursor: IevMarkersSource);
        {* - Нотификация об изменении маркеров. }
    public
    // public properties
      property Margin: TevPixel
        read f_Margin
        write pm_SetMargin;
        {* - Отступ слева. }
      property Delta: TevInch
        read f_Delta
        write pm_SetDelta;
        {-}
      property Option[Index : Long] : TevInch
        read pm_GetMarkerValue
        write pm_SetMarkerValue;
        {-}
      property MarkerStyle[ParaMarker: Long]: TevParaMarkerStyle
        read pm_GetMarkerStyle;
        {-}
      property Zoom: SmallInt
        read f_Zoom
        write pm_SetZoom
        default def_Zoom;
        {-}
      property MarkerCount: Long
        read pm_GetMarkerCount;
        {-}
    public
    // public events
      property OnSetMarker: TevOnSetMarker
        read f_OnSetMarker
        write f_OnSetMarker;
        {-}
    public
      property Color
        default clBtnFace;
        {-}
      property Height
        default 33;
        {* - Высота линейки. }
      property Width
        default 768;
        {* - Ширина линейки. }
      property Visible;
        {-}
      property CharWidth: Word
        read pm_GetCharWidth
        write pm_SetCharWidth
        default def_CharWidth * cM;
        {-}
      property Units: TevUnits
        read pm_GetUnits
        write pm_SetUnits
        default ev_unInch;
        {* - Единицы измерения линейки. }
      property SmallFont: TFont
        read f_SmallFont
        write pm_SetSmallFont;
        {* - Шрифт для показа маленьких цифр. }
      property BGap: TevPixel
        read f_BGap
        write pm_SetBGap
        stored BGapStored;
        {-}
      property AdjustBGap: Bool
        read f_AdjustBGap
        write pm_SetAdjustBGap
        default true;
        {-}
      property WordLike: Bool
        read f_WordLike
        write pm_SetWordLike
        default true;
        {-}
      property DrawTabs: Bool
        read f_DrawTabs
        write pm_SetDrawTabs
        default true;
        {-}
  end;//TevCustomRuler

  TevRuler = class(TevCustomRuler)
   {*! Класс линеек для применения программистом в дизайнере форм. }
    published
    // parents' properties
      property Align;
      property Alignment;
      property BevelInner;
      property BevelOuter;
      property BevelWidth;
      property BorderWidth;
      property BorderStyle;
      property DragCursor;
      property DragMode;
      property Enabled;
      property Caption;
      property Color;
      property Ctl3D;
      property Font;
      // property Locked;
      property ParentColor;
      property ParentCtl3D;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property TabOrder;
      property TabStop;
      property Visible;
      property OnClick;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnResize;
    published
    // own properties
      property CharWidth;
        {-}
      property Units;
        {-}
      property Orientation;
        {-}
      property SmallFont;
        {-}
      property BGap;
        {-}
      property AdjustBGap;
        {-}
      property WordLike;
        {-}  
      property DrawTabs;
        {-}  
  end;//TevRuler

implementation

uses
  SysUtils,

  l3Interfaces,
  l3MinMax,
  l3Math,
  l3Const,
  l3String,
  l3InterfacesMisc,
  l3Region,
  l3UnitsTools,

  nevFacade,
  nevBase,

  evInternalInterfaces,
  evEditorInterfaces,
  evConst
  ;

// start class TevCustomRuler  

constructor TevCustomRuler.Create(AOwner: TComponent);
begin
 inherited;
 ControlStyle := ControlStyle - [csSetCaption];
 Color := clBtnFace;
 Height := 33;
 Width := 768;
 f_Units := ev_unInch;
 Orientation := ev_orHorizontal;
 f_CharWidth := def_CharWidth * cM;
 fl_Markers := TevMarkersList.Make;
 f_SmallFont := TFont.Create;
 with f_SmallFont do 
 begin
  Name := def_SmallFontName;
  Size := def_SmallFontSize;
 end;{with f_SmallFont..}
 with Font do 
 begin
  Name := def_SmallFontName;
  Size := 6;
 end;{with Font..}
 f_Zoom := def_Zoom;
 f_AdjustBGap := True;
 BevelInner := bvLowered;
 BevelOuter := bvRaised;
 WordLike := True;
 DrawTabs := True;
end;

procedure TevCustomRuler.Cleanup;
begin
 l3Free(fl_Markers);
 l3Free(f_SmallFont);
 inherited;
end;

procedure TevCustomRuler.DoScroll(iD: TevInch);
  {-}
var
 l_CR : Tl3SRect;
 l_S  : Bool;
 l_D  : TevPixel;
 l_UR : Tl3SRect;
begin
 f_Delta := f_Delta - iD;
 l_D  := evPixelZoom(Zoom, nev.CrtIC.LP2DP(l3PointX(iD)).X);
 l_CR.InitRect(ClientRect);
 Inc(l_CR.R.TopLeft.P.oPt[Orientation], BGap);
 l_CR.Inflate1(-Succ(BevelWidth));
 l_S := True;
 case Orientation of
  ev_orHorizontal :
   if (Abs(l_D) < (l_CR.R.Right - l_CR.R.Left)) then 
     ScrollWindowEx(Handle, l_D, 0, @l_CR, @l_CR, 0, @l_UR, 0) 
   else 
     l_S := False;
  ev_orVertical   :
   if (Abs(l_D) < (l_CR.R.Bottom - l_CR.R.Top)) then 
     ScrollWindowEx(Handle, 0, l_D, @l_CR, @l_CR, 0, @l_UR, 0) 
   else 
     l_S := False;
 end;{case Orientation}
 if l_S then 
 begin
  l_UR.Inflate1(1);
  l_UR.Invalidate(Handle, False);
  Update;
 end 
 else 
   Invalidate;
end;

procedure TevCustomRuler.ControlMoved;
  {-}
var
 l_RD : Tl3SPoint; 
 l_CD : Tl3SPoint;
begin
 if (Control <> nil) AND f_AdjustBGap then 
 begin
  l_RD := Point0;
  l_CD := Point0;
  l_RD.Convert(ClientToScreen);
  l_CD.Convert(Control.ClientToScreen);
  case Orientation of
   ev_orHorizontal : f_BGap := l_CD.X - l_RD.X;
   ev_orVertical   : f_BGap := l_CD.Y - l_RD.Y;
  end;{case Orientation..}
  Invalidate;
 end;
end;

function TevCustomRuler.NeedInvalidateAll: Bool;
  {-}
var
 l_CharWidth : Long;
 l_Unints    : TevUnits;
begin
 l_Unints := Units;
 l_CharWidth := CharWidth;
 try
  Result := (l_Unints <> fl_OldUnits) OR (l_CharWidth <> fl_OldCharWidth);
  if Result then Invalidate;
 finally
  fl_OldUnits := l_Unints;
  fl_OldCharWidth := l_CharWidth;
 end;{try..finally}
end;

procedure TevCustomRuler.MarkersChanged(const aView : InevView;
                                        const aCursor: IevMarkersSource);
  {-}
var
 i              : Long;
 l_MarkersList  : TevMarkersList;
 l_Region       : Tl3Region;
 l_OldMarker    : IevMarker;
 l_NewMarker    : IevMarker;
 l_MarkersCount : Integer;
begin
 NeedInvalidateAll;
 if (MarkerCount > 0) then 
 begin
  l_MarkersList := TevMarkersList.Make;
  try
   if (aCursor <> nil) then 
    aCursor.GetMarkers(aView, l_MarkersList);
   l_Region := Tl3Region.Create;
   try
    l_MarkersCount := Max(l_MarkersList.Count, MarkerCount) - 1;
    for i := 0 to l_MarkersCount do 
    begin
     if (i < l_MarkersList.Count) then
      l_NewMarker := l_MarkersList[i]
     else
      l_NewMarker := nil;
     if (i < MarkerCount) then
      l_OldMarker := fl_Markers[i]
     else
      l_OldMarker := nil;
     if ((l_NewMarker = nil) AND (l_OldMarker <> nil)) OR ((l_NewMarker <> nil) AND (l_NewMarker.Compare(l_OldMarker) <> 0)) then 
     begin
      if (l_OldMarker <> nil) then 
      begin
       l_Region.CombineRect(GetMarkerRectPrim(l_OldMarker.Value, l_OldMarker.Style, True), RGN_OR);
       l_Region.CombineRect(GetMarkerRectPrim(l_OldMarker.Acc, l_OldMarker.Style, True), RGN_OR);
      end;
      if (l_NewMarker <> nil) then 
      begin
       l_Region.CombineRect(GetMarkerRectPrim(l_NewMarker.Value, l_NewMarker.Style, True), RGN_OR);
       l_Region.CombineRect(GetMarkerRectPrim(l_NewMarker.Acc, l_NewMarker.Style, True), RGN_OR);
      end;
     end;
    end;{for i := 0..}
    l_Region.Invalidate(Handle, False);
   finally
    l3Free(l_Region);
   end;{try..finally}
   l3Set(fl_Markers, l_MarkersList);
  finally
   l3Free(l_MarkersList);
  end;{try..finally}
 end 
 else 
 begin
  if (aCursor <> nil) then 
    aCursor.GetMarkers(aView, fl_Markers);
  Invalidate;
 end;
end;

procedure TevCustomRuler.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
begin
  Msg.Result := 1;  {don't erase background}
end;

procedure TevCustomRuler.pm_SetDelta(Value: TevInch);
  {-}
begin
 if (f_Delta <> Value) then 
 begin
  f_Delta := Value;
  Invalidate;
 end;{f_Delta <> Value}
end;

function TevCustomRuler.pm_GetZoom: SmallInt;
  {-}
begin
 Result := Zoom;
end;

procedure TevCustomRuler.pm_SetZoom(Value: SmallInt);
  {-}
begin
 if (Zoom <> Value) then 
 begin
  f_Zoom := Value;
  fl_SmallFont := (f_Zoom < 50);
  Invalidate;
 end;
end;

procedure TevCustomRuler.pm_SetSmallFont(Value: TFont);
  {-}
begin
 if (f_SmallFont <> nil) then 
 begin
  f_SmallFont.Assign(Value);
  if fl_SmallFont then Invalidate;
 end;{f_SmallFont <> nil}
end;

procedure TevCustomRuler.pm_SetBGap(Value: TevPixel);
  {-}
begin
 if (f_BGap <> Value) AND not f_AdjustBGap then 
 begin
  f_BGap := Value;
  Invalidate;
 end;
end;

procedure TevCustomRuler.pm_SetMargin(Value: TevPixel);
  {-}
begin
 if (f_Margin <> Value) then 
 begin
  f_Margin := Value;
  Invalidate;
 end;
end;

procedure TevCustomRuler.pm_SetAdjustBGap(Value: Bool);
  {-}
begin
 if (f_AdjustBGap <> Value) then 
 begin
  f_AdjustBGap := Value;
  ControlMoved;
 end;
end;

procedure TevCustomRuler.pm_SetWordLike(aValue: Bool);
  {-}
begin
 if (f_WordLike <> aValue) then 
 begin
  f_WordLike := aValue;
  Invalidate;
 end;//f_WordLike <> aValue
end;

procedure TevCustomRuler.pm_SetDrawTabs(aValue: Bool);
  {-}
begin
 if (f_DrawTabs <> aValue) then 
 begin
  f_DrawTabs := aValue;
  Invalidate;
 end;//f_DrawTabs <> aValue
end;

function TevCustomRuler.BGapStored: Boolean;
  {-}
begin
 Result := not AdjustBGap AND (BGap <> 0);
end;

function TevCustomRuler.GetMarkerRect(ParaMarker: Long) : Tl3SRect;
begin
 Result := GetMarkerRectPrim(Option[ParaMarker], MarkerStyle[ParaMarker], false);
end;

function TevCustomRuler.GetTabsHeight: Long;
  {-}
begin
 Result := 0;
 if NeedDrawTabs then 
  Result := Min(ClientHeight div 5, 10);
  // - Резервируем место для позиций табуляции
end;

function TevCustomRuler.NeedDrawTabs: Bool;
  {-}
begin
 Result := DrawTabs AND (Orientation = ev_orHorizontal);
end;

function TevCustomRuler.GetMarkerRectPrim(MV   : TevInch;
                                          MS   : TevParaMarkerStyle;
                                          Incr : Bool): Tl3SRect;
var
 l_Half   : TevPixel;
 l_Op     : TevPixel;
 l_Height : Long;
begin
 l3FillChar(Result, SizeOf(Result), 0);
 if (MV = l3NilLong) then Exit;

 l_Height := ClientHeight;

 Dec(l_Height, GetTabsHeight);

 l_Half := l_Height div 2;

 l_Op := evPixelZoom(Zoom, nev.CrtIC.LP2DP(l3PointX(MV - Delta)).X);
 Inc(l_Op, Margin);
 Inc(l_Op, BGap);
 case MS of
  ev_pmsNone: ;
  ev_pmsFirstIndent:
  begin
   Result.Top  := 3;
   Result.Bottom := l_Half;
   Result.Left := l_Op;
   Result.Right := Result.Left + (Result.Bottom - Result.Top);
  end;//ev_pmsFirstIndent
  ev_pmsLeftIndent:
  begin
   Result.Top  := l_Half;
   Result.Bottom := l_Height - 3;
   Result.Left  := l_Op - (Result.Bottom - Result.Top);
   Result.Right := l_Op;
  end;//ev_pmsLeftIndent
  ev_pmsWrapColumn:
  begin
   Result.Top  := l_Half;
   Result.Bottom := l_Height-3;
   Result.Left  := l_Op;
   Result.Right := l_Op + (Result.Bottom - Result.Top);
  end;//ev_pmsWrapColumn
  ev_pmsPageLeftIndent,
  ev_pmsParaIndent :
   with Result do
   begin
    R.Right  := l_Op;
    R.Top    := 3;
    R.Bottom := l_Height-3;
    R.Left   := R.Right-5;
   end;//with Result
  ev_pmsPageSize,
  ev_pmsPageRightIndent,
  ev_pmsParaSize:
   with Result do
   begin
    R.Left   := l_Op;
    R.Top    := 3;
    R.Bottom := l_Height-3;
    R.Right  := R.Left+5;
   end;//with Result
  ev_pmsColumnBorder:
   with Result do
   begin
    R.Left   := l_Op - 2;
    R.Top    := 3;
    R.Bottom := l_Height-3;
    R.Right  := R.Left+5;
   end;//with Result
  ev_pmsTabIndent: begin
   with Result do
   begin
    R.Right  := l_Op + 5;
    R.Top    := l_Height - 9;
    R.Bottom := l_Height - 3;
    R.Left   := l_Op - 5;
   end;//with Result
  end;
 end;//case MS
 if Incr then 
   Result.Inflate1(1);
end;

function TevCustomRuler.MarkerByPos(const aPos : Tl3SPoint): Long;
var
 l_R     : Tl3SRect;
 l_Index : Long;
begin
 Result := -1;
 if (MarkerCount > 0) then 
 begin
  for l_Index := Pred(MarkerCount) downto 0 do
  begin
   l_R := GetMarkerRect(l_Index);
   if l_R.ContainsPt(aPos) then 
   begin
    Result := l_Index;
    Break;
   end;//l_R.ContainsPt(Pos)
  end;//for l_Index
 end;//MarkerCount > 0..
end;

procedure TevCustomRuler.DrawMarker(const aCanvas: Il3Canvas; ParaMarker : Long);
var
 l_Rect        : Tl3SRect;
 l_MS  : TevParaMarkerStyle;
 l_OldPenWidth : Integer;
begin
 l_Rect := GetMarkerRect(ParaMarker);
 l_MS := MarkerStyle[ParaMarker]; 
 with aCanvas.Canvas do
 begin
  Pen.Color:= clBlack;
  Brush.Color := Self.Color;
  case l_MS of
   ev_pmsFirstIndent:
    begin
     Polygon([Point(l_Rect.Left, l_Rect.Top),
              Point(l_Rect.Right, l_Rect.Top),
              Point(l_Rect.Left, l_Rect.Bottom)]);
     Pen.Color := clBtnHighlight;
     PolyLine([Point(l_Rect.Left + 1, l_Rect.Bottom - 2),
               Point(l_Rect.Left + 1, l_Rect.Top + 1),
               Point(l_Rect.Right - 2, l_Rect.Top + 1)]);
     Pen.Color := Self.Color;
     MoveTo(l_Rect.Right - 2, l_Rect.Top + 1);
     LineTo(l_Rect.Left + 1, l_Rect.Bottom - 2);
    end;//ev_pmsFirstIndent
   ev_pmsLeftIndent:
    begin
     Polygon([Point(l_Rect.Right, l_Rect.Top),
              Point(l_Rect.Right, l_Rect.Bottom),
              Point(l_Rect.Left, l_Rect.Bottom)]);
     Pen.Color := Self.Color;
     PolyLine([Point(l_Rect.Left + 2, l_Rect.Bottom - 1),
               Point(l_Rect.Right - 1, l_Rect.Bottom - 1),
               Point(l_Rect.Right - 1, l_Rect.Top + 2)]);
     Pen.Color := clBtnHighlight;
     MoveTo(l_Rect.Right - 1, l_Rect.Top + 2);
     LineTo(l_Rect.Left + 2, l_Rect.Bottom - 1);
    end;//ev_pmsLeftIndent
   ev_pmsWrapColumn:
    begin
     Polygon([Point(l_Rect.Left, l_Rect.Bottom),
              Point(l_Rect.Left, l_Rect.Top),
              Point(l_Rect.Right, l_Rect.Bottom)]);
     Pen.Color := Self.Color;
     PolyLine([Point(l_Rect.Left + 1, l_Rect.Top + 2),
               Point(l_Rect.Right - 2, l_Rect.Bottom - 1),
               Point(l_Rect.Left + 1, l_Rect.Bottom - 1)]);
     Pen.Color := clBtnHighlight;
     MoveTo(l_Rect.Left + 1, l_Rect.Bottom - 1);
     LineTo(l_Rect.Left + 1, l_Rect.Top + 2);
    end;//ev_pmsWrapColumn
   ev_pmsColumnBorder:
    begin
     Polygon([Point(l_Rect.Right, l_Rect.Bottom),
              Point(l_Rect.Right, l_Rect.Top),
              Point(l_Rect.Left, l_Rect.Top),
              Point(l_Rect.Left, l_Rect.Bottom)]);

     Pen.Color := Self.Color;
     PolyLine([Point(l_Rect.Left + 1, l_Rect.Bottom - 1),
               Point(l_Rect.Right - 1, l_Rect.Bottom - 1),
               Point(l_Rect.Right - 1, l_Rect.Top + 1)]);

     Pen.Color := clBtnHighlight;
     PolyLine([Point(l_Rect.Left + 1,  l_Rect.Bottom - 1),
               Point(l_Rect.Left + 1, l_Rect.Top + 1),
               Point(l_Rect.Right - 1, l_Rect.Top + 1)]);
    end;//ev_pmsColumnBorder
   ev_pmsPageLeftIndent,
   ev_pmsParaIndent :
    begin
     Polygon([Point(l_Rect.Right, l_Rect.Bottom),
              Point(l_Rect.Right, l_Rect.Top),
              Point(l_Rect.Left, l_Rect.Top + (l_Rect.Right - l_Rect.Left)),
              Point(l_Rect.Left, l_Rect.Bottom - (l_Rect.Right - l_Rect.Left))]);

     Pen.Color := Self.Color;
     PolyLine([Point(l_Rect.Left + 1, l_Rect.Bottom - (l_Rect.Right - l_Rect.Left)),
               Point(l_Rect.Right - 1, l_Rect.Bottom - 2),
               Point(l_Rect.Right - 1, l_Rect.Top + 2)]);

     Pen.Color := clBtnHighlight;
     PolyLine([Point(l_Rect.Left + 1,  l_Rect.Bottom - (l_Rect.Right - l_Rect.Left) - 1),
               Point(l_Rect.Left + 1, l_Rect.Top + (l_Rect.Right - l_Rect.Left)),
               Point(l_Rect.Right, l_Rect.Top + 1)]);
    end;//ev_pmsPageLeftIndent..
   ev_pmsPageSize,
   ev_pmsPageRightIndent,
   ev_pmsParaSize:
    begin
     Polygon([Point(l_Rect.Left, l_Rect.Bottom),
              Point(l_Rect.Left, l_Rect.Top),
              Point(l_Rect.Right, l_Rect.Top + (l_Rect.Right - l_Rect.Left)),
              Point(l_Rect.Right, l_Rect.Bottom - (l_Rect.Right - l_Rect.Left))]);

     Pen.Color := Self.Color;
     PolyLine([Point(l_Rect.Left + 2, l_Rect.Bottom - 3),
               Point(l_Rect.Right - 1, l_Rect.Bottom - (l_Rect.Right - l_Rect.Left)),
               Point(l_Rect.Right - 1, l_Rect.Top + (l_Rect.Right - l_Rect.Left))]);

     Pen.Color := clBtnHighlight;
     PolyLine([Point(l_Rect.Left + 1,  l_Rect.Bottom - 2),
               Point(l_Rect.Left + 1, l_Rect.Top + 2),
               Point(l_Rect.Right, l_Rect.Top + (l_Rect.Right - l_Rect.Left) + 1)]);
    end;//ev_pmsPageSize
   ev_pmsTabIndent: begin
    Pen.Color:= clBlue;
    l_OldPenWidth := Pen.Width;
    Pen.Width := 2;
    MoveTo(l_Rect.Left, l_Rect.Top + 6);
    LineTo(l_Rect.Left + 8, l_Rect.Top + 6);
    MoveTo(l_Rect.Left + 4, l_Rect.Top);
    LineTo(l_Rect.Left + 4, l_Rect.Top + 6);
    Pen.Width := l_OldPenWidth;
   end;//ev_pmsTabIndent
  end;// case l_MS
 end;// with aCanvas
end;

procedure TevCustomRuler.WMLButtonDown(var Msg : TWMLButtonDown);
begin
 with Msg.Pos do 
  fl_DragMarker := MarkerByPos(l3SPoint(X, Y));
 if (fl_DragMarker >= 0) AND (fl_DragMarker < MarkerCount) then
 begin
  fl_MoveInProcess := True;
  BeginDrag(Msg.XPos, Msg.YPos);
 end;//fl_DragMarker >= 0..
end;

procedure TevCustomRuler.WMLButtonUp(var Msg : TWMLButtonUp);
begin
 if fl_MoveInProcess then
 begin
  EndDrag(Msg.XPos, Msg.YPos);
  fl_MoveInProcess := false;
 end;//fl_MoveInProcess
end;

procedure TevCustomRuler.WMMouseMove (var Msg : TWMMouseMove);
begin
 if fl_MoveInProcess then
  Drag(Msg.XPos, Msg.YPos);
end;

procedure TevCustomRuler.WMSize(var Msg: TWMSize);
  {message WM_Size;}
  {-}
begin
 inherited;
 case Orientation of
  ev_orHorizontal: if Align in [alLeft, alRight] then 
                    Orientation := ev_orVertical;
  ev_orVertical: if Align in [alTop, alBottom] then 
                  Orientation := ev_orHorizontal;
 end;//case Orientation
end;

procedure TevCustomRuler.WMNCHitTest(var Msg: TWMNCHitTest);
  {message WM_NCHitTest;}
var
 l_MarkerIndex : Long;
 l_Marker      : IevMarker;
begin
 if not (csDesigning in ComponentState) then
 begin
  {get the mouse position in client coordinates}
  with Msg do 
   l_MarkerIndex := MarkerByPos(l3SPoint(XPos, YPos).Convert(ScreenToClient));
  if (l_MarkerIndex >= 0) then
  begin
   l_Marker := fl_Markers[l_MarkerIndex];
   if l3IsNil(l_Marker.Hint) then
   begin
    fl_HintMarker := -1;
    Hint := '';
    ShowHint := false;
   end//l3IsNil(l_Marker.Hint)
   else
    if (l_MarkerIndex <> fl_HintMarker) then
    begin
     fl_HintMarker := l_MarkerIndex;
     Hint := l3Str(l_Marker.Hint) + '|';
     ShowHint := true;
    end;//l_MarkerIndex <> fl_HintMarker
  end
  else
  begin
   fl_HintMarker := -1;
   Hint := '';
   ShowHint := False;
  end;//l_MarkerIndex >= 0
 end;//not (csDesigning in ComponentState)
 inherited;
end;

procedure TevCustomRuler.BeginDrag(nX, nY: integer);
const
  evPageMarkerStyle = [ev_pmsPageLeftIndent, ev_pmsPageRightIndent, ev_pmsPageSize];
const
  evSplitMarkerStyle = [ev_pmsColumnBorder .. ev_pmsPageSize];
var
 l_R : Tl3SRect;
begin
 if (Control = nil) then Exit;

 if WordLike AND (MarkerStyle[fl_DragMarker] in evPageMarkerStyle) then
 begin
  // - Не даем изменять левое поле и размер бумаги
  fl_MoveInProcess := false;
  Exit;
 end;//WordLike..

 MouseCapture := True;

 fl_DragDC := l3System.GetDCEx(Control.Handle, 0, dcx_Cache or dcx_ClipSiblings);
 fl_PrevRect := GetMarkerRect(fl_DragMarker);
 FirstPos := evInchZoom(Zoom, nev.CrtIC.LP2DP(l3PointX(Option[fl_DragMarker] - Delta)).X) + Margin;
 fl_MouseDelta := FirstPos - nX + BGap;

 fl_PrevRect.Left := FirstPos;
 fl_PrevRect.Right := fl_PrevRect.Left + StrobWidth;

 l_R.InitClientRect(Control.Handle);
 fl_PrevRect.Top := l_R.Top;
 fl_PrevRect.Bottom := l_R.Bottom;
 if (MarkerStyle[fl_DragMarker] in evSplitMarkerStyle) then
  Screen.Cursor := crHSplit;
 fl_PrevRect.Invert(fl_DragDC);
end;

procedure TevCustomRuler.Drag(nX, nY: Integer);
begin
 fl_PrevRect.Invert(fl_DragDC);
 fl_MouseDelta := 0;

 fl_PrevRect.Left := nX - BGap;
 fl_PrevRect.Right := fl_PrevRect.Left + StrobWidth;

 fl_PrevRect.Invert(fl_DragDC);
end;

procedure TevCustomRuler.EndDrag(nX, nY: integer);
var
 l_Width   : TevInch;
 l_Control : InevControl;
begin
 fl_PrevRect.Invert(fl_DragDC);
 l3System.ReleaseDC(Control.Handle, fl_DragDC);
 l_Width := evInchDezoom(Zoom, fl_PrevRect.Left - Margin) - fl_MouseDelta;
 if Supports(Control, InevControl, l_Control) then
  l_Control.SetFlag(ev_uwfRuler);
 Option[fl_DragMarker] := nev.CrtIC.DP2LP(PointX(l_Width)).X + Delta;
 Screen.Cursor  := crDefault;
 MouseCapture := False;
end;

procedure TevCustomRuler.pm_SetMarkerValue(Index: Long; Value: TevInch);
var
 l_OneUnit    : Long;
 l_Divizor    : Long;
 l_Multiplier : Long;
 l_Value      : Long;
 l_NullOffset : Long;
begin
 if (Index >= 0) AND (Index < MarkerCount) AND Assigned(f_OnSetMarker) then
 begin
  GetUnitsParam(l_OneUnit, l_Divizor, l_Multiplier, True);
  l_OneUnit := (l_OneUnit div l_Divizor);
  l_NullOffset := GetNullOffset;
  l_Value := ((((Value + l_NullOffset) * cM) div l_OneUnit) * l_OneUnit) div cM - l_NullOffset;
  f_OnSetMarker(Self, fl_Markers[Index], l_Value);
 end;//Index >= 0
end;

function TevCustomRuler.pm_GetMarkerValue(Index: Long) : TevInch;
begin
 if (Index >= 0) AND (Index < MarkerCount) then
  Result := fl_Markers[Index].Value
 else
  Result := l3NilLong;
end;

function TevCustomRuler.pm_GetMarkerCount: Long;
  {-}
begin
 if (fl_Markers <> nil) then
  Result := fl_Markers.Count
 else
  Result := 0;
end;

procedure TevCustomRuler.pm_SetOnSetMarker(aValue: TevOnSetMarker);
  {-}
begin
 OnSetMarker := aValue;
end;

function TevCustomRuler.pm_GetMarkerStyle(ParaMarker: Long): TevParaMarkerStyle;
  {-}
begin
 if (ParaMarker >= 0) AND (ParaMarker < MarkerCount) then
  Result := fl_Markers[ParaMarker].Style
 else
  Result := ev_pmsNone;
end;

function TevCustomRuler.pm_GetCharWidth : Word;
begin
 Result := f_CharWidth;
end;

procedure TevCustomRuler.pm_SetCharWidth(Value : Word);
  {-}
begin
 if (Value <> f_CharWidth) then
 begin
  f_CharWidth := Value;
  if (Units = ev_unChar) then Invalidate;
 end;{Value <> f_CharWidth..}
end;

function TevCustomRuler.pm_GetUnits: TevUnits;
  {-}
var
 l_ParaFormatting : IedParagraphFormatting;
 l_FontInfo       : Il3FontInfo2;
begin
 Result := f_Units;
 if (Orientation <> ev_orVertical) AND
    Supports(Control, IedParagraphFormatting, l_ParaFormatting) then
  try
   if (l_ParaFormatting.HorizontalAligment = ed_halPreformatted) then
   begin
    if Supports(Control, Il3FontInfo2, l_FontInfo) then
     try
      with nev.CrtIC do
      begin
       Font := l_FontInfo;
       f_CharWidth := pxAverageCharWidth * cM;
      end;//with nev.CrtIC
     finally
      l_FontInfo := nil;
     end;//try..finally
    Result := ev_unChar;
    //l_ParaFormatting.HorizontalAligment = ev_halPreformatted
   end else
    f_CharWidth := nev.CrtIC.LP2DP(l3PointX(evChar2Inch(cM))).X;
  finally
   l_ParaFormatting := nil;
  end;//try..finally
end;

procedure TevCustomRuler.pm_SetUnits(Value: TevUnits);
begin
 if (f_Units <> Value) then 
 begin
  f_Units := Value;
  Invalidate;
 end;{f_Units <> Value}
end;

procedure TevCustomRuler.GetUnitsParam(var theOneUnit, theDivizor, theMultiplier: Long;
                                       InInch : Bool);
  {-}
begin
 case Units of
  ev_unInch:
  begin
   if InInch then
    theOneUnit := evInchMul * cM
   else
    theOneUnit := Screen.PixelsPerInch * cM;
   theDivizor := 12;
   theMultiplier := 1;
   Exit;
  end;//ev_unInch
  ev_unCm:
  begin
   if InInch then
    theOneUnit := l3MulDiv(evInchMul * 100, cM, ev_MmInInch)
   else
    theOneUnit := l3MulDiv(Screen.PixelsPerInch * 100, cM, ev_MmInInch);
   if WordLike then
    theDivizor := 4
   else
    theDivizor := 10;
   theMultiplier := 1;
   Exit;
  end;//ev_unCm
  ev_unChar:
  begin
{   OneUnit := Screen.PixelsPerInch * evChar2Inch(10);}
   theOneUnit := CharWidth * 10;
   theDivizor := 10;
   theMultiplier := 10;
  end;
  ev_unPixel: begin
   theOneUnit := 100 * cM;
   theDivizor := 10;
   theMultiplier := 100;
  end;//ev_unPixel 
 end; //case Units
 if InInch then
  theOneUnit := nev.CrtIC.DP2LP(PointX(theOneUnit)).X;
end;

function TevCustomRuler.GetNullOffset: Long;
  {-}
var
 l_ObjectFrame : IevObjectFrame;
begin
 Result := 0;
 if (Orientation <> ev_orVertical) AND
    Supports(Control, IevObjectFrame, l_ObjectFrame) then
  try
   Result := l_ObjectFrame.ObjectXOffset;
  finally
   l_ObjectFrame := nil;
  end;//try..finally
end;

procedure TevCustomRuler.Paint(const aCanvas: Il3Canvas);
var
 l_Rect        : TRect;
 X, Y          : TevPixel;   // - Логические координаты для рисования засечек
 X1            : TevPixel;
 i             : Long;       // - Индекс для рисования маркеров
 l_DigitalMark : Long;       // - Определяет засечку соотв. целой единице измерения
 l_OneUnit     : Long;       // - Размер единицы измерения в точках
 l_Divizor     : Long;       // - Количество засечек в одной единице измерения
 l_Multiplier  : Long;
 l_MinShtrSize : SmallInt;   // - Размер минимальной засечки 
 l_CurNumber   : Long;       // - Цифра текущей засечки
 l_NumStr      : string[10]; // - Строковое представление l_CurNumber
 l_Incr        : TevPixel;   // - Цена одного деления
 l_Extent      : Tl3Point;   // - Размеры линейки
 l_TargetRectS : Tl3SRect;   // - Прямоугольник для рисования текста и рамки
 l_BoolOrient  : Bool;       // - Ориентация линейки в Булевском представлении
 l_NumStrExt   : Tl3SPoint;  // - Размеры строки l_NumStr 
 l_ClipRectS   : Tl3SRect;
 l_Delta       : TevPixel;
 l_Unints      : TevUnits;   // - Текущие единицы измерения параметров маркеров
 l_Canvas      : TCanvas;    // - Канва рисования
 l_DrawTabs    : Bool;
 l_TabsHeight  : Long;
 l_TabsWidth   : Long;
begin
 l_Unints := Units;
 l_BoolOrient := (Orientation = ev_orVertical);
 l_DrawTabs := NeedDrawTabs;
 l_Extent.X := ClientWidth;
 l_Extent.Y := ClientHeight;

 l_MinShtrSize := ((l_Extent.P.bPt[not l_BoolOrient]-4)) div 4;

 GetUnitsParam(l_OneUnit, l_Divizor, l_Multiplier, False);

 l_Incr := (l_OneUnit div l_Divizor);

 l_Incr := evInchZoom(Zoom, l_Incr);

 l_Delta := Delta + GetNullOffset;
 l_Delta := evInchZoom(Zoom, nev.CrtIC.LP2DP(l3PointX(l_Delta)).X * cM);
 
 Dec(l_Delta, BGap * cM);

 l_Canvas := aCanvas.Canvas;
 if (l_Incr > 0) then 
  with l_Canvas do 
  begin
   l_ClipRectS.InitRect(ClipRect);
   X := (((l_Delta + (l_ClipRectS.R.TopLeft.P.bPt[l_BoolOrient] - 40) * cM) div l_Incr) * l_Incr);
   if l_DrawTabs then 
   begin
    l_TabsHeight := GetTabsHeight;
    Dec(l_Extent.P.Y, l_TabsHeight);
    // - Резервируем место для позиций табуляции
   end;//l_DrawTabs
   l_Extent.P.bPt[l_BoolOrient] := l_ClipRectS.R.BottomRight.P.bPt[l_BoolOrient];
   l_CurNumber := X div l_Incr;
   if fl_SmallFont then 
    Font := f_SmallFont 
   else 
    Font := Self.Font;

   if WordLike then
   begin
    if l_DrawTabs then
    begin
     Brush.Color := Color;
     FillRect(Rect(0, 0, l_Extent.X, 5));
     FillRect(Rect(0, 0, BGap, l_Extent.Y - 2));
     FillRect(Rect(0, l_Extent.Y - 2, l_Extent.X, l_Extent.Y + l_TabsHeight));
     Brush.Color := clWindow;
     FillRect(Rect(BGap, 5, l_Extent.X, l_Extent.Y - 2));
     //l_DrawTabs
    end
    else
    begin
     Brush.Color := clWindow;
     FillRect(l_ClipRectS.R.WR);
    end;//l_DrawTabs
    aCanvas.BackColor := clWindow;
   end 
   else 
   begin
    Brush.Color := Color;
    FillRect(l_ClipRectS.R.WR);
   end;//WordLike

   l3FillChar(l_TargetRectS, SizeOf(l_TargetRectS), 0);
   l_TargetRectS.R.BottomRight.P.bPt[l_BoolOrient] := BGap;
   l_TargetRectS.R.BottomRight.P.bPt[not l_BoolOrient] := l_Extent.P.bPt[not l_BoolOrient];
   ExcludeClipRect(Handle, l_TargetRectS.Left, l_TargetRectS.Top, l_TargetRectS.Right, l_TargetRectS.Bottom);

   while True do
   begin
    if WordLike then
     Pen.Color := clBlack
    else
     Pen.Color := clGray;
    l_DigitalMark := l_CurNumber mod l_Divizor;
    case l_Unints of
     ev_unInch:
     begin
      Y  := l_MinShtrSize * (1 + Byte(l_CurNumber mod 3 = 0) +
            Byte(l_CurNumber mod 6 = 0) +
            Byte(l_CurNumber mod 12 = 0));
     end;//ev_unInch
     ev_unCm:
     begin
      if WordLike then
       Y  := l_MinShtrSize * (1 +
             Byte(l_CurNumber mod 2 = 0) +
             2 * Byte(l_CurNumber mod 4 = 0)) * 2 div 3
      else
       Y  := l_MinShtrSize * (1 +
             Byte(l_CurNumber mod 5 = 0) +
             2 * Byte(l_CurNumber mod 10 = 0));
     end;//ev_unCm
     ev_unChar:
     begin
      Y  := l_MinShtrSize * (1 +
            Byte(l_CurNumber mod 5 = 0) +
            Byte(l_CurNumber mod 10 = 0));
     end;//ev_unChar
     ev_unPixel: begin
      Y  := l_MinShtrSize * (1 +
            Byte(l_CurNumber mod 5 = 0) +
            2 * Byte(l_CurNumber mod 10 = 0));
     end;//ev_unPixel
    end;//case l_Unints

    X1 := Margin + (X - l_Delta) div cM;

    case Orientation of
     ev_orHorizontal:
     begin
 {     if WordLike then begin
       MoveTo(X1, (l_Extent.Y - Y) div 2);
       LineTo(X1, (l_Extent.Y + Y) div 2);
      end else }begin
       MoveTo(X1, l_Extent.Y - 4);
       LineTo(X1, l_Extent.Y - Y - 2);
      end;//WordLike
      if not fl_SmallFont AND not WordLike then 
      begin
       Pen.Color := clBtnHighlight;
       MoveTo(Succ(X1), l_Extent.Y - 4);
       LineTo(Succ(X1), l_Extent.Y - Y - 2);
      end;{not fl_SmallFont}
     end;//ev_orHorizontal
     ev_orVertical:
     begin
      MoveTo(l_Extent.X - 4, X1);
      LineTo(l_Extent.X - Y - 2, X1);
      if not fl_SmallFont AND not WordLike then 
      begin
       Pen.Color := clBtnHighlight;
       MoveTo(l_Extent.X - 4, X1 + 1);
       LineTo(l_Extent.X - Y - 2, X1+ 1);
      end;//not fl_SmallFont
     end;//ev_orVertical
    end;//case Orientation..
    if (l_DigitalMark = 0) then
    begin
     l_NumStr := IntToStr((l_CurNumber div l_Divizor) * l_Multiplier);
     l_NumStrExt.Init(TextWidth(l_NumStr), TextHeight(l_NumStr));
     with l_TargetRectS.R.TopLeft do
     begin
      P.bPt[l_BoolOrient] := X1 - l_NumStrExt.P.bPt[l_BoolOrient] div 2;
      P.bPt[not l_BoolOrient] := (l_Extent.P.bPt[not l_BoolOrient] - l_NumStrExt.P.bPt[not l_BoolOrient]) div 2;
     end;//with l_TargetRectS.R.TopLeft
     l_TargetRectS.Right := l_TargetRectS.Left + l_NumStrExt.X;
     l_TargetRectS.Bottom := l_TargetRectS.Top + l_NumStrExt.Y;
     aCanvas.ExtTextOut(l_TargetRectS.R.TopLeft, l_TargetRectS, l3PCharLen(l_NumStr));
    end;//l_DigitalMark = 0
    if (X1 >= (l_Extent.P.oPt[Orientation])) then
     Break;
    Inc(l_CurNumber);
    Inc(X, l_Incr);
   end;//while true
   if l_DrawTabs then 
   begin
    l_TabsWidth := l_TabsHeight div 3;
    l_TabsHeight := l_TabsHeight div 2 - 1;
    Dec(l_Extent.P.Y, 1);
    Brush.Color := clBtnShadow;
    Pen.Color := clBtnShadow;
    l_Incr := Screen.PixelsPerInch * cM div 2;
    l_Incr := evInchZoom(Zoom, l_Incr);
    X := 0;
    while True do 
    begin
     X1 := Margin + (X - l_Delta) div cM;
     Polygon([Point(X1, l_Extent.Y),
              Point(X1 + l_TabsWidth, l_Extent.Y + l_TabsHeight),
              Point(X1, l_Extent.Y + l_TabsHeight * 2),
              Point(X1 - l_TabsWidth, l_Extent.Y + l_TabsHeight)]);
     if (X1 >= (l_Extent.P.oPt[Orientation])) then
      Break;
     Inc(X, l_Incr);
    end;//while True
   end;//l_DrawTabs
  end;//with l_Canvas..
 
 for i := 0 to MarkerCount - 1 do 
  DrawMarker(aCanvas, i);
  
 if not WordLike then
 begin
  l_Rect := GetClientRect;
  DrawFrame(aCanvas, l_Rect);
 end;
end;{Paint}

procedure TevCustomRuler.ViewChanged(const aView: InevView);
var
 i        : Integer;
 l_Marker : IevMarker;
begin
 for i := 0 to MarkerCount - 1 do
  fl_Markers[i].View := aView;
end;

end.
