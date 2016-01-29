unit WinControlsProcessingPack;

interface

uses
 l3IntfUses
 , Controls
 , Classes
 , Types
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;

implementation

uses
 l3ImplUses
 , Messages
 , Windows
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopControlMouseLeftClick = class(TtfwClassLike)
  {* ����� ������� pop:Control:MouseLeftClick
*������:*
[code]
 aPoint aControl pop:Control:MouseLeftClick
[code]  }
  procedure MouseLeftClick(const aCtx: TtfwContext;
   aControl: TWinControl;
   const aPoint: TPoint);
   {* ���������� ����� ������� pop:Control:MouseLeftClick }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlMouseLeftClick
 
 TkwPopControlMouseMiddleClick = class(TtfwClassLike)
  {* ����� ������� pop:Control:MouseMiddleClick
*������:*
[code]
 aPoint aControl pop:Control:MouseMiddleClick
[code]  }
  procedure MouseMiddleClick(const aCtx: TtfwContext;
   aControl: TWinControl;
   const aPoint: TPoint);
   {* ���������� ����� ������� pop:Control:MouseMiddleClick }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlMouseMiddleClick
 
 TkwPopControlMouseRightClick = class(TtfwClassLike)
  {* ����� ������� pop:Control:MouseRightClick
*������:*
[code]
 aPoint aControl pop:Control:MouseRightClick
[code]  }
  procedure MouseRightClick(const aCtx: TtfwContext;
   aControl: TWinControl;
   const aPoint: TPoint);
   {* ���������� ����� ������� pop:Control:MouseRightClick }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlMouseRightClick
 
 TkwPopControlFindControlByName = class(TtfwClassLike)
  {* ����� ������� pop:Control:FindControlByName
*��� ����������:* TComponent
*������:*
[code]
OBJECT VAR l_TComponent
 aName aControl pop:Control:FindControlByName >>> l_TComponent
[code]  }
  function FindControlByName(const aCtx: TtfwContext;
   aControl: TWinControl;
   const aName: AnsiString): TComponent;
   {* ���������� ����� ������� pop:Control:FindControlByName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlFindControlByName
 
 TkwPopControlGetControl = class(TtfwClassLike)
  {* ����� ������� pop:Control:GetControl
*��� ����������:* TControl
*������:*
[code]
OBJECT VAR l_TControl
 anIndex aControl pop:Control:GetControl >>> l_TControl
[code]  }
  function GetControl(const aCtx: TtfwContext;
   aControl: TWinControl;
   anIndex: Integer): TControl;
   {* ���������� ����� ������� pop:Control:GetControl }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlGetControl
 
 TkwPopControlMouseWheelUp = class(TtfwClassLike)
  {* ����� ������� pop:Control:MouseWheelUp
*������:*
[code]
 aControl pop:Control:MouseWheelUp
[code]  }
  procedure MouseWheelUp(const aCtx: TtfwContext;
   aControl: TWinControl);
   {* ���������� ����� ������� pop:Control:MouseWheelUp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlMouseWheelUp
 
 TkwPopControlMouseWheelDown = class(TtfwClassLike)
  {* ����� ������� pop:Control:MouseWheelDown
*������:*
[code]
 aControl pop:Control:MouseWheelDown
[code]  }
  procedure MouseWheelDown(const aCtx: TtfwContext;
   aControl: TWinControl);
   {* ���������� ����� ������� pop:Control:MouseWheelDown }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlMouseWheelDown
 
 TkwPopControlSetFocus = class(TtfwClassLike)
  {* ����� ������� pop:Control:SetFocus
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:SetFocus >>> l_Boolean
[code]  }
  function SetFocus(const aCtx: TtfwContext;
   aControl: TWinControl): Boolean;
   {* ���������� ����� ������� pop:Control:SetFocus }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlSetFocus
 
 TkwPopControlMouseLeftDragAndDrop = class(TtfwClassLike)
  {* ����� ������� pop:Control:MouseLeftDragAndDrop
*������:*
[code]
 aPoint aDelta aControl pop:Control:MouseLeftDragAndDrop
[code]  }
  procedure MouseLeftDragAndDrop(const aCtx: TtfwContext;
   aControl: TWinControl;
   const aDelta: TPoint;
   const aPoint: TPoint);
   {* ���������� ����� ������� pop:Control:MouseLeftDragAndDrop }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlMouseLeftDragAndDrop
 
 TkwPopControlControlCount = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:ControlCount
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:ControlCount >>> l_Integer
[code]  }
  function ControlCount(const aCtx: TtfwContext;
   aControl: TWinControl): Integer;
   {* ���������� ����� ������� pop:Control:ControlCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlControlCount
 
 TkwPopControlHandle = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:Handle
*��� ����������:* Cardinal
*������:*
[code]
CARDINAL VAR l_Cardinal
 aControl pop:Control:Handle >>> l_Cardinal
[code]  }
  function Handle(const aCtx: TtfwContext;
   aControl: TWinControl): Cardinal;
   {* ���������� ����� ������� pop:Control:Handle }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlHandle
 
 TkwPopControlFocused = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:Focused
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:Focused >>> l_Boolean
[code]  }
  function Focused(const aCtx: TtfwContext;
   aControl: TWinControl): Boolean;
   {* ���������� ����� ������� pop:Control:Focused }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlFocused
 
 TkwPopControlCanFocus = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:CanFocus
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:CanFocus >>> l_Boolean
[code]  }
  function CanFocus(const aCtx: TtfwContext;
   aControl: TWinControl): Boolean;
   {* ���������� ����� ������� pop:Control:CanFocus }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlCanFocus
 
end.
