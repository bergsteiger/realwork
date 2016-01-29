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
  {* Слово скрипта pop:Control:MouseLeftClick
*Пример:*
[code]
 aPoint aControl pop:Control:MouseLeftClick
[code]  }
  procedure MouseLeftClick(const aCtx: TtfwContext;
   aControl: TWinControl;
   const aPoint: TPoint);
   {* Реализация слова скрипта pop:Control:MouseLeftClick }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlMouseLeftClick
 
 TkwPopControlMouseMiddleClick = class(TtfwClassLike)
  {* Слово скрипта pop:Control:MouseMiddleClick
*Пример:*
[code]
 aPoint aControl pop:Control:MouseMiddleClick
[code]  }
  procedure MouseMiddleClick(const aCtx: TtfwContext;
   aControl: TWinControl;
   const aPoint: TPoint);
   {* Реализация слова скрипта pop:Control:MouseMiddleClick }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlMouseMiddleClick
 
 TkwPopControlMouseRightClick = class(TtfwClassLike)
  {* Слово скрипта pop:Control:MouseRightClick
*Пример:*
[code]
 aPoint aControl pop:Control:MouseRightClick
[code]  }
  procedure MouseRightClick(const aCtx: TtfwContext;
   aControl: TWinControl;
   const aPoint: TPoint);
   {* Реализация слова скрипта pop:Control:MouseRightClick }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlMouseRightClick
 
 TkwPopControlFindControlByName = class(TtfwClassLike)
  {* Слово скрипта pop:Control:FindControlByName
*Тип результата:* TComponent
*Пример:*
[code]
OBJECT VAR l_TComponent
 aName aControl pop:Control:FindControlByName >>> l_TComponent
[code]  }
  function FindControlByName(const aCtx: TtfwContext;
   aControl: TWinControl;
   const aName: AnsiString): TComponent;
   {* Реализация слова скрипта pop:Control:FindControlByName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlFindControlByName
 
 TkwPopControlGetControl = class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetControl
*Тип результата:* TControl
*Пример:*
[code]
OBJECT VAR l_TControl
 anIndex aControl pop:Control:GetControl >>> l_TControl
[code]  }
  function GetControl(const aCtx: TtfwContext;
   aControl: TWinControl;
   anIndex: Integer): TControl;
   {* Реализация слова скрипта pop:Control:GetControl }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlGetControl
 
 TkwPopControlMouseWheelUp = class(TtfwClassLike)
  {* Слово скрипта pop:Control:MouseWheelUp
*Пример:*
[code]
 aControl pop:Control:MouseWheelUp
[code]  }
  procedure MouseWheelUp(const aCtx: TtfwContext;
   aControl: TWinControl);
   {* Реализация слова скрипта pop:Control:MouseWheelUp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlMouseWheelUp
 
 TkwPopControlMouseWheelDown = class(TtfwClassLike)
  {* Слово скрипта pop:Control:MouseWheelDown
*Пример:*
[code]
 aControl pop:Control:MouseWheelDown
[code]  }
  procedure MouseWheelDown(const aCtx: TtfwContext;
   aControl: TWinControl);
   {* Реализация слова скрипта pop:Control:MouseWheelDown }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlMouseWheelDown
 
 TkwPopControlSetFocus = class(TtfwClassLike)
  {* Слово скрипта pop:Control:SetFocus
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:SetFocus >>> l_Boolean
[code]  }
  function SetFocus(const aCtx: TtfwContext;
   aControl: TWinControl): Boolean;
   {* Реализация слова скрипта pop:Control:SetFocus }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlSetFocus
 
 TkwPopControlMouseLeftDragAndDrop = class(TtfwClassLike)
  {* Слово скрипта pop:Control:MouseLeftDragAndDrop
*Пример:*
[code]
 aPoint aDelta aControl pop:Control:MouseLeftDragAndDrop
[code]  }
  procedure MouseLeftDragAndDrop(const aCtx: TtfwContext;
   aControl: TWinControl;
   const aDelta: TPoint;
   const aPoint: TPoint);
   {* Реализация слова скрипта pop:Control:MouseLeftDragAndDrop }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlMouseLeftDragAndDrop
 
 TkwPopControlControlCount = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:ControlCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:ControlCount >>> l_Integer
[code]  }
  function ControlCount(const aCtx: TtfwContext;
   aControl: TWinControl): Integer;
   {* Реализация слова скрипта pop:Control:ControlCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlControlCount
 
 TkwPopControlHandle = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Handle
*Тип результата:* Cardinal
*Пример:*
[code]
CARDINAL VAR l_Cardinal
 aControl pop:Control:Handle >>> l_Cardinal
[code]  }
  function Handle(const aCtx: TtfwContext;
   aControl: TWinControl): Cardinal;
   {* Реализация слова скрипта pop:Control:Handle }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlHandle
 
 TkwPopControlFocused = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Focused
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:Focused >>> l_Boolean
[code]  }
  function Focused(const aCtx: TtfwContext;
   aControl: TWinControl): Boolean;
   {* Реализация слова скрипта pop:Control:Focused }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlFocused
 
 TkwPopControlCanFocus = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:CanFocus
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:CanFocus >>> l_Boolean
[code]  }
  function CanFocus(const aCtx: TtfwContext;
   aControl: TWinControl): Boolean;
   {* Реализация слова скрипта pop:Control:CanFocus }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlCanFocus
 
end.
