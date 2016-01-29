unit vtPreviewPanel;
{* Компонент для Preview. }

{ $Id: vtPreviewPanel.pas,v 1.40 2015/10/06 12:53:13 dinishev Exp $ }

// $Log: vtPreviewPanel.pas,v $
// Revision 1.40  2015/10/06 12:53:13  dinishev
// {Requestlink:293280988}
//
// Revision 1.39  2015/02/26 09:29:07  kostitsin
// List*ner -> Listener
//
// Revision 1.38  2015/02/25 13:53:28  kostitsin
// List*ner -> Listener
//
// Revision 1.37  2013/03/29 11:36:59  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.36  2012/10/29 16:57:24  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.35  2012/06/04 11:30:48  lulin
// {RequestLink:318373921}
//
// Revision 1.34  2012/03/16 15:54:58  gensnet
// http://mdp.garant.ru/pages/viewpage.action?pageId=344135940
//
// Revision 1.33  2012/03/12 15:46:11  gensnet
// http://mdp.garant.ru/pages/viewpage.action?pageId=344135940
//
// Revision 1.32  2011/05/26 11:10:21  dinishev
// [$266409350]
//
// Revision 1.31  2010/10/26 13:03:01  lulin
// {RequestLink:237503905}.
//
// Revision 1.30  2010/04/21 17:26:59  lulin
// {RequestLink:200081909}.
// - bug fix: не собирался Эверест в ветке.
//
// Revision 1.29  2010/04/14 16:34:36  lulin
// {RequestLink:191730233}.
//
// Revision 1.28  2009/09/02 11:48:58  lulin
// {RequestLink:159360578}. №20.
//
// Revision 1.27  2008/04/14 09:18:28  oman
// - new: Не сбрасываем масштаб и "серость" превью (cq28852)
//
// Revision 1.26  2008/04/02 14:22:17  lulin
// - cleanup.
//
// Revision 1.25  2008/02/14 17:09:07  lulin
// - cleanup.
//
// Revision 1.24  2008/01/28 08:19:56  oman
// - fix: При двойном переполучении текста превью не обновлялось (cq28105)
//
// Revision 1.23  2007/12/12 12:38:24  lulin
// - модуль afwInterfaces теперь генерируется с модели целиком.
//
// Revision 1.22  2007/08/24 12:49:34  oman
// - fix: Не принимаем счетчика страниц в качестве канвы (cq26479)
//
// Revision 1.21  2007/08/14 19:31:40  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.20  2007/04/09 10:15:25  oman
// - fix: При сбросе превью от нотификации не обновляем статус (cq24726)
//
// Revision 1.19  2007/03/21 11:29:56  oman
// - new: добавил нотификацию о переключении конфигураций и возможной смене
//  всех настроек
//
// Revision 1.18  2007/01/11 11:55:04  oman
// - fix: Визуализация постоения превью - не учел кэширование (cq23938)
//
// Revision 1.17  2007/01/11 09:01:03  oman
// - fix: Визуализация постоения превью.(cq23938)
//
// Revision 1.16  2006/12/15 11:30:43  lulin
// - добавлена картинка со счетчиком ссылок.
//
// Revision 1.15  2006/12/11 09:55:31  oman
// - new: HiddenStyles перенесены с DocumentContainer на редактор (cq12564)
// - new: Изменена схема кэширования превью на DocumentContainer
//
// Revision 1.14  2006/12/05 14:33:33  lulin
// - контрол переехал в визуальную библиотеку.
//
// Revision 1.13  2006/09/29 10:12:26  oman
// - fix: Более корректно расчитываем LastTop/BottomPage.
//  (cq22782, 19723)
//
// Revision 1.12  2006/09/20 08:09:03  oman
// - fix: Неправильно определяли страницу видимую на верхней
//  границе окна (cq22645)
//
// Revision 1.11  2006/06/20 13:13:53  oman
// - fix: Сохраняем флаг серый/цветной при переключении между
//  текстом- справкой-выделением (cq21390)
//
// Revision 1.10  2006/05/19 12:40:07  lulin
// - cleanup.
//
// Revision 1.8  2006/05/19 09:28:51  lulin
// - bug fix: после построения предварительного просмотра не показывалось число страниц (CQ OIT5-20982).
//
// Revision 1.7  2006/04/13 10:20:28  oman
// - fix: Неправильно определялась текущая страница при печати
//  из-под превью (cq20418)
//
// Revision 1.6  2006/03/03 09:05:02  oman
// - fix: При вычислении вертикального смещения страницы брали не тот индекс
//
// Revision 1.5  2006/01/30 11:18:25  oman
// - fix: если у ComplexPreview изменился документ - надо обновиться.
//   Более красивого механизма нотификации пока не нарыл
//
// Revision 1.4  2006/01/24 15:25:51  oman
// - fix: если превбю прерывалось без закрытия окна (изменение
//  таблицы стилей, настроек), то оно не переформировывалось.
//
// Revision 1.3  2005/11/28 18:22:39  lulin
// - bug fix: был AV при попытке удаления скрытых комментариев.
//
// Revision 1.2  2005/11/16 08:53:47  lulin
// - избавляемся от артефактов отрисовки.
//
// Revision 1.1  2005/10/11 10:34:27  lulin
// - bug fix: не собиралась библиотека.
// - панель _Preview переехала в библиотеку VT.
//
// Revision 1.59.4.5  2005/10/11 09:26:16  lulin
// - интерфейс для нотификации об изменении таблицы стилей переехал в общее место.
//
// Revision 1.59.4.4  2005/10/10 08:09:45  lulin
// - общие файлы вынуты из ветки.
//
// Revision 1.59.4.3  2005/05/30 12:06:00  lulin
// - кеш данных переехал в библиотеку L3.
//
// Revision 1.59.4.2  2005/05/26 17:44:29  lulin
// - базовая канва вывода переехала из Эвереста в L3.
//
// Revision 1.59.4.1  2005/05/18 12:42:47  lulin
// - отвел новую ветку.
//
// Revision 1.58.2.1  2005/05/18 12:32:09  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.59  2005/05/12 17:06:33  lulin
// - удален ненужный модуль.
//
// Revision 1.58  2005/03/14 12:43:49  lulin
// - new behavior: панель _Preview регистрирует себя в качестве IafwSettingsListener.
//
// Revision 1.57  2005/01/20 13:13:06  fireton
// - bug fix: заново научили print _preview восстанавливаться из истории
//
// Revision 1.56  2005/01/19 12:54:42  fireton
// - bug fix: при zoom'e сбрасываем кэш смещений
// - небольшой рефакторинг
//
// Revision 1.55  2005/01/19 08:17:57  lulin
// - убраны ненужные методы, связанные с составным _preview - за ненадобностью, т.к. составное _preview сейчас реализуется по-другому.
//
// Revision 1.54  2005/01/17 15:25:26  lulin
// - bug fix: для ненумерованных параграфов не всегда правильно показывалась текущая страница.
//
// Revision 1.53  2005/01/17 14:40:04  lulin
// - new behavior: теперь _preview показывает ту страницу, которую видел пользователь (CQ OIT5-10919).
//
// Revision 1.52  2005/01/14 16:36:40  lulin
// - восстановил собственную копию статусной строки для кождой основной формы приложения.
//
// Revision 1.51  2005/01/14 11:02:19  lulin
// - методы Get*ParentForm переехали в библиотеку AFW.
//
// Revision 1.50  2005/01/12 12:47:32  lulin
// - перевел модуль afwFacade в глобальных процедур на метакласс.
//
// Revision 1.49  2004/12/27 17:23:29  lulin
// - new behavior: в первом приближении вернул печать диапазона (пока без открытых интервалов).
//
// Revision 1.48  2004/12/27 15:21:00  lulin
// - cleanup: убраны ненужные методы.
//
// Revision 1.47  2004/12/27 15:09:27  lulin
// - new behavior: print-_preview теперь реагирует на изменение таблицы стилей.
//
// Revision 1.46  2004/12/27 14:44:53  lulin
// - cleanup: убраны ненужные методы.
//
// Revision 1.45  2004/12/24 17:04:53  lulin
// - быстрее прерываем построение _Preview.
//
// Revision 1.44  2004/12/24 16:24:24  lulin
// - new behavior: не перестраиваем _Preview если система залочена.
//
// Revision 1.43  2004/12/24 13:49:37  lulin
// - bug fix: очередной раз отъехало обновление Caption формы _Preview.
//
// Revision 1.42  2004/12/23 15:34:02  lulin
// - большинство операций перенесено с формы _Preview на панель _Preview.
//
// Revision 1.41  2004/12/21 19:04:38  lulin
// - new behavior: после остановки _preview теперь форма корректно закрывается.
//
// Revision 1.40  2004/12/21 17:33:31  lulin
// - new class: TnscPreviewPanel.
//
// Revision 1.39  2004/12/20 16:16:54  lulin
// - вычищены ошметки от старой строки статуса.
//
// Revision 1.38  2004/12/15 16:31:03  lulin
// - переключатель документ/справка теперь опять живой.
//
// Revision 1.37  2004/12/14 15:50:11  lulin
// - bug fix: не восстанавливалось _Preview из истории.
//
// Revision 1.36  2004/12/11 17:29:30  lulin
// - управление Print-_preview теперь живет на контейнере.
//
// Revision 1.35  2004/12/11 14:40:22  lulin
// - в нулевом приближении прикрутил свой Print-_preview взамен Никитинского.
//
// Revision 1.34  2004/12/09 18:41:46  lulin
// - bug fix: не всегда учитывалась максимальная ширина страницы.
//
// Revision 1.33  2004/12/09 18:01:07  lulin
// - убран отладочный код.
//
// Revision 1.32  2004/12/09 17:00:58  lulin
// - bug fix: неправильно расчитывалась высота первой страницы.
//
// Revision 1.31  2004/12/09 12:00:03  lulin
// - закончена оптимизация скроллинга больших документов.
//
// Revision 1.30  2004/12/08 18:19:48  lulin
// - еще оптимизирован скроллинг больших документов (ближе к концу документа тормозило сильнее).
//
// Revision 1.29  2004/12/08 16:57:33  lulin
// - вынес за цикл код, который делает картинку серой из цветной.
//
// Revision 1.28  2004/12/08 16:41:08  lulin
// - добавлен модификатор const.
//
// Revision 1.27  2004/12/08 16:27:11  lulin
// - cleanup.
//
// Revision 1.26  2004/12/08 15:58:03  lulin
// - bug fix: при изменении размеров окна не пересчитывались коэффициэнты масштабирования.
//
// Revision 1.25  2004/12/08 10:05:38  lulin
// - bug fix: не всегда пересчитывались размеры отображаемых страниц.
//
// Revision 1.24  2004/12/07 15:06:16  lulin
// - оптимизирован скроллинг больших документов.
//
// Revision 1.23  2004/12/07 14:40:15  lulin
// - optimization: запоминаем последнюю страницу к которой обращались.
//
// Revision 1.22  2004/12/07 14:27:55  lulin
// - оптимизирована отрисовка Print-_preview - рисуем только те страницы, которые попадают в видимую область.
//
// Revision 1.21  2004/12/07 14:08:06  lulin
// - cleanup.
//
// Revision 1.20  2004/12/07 14:03:11  lulin
// - cleanup.
//
// Revision 1.19  2004/12/07 13:24:15  lulin
// - bug fix: не восстанавливалась текущая страница _Preview.
//
// Revision 1.18  2004/12/06 13:56:45  lulin
// - от классов переходим к интерфейсам.
//
// Revision 1.17  2004/12/03 15:22:33  lulin
// - new interface: IevPreviewPage.
//
// Revision 1.16  2004/11/19 16:33:00  lulin
// - bug fix: съедались двухбуквенные ShortCut'ы.
//
// Revision 1.15  2004/10/27 17:52:54  lulin
// - new behavior: теперь в PrintPreview в статусной строке бежит индикатор.
// - new behavior: страницы начинают отрисовываться как только они подготовлены - без ожидания конца подготовки _Preview.
//
// Revision 1.14  2004/10/27 16:45:14  lulin
// - new behavior: теперь храним в истории PreviewCanvas - соответственно не перестраиваем каждый раз _Preview.
//
// Revision 1.13  2004/10/25 17:52:19  lulin
// - new behavior: побыстрее сообщаем панели-_Preview о уже сформированных листах _Preview, а не ждем окончания всего процесса.
//
// Revision 1.12  2004/10/25 16:39:23  lulin
// - cleanup.
//
// Revision 1.11  2004/10/25 16:18:01  lulin
// - вся логика из TeePreviewPanel переехала в TevCustomPreviewPanel.
//
// Revision 1.46  2004/10/25 15:46:17  lulin
// - cleanup.
//
// Revision 1.45  2004/10/25 15:29:19  lulin
// - cleanup.
//

{$Include vtDefine.inc }

interface

uses
  Windows,
  Messages,

  Classes,
  SysUtils,

  Graphics,
  Controls,
  Forms,
  StdCtrls,
  ExtCtrls,
  Math,

  afwInterfaces,
  afwCustomCommonControl,

  evMsgCode
  ;

type
  TnsDownMode = (
    ppNone,
    ppMove,
    ppZoomIn,
    ppZoomOut
  );

  IevPreviewPanelState = interface(IUnknown)
   ['{6B09B1EF-1CE9-45A6-9757-0E07AED14DED}']
    function Page: TPoint;
    function PagePixOffset: TPoint;
    function MM2Pix: Double;
    function IsGrayscale: Boolean;
    function PreviewCanvas: IafwPreviewCanvas;
    function Preview: IafwDocumentPreview;
  end;//IevPreviewPanelState

  TevZoomStatus = (ev_zsCustom, ev_zsToPage, ev_zsByWidth);

  TvtCustomPreviewPanel = class(TafwCustomCommonControl,
                                IafwPreviewPanel,
                                {$IfNDef DesignTimeLibrary}IafwStyleTableSpy,{$EndIf}
                                IafwPreviewNotifier)
   {* Компонент для Preview. }
    private
      f_Gray,
      f_DownFlag      : Boolean;
      f_DownMode      : TnsDownMode;
      f_MouseDownPos,
      f_MousePrevPos  : TPoint;

      f_PreviewCanvas : IafwPreviewCanvas;
      f_Preview       : IafwDocumentPreview;

      f_MM2Pix        : Double;

      f_CurrentPage   : TPoint;
      f_OnCurrentPageChanged : TNotifyEvent;

      f_PrevClientWidth,
      f_PrevClientHeight : Longint;

      f_ScrollRange,
      f_ScrollSmallStep, //screen pixels

      f_LastTopVisiblePage: Integer;
      f_LastTopPage    : Integer;
      f_LastBottomPage : Integer;
      f_LastDeltaX     : Integer;
      f_LastDeltaY     : Integer;
      f_PixX0,
      f_PixY0,
      f_BorderSize     : Longint;

      f_ZoomStatus     : TevZoomStatus;

      f_Bitmap         : TBitmap;
      f_PixWidth       : record
       rClient     : Integer;
       rPagesCount : Integer;
       rValue      : Integer;
      end;//f_PixWidth
      f_PixHeight      : record
       rClient     : Integer;
       rPagesCount : Integer;
       rValue      : Integer;
      end;//f_PixHeight
      f_PageOffset : array of array of TPoint;
      f_ReadingFromHistory: Boolean;
      f_Stopped    : Boolean;
      f_GrayScaleLockCount: Integer;
      f_Painted: Boolean;
      f_LockStatusUpdate: Boolean;
      f_StateInited: Boolean;
    protected
    // interface methods
      // IafwStyleTableSpy
      procedure StyleTableChanged;
        {-}
      procedure LockGrayScale;
        {-}
      procedure UnlockGrayScale;
        {-}
      // IafwPreviewNotifier
      procedure ContentChanged;
        {-}
    protected
    // property methods
      function  pm_GetPagesCount: Integer;
        {-}
      function  pm_GetPagesCounted: TafwPagesInfo;
        {-}
      procedure IevPreviewPanel_SetCurrentPage(aValue: Integer);
      procedure IafwPreviewPanel.SetCurrentPage = IevPreviewPanel_SetCurrentPage;
        {-}
      function  pm_GetPreviewCanvas: IafwPreviewCanvas;
      procedure pm_SetPreviewCanvas(const aPreviewCanvas: IafwPreviewCanvas);
        {-}
      procedure Done;
        {-}
      function pm_GetPainted: Boolean;
        {-}
      function GetPreview: IafwDocumentPreview;
      procedure SetPreview(const aPreview: IafwDocumentPreview);
        {-}
    private
    // internal methods
      procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
        {-}
      procedure CallCurrentPageChanged;
        {-}
      procedure DropSize;
        {-}
      procedure RGBToGray(aBitmap: TBitmap; const aRect: TRect);

      function  PageIndex(aIndex: Integer): Integer;
      function  PageWIndex(aIndex, aWIndex: Integer): Integer;

      function  MMPageWidth(aIndex, aWIndex: Integer): Longint;
      function  MMPageHeight(aIndex, aWIndex: Integer): Longint;
      function  PixPageWidth(aIndex, aWIndex: Integer): Longint;
      function  PixPageHeight(aIndex, aWIndex: Integer): Longint;
      function  PageXOffset(aIndex, aWIndex: Integer): Longint;
      function  PageYOffset(aIndex, aWIndex: Integer): Longint;
      function  PixWidth: Longint;
      function  PixHeight: Longint;

      procedure DrawZoomRect(aX0, aY0, aX1, aY1: Integer);
      function  PaintToBitmap: Boolean;
      function  GetPageAt(var aX, aY: Integer): TPoint;
      function  GetPageRect(aPage, aWPage: Integer; out aRect: TRect): Boolean;
      function  GetPaperRect(aPage, aWPage: Integer; out aRect: TRect): Boolean;
      procedure DrawFocusRectA(aPage: TPoint);
      procedure DropOffsetCache;
      procedure UpdateCurrent;
      procedure UpdateCurrentAt(aX, aY: Integer);

      procedure SetMM2Pix(aMM2Pix: Double);
      procedure SetPixXYOffset(aX, aY: Integer; aRepaintNow: Boolean = false);
      procedure SetPixX0(aX: Longint);
      procedure SetPixY0(aY: Longint);
      procedure pm_SetPainted(const aValue: Boolean);

      function  GetZoomPercent: Integer;
      procedure SetZoomPercent(aPercent: Integer);

      function  GetCurrentPage: TPoint;
      procedure SetCurrentPage(const aIndex: TPoint);

      procedure SetGrayscale(aNeedGrayscale: Boolean);

      procedure SetMoveMode;
      procedure SetMoveZoomIn;
      procedure SetMoveZoomOut;

      property PixX0: Longint
        read f_PixX0
        write SetPixX0;
        {-}
      property PixY0: Longint
        read f_PixY0
        write SetPixY0;
        {-}
      property Painted: Boolean
        read f_Painted
       write pm_SetPainted;
        {-}
    protected
      function  IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
        {-}
      procedure WMKeyDown(Var Msg: TWMKeyDown);
        message WM_KEYDOWN;
        {-}
      procedure WMSysKeyDown(var Msg: TWMSysKeyDown);
        message WM_SYSKEYDOWN;
        {-}
      procedure WMKeyUp(Var Msg: TWMKeyUp);
        message WM_KEYUP;
        {-}
      procedure WMSysKeyUp(var Msg: TWMSysKeyUp);
        message WM_SYSKEYUP;
        {-}
      procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd);
        message WM_ERASEBKGND;
        {-}
      procedure WMGetDlgCode(var Msg: TWMGetDlgCode);
        message WM_GETDLGCODE;
        {-}
      procedure WMMouseActivate(var Msg : TWMMouseActivate);
        message WM_MOUSEACTIVATE;
        {-}
      procedure evmsgNeedDoc(var Msg: TMessage);
        message ev_msgNeedDoc;
        {-}
      procedure Paint;
        override;
        {-}
      procedure Resize;
        override;
        {-}
      procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        override;
        {-}
      procedure MouseMove(Shift: TShiftState; X, Y: Integer);
        override;
        {-}
      procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        override;
        {-}
      procedure WMVScroll(var Msg : TWMScroll);
        message WM_VSCROLL;
        {-}
      procedure WMHScroll(var Msg : TWMScroll);
        message WM_HSCROLL;
        {-}
      procedure MouseWheelHandler(var Message: TMessage);
        override;
        {-}
      procedure UpdatePreview;
        {-}
      procedure Cleanup;
        override;
        {-}
      {$IFDEF nsTest}
      function ShouldStop: Boolean;
      {$ENDIF nsTest}
    protected
    // internal properties
      property ZoomStatus: TevZoomStatus
        read f_ZoomStatus;
        {-}
    public
      constructor Create(AOwner: TComponent);
        override;
        {-}
      function Print: Boolean;
        {-}  
      function MM2Pix: Double;
        {-}
      function PagePixOffset: TPoint;
        {-}
      procedure ZoomToPage(aIndex, aWIndex: Integer; aByWidth: Boolean = false);
        {-}
      function  GetState: IevPreviewPanelState;
        {-}
      procedure SetState(const aState: IevPreviewPanelState);
        {-}
      procedure Zoom(aX0, aY0: Integer; aK: Double; aGoCenter: Boolean = true);
        {-}
      function  DefPage: TPoint;
        {-}
      procedure UpdateMouseMode;
        {-}
      procedure GoHome;
        {-}
      procedure GoEnd;
        {-}
      procedure PageUp;
        {-}
      procedure PageDown;
        {-}
      procedure ScrollUp;
        {-}
      procedure ScrollDown;
        {-}
      procedure ScrollLeft;
        {-}
      procedure ScrollRight;
        {-}
      procedure ZoomIn;
        {-}
      procedure ZoomOut;
        {-}
      function  IsPagesCounter: Boolean;
        {-}
      function  IsReady: Boolean;
        {-}
      function  InUpdate: Boolean;
        {-}
      property GrayscaleFlag: Boolean
        read f_Gray
        write SetGrayscale;
        {-}
      property PagesCount: Integer
        read pm_GetPagesCount;
        {-}
      property PagesCounted: TafwPagesInfo
        read pm_GetPagesCounted;
        {-}
      property CurrentPage: TPoint
        read GetCurrentPage
        write SetCurrentPage;
        {-}
      property ZoomPercent: Integer
        read GetZoomPercent
        write SetZoomPercent;
        {-}
      property PreviewCanvas: IafwPreviewCanvas
        read pm_GetPreviewCanvas
        write pm_SetPreviewCanvas;
        {-}
      property Preview: IafwDocumentPreview
        read GetPreview
        write SetPreview;
        {-}
      property OnCurrentPageChanged : TNotifyEvent
       read f_OnCurrentPageChanged
       write f_OnCurrentPageChanged;
       {-}
  end;//TvtCustomPreviewPanel

  TvtPreviewPanel = class(TvtCustomPreviewPanel)
   {* Компонент для Preview. С published свойствами. }
    published
      property Align;
  //    property Alignment;
      property Anchors;
      property AutoSize;
      property BevelInner;
      property BevelOuter;
      property BevelWidth;
      property BiDiMode;
      property BorderWidth;
      property BorderStyle;
      property Caption;
      property Color;
      property Constraints;
      property Ctl3D;
      property UseDockManager default True;
      property DockSite;
      property DragCursor;
      property DragKind;
      property DragMode;
      property Enabled;
  //    property FullRepaint;
      property Font;
  //    property Locked;
      property ParentBiDiMode;
      property ParentColor;
      property ParentCtl3D;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property TabOrder;
      property TabStop;
      property Visible;
      property OnCanResize;
      property OnClick;
      property OnConstrainedResize;
      property OnContextPopup;
      property OnDockDrop;
      property OnDockOver;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDock;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnGetSiteInfo;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnResize;
      property OnStartDock;
      property OnStartDrag;
      property OnUnDock;

      property OnCurrentPageChanged;
       {-}
  end;//TvtPreviewPanel

implementation

uses
  Types,
  
  OvcBase,
  OvcCmd,
  OvcConst,

  l3InternalInterfaces,
  l3InterfacesMisc,
  l3Base,
  l3Bitmap,
  l3CacheableBase,

  afwFacade,

  evStyleTableSpy,

  nevBase
  ;

const
  c_PixelsPerInch = 96;

type
  TeePreviewPanelState = class(Tl3CacheableBase, IevPreviewPanelState)
    private
    // internal fields
      f_Page            : TPoint;
      f_PixOffset       : TPoint;
      f_MM2Pix          : Double;
      f_Grayscale       : Boolean;
      f_PreviewCanvas   : IafwPreviewCanvas;
      f_Preview         : IafwDocumentPreview;
    protected
    // internal fields
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      class function Make(const aPanel: TvtCustomPreviewPanel): IevPreviewPanelState;
        {-}
      function Page: TPoint;
        {-}
      function PagePixOffset: TPoint;
        {-}
      function MM2Pix: Double;
        {-}
      function IsGrayscale: Boolean;
        {-}
      function PreviewCanvas: IafwPreviewCanvas;
        {-}
      function Preview: IafwDocumentPreview;
        {-}
  end;//TeePreviewPanelState

//  TeePreviewPanelState

class function TeePreviewPanelState.Make(const aPanel: TvtCustomPreviewPanel): IevPreviewPanelState;
var
  l_PreviewPanelState: TeePreviewPanelState;
begin
 l_PreviewPanelState := TeePreviewPanelState.Create;
 try
  with l_PreviewPanelState do
  begin
   f_Preview := aPanel.Preview;
   f_Page := aPanel.CurrentPage;
   f_PixOffset.X := aPanel.PixX0;
   f_PixOffset.Y := aPanel.PixY0;
   f_MM2Pix := aPanel.MM2Pix;
   f_Grayscale := aPanel.GrayscaleFlag;
   if (aPanel.f_PreviewCanvas = nil) then
    f_PreviewCanvas := nil
   else
   begin
    if (f_Preview = nil) then
     f_PreviewCanvas := aPanel.PreviewCanvas
    else
     f_PreviewCanvas := nil;
   end;//aPanel.f_PreviewCanvas = nil
   if (f_PreviewCanvas <> nil) then
    f_PreviewCanvas.Drop;
  end;//with l_PreviewPanelState
  Result := l_PreviewPanelState;
 finally
  l3Free(l_PreviewPanelState);
 end;//try..finally
end;

procedure TeePreviewPanelState.Cleanup;
  //override;
  {-}
begin
 f_Preview := nil;
 f_PreviewCanvas := nil;
 inherited;
end;

function TeePreviewPanelState.Page: TPoint;
begin
 Result := f_Page;
end;

function TeePreviewPanelState.PagePixOffset: TPoint;
begin
 Result := f_PixOffset;
end;

function TeePreviewPanelState.MM2Pix: Double;
begin
 Result := f_MM2Pix;
end;

function TeePreviewPanelState.IsGrayscale: Boolean;
begin
 Result := f_Grayscale;
end;

function TeePreviewPanelState.PreviewCanvas: IafwPreviewCanvas;
  {-}
begin
 Result := f_PreviewCanvas;
end;

function TeePreviewPanelState.Preview: IafwDocumentPreview;
  {-}
begin
 Result := f_Preview;
end;

//  TeePreviewPanel

constructor TvtCustomPreviewPanel.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 ScrollStyle := ssBoth;
//
 f_Gray := false;

 with Constraints do
 begin
  MinWidth := 160;
  MinHeight := 120;
 end;//with Constraints

 PreviewCanvas := nil;
 f_MM2Pix := 0;
 f_CurrentPage.X := -1;
 f_CurrentPage.Y := -1;
 f_OnCurrentPageChanged := nil;

 f_PrevClientWidth := 0;
 f_PrevClientHeight := 0;

 f_ScrollRange := 32000;
 f_ScrollSmallStep := 32;
 f_LastTopPage := 0;
 f_LastBottomPage := High(f_LastBottomPage);
 f_LastTopVisiblePage := 0;
 f_PixX0 := 0;
 f_PixY0 := 0;

 f_BorderSize := 3;
 f_DownFlag := false;
 f_DownMode := ppNone;

 Screen.Cursors[Integer(ppMove)] := LoadCursor(HInstance, 'ee_move');
 Screen.Cursors[Integer(ppZoomIn)] := LoadCursor(HInstance, 'ee_zoom_in');
 Screen.Cursors[Integer(ppZoomOut)] := LoadCursor(HInstance, 'ee_zoom_out');

 SetMoveMode;
 {$IfNDef DesignTimeLibrary}
 evAddStyleTableSpy(Self);
 {$EndIf}
 f_ReadingFromHistory := False;
 f_StateInited := False;
 f_LockStatusUpdate := False;
 f_Painted := False;
end;

procedure TvtCustomPreviewPanel.Cleanup;
begin
 {$IfNDef DesignTimeLibrary}
 evDelStyleTableSpy(Self);
 {$EndIf}
 Preview := nil;
 DropOffsetCache;
 f_OnCurrentPageChanged := nil;
 PreviewCanvas := nil;
 FreeAndNil(f_Bitmap);
 inherited;
end;

procedure TvtCustomPreviewPanel.StyleTableChanged;
  {-}
begin
 f_LockStatusUpdate := true;
 try
  PreviewCanvas := nil;
 finally
  f_LockStatusUpdate := False;
 end;
end;

function TvtCustomPreviewPanel.pm_GetPagesCount: Integer;
  {-}
begin
 if (PreviewCanvas = nil) then
  Result := 0
 else
  Result := PreviewCanvas.GetPagesCount;
end;

function TvtCustomPreviewPanel.pm_GetPagesCounted: TafwPagesInfo;
  {-}
begin
 if (PreviewCanvas = nil) then
  Result := TafwPagesInfo_Z
 else
  Result := PreviewCanvas.PagesInfo; 
end;

procedure TvtCustomPreviewPanel.DropSize;
  {-}
begin
 f_LastTopPage := 0;
 f_LastBottomPage := High(f_LastBottomPage);
 f_LastTopVisiblePage := 0;
 f_PixWidth.rClient := 0;
 f_PixWidth.rPagesCount := 0;
 f_PixHeight.rClient := 0;
 f_PixHeight.rPagesCount := 0;
end;

procedure TvtCustomPreviewPanel.RGBToGray(aBitmap: TBitmap; const aRect: TRect);
var
  x,
  x4,
  y,
  l_x0,
  l_y0,
  l_x1,
  l_y1: Integer;
  l_Ptr: PByteArray;
begin
  if not Assigned(aBitmap) then
    exit;
  if aBitmap.PixelFormat <> pf32bit then
    exit;

  l_x0 := Max(0, aRect.Left);
  l_y0 := Max(0, aRect.Top);
  l_x1 := Min(aBitmap.Width, aRect.Right) - 1;
  l_y1 := Min(aBitmap.Height, aRect.Bottom) - 1;

  for y := l_y0 to l_y1 do
  begin
    l_Ptr := aBitmap.ScanLine[y];
    for x := l_x0 to l_x1 do
    begin
      x4 := x*4;
      l_Ptr[x4] :=
        (Integer(l_Ptr[x4])*5 +
         Integer(l_Ptr[x4 + 1])*16 +
         Integer(l_Ptr[x4 + 2])*11) div 32;
      l_Ptr[x4 + 1] := l_Ptr[x4];
      l_Ptr[x4 + 2] := l_Ptr[x4];
    end;
  end;
end;

function TvtCustomPreviewPanel.PageIndex(aIndex: Integer): Integer;
begin
 Result := -1;
 if (PagesCount > 0) then
  Result := Max(0, Min(aIndex, PagesCount - 1));
end;

function TvtCustomPreviewPanel.PageWIndex(aIndex, aWIndex: Integer): Integer;
begin
 Result := Max(0, Min(aWIndex, PreviewCanvas.GetPagesWidthCount(PageIndex(aIndex)) - 1));
end;

function TvtCustomPreviewPanel.MMPageWidth(aIndex, aWIndex: Integer): Longint;
begin
 Result := 0;
 if (PagesCount > 0) then
  Result := PreviewCanvas.GetMMPageWidth(PageIndex(aIndex), aWIndex) div 100;
end;

function TvtCustomPreviewPanel.MMPageHeight(aIndex, aWIndex: Integer): Longint;
begin
 Result := 0;
 if (PagesCount > 0) then
  Result := PreviewCanvas.GetMMPageHeight(PageIndex(aIndex), aWIndex) div 100;
end;

function TvtCustomPreviewPanel.PixPageWidth(aIndex, aWIndex: Integer): Longint;
begin
 Result := f_BorderSize + Trunc(MMPageWidth(aIndex, aWIndex)*MM2Pix) + f_BorderSize;
end;

function TvtCustomPreviewPanel.PixPageHeight(aIndex, aWIndex: Integer): Longint;
begin
 Result := f_BorderSize + Trunc(MMPageHeight(aIndex, aWIndex)*MM2Pix) + f_BorderSize;
end;

function TvtCustomPreviewPanel.PageXOffset(aIndex, aWIndex: Integer): Longint;
var
 x        : Integer;
 l_Index  : Integer;
 l_WIndex : Integer;
begin
 Result := 0;
 if not IsPagesCounter AND (PagesCount > 0) AND
    (aIndex >= 0) AND (aWIndex >= 0) then
 begin
  if (aIndex < Length(f_PageOffset)) then
  begin
   if (aWIndex < Length(f_PageOffset[aIndex])) then
   begin
    Result := f_PageOffset[aIndex, aWIndex].X;
    if (Result > 0) then
     Exit;
   end;//aWIndex < Length(f_PageOffset[aIndex])
  end;//aIndex < Length(f_PageOffset)
  l_Index := PageIndex(aIndex);
  l_WIndex := PageWIndex(aIndex, aWIndex) - 1;
  for x := 0 to l_WIndex do
   Result := Result + PixPageWidth(l_Index, x);
  if (aIndex >= Length(f_PageOffset)) then
   SetLength(f_PageOffset, aIndex + 1);
  if (aWIndex >= Length(f_PageOffset[aIndex])) then
   SetLength(f_PageOffset[aIndex], aWIndex + 1);
  f_PageOffset[aIndex, aWIndex].X := Result;
 end;//PagesCount > 0
end;

function TvtCustomPreviewPanel.PageYOffset(aIndex, aWIndex: Integer): Longint;
var
  x,
  y,
  l_h1,
  l_x1: Integer;
  l_Index : Integer;
begin
 Result := 0;
 if not IsPagesCounter AND (PagesCount > 0) AND
    (aIndex >= 0) AND (aWIndex >= 0) then
 begin
  if (aIndex < Length(f_PageOffset)) then
  begin
   if (aWIndex < Length(f_PageOffset[aIndex])) then
   begin
    Result := f_PageOffset[aIndex, aWIndex].Y;
    if (Result > 0) then
     Exit;
   end;//aWIndex < Length(f_PageOffset[aIndex])
  end;//aIndex < Length(f_PageOffset)
  l_Index := PageIndex(aIndex) - 1;
  for y := 0 to l_Index do
  begin
   l_h1 := 0;
   l_x1 := PageWIndex(y, aWIndex);
   for x := 0 to l_x1 do
     l_h1 := Max(l_h1, PixPageHeight(y, x));
   Result := Result + l_h1;
  end;//for y
  if (aIndex >= Length(f_PageOffset)) then
   SetLength(f_PageOffset, aIndex + 1);
  if (aWIndex >= Length(f_PageOffset[aIndex])) then
   SetLength(f_PageOffset[aIndex], aWIndex + 1);
  f_PageOffset[aIndex, aWIndex].Y := Result;
 end;//PagesCount > 0
end;

function TvtCustomPreviewPanel.PixWidth: Longint;
var
 x,
 y,
 l_w1         : Integer;
 //l_h1,
 //l_YMin,
 //l_YMax       : Integer;
 l_WidthCount : Integer;
begin
 Result := 0;
 if (PagesCount > 0) then
 begin
  if (f_PixWidth.rPagesCount = PagesCount) AND
     (f_PixWidth.rClient = ClientWidth) then
  begin
   Result := f_PixWidth.rValue;
   Exit;
  end;//f_PixWidth.rPagesCount..
  for y := 0 to PagesCount - 1 do
  begin
   //l_h1 := 0;
   l_WidthCount := PreviewCanvas.GetPagesWidthCount(y) - 1;
(*   for x := 0 to l_WidthCount do
    l_h1 := Max(l_h1, PixPageHeight(y, x));
   l_YMin := PixY0 + PageYOffset(y, 0);
   l_YMax := l_YMin + l_h1;

   if (l_YMax - f_BorderSize < 0) or (l_YMin + f_BorderSize > ClientHeight) then
    continue;*)

   l_w1 := 0;
   for x := 0 to l_WidthCount do
    l_w1 := l_w1 + PixPageWidth(y, x);
   Result := Max(result, l_w1);
  end;//for y
  f_PixWidth.rClient := ClientWidth;
  f_PixWidth.rPagesCount := PagesCount;
  f_PixWidth.rValue := Result;
 end;//PagesCount > 0
end;

function TvtCustomPreviewPanel.PixHeight: Longint;
var
 x            : Integer;
 y            : Integer;
 l_h1         : Integer;
 l_WidthCount : Integer;
begin
 Result := 0;
 if (PagesCount > 0) then
 begin
  if (f_PixHeight.rPagesCount = PagesCount) AND
     (f_PixHeight.rClient = ClientHeight) then
  begin
   Result := f_PixHeight.rValue;
   Exit;
  end;//f_PixHeight.rPagesCount..
  for y := 0 to PagesCount - 1 do
  begin
   l_h1 := 0;
   l_WidthCount := PreviewCanvas.GetPagesWidthCount(y) - 1;
   for x := 0 to l_WidthCount do
     l_h1 := Max(l_h1, PixPageHeight(y, x));
   Result := Result + l_h1;
  end;//for y
  f_PixHeight.rClient := ClientHeight;
  f_PixHeight.rPagesCount := PagesCount;
  f_PixHeight.rValue := Result;
 end;//PagesCount > 0
end;

function TvtCustomPreviewPanel.PagePixOffset: TPoint;
var
  l_Page: TPoint;
  l_Rect: TRect;
begin
  result.X := 0;
  result.Y := 0;
  l_Page := CurrentPage;
  if GetPageRect(l_Page.Y, l_Page.X, l_Rect) then
    result := l_Rect.TopLeft;
end;

procedure TvtCustomPreviewPanel.UpdatePreview;
  {-}
var
 l_Form : IafwForm;  
begin
 if (Preview <> nil) then
 begin
  if Supports(afw.GetParentForm(Self), IafwForm, l_Form) then
   try
    l_Form.UpdateCaption(Preview.DocumentName);
   finally
    l_Form := nil;
   end;//try..finally
  if InUpdating OR f_Stopped then
   f_PreviewCanvas := nil
  else
  begin
   while true do
    with Preview do
     try
      Update(Self);
      if Stopped then f_Stopped := true;
      break;
     except
      on EnevMaybePreviewCancelled do break;
      on EnevMaybeBaseSwitched do continue; // http://mdp.garant.ru/pages/viewpage.action?pageId=344135940
     end;//try..except
  end;//else
 end;//Preview <> nil
end;

procedure TvtCustomPreviewPanel.IevPreviewPanel_SetCurrentPage(aValue: Integer);
  {-}
begin
 if (aValue >= 0) and (not f_ReadingFromHistory) then
 begin
  DropOffsetCache;
  SetPixXYOffset(-PageXOffset(aValue, 0), -PageYOffset(aValue, 0), false);
  SetCurrentPage(Point(0, aValue));
  Invalidate;
 end;//aValue >= 0
end;
  
function TvtCustomPreviewPanel.pm_GetPreviewCanvas: IafwPreviewCanvas;
begin
 if (f_PreviewCanvas = nil) then
  UpdatePreview;
 Result := f_PreviewCanvas;
end;

procedure TvtCustomPreviewPanel.CallCurrentPageChanged;
  {-}
var
 l_Form : IafwMainForm;
begin
 if not f_LockStatusUpdate and not (csDestroying in ComponentState) AND
    Supports(afw.GetMainForm(Self), IafwMainForm, l_Form) AND
    (l_Form.Status <> nil) then
  l_Form.Status.Update;
 if Assigned(f_OnCurrentPageChanged) then
  f_OnCurrentPageChanged(self);
end;

procedure TvtCustomPreviewPanel.pm_SetPreviewCanvas(const aPreviewCanvas: IafwPreviewCanvas);
var
 l_PrevCanvas: IafwPreviewCanvas;
begin
 l_PrevCanvas := f_PreviewCanvas;
 if not l3IEQ(f_PreviewCanvas, aPreviewCanvas) then
 begin
  f_PreviewCanvas := nil;
  Painted := False;

  // Не принимаем в качестве канвы счетчик страниц (cq26479)
  if Assigned(aPreviewCanvas) and aPreviewCanvas.IsPagesCounter then
   Exit;

  if not ((l_PrevCanvas = nil) and f_ReadingFromHistory) then
  begin
   f_CurrentPage.X := -1;
   f_CurrentPage.Y := -1;
   CallCurrentPageChanged;
  end;//aPreviewCanvas = nil

  if (aPreviewCanvas <> nil) then
  begin
   f_PreviewCanvas := aPreviewCanvas;
   if not ((l_PrevCanvas = nil) and f_ReadingFromHistory) and not f_StateInited then
   begin
    GrayscaleFlag := f_PreviewCanvas.IsMonochrome;
    ZoomToPage(0, 0, true);
    f_StateInited := True;
   end;
   if l_PrevCanvas <> nil then
    f_ReadingFromHistory := False;
  end;//aPreviewCanvas <> nil
  DropOffsetCache;
  Invalidate;
  if (aPreviewCanvas <> nil) then
   Update;
 end;//not l3IEQ(f_PreviewCanvas, aPreviewCanvas)
end;

procedure TvtCustomPreviewPanel.Done;
  {-}
begin
 if (f_PreviewCanvas <> nil) then
 // - иначе огребаем зацикливание:
 // http://mdp.garant.ru/pages/viewpage.action?pageId=315261926&focusedCommentId=370378738#comment-370378738
  CallCurrentPageChanged;
end;

procedure TvtCustomPreviewPanel.SetPreview(const aPreview: IafwDocumentPreview);
  {-}
var
 l_Source: IafwPreviewNotificationSource;
begin
 if (f_Preview <> aPreview) then
 begin
  if Supports(f_Preview, IafwPreviewNotificationSource, l_Source) then
   l_Source.UnSubscribe(IafwPreviewNotifier(Self));
  f_Preview := aPreview;
  if Supports(f_Preview, IafwPreviewNotificationSource, l_Source) then
   l_Source.Subscribe(IafwPreviewNotifier(Self));
 end;//f_Preview <> aPreview
end;

procedure TvtCustomPreviewPanel.ZoomToPage(aIndex, aWIndex: Integer; aByWidth: Boolean = false);
var
 l_PixPageWidth,
 l_PixPageHeight: Integer;

 l_Rect: TRect;

 l_Point,
 l_Prev: TPoint;
 l_HasPrev: Boolean;
 l_Left,
 l_Top,
 l_Right,
 l_Bottom: Boolean;

 l_x0,
 l_y0: Integer;
begin
 if (PagesCount < 1) then
  Exit;

 l_HasPrev := false;
 l_Prev := CurrentPage;
 if l_Prev.Y >= 0 then
 begin
  GetPaperRect(l_Prev.Y, l_Prev.X, l_Rect);
  l_Left := l_Rect.Left > 0;
  l_Top := l_Rect.Top > 0;
  l_Right := l_Rect.Right < ClientWidth;
  l_Bottom := l_Rect.Bottom < ClientHeight;
  l_HasPrev := true;
 end
 else
 begin
  l_Left := False;
  l_Top := False;
  l_Right := False;
  l_Bottom := False;
 end;

 l_Point.X := aWIndex;
 l_Point.Y := aIndex;
 CurrentPage := l_Point;
//подбираем масштаб, чтоб CurrentPage в окно
 l_PixPageWidth := ClientWidth - f_BorderSize - f_BorderSize;
 DropOffsetCache;
 if aByWidth then
 begin
  SetMM2Pix(l_PixPageWidth/MMPageWidth(CurrentPage.Y, CurrentPage.X));
  f_ZoomStatus := ev_zsByWidth;
 end//aByWidth
 else
 begin
  l_PixPageHeight := ClientHeight - f_BorderSize - f_BorderSize;
  if (MMPageWidth(CurrentPage.Y, CurrentPage.X)/MMPageHeight(CurrentPage.Y, CurrentPage.X) >
      l_PixPageWidth/l_PixPageHeight) then
    SetMM2Pix(l_PixPageWidth/MMPageWidth(CurrentPage.Y, CurrentPage.X))
  else
    SetMM2Pix(l_PixPageHeight/MMPageHeight(CurrentPage.Y, CurrentPage.X));
  f_ZoomStatus := ev_zsToPage;
 end;//aByWidth
//позиционируемся на CurrentPage
 GetPageRect(CurrentPage.Y, CurrentPage.X, l_Rect);
 l_x0 := ((ClientWidth - (l_Rect.Right - l_Rect.Left)) div 2) -
   PageXOffset(CurrentPage.Y, CurrentPage.X);
 l_y0 := ((ClientHeight - (l_Rect.Bottom - l_Rect.Top)) div 2) -
   PageYOffset(CurrentPage.Y, CurrentPage.X);
 if aByWidth then
 begin
  l_Prev := CurrentPage;
  SetPixXYOffset(l_x0, l_y0);
  CurrentPage := l_Prev;
  GetPageRect(CurrentPage.Y, CurrentPage.X, l_Rect);
  if l_HasPrev then
  begin
   if l_Left then
   begin
    if l_Rect.Left < 0 then
     l_x0 := -PageXOffset(CurrentPage.Y, CurrentPage.X);
   end
   else
   if l_Right then
   begin
    if l_Rect.Right > ClientWidth then
     l_x0 := ClientWidth -
       (PageXOffset(CurrentPage.Y, CurrentPage.X) + PixPageWidth(CurrentPage.Y, CurrentPage.X));
   end;
   if l_Top then
   begin
    if l_Rect.Top < 0 then
     l_y0 := -PageYOffset(CurrentPage.Y, CurrentPage.X);
   end
   else
   if l_Bottom then
   begin
    if l_Rect.Bottom > ClientHeight then
     l_y0 := ClientHeight -
       (PageYOffset(CurrentPage.Y, CurrentPage.X) + PixPageHeight(CurrentPage.Y, CurrentPage.X));
   end;
  end
  else
   l_y0 := -PageYOffset(CurrentPage.Y, CurrentPage.X);
 end;
 SetPixXYOffset(l_x0, l_y0);
end;

function TvtCustomPreviewPanel.GetState: IevPreviewPanelState;
begin
 result := TeePreviewPanelState.Make(self);
end;

procedure TvtCustomPreviewPanel.SetState(const aState: IevPreviewPanelState);
  {-}
begin
 if (aState = nil) then
  Exit;
 f_ReadingFromHistory := True;
 Preview := aState.Preview;
 PreviewCanvas := aState.PreviewCanvas;
 SetMM2Pix(aState.MM2Pix);
 GrayscaleFlag := aState.IsGrayscale;
 DropOffsetCache;
 f_PixX0 := aState.PagePixOffset.X;
 f_PixY0 := aState.PagePixOffset.Y;
 f_CurrentPage := aState.Page;
end;

procedure TvtCustomPreviewPanel.Zoom(aX0, aY0: Integer; aK: Double; aGoCenter: Boolean = true);
var
  l_X0,
  l_Y0: Integer;
  l_Current: TPoint;
  l_MM2PixPrev: Double;
begin
 if aK <= 0 then
  Exit;
 DropOffsetCache;
 f_ZoomStatus := ev_zsCustom;
 l_X0 := aX0;
 l_Y0 := aY0;
 l_Current := GetPageAt(l_X0, l_Y0);
 if l_Current.Y < 0 then
  Exit;

 l_MM2PixPrev := MM2Pix;
 SetMM2Pix(MM2Pix*aK);
 aK := MM2Pix/l_MM2PixPrev;

 if (aK >= 1.0) and aGoCenter then
 begin
   aX0 := ClientWidth div 2;
   aY0 := ClientHeight div 2;
 end;//(aK >= 1.0) and aGoCenter
 SetPixXYOffset(aX0 - (PageXOffset(l_Current.Y, l_Current.X) + Trunc(l_X0*aK)),
                aY0 - (PageYOffset(l_Current.Y, l_Current.X) + Trunc(l_Y0*aK)), true);
end;

function TvtCustomPreviewPanel.DefPage: TPoint;
var
  l_x0,
  l_y0: Integer;
begin
  l_x0 := ClientWidth div 2;
  l_y0 := ClientHeight div 2;
  result := GetPageAt(l_x0, l_y0);
end;

procedure TvtCustomPreviewPanel.DrawZoomRect(aX0, aY0, aX1, aY1: Integer);
var
 l_x0,
 l_y0,
 l_x1,
 l_y1 : Integer;
begin
 Canvas.Brush.Style := bsClear;
 Canvas.Pen.Color := clBtnFace;
 Canvas.Pen.Mode := pmXor;
 l_x0 := Min(f_MouseDownPos.X, f_MousePrevPos.X);
 l_y0 := Min(f_MouseDownPos.Y, f_MousePrevPos.Y);
 l_x1 := Max(f_MouseDownPos.X, f_MousePrevPos.X) + 1;
 l_y1 := Max(f_MouseDownPos.Y, f_MousePrevPos.Y) + 1;
 Canvas.Rectangle(l_x0, l_y0, l_x1, l_y1);
end;

function TvtCustomPreviewPanel.IsPagesCounter: Boolean;
begin
 Result := (PreviewCanvas <> nil) AND PreviewCanvas.IsPagesCounter;
end;

function TvtCustomPreviewPanel.IsReady: Boolean;
  {-}
begin
 Result := (f_PreviewCanvas <> nil) AND
           (PagesCounted.rPagesCount > 0) AND
           (PagesCount = PagesCounted.rPagesCount);
end;

function TvtCustomPreviewPanel.InUpdate: Boolean;
  {-}
begin
 Result := (Preview <> nil) AND Preview.InUpdate; 
end;

function TvtCustomPreviewPanel.PaintToBitmap: Boolean;
var
 l_TopPage    : Integer;
 l_BottomPage : Integer;
 x            : Integer;
 y            : Integer;
 l_Rect       : TRect;
 l_WidthCount : Integer;
begin
 Result := false;
 if (PagesCount < 1) OR
    (PreviewCanvas = nil) OR IsPagesCounter then
  Exit;

 if (f_Bitmap = nil) then
 begin
  f_Bitmap := Tl3Bitmap.Create;
  f_Bitmap.PixelFormat := pf32bit;
  f_Bitmap.Width := ClientWidth;
  f_Bitmap.Height := ClientHeight;
 end;//f_Bitmap = nil

 with f_Bitmap.Canvas do
 begin
  Pen.Mode := pmCopy;
  Pen.Color := clBtnFace;
  Brush.Color := clBtnFace;
  Brush.Style := bsSolid;
  Rectangle(GetClientRect);
 end;//with f_Bitmap.Canvas
 l_TopPage := 0;
 l_BottomPage := PagesCount - 1;
 if (Abs(f_LastDeltaY - f_PixY0) < ClientHeight div 2) then
 begin
  l_TopPage := Max(l_TopPage, f_LastTopPage);
  l_BottomPage := Min(f_LastBottomPage, l_BottomPage);
 end;//Abs(f_LastDeltaY - f_PixY0)
 f_LastTopPage := High(f_LastTopPage);
 f_LastTopVisiblePage := High(f_LastTopPage);
 f_LastBottomPage := 0;
 for y := l_TopPage to l_BottomPage do
 begin
  l_WidthCount := PreviewCanvas.GetPagesWidthCount(y) - 1;
  if (l_WidthCount >= 0) then
  begin
   for x := 0 to l_WidthCount do
   begin
    GetPaperRect(y, x, l_Rect);
     // - область вывода закончилась
    if (l_Rect.Bottom < 0) then
     continue;
     // - бежим по страницам сверху вниз
    if (l_Rect.Top > f_Bitmap.Height) then
     break;
 //page number
    f_LastTopPage := Min(f_LastTopPage, y-1);
    f_LastBottomPage := Max(f_LastBottomPage, y+1);
    f_LastTopVisiblePage := Min(f_LastTopVisiblePage, y);
    if (l_Rect.Right < 0) then
     continue;
     // - бежим по страницам справа налево
    if (l_Rect.Left > f_Bitmap.Width) then
     break;
     // - область вывода закончилась
    with f_Bitmap.Canvas do
    begin
 //paper rect
     Pen.Color := clBtnText;
     Pen.Mode := pmCopy;
     Pen.Style := psSolid;
     Brush.Color := clWhite;//clWindow
     Brush.Style := bsSolid;
     Rectangle(l_Rect);
 //paper rect shadow
     Pen.Color := cl3DDkShadow;
     MoveTo(l_Rect.Left + 1, l_Rect.Bottom);
     LineTo(l_Rect.Right, l_Rect.Bottom);
     LineTo(l_Rect.Right, l_Rect.Top);
     PreviewCanvas.DrawTo(y, x, l_Rect, f_Bitmap);
 //rgb to gray
    end;//with f_Bitmap.Canvas
   end;//for x
   if (l_Rect.Bottom < 0) then
    continue;
    // - бежим по страницам сверху вниз
   if (l_Rect.Top > f_Bitmap.Height) then
    break;
    // - область вывода закончилась
  end;//l_WidthCount >= 0
 end;//for y
 if f_Gray then
  RGBToGray(f_Bitmap, Rect(0, 0, f_Bitmap.Width, f_Bitmap.Height));
 Result := true;
end;

function TvtCustomPreviewPanel.Print: Boolean;
  {-}
begin
 Result := False;
 if (Preview <> nil) then
 begin
  Preview.Print;
  Result := not Preview.Stopped;
 end;
end;

function TvtCustomPreviewPanel.MM2Pix: Double;
begin
 Result := f_MM2Pix;
 if (Result <= 0) AND (PreviewCanvas <> nil) AND (PagesCount > 0) then
 begin
  f_MM2Pix := 0.1;
  // - чтобы избежать рекурсии
  ZoomToPage(0, 0, true);
  Result := f_MM2Pix;
  f_PageOffset := nil;
 end;//Result <= 0
end;

procedure TvtCustomPreviewPanel.SetMM2Pix(aMM2Pix: Double);
begin
 f_PageOffset := nil;
 f_MM2Pix := aMM2Pix;

 if ZoomPercent < 5 then
  f_MM2Pix := 5*0.01*(c_PixelsPerInch/25.4)
 else
 if ZoomPercent > 500 then
  f_MM2Pix := 500*0.01*(c_PixelsPerInch/25.4);
end;

procedure TvtCustomPreviewPanel.SetPixXYOffset(aX, aY: Integer; aRepaintNow: Boolean = false);
var
 l_x0,
 l_y0,
 l_PixWidth,
 l_PixHeight  : Longint;
 l_ScrollInfo : TScrollInfo;
begin
 f_LastDeltaX := f_PixX0;
 f_LastDeltaY := f_PixY0;
 l_PixHeight := PixHeight;
 l_y0 := aY;
 if (l_PixHeight < ClientHeight) then
  l_y0 := (ClientHeight - l_PixHeight) div 2
 else
 begin
  l_y0 := Max(ClientHeight - l_PixHeight, l_y0);
  l_y0 := Min(0, l_y0);
 end;
 f_PixY0 := l_y0;

 l_PixWidth := PixWidth;
 l_x0 := aX;
 if (l_PixWidth < ClientWidth) then
  l_x0 := (ClientWidth - l_PixWidth) div 2
 else
 begin
  l_x0 := Max(ClientWidth - l_PixWidth, l_x0);
  l_x0 := Min(0, l_x0);
 end;
 f_PixX0 := l_x0;

 if aRepaintNow then
  Paint
 else
  Invalidate;
 UpdateCurrent;

 l_PixWidth := PixWidth;
 l_PixHeight := PixHeight;

 l3FillChar(l_ScrollInfo, SizeOf(l_ScrollInfo), 0);
 with l_ScrollInfo do
 begin
  cbSize := SizeOf(l_ScrollInfo);
  fMask := SIF_ALL;
  nMin := 0;
  nMax := f_ScrollRange;
 end;
 if l_PixWidth > ClientWidth then
 begin
  EnableScrollBar(Handle, SB_HORZ, ESB_ENABLE_BOTH);
  with l_ScrollInfo do
  begin
   nPage := Trunc((ClientWidth/l_PixWidth)*f_ScrollRange);
   nPos := Trunc(-(PixX0/l_PixWidth)*f_ScrollRange);
  end;
  SetScrollInfo(Handle, SB_HORZ, l_ScrollInfo, true);
 end
 else
  EnableScrollBar(Handle, SB_HORZ, ESB_DISABLE_BOTH);
 if l_PixHeight > ClientHeight then
 begin
  EnableScrollBar(Handle, SB_VERT, ESB_ENABLE_BOTH);
  with l_ScrollInfo do
  begin
   nPage := Trunc((ClientHeight/l_PixHeight)*f_ScrollRange);
   nPos := Trunc(-(PixY0/l_PixHeight)*f_ScrollRange);
  end;
  SetScrollInfo(Handle, SB_VERT, l_ScrollInfo, true);
 end
 else
  EnableScrollBar(Handle, SB_VERT, ESB_DISABLE_BOTH);
end;

procedure TvtCustomPreviewPanel.SetPixX0(aX: Longint);
begin
 SetPixXYOffset(aX, PixY0, true);
end;

procedure TvtCustomPreviewPanel.SetPixY0(aY: Longint);
begin
 SetPixXYOffset(PixX0, aY, true);
end;

function TvtCustomPreviewPanel.GetPageAt(var aX, aY: Integer): TPoint;
var
 i,
 l_Count1: Integer;
begin
 Result.Y := -1;
 Result.X := -1;
 if (PagesCount < 1) OR IsPagesCounter then
  Exit;

 l_Count1 := PagesCount - 1;
 result.Y := l_Count1;
 for i := 1 to l_Count1 do
   if aY < PixY0 + PageYOffset(i, 0) then
   begin
     result.Y := i - 1;
     break;
   end;
 l_Count1 := PreviewCanvas.GetPagesWidthCount(result.Y) - 1;
 result.X := l_Count1;
 for i := 1 to l_Count1 do
   if aX < PixX0 + PageXOffset(result.Y, i) then
   begin
     result.X := i - 1;
     break;
   end;

 aX := aX - (PixX0 + PageXOffset(result.Y, result.X));
 aY := aY - (PixY0 + PageYOffset(result.Y, result.X));
end;

function TvtCustomPreviewPanel.GetPageRect(aPage, aWPage: Integer; out aRect: TRect): Boolean;
begin
 Result := false;
 if (PagesCount < 1) OR IsPagesCounter then
  Exit;
 aRect.Left := PixX0 + PageXOffset(aPage, aWPage);
 aRect.Top := PixY0 + PageYOffset(aPage, aWPage);
 aRect.Right := aRect.Left + PixPageWidth(aPage, aWPage);
 aRect.Bottom := aRect.Top + PixPageHeight(aPage, aWPage);
 Result := true;
end;

function TvtCustomPreviewPanel.GetPaperRect(aPage, aWPage: Integer; out aRect: TRect): Boolean;
begin
 Result := GetPageRect(aPage, aWPage, aRect);
 if Result then
  InflateRect(aRect, -f_BorderSize*2, -f_BorderSize*2);
end;

procedure TvtCustomPreviewPanel.DrawFocusRectA(aPage: TPoint);
var
 l_Rect: TRect;
begin
 if GetPaperRect(aPage.Y, aPage.X, l_Rect) then
 begin
  InflateRect(l_Rect, -2, -2);
  Canvas.DrawFocusRect(l_Rect);
 end;
end;

procedure TvtCustomPreviewPanel.DropOffsetCache;
begin
 DropSize;
 f_PageOffset := nil;
end;

procedure TvtCustomPreviewPanel.UpdateCurrent;
var
  l_Point: TPoint;
begin
  GetCursorPos(l_Point);
  with ScreenToClient(l_Point) do
    UpdateCurrentAt(X, Y);
end;

procedure TvtCustomPreviewPanel.UpdateCurrentAt(aX, aY: Integer);
var
  l_x0,
  l_y0: Integer;
  l_Current: TPoint;
begin
 if (PagesCount < 1) OR IsPagesCounter then
  Exit;
 l_x0 := Min(Max(0, aX), ClientWidth - 1);
 l_y0 := Min(Max(0, aY), ClientHeight - 1);
 l_Current := GetPageAt(l_x0, l_y0);

 if (l_Current.Y <> CurrentPage.Y) or (l_Current.X <> CurrentPage.X) then
  CurrentPage := l_Current;
end;

function TvtCustomPreviewPanel.IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
var
 l_Controller : TOvcController;
begin
 Result := false;
 l_Controller := GetDefController;
 if Assigned(l_Controller) then
  with l_Controller.EntryCommands do
   if TranslateUsing([], TMessage(Msg), GetTickCount) = ccShortCut then
   begin
    Msg.Result := 0;  {indicate that this message was processed}
    Result := true;
   end;
end;

procedure TvtCustomPreviewPanel.WMKeyDown(Var Msg: TWMKeyDown);
begin
 if IsHandledShortcut(Msg) then
  Exit;
 UpdateMouseMode;
 case Msg.CharCode of
  VK_HOME:
   GoHome;
  VK_END:
   GoEnd;
  VK_UP:
   ScrollUp;
  VK_DOWN:
   ScrollDown;
  VK_LEFT:
   ScrollLeft;
  VK_RIGHT:
   ScrollRight;
  VK_PRIOR:
   PageUp;
  VK_NEXT:
   PageDown;
  187,
  VK_ADD:
   ZoomIn;
  189,
  VK_SUBTRACT:
   ZoomOut;
 end;
 inherited;
end;

procedure TvtCustomPreviewPanel.WMSysKeyDown(var Msg: TWMSysKeyDown);
begin
 if IsHandledShortcut(Msg) then
  Exit;
 UpdateMouseMode;
 inherited;
end;

procedure TvtCustomPreviewPanel.WMKeyUp(Var Msg: TWMKeyUp);
begin
 UpdateMouseMode;
 inherited;
end;
procedure TvtCustomPreviewPanel.WMSysKeyUp(var Msg: TWMSysKeyUp);
begin
 UpdateMouseMode;
 inherited;
end;

procedure TvtCustomPreviewPanel.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
begin
 Msg.Result := 1;
end;

procedure TvtCustomPreviewPanel.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
 inherited;
 if csDesigning in ComponentState then
  Msg.Result := DLGC_STATIC
 else
  Msg.Result := Msg.Result or DLGC_WANTCHARS or DLGC_WANTARROWS or
                DLGC_WANTALLKEYS{ or DLGC_WANTTAB};
end;

procedure TvtCustomPreviewPanel.WMMouseActivate(var Msg : TWMMouseActivate);
begin
 inherited;
 if not (csDesigning in ComponentState) then
  SetFocus;
end;

procedure TvtCustomPreviewPanel.evmsgNeedDoc(var Msg: TMessage);
  //message ev_msgNeedDoc;
  {-}
begin
 if Assigned(f_Preview) and not f_Preview.CloseRequested then
  f_Stopped := false;
 try
  PreviewCanvas;
 except
  on EnevMaybePreviewCancelled do ;
 end;//try..except
end;

procedure TvtCustomPreviewPanel.Paint;
var
 l_NeedClear : Boolean;
begin
 l_NeedClear := true;
 if (f_PreviewCanvas = nil) then
 begin
  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(ClientRect);
  PostMessage(Handle, ev_msgNeedDoc, 0, 0);
  Exit;
 end;//f_PreviewCanvas = nil
 if PaintToBitmap AND (f_Bitmap <> nil) then
 begin
  Canvas.Draw(0, 0, f_Bitmap);
  DrawFocusRectA(CurrentPage);
  Painted := True;
 end//PaintToBitmap
 else
 if l_NeedClear then
 begin
  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(ClientRect);
 end;//PaintToBitmap
end;

procedure TvtCustomPreviewPanel.Resize;
begin
 inherited;
 if (f_PrevClientWidth < 1) or (f_PrevClientHeight < 1) then
 begin
  f_PrevClientWidth := ClientWidth;
  f_PrevClientHeight := ClientHeight;
 end;//f_PrevClientWidth < 1..
 DropSize;
 if Assigned(f_Bitmap) then
 begin
  with f_Bitmap do
  begin
   Width := ClientWidth;
   Height := ClientHeight;
  end;//with f_Bitmap
  if (PagesCount > 0) then
  begin
   if (f_ZoomStatus = ev_zsCustom) then
   begin
    SetPixXYOffset(PixX0 + (ClientWidth - f_PrevClientWidth) div 2,
                   PixY0 + (ClientHeight - f_PrevClientHeight) div 2);
    Zoom(ClientWidth div 2, 0, ClientWidth/f_PrevClientWidth, false);
   end//f_ZoomStatus = ev_zsCustom
   else
    with GetCurrentPage do
     ZoomToPage(Y, X, f_ZoomStatus = ev_zsByWidth);
  end;//PagesCount > 0
 end;//Assigned(f_Bitmap)
 f_PrevClientWidth := ClientWidth;
 f_PrevClientHeight := ClientHeight;
end;

procedure TvtCustomPreviewPanel.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 inherited;
 if (Button = mbLeft) then
 begin
  f_DownFlag := true;
  f_MouseDownPos.X := X;
  f_MouseDownPos.Y := Y;
  f_MousePrevPos.X := X;
  f_MousePrevPos.Y := Y;
 end;//Button = mbLeft
end;

procedure TvtCustomPreviewPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
 if (f_PreviewCanvas <> nil) then
 begin
  if f_DownFlag then
    case f_DownMode of
      ppMove:
      begin
        SetPixXYOffset(PixX0 + X - f_MousePrevPos.X, PixY0 + Y - f_MousePrevPos.Y, true);
        f_MousePrevPos.X := X;
        f_MousePrevPos.Y := Y;
      end;
      ppZoomIn,
      ppZoomOut:
      begin
        DrawZoomRect(f_MouseDownPos.X, f_MouseDownPos.Y, f_MousePrevPos.X, f_MousePrevPos.Y);
        f_MousePrevPos.X := X;
        f_MousePrevPos.Y := Y;
        DrawZoomRect(f_MouseDownPos.X, f_MouseDownPos.Y, f_MousePrevPos.X, f_MousePrevPos.Y);
      end;
    end;

  UpdateCurrentAt(X, Y);
 end;//f_PreviewCanvas <> nil
 inherited;
end;

procedure TvtCustomPreviewPanel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  c_MinDelta = 4;
var
  l_dX,
  l_dY,
  l_kX,
  l_kY : Double;
begin
  if f_DownFlag then
    case f_DownMode of
      ppZoomIn,
      ppZoomOut:
      begin
        DrawZoomRect(f_MouseDownPos.X, f_MouseDownPos.Y, f_MousePrevPos.X, f_MousePrevPos.Y);
        l_dX := Abs(X - f_MouseDownPos.X);
        l_dY := Abs(Y - f_MouseDownPos.Y);
        if l_dX + l_dY < c_MinDelta then
          l_kX := 1.5
        else
        begin
          l_kX := l_dX/ClientWidth;
          l_kY := l_dY/ClientHeight;
          if l_kY > l_kX then
            l_kX := l_kY;
          l_kX := 1/l_kX;
        end;
        if f_DownMode = ppZoomOut then
          l_kX := 1/l_kX;
        Zoom((f_MouseDownPos.X + X) div 2, (f_MouseDownPos.Y + Y) div 2, l_kX);
      end;
    end;
  f_DownFlag := false;
  UpdateMouseMode;

  inherited;
end;

procedure TvtCustomPreviewPanel.WMVScroll(var Msg : TWMScroll);
begin
 case Msg.ScrollCode of
  SB_LINEUP:
   ScrollUp;
  SB_LINEDOWN:
   ScrollDown;
  SB_PAGEUP:
   PageUp;
  SB_PAGEDOWN:
   PageDown;
  SB_THUMBPOSITION,
  SB_THUMBTRACK:
   PixY0 := Trunc(-(Msg.Pos/f_ScrollRange)*PixHeight);
 end;
end;

procedure TvtCustomPreviewPanel.WMHScroll(var Msg : TWMScroll);
begin
 case Msg.ScrollCode of
  SB_LINEUP:
   PixX0 := PixX0 + f_ScrollSmallStep;
  SB_LINEDOWN:
   PixX0 := PixX0 - f_ScrollSmallStep;
  SB_PAGEUP:
   PixX0 := PixX0 + ClientWidth;
  SB_PAGEDOWN:
   PixX0 := PixX0 - ClientWidth;
  SB_THUMBPOSITION,
  SB_THUMBTRACK:
   PixX0 := Trunc(-(Msg.Pos/f_ScrollRange)*PixWidth);
 end;
end;

procedure TvtCustomPreviewPanel.MouseWheelHandler(var Message: TMessage);
begin
 inherited;
 if (Integer(Message.wParam) > 0) then
  PixY0 := PixY0 + f_ScrollSmallStep
 else
  PixY0 := PixY0 - f_ScrollSmallStep;
end;

function TvtCustomPreviewPanel.GetZoomPercent: Integer;
begin
 result := Trunc(100.0*MM2Pix/(c_PixelsPerInch/25.4));
end;

procedure TvtCustomPreviewPanel.SetZoomPercent(aPercent: Integer);
begin
 if (PagesCount > 0) then
  Zoom(ClientWidth div 2,
       ClientHeight div 2,
       aPercent*0.01*(c_PixelsPerInch/25.4)/MM2Pix);
end;

function TvtCustomPreviewPanel.GetCurrentPage: TPoint;
begin
 Result.Y := -1;
 Result.X := -1;
 if (PagesCount > 0) then
 begin
  if (f_CurrentPage.X < 0) OR (f_CurrentPage.Y < 0) then
  begin
   f_CurrentPage.X := 0;
   f_CurrentPage.Y := 0;
   Invalidate;
  end;//f_CurrentPage.X < 0..
  Result := f_CurrentPage;
 end
 else
  f_CurrentPage := Result;
end;

procedure TvtCustomPreviewPanel.SetCurrentPage(const aIndex: TPoint);
begin
 if (PagesCount > 0) then
 begin
  DrawFocusRectA(CurrentPage);
  f_CurrentPage.Y := PageIndex(aIndex.Y);
  f_CurrentPage.X := PageWIndex(f_CurrentPage.Y, aIndex.X);
  DrawFocusRectA(CurrentPage);
  CallCurrentPageChanged;
 end;//PagesCount > 0
end;

procedure TvtCustomPreviewPanel.SetMoveMode;
begin
 Cursor := TCursor(ppMove);
 f_DownMode := ppMove;
end;

procedure TvtCustomPreviewPanel.SetMoveZoomIn;
begin
 Cursor := TCursor(ppZoomIn);
 f_DownMode := ppZoomIn;
end;

procedure TvtCustomPreviewPanel.SetMoveZoomOut;
begin
 Cursor := TCursor(ppZoomOut);
 f_DownMode := ppZoomOut;
end;

procedure TvtCustomPreviewPanel.UpdateMouseMode;
begin
 if f_DownFlag then
  exit;
 if (GetKeyState(VK_CONTROL) < 0) and (GetKeyState(VK_MENU) < 0) then
  SetMoveZoomOut
 else
 if (GetKeyState(VK_CONTROL) < 0) then
  SetMoveZoomIn
 else
  SetMoveMode;
end;

procedure TvtCustomPreviewPanel.GoHome;
begin
 PixY0 := 0;
end;

procedure TvtCustomPreviewPanel.GoEnd;
begin
 PixY0 := -PixHeight;
end;

procedure TvtCustomPreviewPanel.PageUp;
begin
 PixY0 := PixY0 + ClientHeight;
end;

procedure TvtCustomPreviewPanel.PageDown;
begin
 PixY0 := PixY0 - ClientHeight;
end;

procedure TvtCustomPreviewPanel.ScrollUp;
begin
 PixY0 := PixY0 + f_ScrollSmallStep;
end;

procedure TvtCustomPreviewPanel.ScrollDown;
begin
 PixY0 := PixY0 - f_ScrollSmallStep;
end;

procedure TvtCustomPreviewPanel.ScrollLeft;
begin
 PixX0 := PixX0 + f_ScrollSmallStep;
end;

procedure TvtCustomPreviewPanel.ScrollRight;
begin
 PixX0 := PixX0 - f_ScrollSmallStep;
end;

procedure TvtCustomPreviewPanel.ZoomIn;
begin
 Zoom(ClientWidth div 2, ClientHeight div 2, 1.1);
end;

procedure TvtCustomPreviewPanel.ZoomOut;
begin
 Zoom(ClientWidth div 2, ClientHeight div 2, 0.9);
end;

procedure TvtCustomPreviewPanel.LockGrayScale;
begin
 Inc(f_GrayScaleLockCount);
end;

procedure TvtCustomPreviewPanel.UnlockGrayScale;
begin
 Dec(f_GrayScaleLockCount);
end;

procedure TvtCustomPreviewPanel.SetGrayscale(aNeedGrayscale: Boolean);
begin
 if (f_GrayScaleLockCount = 0) and (f_Gray <> aNeedGrayscale) then
 begin
  f_Gray := aNeedGrayscale;
  Invalidate;
 end;
end;

function TvtCustomPreviewPanel.GetPreview: IafwDocumentPreview;
begin
 Result := f_Preview;
 if (Result <> nil) and (f_LastTopVisiblePage < High(f_LastTopVisiblePage)) then
  Result.SetCurrentPageNumber(f_LastTopVisiblePage);
end;

procedure TvtCustomPreviewPanel.ContentChanged;
begin
 f_LockStatusUpdate := true;
 try
  PreviewCanvas := nil;
  if f_Preview.InProcess then
   Invalidate;
 finally
  f_LockStatusUpdate := False;
 end;
end;

procedure TvtCustomPreviewPanel.WMSetCursor(var Message: TWMSetCursor);
begin
 with Message do
  if (CursorWnd = Handle) and (Smallint(HitTest) = HTCLIENT) and not f_Painted then
  begin
   Windows.SetCursor(Screen.Cursors[crHourGlass]);
   Result := 1;
  end
  else
   inherited;
end;

function TvtCustomPreviewPanel.pm_GetPainted: Boolean;
begin
 Result := f_Painted;
end;

procedure TvtCustomPreviewPanel.pm_SetPainted(const aValue: Boolean);
begin
 if Painted <> aValue then
 begin
  f_Painted := aValue;
  Perform(CM_CURSORCHANGED, 0, 0);
 end;
end;

{$IFDEF nsTest}
function TvtCustomPreviewPanel.ShouldStop: Boolean;
begin
 Result := False;
end;
{$ENDIF nsTest}

end.
