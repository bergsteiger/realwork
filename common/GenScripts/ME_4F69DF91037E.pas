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
  {* ���� ��� TControl }
 end;//TControlFriend
 
 TkwPopControlClientToScreen = class(TtfwClassLike)
  {* ����� ������� pop:Control:ClientToScreen
*��� ����������:* TPoint
*������:*
[code]
VAR l_TPoint
 aPoint aControl pop:Control:ClientToScreen >>> l_TPoint
[code]  }
  function ClientToScreen(const aCtx: TtfwContext;
   aControl: TControl;
   const aPoint: TPoint): TPoint;
   {* ���������� ����� ������� pop:Control:ClientToScreen }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlClientToScreen
 
 TkwPopControlScreenToClient = class(TtfwClassLike)
  {* ����� ������� pop:Control:ScreenToClient
*��� ����������:* TPoint
*������:*
[code]
VAR l_TPoint
 aPoint aControl pop:Control:ScreenToClient >>> l_TPoint
[code]  }
  function ScreenToClient(const aCtx: TtfwContext;
   aControl: TControl;
   const aPoint: TPoint): TPoint;
   {* ���������� ����� ������� pop:Control:ScreenToClient }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlScreenToClient
 
 TkwPopControlInvalidate = class(TtfwClassLike)
  {* ����� ������� pop:Control:Invalidate
*������:*
[code]
 aControl pop:Control:Invalidate
[code]  }
  procedure Invalidate(const aCtx: TtfwContext;
   aControl: TControl);
   {* ���������� ����� ������� pop:Control:Invalidate }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlInvalidate
 
 TkwPopControlRepaint = class(TtfwClassLike)
  {* ����� ������� pop:Control:Repaint
*������:*
[code]
 aControl pop:Control:Repaint
[code]  }
  procedure Repaint(const aCtx: TtfwContext;
   aControl: TControl);
   {* ���������� ����� ������� pop:Control:Repaint }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlRepaint
 
 TkwPopControlClick = class(TtfwClassLike)
  {* ����� ������� pop:Control:Click
*������:*
[code]
 aControl pop:Control:Click
[code]  }
  procedure Click(const aCtx: TtfwContext;
   aControl: TControl);
   {* ���������� ����� ������� pop:Control:Click }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlClick
 
 TkwPopControlShow = class(TtfwClassLike)
  {* ����� ������� pop:Control:Show
*������:*
[code]
 aControl pop:Control:Show
[code]  }
  procedure Show(const aCtx: TtfwContext;
   aControl: TControl);
   {* ���������� ����� ������� pop:Control:Show }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlShow
 
 TkwPopControlHide = class(TtfwClassLike)
  {* ����� ������� pop:Control:Hide
*������:*
[code]
 aControl pop:Control:Hide
[code]  }
  procedure Hide(const aCtx: TtfwContext;
   aControl: TControl);
   {* ���������� ����� ������� pop:Control:Hide }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlHide
 
 TkwPopControlUndock = class(TtfwClassLike)
  {* ����� ������� pop:Control:Undock
*������:*
[code]
 aControl pop:Control:Undock
[code]  }
  procedure Undock(const aCtx: TtfwContext;
   aControl: TControl);
   {* ���������� ����� ������� pop:Control:Undock }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlUndock
 
 TkwPopControlGetPopupMenu = class(TtfwClassLike)
  {* ����� ������� pop:Control:GetPopupMenu
*��� ����������:* TMenuItem
*������:*
[code]
OBJECT VAR l_TMenuItem
 aPoint aControl pop:Control:GetPopupMenu >>> l_TMenuItem
[code]  }
  function GetPopupMenu(const aCtx: TtfwContext;
   aControl: TControl;
   const aPoint: TPoint): TMenuItem;
   {* ���������� ����� ������� pop:Control:GetPopupMenu }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlGetPopupMenu
 
 TkwPopControlGetTopParentForm = class(TtfwClassLike)
  {* ����� ������� pop:Control:GetTopParentForm
*��� ����������:* TCustomForm
*������:*
[code]
OBJECT VAR l_TCustomForm
 aControl pop:Control:GetTopParentForm >>> l_TCustomForm
[code]  }
  function GetTopParentForm(const aCtx: TtfwContext;
   aControl: TControl): TCustomForm;
   {* ���������� ����� ������� pop:Control:GetTopParentForm }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlGetTopParentForm
 
 TkwPopControlGetMainForm = class(TtfwClassLike)
  {* ����� ������� pop:Control:GetMainForm
*��� ����������:* TCustomForm
*������:*
[code]
OBJECT VAR l_TCustomForm
 aControl pop:Control:GetMainForm >>> l_TCustomForm
[code]  }
  function GetMainForm(const aCtx: TtfwContext;
   aControl: TControl): TCustomForm;
   {* ���������� ����� ������� pop:Control:GetMainForm }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlGetMainForm
 
 TkwPopControlGetParentForm = class(TtfwClassLike)
  {* ����� ������� pop:Control:GetParentForm
*��� ����������:* TCustomForm
*������:*
[code]
OBJECT VAR l_TCustomForm
 aControl pop:Control:GetParentForm >>> l_TCustomForm
[code]  }
  function GetParentForm(const aCtx: TtfwContext;
   aControl: TControl): TCustomForm;
   {* ���������� ����� ������� pop:Control:GetParentForm }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlGetParentForm
 
 TkwPopControlGetAnotherParentForm = class(TtfwClassLike)
  {* ����� ������� pop:Control:GetAnotherParentForm
*��� ����������:* TCustomForm
*������:*
[code]
OBJECT VAR l_TCustomForm
 aControl pop:Control:GetAnotherParentForm >>> l_TCustomForm
[code]  }
  function GetAnotherParentForm(const aCtx: TtfwContext;
   aControl: TControl): TCustomForm;
   {* ���������� ����� ������� pop:Control:GetAnotherParentForm }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlGetAnotherParentForm
 
 TkwControlByHandle = class(TtfwRegisterableWord)
  {* ����� ������� Control:ByHandle
*��� ����������:* TControl
*������:*
[code]
OBJECT VAR l_TControl
 aHandle Control:ByHandle >>> l_TControl
[code]  }
  function ByHandle(const aCtx: TtfwContext;
   aHandle: THandle): TControl;
   {* ���������� ����� ������� Control:ByHandle }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwControlByHandle
 
 TkwControlFocusedControlPush = class(TtfwRegisterableWord)
  {* ����� ������� focused:control:push
*��� ����������:* TControl
*������:*
[code]
OBJECT VAR l_TControl
 focused:control:push >>> l_TControl
[code]  }
  function focused_control_push(const aCtx: TtfwContext): TControl;
   {* ���������� ����� ������� focused:control:push }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwControlFocusedControlPush
 
 TkwPopControlColor = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:Color
*��� ����������:* TColor
*������:*
[code]
TColor VAR l_TColor
 aControl pop:Control:Color >>> l_TColor
[code]  }
  function Color(const aCtx: TtfwContext;
   aControl: TControl): TColor;
   {* ���������� ����� ������� pop:Control:Color }
  procedure DoSetValue(aControl: TControl;
   aValue: TColor);
   {* ����� ��������� �������� �������� Color }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlColor
 
 TkwPopControlEnabled = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:Enabled
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:Enabled >>> l_Boolean
[code]  }
  function Enabled(const aCtx: TtfwContext;
   aControl: TControl): Boolean;
   {* ���������� ����� ������� pop:Control:Enabled }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlEnabled
 
 TkwPopControlVisible = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:Visible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:Visible >>> l_Boolean
[code]  }
  function Visible(const aCtx: TtfwContext;
   aControl: TControl): Boolean;
   {* ���������� ����� ������� pop:Control:Visible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlVisible
 
 TkwPopControlName = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:Name
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aControl pop:Control:Name >>> l_String
[code]  }
  function Name(const aCtx: TtfwContext;
   aControl: TControl): AnsiString;
   {* ���������� ����� ������� pop:Control:Name }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlName
 
 TkwPopControlHint = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:Hint
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aControl pop:Control:Hint >>> l_String
[code]  }
  function Hint(const aCtx: TtfwContext;
   aControl: TControl): AnsiString;
   {* ���������� ����� ������� pop:Control:Hint }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlHint
 
 TkwPopControlShowHint = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:ShowHint
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:ShowHint >>> l_Boolean
[code]  }
  function ShowHint(const aCtx: TtfwContext;
   aControl: TControl): Boolean;
   {* ���������� ����� ������� pop:Control:ShowHint }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlShowHint
 
 TkwPopControlCaption = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:Caption
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aControl pop:Control:Caption >>> l_String
[code]  }
  function Caption(const aCtx: TtfwContext;
   aControl: TControl): AnsiString;
   {* ���������� ����� ������� pop:Control:Caption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlCaption
 
 TkwPopControlTop = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:Top
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:Top >>> l_Integer
[code]  }
  function Top(const aCtx: TtfwContext;
   aControl: TControl): Integer;
   {* ���������� ����� ������� pop:Control:Top }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlTop
 
 TkwPopControlLeft = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:Left
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:Left >>> l_Integer
[code]  }
  function Left(const aCtx: TtfwContext;
   aControl: TControl): Integer;
   {* ���������� ����� ������� pop:Control:Left }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlLeft
 
 TkwPopControlHeight = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:Height
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:Height >>> l_Integer
[code]  }
  function Height(const aCtx: TtfwContext;
   aControl: TControl): Integer;
   {* ���������� ����� ������� pop:Control:Height }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlHeight
 
 TkwPopControlWidth = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:Width
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:Width >>> l_Integer
[code]  }
  function Width(const aCtx: TtfwContext;
   aControl: TControl): Integer;
   {* ���������� ����� ������� pop:Control:Width }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlWidth
 
 TkwPopControlParent = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:Parent
*��� ����������:* TControl
*������:*
[code]
OBJECT VAR l_TControl
 aControl pop:Control:Parent >>> l_TControl
[code]  }
  function Parent(const aCtx: TtfwContext;
   aControl: TControl): TControl;
   {* ���������� ����� ������� pop:Control:Parent }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlParent
 
 TkwPopControlFont = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:Font
*��� ����������:* Il3FontInfo
*������:*
[code]
INTERFACE VAR l_Il3FontInfo
 aControl pop:Control:Font >>> l_Il3FontInfo
[code]  }
  function Font(const aCtx: TtfwContext;
   aControl: TControl): Il3FontInfo;
   {* ���������� ����� ������� pop:Control:Font }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlFont
 
end.
