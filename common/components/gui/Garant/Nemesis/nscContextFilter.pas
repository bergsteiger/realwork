unit nscContextFilter;

(*-----------------------------------------------------------------------------
 Название:   nscContextFilter
 Автор:      Р. Лукьянец
 Назначение:
 Версия:
   $Id: nscContextFilter.pas,v 1.76 2015/04/14 13:39:01 morozov Exp $
 История:
   $Log: nscContextFilter.pas,v $
   Revision 1.76  2015/04/14 13:39:01  morozov
   {RequestLink: 594891894}

   Revision 1.75  2015/04/08 12:00:25  kostitsin
   {requestlink: 595952825 }

   Revision 1.74  2015/03/31 13:16:53  kostitsin
   {requestlink: 595952825 }

   Revision 1.73  2013/04/24 09:35:37  lulin
   - портируем.

   Revision 1.72  2013/02/04 10:23:54  kostitsin
   [$351209401]

   Revision 1.71  2012/11/12 10:25:03  fireton
   - не собирался AllArchiComponents7

   Revision 1.70  2012/11/02 14:40:37  kostitsin
   [$407738488]

   Revision 1.69  2012/02/08 12:55:34  kostitsin
   [$263293786]

   Revision 1.68  2012/02/08 11:32:20  kostitsin
   [$263293786]

   Revision 1.67  2011/09/22 11:48:46  lulin
   {RequestLink:286625857}.

   Revision 1.66  2011/06/02 12:00:27  lulin
   {RequestLink:265396831}.

   Revision 1.65  2011/03/21 16:14:28  lulin
   {RequestLink:257822128}.

   Revision 1.64  2011/03/18 18:29:11  lulin
   - учим контекстный фильтр обводится синей рамкой.

   Revision 1.63  2011/03/16 18:24:18  lulin
   {RequestLink:228688510}.
   - используем новый синий цвет фона.

   Revision 1.62  2011/03/05 18:55:10  lulin
   {RequestLink:228688510}.

   Revision 1.61  2011/01/28 12:03:59  lulin
   {RequestLink:248195582}.
   - проверяем правильность контекста и в дополнительных списках тоже.

   Revision 1.60  2010/03/10 19:41:58  lulin
   {RequestLink:196445017}.

   Revision 1.59  2009/12/02 14:44:34  oman
   - new: Контекстный фильтр {RequestLink:121157219}

   Revision 1.58  2009/12/02 14:38:00  oman
   - new: Контекстный фильтр {RequestLink:121157219}

   Revision 1.57  2008/10/31 08:59:00  oman
   - fix: Неправильно выясняли заголовок окна (К-122093638)

   Revision 1.56  2008/10/29 12:04:23  lulin
   - <K>: 121166314.

   Revision 1.55  2008/09/08 10:59:07  oman
   - fix: При загрузке запросов всегда приводим дерево ППС в нулевое положение (К-112722961)

   Revision 1.54  2008/07/22 10:30:59  oman
   - new: Отключение пищалки - ручка (К-103940886)

   Revision 1.53  2008/07/10 11:18:33  lulin
   - убран один лишний Beep.

   Revision 1.52  2008/07/07 14:27:03  lulin
   - подготавливаемся к переименованию.

   Revision 1.51  2008/07/02 13:27:31  oman
   - fix: Откручиваем заточки (К-91848911)

   Revision 1.50  2008/07/02 11:41:59  oman
   - fix: Свойство названо в соответствии со своим значением (К-96474339)

   Revision 1.49  2008/07/01 12:46:08  oman
   - new: При вставке из клипборда перефильтровываем дерево посимвольно (К-96474339)

   Revision 1.48  2008/07/01 12:11:13  oman
   - new: При втсавке из клипборда пищим и выделяем зафильтрованное (К-96474339)

   Revision 1.47  2008/06/30 09:56:38  oman
   - new: Пищим только в конце (cq11768)

   Revision 1.46  2008/06/26 11:18:35  oman
   - fix: Боремся с перетрансляцией ввода (cq11768)

   Revision 1.45  2008/06/26 10:49:54  oman
   - fix: Боремся с перетрансляцией ввода (cq11768)

   Revision 1.44  2008/06/26 09:49:10  oman
   - fix: При косвенном вводе повторяем логику (cq11768)

   Revision 1.43  2008/06/26 09:13:48  oman
   - fix: Пытаемся бороться с паразитным OnChange (cq11768)
   - fix: Выделяем лишний хвост (cq11768)

   Revision 1.42  2008/06/26 07:55:16  oman
   - new: Для контекстного фильтра выясняем начало различий (cq11768)

   Revision 1.41  2008/06/26 06:14:46  oman
   - new: Выделяем новый компонент (cq29374)

   Revision 1.40  2008/06/25 13:46:10  oman
   - new: Попискиваем при зафильтрованном контексте (cq11768)

   Revision 1.39  2008/06/24 12:29:26  oman
   - new: Заготовка для нового компонента (cq29374)

   Revision 1.38  2008/06/17 14:07:38  oman
   - new: Цвет для пустого хинта (cq29206)

   Revision 1.37  2008/05/15 20:15:17  lulin
   - тотальная чистка.

   Revision 1.36  2008/04/25 07:00:43  oman
   - fix: Зачищаем Undo буфер после создания

   Revision 1.35  2008/03/25 13:01:37  lulin
   - поправил провисание ссылок, <K>: 88080394.

   Revision 1.34  2008/03/19 14:23:30  lulin
   - cleanup.

   Revision 1.33  2008/02/04 08:51:19  lulin
   - класс _Tl3InterfaceList выделен в отдельный модуль.

   Revision 1.32  2007/12/07 16:22:37  lulin
   - переименовываем файл, чтобы не путать с другой библиотекой.

   Revision 1.31  2007/10/18 10:49:29  oman
   - fix: Паразитно заполнялся текст (cq27127)

   Revision 1.30  2007/10/17 11:08:37  oman
   - fix: Более правильно публикуем операции (cq27106)

   Revision 1.29  2007/10/10 12:32:50  oman
   - fix: Не публиковались операции (cq27002)

   Revision 1.28  2007/08/16 06:58:50  mmorozov
   - new behaviour: пишем событие фильтрации дерева также при разрушении компонета фильтрации (CQ: OIT5-26366);

   Revision 1.27  2007/08/07 11:25:47  oman
   - new: При переключении не только выключаем контекстный
    фильтр, но и очищаем его (cq26252)

   Revision 1.26  2007/07/26 09:38:38  mmorozov
   - new: возможность подписки на события контекстного фильтра (в рамках CQ: OIT5-25852);

   Revision 1.25  2007/04/19 13:00:30  oman
   - fix: Даем управлять жирностью шрифта метки (cq25103)

   Revision 1.24  2007/04/12 12:35:02  lulin
   - используем строки с кодировкой.

   Revision 1.23  2007/04/09 10:14:31  oman
   - fix: Переприменяем фильтр только если он активен

   Revision 1.22  2007/04/02 07:40:07  oman
   - fix: Обновляем валидность после переключения

   Revision 1.21  2007/03/30 06:03:08  oman
   - fix: Автоматически корректируем валидность только если установлен
    проверяльщик

   Revision 1.20  2007/03/29 12:12:25  oman
   переводим на строки с кодировкой - другим макаром

   Revision 1.19  2007/03/29 11:38:33  lulin
   - удалено ненужное свойство.

   Revision 1.18  2007/03/29 11:25:11  lulin
   - переводим на строки с кодировкой.

   Revision 1.17  2007/03/29 09:30:32  oman
   - fix: Обновляем IsContextWrong при присвоении состояния

   Revision 1.16  2007/03/28 19:42:49  lulin
   - ЭлПаковский редактор переводим на строки с кодировкой.

   Revision 1.15  2007/03/26 08:44:45  oman
   - new: Метод по насильному включению/дерганиью OnChange

   Revision 1.14  2007/03/22 13:50:52  oman
   - new: Реакция на переключение баз - теоретически готово (cq24456)

   Revision 1.13  2007/03/22 11:27:41  lulin
   - используем строки с кодировкой.

   Revision 1.12  2007/03/22 11:16:44  lulin
   - bug fix: зачем-то устанавливался неправильный стиль комбо.

   Revision 1.11  2007/03/22 08:22:53  oman
   - fix: На всякий случай прокидываем нотификацию о смене дерева
     у Outliner (ContextTarget), чтобы актуализировать валидность
    контекста (cq24456)

   Revision 1.10  2007/03/21 15:51:32  oman
   - new: Новое свойство ContextFilterTarget
    Более адекватное обновление IsContextWrong
    Реакция на внешнее изменение параметров контекстной
     фильтрации (cq24456)

   Revision 1.9  2007/03/21 08:40:24  oman
   Styling

   Revision 1.8  2007/03/20 15:13:53  oman
   - fix: Неправильно выставлялся цвет редактора (cq24456)

   Revision 1.7  2007/03/20 14:35:33  oman
   - fix: сменил предка, сделал нормальные рамки и поправил
    алгоритм позиционтирования внутренних контролов (cq24456)

   Revision 1.6  2007/03/20 09:12:25  oman
   - new: Поддержка "внешнего ввода" в строку контекста (cq24456)

   Revision 1.5  2007/03/19 10:44:06  oman
   - new: Учим контекстный фильтр сохраняться в историю (cq24456)

   Revision 1.4  2007/03/16 13:31:15  oman
   - new: Дабы не портить цвет шрифта, пользуем FakeBox.TextValid

   Revision 1.3  2007/03/16 07:44:42  oman
   - fix: На мелких шрифтах на загрузке формы портилась высота

   Revision 1.2  2007/03/15 16:00:00  oman
   - new: Вытащил свойство Visible

   Revision 1.1  2007/03/15 15:27:58  oman
   - new: Первое приближение визуального компонента для
    контекстной фильтрации (cq24456)


-----------------------------------------------------------------------------*)

{$Include nscDefine.inc }

interface
{$If defined(Nemesis)}
uses
 Classes,
 Controls,
 ImgList,
 Graphics,
 Messages,

 l3Interfaces,
 l3InternalInterfaces,
 l3TreeInterfaces,
 l3Types,

 afwControl,

 vtLabel,
 vtSpeedButtonForVGScene,

 vcmExternalInterfaces,

 nscInterfaces,
 nscNewInterfaces,
 nscComboBox,
 nscConst,

 vtF1InterfaceConst,

 vg_Scene,
 vg_Objects
 ;

const
 cDefaultBorders = 4{2};
 cDefaultImageIndex = -1;
 cDefaultLabelVisible = True;
 cMinEditorWidth = 50;
 cDefaultActive = False;
 cDefaultContextColor = clWindowText;
 cDefaultContextWrongColor = clRed;
 cDefaultColor = cGarant2011BackColor{clBtnFace};
 cDefaultBevelEdges = [beBottom];
 cDefaultBevelInner = bvRaised;
 cDefaultBevelOuter = bvLowered;
 cDefaultBevelKind = bkTile;
 cDefaultLabelFontIsBold = True;

type
 TnscGetIsContextWrong = procedure (aSender : TObject; var IsWrong: Boolean) of object;
 
 TnscContextFilter = class(TafwControl,
                           IvcmState,
                           IvcmOperationsProvider,
                           Il3CommandPublisherInfo,
                           Il3ContextFilterNotifier)
 {* - компонент задания контекстного фильтра. }
 private
  f_Scene                 : TvgScene;
  f_Border,
  f_InnerBorder,
  f_LabelBackground       : TvgRectangle;
  f_Label                 : TvgText;
  f_Editor                : TnscComboBoxWithFilter;
  f_Button                : TvtSpeedButtonForVGScene;
  f_Borders               : Integer;
  f_OnChange              : TNotifyEvent;
  f_ButtonActiveHint      : Il3CString;
  f_ButtonInactiveHint    : Il3CString;
  f_Active                : Boolean;
  {$IfDef Delphi7}
  f_ParentBackgroundSet   : Boolean;
  {$EndIf Delphi7}
  f_IsContextWrong        : Boolean;
  f_ChangeDisabledCounter : Integer;
  f_ContextFilterTarget   : Pointer;
  f_FilterName            : Il3CString;
  f_ValidContext          : Il3CString;
  f_PressingChar          : Boolean;
  f_OnWrongContext        : TNotifyEvent;
  f_ChangeCounter         : Integer;
  f_AssigningCounter      : Integer;
  f_OnGetIsContextWrong   : TnscGetIsContextWrong;
 protected
  // IvcmState
  function SaveState(out theState : IUnknown;
                     aStateType   : TvcmStateType): Boolean;
    {-}
  function LoadState(const aState : IUnknown;
                     aStateType   : TvcmStateType): Boolean;
    {-}
  // Il3ContextFilterNotifier
  procedure RequestReapply;
   {* - Желательно переприменить фильтр }
  procedure RequestClearAndTurnOff;
   {* - Дерево выключило на себе фильтр }
  procedure RequestCheckValid;
   {* - Дерево поменялось - нужно проверить валидность фильтра }
  // Il3CommandPublisherInfo
  function IsCommandPublished(Cmd: Tl3OperationCode): Boolean;
   {-}
  // IvcmOperationsProvider
  procedure ProvideOps(const aPublisher : IvcmOperationsPublisher);
   {-}
 private
  procedure WMEraseBkgnd(var Message : TWMEraseBkgnd);
    message WM_ERASEBKGND;
    {-}
  procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    {-}
 private
  procedure pm_SetBorders(const aValue: Integer);
    {-}
  function pm_GetImageIndex: TImageIndex;
    {-}
  function pm_GetImages: TCustomImageList;
    {-}
  procedure pm_SetImageIndex(const aValue: TImageIndex);
    {-}
  procedure pm_SetImages(const aValue: TCustomImageList);
    {-}
  function pm_GetLabelVisible: Boolean;
    {-}
  procedure pm_SetLabelVisible(const aValue: Boolean);
    {-}
  function IsLabelCaptionStored: Boolean;
    {-}
  function pm_GetLabelCaption: Tl3DString;
    {-}
  procedure pm_SetLabelCaption(const aValue: Tl3DString);
    {-}
  procedure pm_SetActive(const aValue: Boolean);
    {-}
  function pm_GetActiveContext: Il3CString;
    {-}
  function IsContextEmptyMessageStored: Boolean;
    {-}
  function pm_GetContextEmptyColor: TColor;
    {-}
  function pm_GetContextEmptyMessage: Tl3DString;
    {-}
  function pm_GetContextColor: TColor;
    {-}
  procedure pm_SetContextColor(const aValue: TColor);
    {-}
  procedure pm_SetContextEmptyColor(const aValue: TColor);
    {-}
  function pm_GetContextWrongColor: TColor;
    {-}
  procedure pm_SetContextWrongColor(const aValue: TColor);
    {-}
  procedure pm_SetContextEmptyMessage(const aValue: Tl3DString);
    {-}
  function pm_GetContext: Il3CString;
    {-}
  procedure pm_SetContext(const aValue: Il3CString);
    {-}
  function pm_GetIsContextWrong: Boolean;
    {-}
  procedure SetIsContextWrong(aValue: Boolean);
    {-}
  function IsButtonActiveHintStored: Boolean;
    {-}
  function IsButtonInActiveHintStored: Boolean;
    {-}
  function pm_GetButtonActiveHint: Tl3DString;
    {-}
  function pm_GetButtonInActiveHint: Tl3DString;
    {-}
  procedure pm_SetButtonActiveHint(const aValue: Tl3DString);
    {-}
  procedure pm_SetButtonInActiveHint(const aValue: Tl3DString);
    {-}
  function pm_GetContextFilterTarget: Il3ContextFilterTarget;
    {-}
  procedure pm_SetContextFilterTarget(const aValue: Il3ContextFilterTarget);
    {-}
  function pm_GetLabelFontIsBold: Boolean;
    {-}
  procedure pm_SetLabelFontIsBold(const aValue: Boolean);
    {-}
  function pm_GetContextWasChanged: Boolean;
    {-}
 private
  procedure AdjustContolsPosition;
    {-}
  {$IFNDEF DesignTimeLibrary}
  procedure ButtonClick(Sender: TObject);
    {-}
  procedure EditorChange(Sender: TObject);
    {-}
  {$ENDIF DesignTimeLibrary}
  procedure UpdateButtonHint;
    {-}
  procedure UpdateEditorTextValid;
    {-}
  procedure DisableChange;
    {-}
  procedure EnableChange;
    {-}
  function IsChangeEnabled: Boolean;
    {-}
  function DoMakeState(const aForHistory: Boolean): InscContextFilterState;
    {-}
  procedure OnExitFromEditor(Sender: TObject);
    {* - событие ухода фокуса из поля ввода. }
 protected
  procedure Change;
    {-}
  procedure Cleanup;
   override;
    {-}
  procedure Loaded;
   override;
    {-}
  {$IfDef Delphi7}
  procedure SetParentBackground(Value: Boolean); override;
    {-}
  {$EndIf Delphi7}
  procedure Paint(const CN: Il3Canvas);
   override;
    {-}
  procedure Notification(AComponent: TComponent; Operation: TOperation);
   override;
    {-}
   procedure SceneResize(aSender: TObject);
   procedure ContextEditFocusChanged(aSender: TObject);
 protected
 // properties
   property FilterName: Il3CString
     read f_FilterName
     write f_FilterName;
     {* - название фильтра. В качестве названия используется название формы.
          Параметр не вычисляемый, потому что нужно писать при уничтожении
          компонента, а тогда уже форма недоступна, а при уничтожении формы
          компонент никак об этом не уведомляется. }
   property ContextWasChanged: Boolean
     read pm_GetContextWasChanged;
     {* - контекст был изменен. }
 public
 //public methods
  constructor Create(AOwner : TComponent);
   override;
    {-}
  procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
    override;
    {-}
  function MakeState: InscContextFilterState;
    {-}
  procedure AssignState(const aState: InscContextFilterState);
    {-}
  procedure PressChar(const aChar : AnsiChar);
    {-}
  procedure UpdateIsContextWrong(const aFilterTarget: Il3ContextFilterTarget = nil);
    {-}
  procedure ForceActive;
    {-}
  function NeedRefilterTree: Boolean;
    {-}
  procedure BeginAssignState;
    {-}
  procedure EndAssignState;
    {-}
 public
  property ActiveContext: Il3CString
      read pm_GetActiveContext;
    {* - То что надо подавать для фильтрации - с учетом ACtive }
  property Context: Il3CString
      read pm_GetContext
     write pm_SetContext;
    {* - Строка записанная в контроле }
  property IsContextWrong: Boolean
      read pm_GetIsContextWrong;
    {-}
  {$IfDef Delphi7}
  property ParentBackground
    stored f_ParentBackgroundSet;
    {-}
  {$EndIf Delphi7}
 published
  property Align default alTop;
    {-}
  property Anchors;
    {-}
  property Color
    default cDefaultColor;
    {-}
  property BevelEdges
   default cDefaultBevelEdges;
    {-}
  property BevelInner
   default cDefaultBevelInner;
    {-}
  property BevelOuter
   default cDefaultBevelOuter;
    {-}
  property BevelKind
   default cDefaultBevelKind;
    {-}
  property Visible;
    {-}
  property Borders: Integer
      read f_Borders
     write pm_SetBorders
   default cDefaultBorders;
    {* - Отсупы от границ }
  property Images: TCustomImageList
      read pm_GetImages
     write pm_SetImages;
    {* - Картинки для кнопки }
  property ImageIndex: TImageIndex
      read pm_GetImageIndex
     write pm_SetImageIndex
   default cDefaultImageIndex;
    {-}
  property LabelVisible: Boolean
      read pm_GetLabelVisible
     write pm_SetLabelVisible
   default cDefaultLabelVisible;
    {-}
  property LabelCaption: Tl3DString
      read pm_GetLabelCaption
     write pm_SetLabelCaption
    stored IsLabelCaptionStored;
    {-}
  property Active: Boolean
      read f_Active
     write pm_SetActive
   default cDefaultActive;
    {-}
  property ContextEmptyMessage: Tl3DString
      read pm_GetContextEmptyMessage
     write pm_SetContextEmptyMessage
    stored IsContextEmptyMessageStored;
    {-}
  property ContextColor: TColor
      read pm_GetContextColor
     write pm_SetContextColor
   default cDefaultContextColor;
    {-}
  property ContextWrongColor: TColor
      read pm_GetContextWrongColor
     write pm_SetContextWrongColor
   default cDefaultContextWrongColor;
    {-}
  property ContextEmptyColor: TColor
      read pm_GetContextEmptyColor
     write pm_SetContextEmptyColor
   default cDefaultContextEmptyColor;
    {-}
  property ButtonActiveHint: Tl3DString
      read pm_GetButtonActiveHint
     write pm_SetButtonActiveHint
    stored IsButtonActiveHintStored;
    {-}
  property ButtonInActiveHint: Tl3DString
      read pm_GetButtonInActiveHint
     write pm_SetButtonInActiveHint
    stored IsButtonInActiveHintStored;
    {-}
  property ContextFilterTarget: Il3ContextFilterTarget
      read pm_GetContextFilterTarget
     write pm_SetContextFilterTarget;
    {-}
  property LabelFontIsBold: Boolean
      read pm_GetLabelFontIsBold
     write pm_SetLabelFontIsBold
   default cDefaultLabelFontIsBold;
    {-}
  property OnChange: TNotifyEvent
      read f_OnChange
     write f_OnChange;
    {-}
  property OnWrongContext: TNotifyEvent
      read f_OnWrongContext
     write f_OnWrongContext;
  property OnGetIsContextWrong: TnscGetIsContextWrong
    read f_OnGetIsContextWrong
    write f_OnGetIsContextWrong;
 end;

procedure nscAddContextFilterListener(const aListener: InscContextFilterListener);
  {* - добавить слушателя контекстного фильтра. }
procedure nscRemoveContextFilterListener(const aListener: InscContextFilterListener);
  {* - удалить слушателя контекстного фильтра. }

{$IfEnd} // Nemesis

implementation

{$If defined(Nemesis)}

uses
 StdCtrls,
 SysUtils,
 Windows,
 Forms,
 {$IfDef Delphi7}
 Themes,
 {$EndIf Delphi7}

 afwFacade,

 l3Base,
 l3String,
 l3Chars,
 l3InterfacesMisc,
 l3InterfacePtrList,

 nevTools,

 ctTypes,

 nscContextFilterState,

 nscContextFilterRes,

 l3Defaults,

 evdTypes,

 vtVGSceneRes,

 vgTypes{,
 vgNonModelTypes}
 ;

var
 g_ContextFilterListeners: Tl3InterfacePtrList = nil;

procedure DoFree;
begin
 FreeAndNil(g_ContextFilterListeners);
end;

function nscContextFilterListeners: Tl3InterfacePtrList;
begin
 if (g_ContextFilterListeners = nil) then
 begin
  g_ContextFilterListeners := Tl3InterfacePtrList.Make;
  l3System.AddExitProc(DoFree);
 end;//g_ContextFilterListeners = nil
 Result := g_ContextFilterListeners;
end;

procedure nscAddContextFilterListener(const aListener: InscContextFilterListener);
  {* - добавить слушателя контекстного фильтра. }
begin
 nscContextFilterListeners.Add(aListener);
end;

procedure nscRemoveContextFilterListener(const aListener: InscContextFilterListener);
  {* - удалить слушателя контекстного фильтра. }
begin
 if (g_ContextFilterListeners <> nil) then
  nscContextFilterListeners.Remove(aListener);
end;//nscRemoveContextFilterListener

procedure nscContextCanBeChangedNotify(const aContextFilter: TnscContextFilter);
var
 l_Index    : Integer;
 l_Listener : InscContextFilterListener;
 l_State    : InscContextFilterState;
begin
 l_State := aContextFilter.DoMakeState(False);
 try
  with nscContextFilterListeners do
   for l_Index := 0 to Pred(Count) do
    if Supports(Items[l_Index], InscContextFilterListener, l_Listener) then
    try
     l_Listener.ContextCanBeChanged(Integer(aContextFilter),
                                    aContextFilter.FilterName,
                                    l_State);
    finally
     l_Listener := nil;
    end;//if Supports(Items[l_Index], ...
 finally
  l_State := nil;
 end;//try..finally
end;//nscContextCanBeChangedNotify

procedure nscContextFIlterDestroyingNotify(const aContextFilter: TnscContextFilter);
var
 l_Index    : Integer;
 l_Listener : InscContextFilterListener;
 l_State    : InscContextFilterState;
begin
 if (not l3System.IsDown) then
  l_State := aContextFilter.DoMakeState(False);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=594891894
 try
  with nscContextFilterListeners do
   for l_Index := 0 to Pred(Count) do
    if Supports(Items[l_Index], InscContextFilterListener, l_Listener) then
    try
     l_Listener.FilterRemoving(Integer(aContextFilter));
    finally
     l_Listener := nil;
    end;//if Supports(Items[l_Index], ...
 finally
  l_State := nil;
 end;//try..finally
end;//nscContextCanBeChangedNotify

{ TnscContextFilter }

procedure TnscContextFilter.AdjustContolsPosition;
var
 l_LabelRight,
 l_ButtonLeft,
 l_EditorWidth,
 l_Delta: Single;
 l_ClientRect: TRect;
 l_ClientWidth: Integer;
 l_ClientHeight: Integer;
begin
 // оч грубо
 l_ClientRect := ClientRect;
 with l_ClientRect do
 begin
  l_ClientWidth := Right - Left;
  l_ClientHeight := Bottom - Top;
 end;//with l_ClientRect

 if Assigned(f_Button) then
 begin
  f_Button.SetBounds(l_ClientRect.Left + l_ClientWidth - f_Button.Width - Borders,
                     l_ClientRect.Top + (l_ClientHeight - f_Button.Height) div 2,
                     f_Button.Width,
                     f_Button.Height);
  l_ButtonLeft := f_Button.Left;
 end//Assigned(f_Button)
 else
  l_ButtonLeft := l_ClientWidth;

 if Assigned(f_Label) and LabelVisible then
 begin
  f_Label.DrawWithEllipsis := False;
  TvgCanvas(f_Label.Canvas).Font.Assign(f_Label.Font);
  f_Label.Width := TvgCanvas(f_Label.Canvas).TextWidth(f_Label.Text) + 20;
  f_Label.Position.X := l_ClientRect.Left + Borders;
  f_Label.Height := TvgCanvas(f_Label.Canvas).TextHeight('W');
  f_Label.Position.Y := (l_ClientHeight - f_Label.Height) / 2;

  l_LabelRight := f_Label.Position.X + f_Label.Width + Borders div 2;
  // Вычисляем ширину редаетора
  l_EditorWidth := l_ButtonLeft - 3 - l_LabelRight - 2 * Borders;
  if (l_EditorWidth < cMinEditorWidth) then
  begin
   l_Delta := cMinEditorWidth - l_EditorWidth;
   // Корректируем свою ширину
   if (l_Delta > f_Label.Width) then
   begin
    f_Label.Width := 0;
    l_LabelRight := l_ClientRect.Left;
   end//l_Delta > f_Label.Width
   else
   begin
    f_Label.Width := f_Label.Width - l_Delta;
    l_LabelRight := f_Label.Position.X + f_Label.Width;
    f_Label.DrawWithEllipsis := True;
   end;//l_Delta > f_Label.Width
  end;//l_EditorWidth < cMinEditorWidth
 end//Assigned(f_Label) and LabelVisible
 else
  l_LabelRight := l_ClientRect.Left;

 if Assigned(f_Editor) then
 begin
  l_EditorWidth := l_ButtonLeft - 3 - l_LabelRight - 2 * Borders;
  f_Editor.SetBounds(Trunc(l_LabelRight) + Borders,
   l_ClientRect.Top + (l_ClientHeight - f_Editor.Height) div 2,
   Trunc(l_EditorWidth),
   Trunc(f_Editor.Height));
(*  if f_Editor.HandleAllocated then
   RedrawWindow(f_Editor.Handle, nil, 0, RDW_ERASE or
    RDW_INTERNALPAINT or RDW_FRAME or RDW_INVALIDATE);*)
  SceneResize(f_Scene);  
 end;//Assigned(f_Editor)
end;

{$IFNDEF DesignTimeLibrary}
procedure TnscContextFilter.ButtonClick(Sender: TObject);
begin
 Active := f_Button.Down;
end;

procedure TnscContextFilter.EditorChange(Sender: TObject);
begin
 if not Active and not l3IsNil(f_Editor.Text) then
  Active := True
 else
 if Active then
  Change;
end;
{$ENDIF DesignTimeLibrary}

procedure TnscContextFilter.Change;

  procedure lp_DefineFilterName;
  var
   l_Form: TCustomForm;
  begin
   l_Form := afw.GetParentForm(Self);
   if l_Form.Caption = '' then
   begin
    while (l_Form <> nil) and (l_Form.Caption = '') and (l_Form.Parent <> nil) do
     l_Form := afw.GetParentForm(l_Form.Parent);
    if Assigned(l_Form) then
     FilterName := l3CStr(l_Form.Caption);
   end
   else
    if l_Form <> nil then
     FilterName := l3CStr(l_Form.Caption)
    else
     Assert(False);
  end;//lp_DefineFilterName

begin
 lp_DefineFilterName;
 if IsChangeEnabled and Assigned(f_OnChange) then
 begin
  DisableChange;
  try
   Inc(f_ChangeCounter);
   try
    f_OnChange(Self);
   finally
    Dec(f_ChangeCounter);
   end;//try..finally
  finally
   EnableChange;
  end;//try..finally
  UpdateIsContextWrong;
 end;//IsChangeEnabled and Assigned(f_OnChange)
end;

procedure TnscContextFilter.Cleanup;
begin
 if ContextWasChanged then
  nscContextCanBeChangedNotify(Self);
 nscContextFIlterDestroyingNotify(Self);
 ContextFilterTarget := nil;
 FilterName := nil;
 f_ValidContext := nil;
 l3Free(f_Label);
 l3Free(f_LabelBackground);
 l3Free(f_Editor);
 l3Free(f_Button);
 FreeAndNil(f_InnerBorder);
 FreeAndNil(f_Border);
 FreeAndNil(f_Scene);
 inherited;
end;

type
  TvgHackScene = class(TvgScene)
  end;//TvgHackScene

constructor TnscContextFilter.Create(AOwner: TComponent);
var
 l_BackGround : TvgBackGround;
begin
 inherited;
 f_ChangeDisabledCounter := 0;
 {$IfDef Delphi7}
 f_ParentBackgroundSet := False;
 {$EndIf Delphi7}
 f_Borders := cDefaultBorders;

 l_BackGround := TvgBackGround.Create(Self);
 with l_BackGround do
 begin
  //Fill.Style := vgBrushNone;
  Fill.Style := vgBrushSolid;
  Fill.Color := vgColorToStr(vgColorFromVCL(cDefaultColor));
 end;//with l_BackGround
 l_BackGround.Align := vaClient;

 ControlStyle := ControlStyle + [csAcceptsControls]; 
 f_Scene := TvgScene.Create(Self);
 //f_Scene.ControlStyle := f_Scene.ControlStyle + [csAcceptsControls];
 with f_Scene do
 begin
  ActivateWindowOnClick := True;
  Align := alClient;
  Parent := Self;
  AddObject(l_BackGround);
  //SetBounds(0, IconTextHeight + VertMargin, Result.Width, Result.Height - IconTextHeight - VertMargin);
  Style := vtVGSceneResources.vgResources;
 end;//with f_Scene
 TvgHackScene(f_Scene).OnResize := SceneResize;

 f_Border := TvgRectangle.Create(Self);
 f_Border.Parent := TvgObject(f_Scene.Root);
 with f_Border do
 begin
  Fill.Style := vgBrushNone;
  Stroke.Color := vgColorToStr(vgColorFromVCL(cGarant2011KZBorderColor));
  Sides := [vgSideTop, vgSideLeft, vgSideBottom, vgSideRight];
  StrokeThickness := 2.0;
  Visible := false;
  //Visible := true;
 end;//with f_Border
 f_InnerBorder := TvgRectangle.Create(Self);
 f_InnerBorder.Parent := TvgObject(f_Scene.Root);
 with f_InnerBorder do
 begin
  Fill.Style := vgBrushNone;
  Stroke.Color := vgColorToStr(vgColorFromVCL(clBtnShadow));
  //Stroke.Color := vgColorToStr(vgColorFromVCL(cGarant2011InnerBorderColor));
  Sides := [vgSideTop, vgSideLeft, vgSideBottom, vgSideRight];
  StrokeThickness := 1.0;
  //Visible := false;
  Visible := true;
 end;//with f_InnerBorder

 f_LabelBackground := TvgRectangle.Create(Self);
 f_LabelBackground.Parent := TvgObject(f_Scene.Root);
 with f_LabelBackground do
 begin
  Fill.Style := vgBrushSolid;
  Fill.Color := vgColorToStr(vgColorFromVCL(cGarant2011GradientStartColor));
  //Stroke.Color := vgColorToStr(vgColorFromVCL(cGarant2011GradientStartColor));
  Stroke.Style := vgBrushNone;
  Visible := True;
 end;//with f_InnerBorder

 f_Label := TvgText.Create(Self);
 f_Label.Font.Family := Font.Name;
 f_Label.Font.Size := Font.Size * 1.25;
 f_Label.Fill.Style := vgBrushSolid;
 f_Label.Fill.Color := vgColorToStr(vgColorFromVCL(clWhite));

 f_Label.HorzTextAlign := vgTextAlignCenter;
 f_Label.VertTextAlign := vgTextAlignCenter;

 Color := cDefaultColor;
 BevelEdges := cDefaultBevelEdges;
 BevelInner := cDefaultBevelInner;
 BevelOuter := cDefaultBevelOuter;
 BevelKind := cDefaultBevelKind;

 with f_Label do
 begin
  Parent := TvgObject(f_Scene.Root);
  //FocusControl := f_Editor;
  //Visible := cDefaultLabelVisible;
  Text := str_nsc_LabelCaption.AsWideString;
  LabelFontIsBold := cDefaultLabelFontIsBold;
 end;//with f_Label

 f_Editor := TnscComboBoxWithFilter.Create(Self);
 with f_Editor do
 begin
  Name := 'InternalEditor';
  Text := nil;
  //Parent := f_Scene;
  Parent := Self;
  CEmptyHint := str_nsc_ContextEmptyMessage.AsCStr;
  {$IFNDEF DesignTimeLibrary}
  OnChange := EditorChange;
  {$ENDIF DesignTimeLibrary}
  OnExit := OnExitFromEditor;
  ClearUndoRedoLists;
 end;//with f_Editor
 f_Editor.OnFocusChanged := ContextEditFocusChanged;
 f_Editor.BorderStyle := bsNone;
 //f_Label.FocusControl := f_Editor;

 f_ButtonActiveHint := str_nsc_ButtonActiveHint.AsCStr;
 f_ButtonInActiveHint := str_nsc_ButtonInActiveHint.AsCStr;
 f_Button := TvtSpeedButtonForVGScene.Create(Self);
 with f_Button do
 begin
  Parent := f_Scene;
  //Parent := Self;
  Name := 'ContextFilterButton';
  AllowAllUp := True;
  Opaque := False;
  ImageIndex := cDefaultImageIndex;
  GroupIndex := -1;
  ParentShowHint := False;
  ShowHint := True;
  ActivateWindowOnClick := True;
  {$IFNDEF DesignTimeLibrary}
  OnClick := ButtonClick;
  {$ENDIF DesignTimeLibrary}
 end;
 f_Active := cDefaultActive;
 UpdateButtonHint;

 ContextColor := cDefaultContextColor;
 ContextWrongColor := cDefaultContextWrongColor;
 ContextEmptyColor := cDefaultContextEmptyColor;
 SetIsContextWrong(False);
 f_ValidContext := Context;
 Align := alTop;
end;

function TnscContextFilter.IsContextEmptyMessageStored: Boolean;
begin
 Result := Assigned(f_Editor) and
           not l3Same(str_nsc_ContextEmptyMessage.AsCStr,
                      f_Editor.CEmptyHint);
end;

function TnscContextFilter.IsLabelCaptionStored: Boolean;
begin
 Result := Assigned(f_Label) and (str_nsc_LabelCaption.AsWideString <> f_Label.Text);
end;

function TnscContextFilter.pm_GetActiveContext: Il3CString;
begin
 if Active then
  Result := Context
 else
  Result := l3CStr('');
end;

function TnscContextFilter.pm_GetContextEmptyColor: TColor;
begin
 if Assigned(f_Editor) then
  Result := f_Editor.EmptyHintCOlor
 else
  Result := cDefaultContextEmptyColor;
end;

function TnscContextFilter.pm_GetContextEmptyMessage: Tl3DString;
begin
 if Assigned(f_Editor) then
  Result := f_Editor.EmptyHint
 else
  Result := l3DStr(str_nsc_ContextEmptyMessage.AsCStr);
end;

function TnscContextFilter.pm_GetImageIndex: TImageIndex;
begin
 if Assigned(f_Button) then
  Result := f_Button.ImageIndex
 else
  Result := cDefaultImageIndex;
end;

function TnscContextFilter.pm_GetImages: TCustomImageList;
begin
 if Assigned(f_Button) then
  Result := f_Button.Images
 else
  Result := nil;
end;

function TnscContextFilter.pm_GetLabelCaption: Tl3DString;
begin
 if Assigned(f_Label) then
  Result := l3DStr(f_Label.Text)
 else
  Result := l3DStr(str_nsc_LabelCaption.AsCStr);
end;

function TnscContextFilter.pm_GetLabelVisible: Boolean;
begin
 if Assigned(f_Label) then
  Result := f_Label.Visible
 else
  Result := cDefaultLabelVisible;
end;

procedure TnscContextFilter.pm_SetActive(const aValue: Boolean);
begin
 if (f_Active <> aValue) then
 begin
  f_Active := aValue;
  if Assigned(f_Button) and (f_Button.Down <> aValue) then
   f_Button.Down := aValue;
  UpdateButtonHint;
  Change;
  UpdateEditorTextValid;
 end;//f_Active <> aValue
end;

procedure TnscContextFilter.pm_SetBorders(const aValue: Integer);
begin
 if (f_Borders <> aValue) then
 begin
  f_Borders := aValue;
  if (f_Borders < 0) then
   f_Borders := 0;
  AdjustSize;
 end;//f_Borders <> aValue
end;

procedure TnscContextFilter.pm_SetContextColor(const aValue: TColor);
begin
 if Assigned(f_Editor) then
  f_Editor.Font.Color := aValue;
end;

procedure TnscContextFilter.pm_SetContextEmptyColor(const aValue: TColor);
begin
 if Assigned(f_Editor) then
  f_Editor.EmptyHintColor := aValue;
end;

procedure TnscContextFilter.pm_SetContextWrongColor(const aValue: TColor);
begin
 if Assigned(f_Editor) then
  f_Editor.ErrorColor := aValue;
end;

procedure TnscContextFilter.pm_SetContextEmptyMessage(
  const aValue: Tl3DString);
begin
 if Assigned(f_Editor) then
  f_Editor.EmptyHint := aValue;
end;

procedure TnscContextFilter.pm_SetImageIndex(const aValue: TImageIndex);
begin
 if Assigned(f_Button) then
  f_Button.ImageIndex := aValue;
end;

procedure TnscContextFilter.pm_SetImages(const aValue: TCustomImageList);
begin
 if Assigned(f_Button) then
  f_Button.Images := aValue;
end;

procedure TnscContextFilter.pm_SetLabelCaption(const aValue: Tl3DString);
begin
 if Assigned(f_Label) then
  if not l3Same(l3DStr(f_Label.Text), aValue) then
  begin
   f_Label.Text := aValue;
   AdjustSize;
  end;//not l3Same(f_Label.CCaption, aValue)
end;

procedure TnscContextFilter.pm_SetLabelVisible(const aValue: Boolean);
begin
 if Assigned(f_Label) then
  if (f_Label.Visible <> aValue) then
  begin
   f_Label.Visible := aValue;
   f_LabelBackground.Visible := aValue;
   AdjustSize;
  end;//f_Label.Visible <> aValue
end;

procedure TnscContextFilter.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
var
 l_ClientDelta: Integer;
begin
 if Assigned(f_Editor) then
 begin
  l_ClientDelta := Height - ClientHeight;
  aHeight := f_Editor.Height + 2*Borders + l_ClientDelta;
 end;//Assigned(f_Editor)
 DisableAlign;
 try
  inherited SetBounds(aLeft, aTop, aWidth, aHeight);
  AdjustContolsPosition;
 finally
  EnableAlign;
 end;//try..finally
end;

function TnscContextFilter.pm_GetContext: Il3CString;
begin
 if Assigned(f_Editor) then
  Result := f_Editor.Text
 else
  Result := l3CStr('');
end;

type
  THackEditor = class(TnscComboBoxWithFilter); 

procedure TnscContextFilter.pm_SetContext(const aValue: Il3CString);
begin
 if Assigned(f_Editor) then
  THackEditor(f_Editor).Paras.ParagraphStrings[0] := aValue
end;

procedure TnscContextFilter.SetIsContextWrong(aValue: Boolean);
begin
 if Assigned(f_OnGetIsContextWrong) then
  f_OnGetIsContextWrong(Self, aValue);
 if (f_IsContextWrong <> aValue) then
 begin
  f_IsContextWrong := aValue;
  UpdateEditorTextValid;
 end;//f_IsContextWrong <> aValue
end;

procedure TnscContextFilter.UpdateButtonHint;
begin
 if Assigned(f_Button) then
 begin
  if Active then
   f_Button.Hint := l3Str(ButtonActiveHint)
  else
   f_Button.Hint := l3Str(ButtonInActiveHint);
 end;//Assigned(f_Button)
end;

function TnscContextFilter.IsButtonActiveHintStored: Boolean;
begin
 Result := not l3Same(str_nsc_ButtonActiveHint.AsCStr,
                      f_ButtonActiveHint);
end;

function TnscContextFilter.IsButtonInActiveHintStored: Boolean;
begin
 Result := not l3Same(str_nsc_ButtonInActiveHint.AsCStr,
                      f_ButtonInActiveHint);
end;

function TnscContextFilter.pm_GetButtonActiveHint: Tl3DString;
begin
 Result := l3DStr(f_ButtonActiveHint);
end;

function TnscContextFilter.pm_GetButtonInActiveHint: Tl3DString;
begin
 Result := l3DStr(f_ButtonInActiveHint);
end;

procedure TnscContextFilter.pm_SetButtonActiveHint(const aValue: Tl3DString);
begin
 if not l3Same(f_ButtonActiveHint, aValue) then
 begin
  f_ButtonActiveHint := l3CStr(aValue);
  UpdateButtonHint;
 end;//not l3Same(f_ButtonActiveHint, aValue)
end;

procedure TnscContextFilter.pm_SetButtonInActiveHint(const aValue: Tl3DString);
begin
 if not l3Same(f_ButtonInActiveHint, aValue) then
 begin
  f_ButtonInActiveHint := l3CStr(aValue);
  UpdateButtonHint;
 end;//not l3Same(f_ButtonInActiveHint, aValue)
end;

procedure TnscContextFilter.Loaded;
begin
 inherited;
 AdjustSize;
end;

function TnscContextFilter.pm_GetContextColor: TColor;
begin
 if Assigned(f_Editor) then
  Result := f_Editor.Font.Color
 else
  Result := cDefaultContextColor;
end;

function TnscContextFilter.pm_GetContextWrongColor: TColor;
begin
 if Assigned(f_Editor) then
  Result := f_Editor.ErrorColor
 else
  Result := cDefaultContextWrongColor;
end;

function TnscContextFilter.pm_GetIsContextWrong: Boolean;
begin
 Result := f_IsContextWrong;
end;

function TnscContextFilter.MakeState: InscContextFilterState;
begin
 Result := DoMakeState(False);
end;

procedure TnscContextFilter.AssignState(
  const aState: InscContextFilterState);
begin
 DisableChange;
 try
  Context := aState.Context;
  if Assigned(f_Editor) then
   f_Editor.CaretPos := aState.CaretPos;
  Active := aState.Active;
  UpdateIsContextWrong;  
 finally
  EnableChange;
 end;//try..finally
end;

function TnscContextFilter.LoadState(const aState: IInterface;
  aStateType: TvcmStateType): Boolean;
var
 l_State: InscContextFilterState;
begin
 if Supports(aState, InscContextFilterState, l_State) then
 begin
  Result := True;
  AssignState(l_State);
 end//Supports(aState, InscContextFilterState, l_State)
 else
  Result := False;
end;

function TnscContextFilter.SaveState(out theState: IInterface;
  aStateType: TvcmStateType): Boolean;
begin
 if (aStateType = vcm_stContent) then
 begin
  Result := True;
  theState := DoMakeState(True);
 end//aStateType = vcm_stContent
 else
  Result := False;
end;

procedure TnscContextFilter.PressChar(const aChar: AnsiChar);
var
 l_CurLength  : Integer;
 l_NewContext : Il3CString;
 l_Op         : InevOp;
begin
 l_NewContext := f_ValidContext;
 l_CurLength := l3Len(l_NewContext);
 if (aChar = cc_HardSpace) and
  ((l_CurLength = 0) or l3IsChar(l_NewContext,l_CurLength, cc_HardSpace)) then
   Exit;

 if Active then
 begin
  if (aChar <> cc_Backspace) then
   l_NewContext := l3Cat(l_NewContext, aChar)
  else
  begin
   if (l_CurLength > 0) then
    l3SetLen(l_NewContext, l_CurLength-1);
  end;//aChar <> cc_Backspace
 end//Active
 else
 if aChar <> cc_Backspace then
  l_NewContext := l3Cat(l_NewContext, l3PCharLen(aChar))
 else
  Exit;
 if not l3Same(l_NewContext, Context) then
 begin
  if (f_Editor <> nil) then
   l_Op := f_Editor.StartOp;
  try
   f_PressingChar := True;
   try
    Context := l_NewContext;
    if not Active then
     Active := True
    {else
     Change};
   finally
    f_PressingChar := False;
   end;
  finally
   l_Op := nil;
  end;//try..finally
 end;//not l3Same(l_NewContext, Context)
end;

{$IfDef Delphi7}
procedure TnscContextFilter.SetParentBackground(Value: Boolean);
begin
 { TCustomPanel needs to not have csOpaque when painting
   with the ParentBackground in Themed applications }
 if Value then
   ControlStyle := ControlStyle - [csOpaque]
 else
   ControlStyle := ControlStyle + [csOpaque];
 f_ParentBackgroundSet := True;
 inherited;
end;
{$EndIf Delphi7}

procedure TnscContextFilter.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
 Message.Result := Integer(True);
end;

procedure TnscContextFilter.WMSetFocus(var Msg: TWMSetFocus);
  {-}
begin
 inherited;
 if (f_Editor <> nil) then
  f_Editor.SetFocus;
end;
  
procedure TnscContextFilter.Paint(const CN: Il3Canvas);
var
 l_Rect: TRect;
begin
 l_Rect := GetClientRect;
 with CN do
 begin
  with Canvas do
  begin
   {$IfDef Delphi7}
   if not ParentBackground or not ThemeServices.ThemesEnabled then
   {$EndIf Delphi7}
   begin
    Brush.Color := Color;
    FillRect(l_Rect);
   end;//not ParentBackground..
  end;//with Canvas
 end;//with CN
end;

procedure TnscContextFilter.UpdateEditorTextValid;
begin
 if Assigned(f_Editor) then
  f_Editor.TextValid := not IsContextWrong;
end;

procedure TnscContextFilter.RequestReapply;
begin
 if Active then
  Change;
end;

procedure TnscContextFilter.RequestClearAndTurnOff;
begin
 DisableChange;
 try
  Active := False;
  Context := nil;
  UpdateIsContextWrong;
 finally
  EnableChange;
 end;//try..finally
end;

procedure TnscContextFilter.DisableChange;
begin
 Inc(f_ChangeDisabledCounter);
end;

procedure TnscContextFilter.EnableChange;
begin
 Dec(f_ChangeDisabledCounter);
end;

function TnscContextFilter.IsChangeEnabled: Boolean;
begin
 Result := f_ChangeDisabledCounter = 0;
end;

function TnscContextFilter.pm_GetContextFilterTarget: Il3ContextFilterTarget;
begin
 Result := Il3ContextFilterTarget(f_ContextFilterTarget);
end;

procedure TnscContextFilter.pm_SetContextFilterTarget(
  const aValue: Il3ContextFilterTarget);
var
 l_NotifySource: Il3ContextFilterNotifySource;
begin
 if Supports(IUnknown(f_ContextFilterTarget), Il3ContextFilterNotifySource, l_NotifySource) then
  l_NotifySource.UnSubscribeFromContextFilter(Self);
 f_ContextFilterTarget := Pointer(aValue);
 if Supports(IUnknown(f_ContextFilterTarget), Il3ContextFilterNotifySource, l_NotifySource) then
  l_NotifySource.SubscribeToContextFilter(Self);
 UpdateIsContextWrong;  
end;

procedure TnscContextFilter.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
 inherited;
 if (Operation = opRemove) and l3IEQ(ContextFilterTarget, aComponent) then
  ContextFilterTarget := nil;
end;

procedure TnscContextFilter.SceneResize(aSender: TObject);
begin
 f_Border.Position.X := f_Editor.Left - 3;
 f_Border.Position.Y := f_Editor.Top - 3;
 f_Border.Height := f_Editor.Height + 6;
 f_Border.Width := f_Editor.Width + 6;

 f_InnerBorder.Position.X := f_Editor.Left - 1;
 f_InnerBorder.Position.Y := f_Editor.Top - 1;
 f_InnerBorder.Height := f_Editor.Height + 2;
 f_InnerBorder.Width := f_Editor.Width + 2;

 f_LabelBackground.SetBounds(f_Label.Position.X, f_Editor.Top - 1, f_Label.Width, f_Editor.Height + 2);
end;

procedure TnscContextFilter.ContextEditFocusChanged(aSender: TObject);
begin
 if f_Editor.Focused then
  f_InnerBorder.Stroke.Color := vgColorToStr(vgColorFromVCL(cGarant2011KZInnerBorderColor))
 else
  f_InnerBorder.Stroke.Color := vgColorToStr(vgColorFromVCL(clBtnShadow));
 f_Border.Visible := f_Editor.Focused;
 //f_InnerBorder.Visible := f_Editor.Focused;
end;

procedure TnscContextFilter.UpdateIsContextWrong(const aFilterTarget: Il3ContextFilterTarget = nil);
var
 l_Start: Cardinal;
 l_Same: Boolean;
 l_Target: Il3ContextFilterTarget;
begin
 if (not l3System.IsDown) then
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=594891894
 begin
  if aFilterTarget = nil then
   l_Target := ContextFilterTarget
  else
   l_Target := aFilterTarget;
  if Assigned(l_Target) then
  begin
   l_Same := l_Target.IsSameContext(ActiveContext, l_Start);
   SetIsContextWrong(Active and not l_Same);
   if (f_Editor.CaretPos = f_Editor.TextLen) or
      f_PressingChar or
      f_Editor.DroppingData then
   begin
    if IsContextWrong then
     f_Editor.SelectTail(l_Start);
    if Visible and IsContextWrong and (f_AssigningCounter = 0) then
     if Assigned(f_OnWrongContext) then
      f_OnWrongContext(Self);
   end;//f_Editor.CaretPos = f_Editor.TextLen
   if IsContextWrong then
    f_ValidContext := l3Copy(Context, 0, l_Start)
   else
    f_ValidContext := Context;
  end;//Assigned(l_Target)
 end;//(not l3System.IsDown)
end;

procedure TnscContextFilter.RequestCheckValid;
begin
 if IsChangeEnabled then
 begin
  if (f_ChangeCounter > 0) or (f_AssigningCounter > 0) then
   UpdateIsContextWrong
  else
   RequestClearAndTurnOff;
 end;//IsChangeEnabled
end;

function TnscContextFilter.DoMakeState(
  const aForHistory: Boolean): InscContextFilterState;
var
 l_Pos: Integer;
 l_DroppingData: Boolean;
begin
 if Assigned(f_Editor) then
 begin
  l_Pos := f_Editor.CaretPos;
  l_DroppingData := f_Editor.DroppingData;
 end//Assigned(f_Editor)
 else
 begin
  l_Pos := 0;
  l_DroppingData := false;
 end;//Assigned(f_Editor)
 if aForHistory then
  Result := TnscContextFilterState.Make(Active, Context, l_Pos, false, ContextFilterTarget)
 else
  Result := TnscContextFilterState.Make(Active, Context, l_Pos, l_DroppingData);
end;

procedure TnscContextFilter.ForceActive;
begin
 if not Active then
  Active := True
 else
  Change;
end;

function TnscContextFilter.pm_GetLabelFontIsBold: Boolean;
begin
 if Assigned(f_Label) then
  Result := f_Label.Font.Style = vgFontBold
 else
  Result := cDefaultLabelFontIsBold;
end;

procedure TnscContextFilter.pm_SetLabelFontIsBold(const aValue: Boolean);
begin
 if Assigned(f_Label) then
 begin
  if aValue then
   f_Label.Font.Style := vgFontBold
  else
   f_Label.Font.Style := vgFontRegular;
  AdjustSize;
 end;//Assigned(f_Label)
end;

procedure TnscContextFilter.OnExitFromEditor(Sender: TObject);
begin
 if (Sender is TControl) then
 begin
  if ContextWasChanged then
   nscContextCanBeChangedNotify(Self);
 end//Sender is TControl
 else
  Assert(False);
end;//OnExitFromEditor

function TnscContextFilter.pm_GetContextWasChanged: Boolean;
begin
 Result := FilterName <> nil;
end;

function TnscContextFilter.IsCommandPublished(
  Cmd: Tl3OperationCode): Boolean;
var
 l_Intf: Il3CommandPublisherInfo;
begin
 Result := Supports(f_Editor, Il3CommandPublisherInfo, l_Intf) and
  l_Intf.IsCommandPublished(Cmd);
end;

procedure TnscContextFilter.ProvideOps(
  const aPublisher: IvcmOperationsPublisher);
var
 l_Intf: IvcmOperationsProvider;
begin
 if Supports(f_Editor, IvcmOperationsProvider, l_Intf) then
  l_Intf.ProvideOps(aPublisher);
end;

function TnscContextFilter.NeedRefilterTree: Boolean;
begin
 if Assigned(f_Editor) then
  Result := f_Editor.DroppingData
 else
  Result := False;
end;

procedure TnscContextFilter.BeginAssignState;
begin
 Inc(f_AssigningCounter);
end;

procedure TnscContextFilter.EndAssignState;
begin
 Dec(f_AssigningCounter);
 UpdateIsContextWrong;  
end;

{$IfEnd} // Nemesis

end.

