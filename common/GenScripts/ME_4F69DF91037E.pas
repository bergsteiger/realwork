unit ControlsProcessingPack;

interface

uses
 l3IntfUses
 , Controls
 , Graphics
 , l3Interfaces
 , Types
 , Menus
 , Forms
 , Windows
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwRegisterableWord
 , tfwPropertyLike
 , tfwTypeInfo
;

implementation

uses
 l3ImplUses
 , kwBynameControlPush
 , Messages
 , l3PopupMenuHelper
 , l3FormsService
 , l3ControlFontService
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TControlFriend = class(TControl)
  {* Друг для TControl }
 end;//TControlFriend
 
 TkwPopControlClientToScreen = class(TtfwClassLike)
  {* Слово скрипта pop:Control:ClientToScreen
*Тип результата:* TPoint
*Пример:*
[code]
VAR l_TPoint
 aPoint aControl pop:Control:ClientToScreen >>> l_TPoint
[code]  }
  function ClientToScreen(const aCtx: TtfwContext;
   aControl: TControl;
   const aPoint: TPoint): TPoint;
   {* Реализация слова скрипта pop:Control:ClientToScreen }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlClientToScreen
 
 TkwPopControlScreenToClient = class(TtfwClassLike)
  {* Слово скрипта pop:Control:ScreenToClient
*Тип результата:* TPoint
*Пример:*
[code]
VAR l_TPoint
 aPoint aControl pop:Control:ScreenToClient >>> l_TPoint
[code]  }
  function ScreenToClient(const aCtx: TtfwContext;
   aControl: TControl;
   const aPoint: TPoint): TPoint;
   {* Реализация слова скрипта pop:Control:ScreenToClient }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlScreenToClient
 
 TkwPopControlInvalidate = class(TtfwClassLike)
  {* Слово скрипта pop:Control:Invalidate
*Пример:*
[code]
 aControl pop:Control:Invalidate
[code]  }
  procedure Invalidate(const aCtx: TtfwContext;
   aControl: TControl);
   {* Реализация слова скрипта pop:Control:Invalidate }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlInvalidate
 
 TkwPopControlRepaint = class(TtfwClassLike)
  {* Слово скрипта pop:Control:Repaint
*Пример:*
[code]
 aControl pop:Control:Repaint
[code]  }
  procedure Repaint(const aCtx: TtfwContext;
   aControl: TControl);
   {* Реализация слова скрипта pop:Control:Repaint }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlRepaint
 
 TkwPopControlClick = class(TtfwClassLike)
  {* Слово скрипта pop:Control:Click
*Пример:*
[code]
 aControl pop:Control:Click
[code]  }
  procedure Click(const aCtx: TtfwContext;
   aControl: TControl);
   {* Реализация слова скрипта pop:Control:Click }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlClick
 
 TkwPopControlShow = class(TtfwClassLike)
  {* Слово скрипта pop:Control:Show
*Пример:*
[code]
 aControl pop:Control:Show
[code]  }
  procedure Show(const aCtx: TtfwContext;
   aControl: TControl);
   {* Реализация слова скрипта pop:Control:Show }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlShow
 
 TkwPopControlHide = class(TtfwClassLike)
  {* Слово скрипта pop:Control:Hide
*Пример:*
[code]
 aControl pop:Control:Hide
[code]  }
  procedure Hide(const aCtx: TtfwContext;
   aControl: TControl);
   {* Реализация слова скрипта pop:Control:Hide }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlHide
 
 TkwPopControlUndock = class(TtfwClassLike)
  {* Слово скрипта pop:Control:Undock
*Пример:*
[code]
 aControl pop:Control:Undock
[code]  }
  procedure Undock(const aCtx: TtfwContext;
   aControl: TControl);
   {* Реализация слова скрипта pop:Control:Undock }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlUndock
 
 TkwPopControlGetPopupMenu = class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetPopupMenu
*Тип результата:* TMenuItem
*Пример:*
[code]
OBJECT VAR l_TMenuItem
 aPoint aControl pop:Control:GetPopupMenu >>> l_TMenuItem
[code]  }
  function GetPopupMenu(const aCtx: TtfwContext;
   aControl: TControl;
   const aPoint: TPoint): TMenuItem;
   {* Реализация слова скрипта pop:Control:GetPopupMenu }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlGetPopupMenu
 
 TkwPopControlGetTopParentForm = class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetTopParentForm
*Тип результата:* TCustomForm
*Пример:*
[code]
OBJECT VAR l_TCustomForm
 aControl pop:Control:GetTopParentForm >>> l_TCustomForm
[code]  }
  function GetTopParentForm(const aCtx: TtfwContext;
   aControl: TControl): TCustomForm;
   {* Реализация слова скрипта pop:Control:GetTopParentForm }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlGetTopParentForm
 
 TkwPopControlGetMainForm = class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetMainForm
*Тип результата:* TCustomForm
*Пример:*
[code]
OBJECT VAR l_TCustomForm
 aControl pop:Control:GetMainForm >>> l_TCustomForm
[code]  }
  function GetMainForm(const aCtx: TtfwContext;
   aControl: TControl): TCustomForm;
   {* Реализация слова скрипта pop:Control:GetMainForm }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlGetMainForm
 
 TkwPopControlGetParentForm = class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetParentForm
*Тип результата:* TCustomForm
*Пример:*
[code]
OBJECT VAR l_TCustomForm
 aControl pop:Control:GetParentForm >>> l_TCustomForm
[code]  }
  function GetParentForm(const aCtx: TtfwContext;
   aControl: TControl): TCustomForm;
   {* Реализация слова скрипта pop:Control:GetParentForm }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlGetParentForm
 
 TkwPopControlGetAnotherParentForm = class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetAnotherParentForm
*Тип результата:* TCustomForm
*Пример:*
[code]
OBJECT VAR l_TCustomForm
 aControl pop:Control:GetAnotherParentForm >>> l_TCustomForm
[code]  }
  function GetAnotherParentForm(const aCtx: TtfwContext;
   aControl: TControl): TCustomForm;
   {* Реализация слова скрипта pop:Control:GetAnotherParentForm }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlGetAnotherParentForm
 
 TkwControlByHandle = class(TtfwRegisterableWord)
  {* Слово скрипта Control:ByHandle
*Тип результата:* TControl
*Пример:*
[code]
OBJECT VAR l_TControl
 aHandle Control:ByHandle >>> l_TControl
[code]  }
  function ByHandle(const aCtx: TtfwContext;
   aHandle: THandle): TControl;
   {* Реализация слова скрипта Control:ByHandle }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwControlByHandle
 
 TkwControlFocusedControlPush = class(TtfwRegisterableWord)
  {* Слово скрипта focused:control:push
*Тип результата:* TControl
*Пример:*
[code]
OBJECT VAR l_TControl
 focused:control:push >>> l_TControl
[code]  }
  function focused_control_push(const aCtx: TtfwContext): TControl;
   {* Реализация слова скрипта focused:control:push }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwControlFocusedControlPush
 
 TkwPopControlColor = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Color
*Тип результата:* TColor
*Пример:*
[code]
TColor VAR l_TColor
 aControl pop:Control:Color >>> l_TColor
[code]  }
  function Color(const aCtx: TtfwContext;
   aControl: TControl): TColor;
   {* Реализация слова скрипта pop:Control:Color }
  procedure DoSetValue(aControl: TControl;
   aValue: TColor);
   {* Метод установки значения свойства Color }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlColor
 
 TkwPopControlEnabled = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Enabled
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:Enabled >>> l_Boolean
[code]  }
  function Enabled(const aCtx: TtfwContext;
   aControl: TControl): Boolean;
   {* Реализация слова скрипта pop:Control:Enabled }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlEnabled
 
 TkwPopControlVisible = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Visible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:Visible >>> l_Boolean
[code]  }
  function Visible(const aCtx: TtfwContext;
   aControl: TControl): Boolean;
   {* Реализация слова скрипта pop:Control:Visible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlVisible
 
 TkwPopControlName = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Name
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aControl pop:Control:Name >>> l_String
[code]  }
  function Name(const aCtx: TtfwContext;
   aControl: TControl): AnsiString;
   {* Реализация слова скрипта pop:Control:Name }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlName
 
 TkwPopControlHint = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Hint
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aControl pop:Control:Hint >>> l_String
[code]  }
  function Hint(const aCtx: TtfwContext;
   aControl: TControl): AnsiString;
   {* Реализация слова скрипта pop:Control:Hint }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlHint
 
 TkwPopControlShowHint = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:ShowHint
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:ShowHint >>> l_Boolean
[code]  }
  function ShowHint(const aCtx: TtfwContext;
   aControl: TControl): Boolean;
   {* Реализация слова скрипта pop:Control:ShowHint }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlShowHint
 
 TkwPopControlCaption = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Caption
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aControl pop:Control:Caption >>> l_String
[code]  }
  function Caption(const aCtx: TtfwContext;
   aControl: TControl): AnsiString;
   {* Реализация слова скрипта pop:Control:Caption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlCaption
 
 TkwPopControlTop = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Top
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:Top >>> l_Integer
[code]  }
  function Top(const aCtx: TtfwContext;
   aControl: TControl): Integer;
   {* Реализация слова скрипта pop:Control:Top }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlTop
 
 TkwPopControlLeft = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Left
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:Left >>> l_Integer
[code]  }
  function Left(const aCtx: TtfwContext;
   aControl: TControl): Integer;
   {* Реализация слова скрипта pop:Control:Left }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlLeft
 
 TkwPopControlHeight = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Height
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:Height >>> l_Integer
[code]  }
  function Height(const aCtx: TtfwContext;
   aControl: TControl): Integer;
   {* Реализация слова скрипта pop:Control:Height }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlHeight
 
 TkwPopControlWidth = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Width
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:Width >>> l_Integer
[code]  }
  function Width(const aCtx: TtfwContext;
   aControl: TControl): Integer;
   {* Реализация слова скрипта pop:Control:Width }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlWidth
 
 TkwPopControlParent = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Parent
*Тип результата:* TControl
*Пример:*
[code]
OBJECT VAR l_TControl
 aControl pop:Control:Parent >>> l_TControl
[code]  }
  function Parent(const aCtx: TtfwContext;
   aControl: TControl): TControl;
   {* Реализация слова скрипта pop:Control:Parent }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlParent
 
 TkwPopControlFont = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Font
*Тип результата:* Il3FontInfo
*Пример:*
[code]
INTERFACE VAR l_Il3FontInfo
 aControl pop:Control:Font >>> l_Il3FontInfo
[code]  }
  function Font(const aCtx: TtfwContext;
   aControl: TControl): Il3FontInfo;
   {* Реализация слова скрипта pop:Control:Font }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlFont
 
end.
