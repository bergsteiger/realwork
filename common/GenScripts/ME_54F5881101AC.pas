unit ScrollingWinControlWordsPack;

interface

uses
 l3IntfUses
 , Controls
 , Forms
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;

implementation

uses
 l3ImplUses
 , Windows
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopControlVScrollerVisible = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:VScrollerVisible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:VScrollerVisible >>> l_Boolean
[code]  }
  function VScrollerVisible(const aCtx: TtfwContext;
   aControl: TWinControl): Boolean;
   {* ���������� ����� ������� pop:Control:VScrollerVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlVScrollerVisible
 
 TkwPopControlHScrollerVisible = class(TtfwPropertyLike)
  {* ����� ������� pop:Control:HScrollerVisible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:HScrollerVisible >>> l_Boolean
[code]  }
  function HScrollerVisible(const aCtx: TtfwContext;
   aControl: TWinControl): Boolean;
   {* ���������� ����� ������� pop:Control:HScrollerVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlHScrollerVisible
 
 TkwPopScrollingWinControlVScrollerVisible = class(TtfwPropertyLike)
  {* ����� ������� pop:ScrollingWinControl:VScrollerVisible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aScrollingWinControl pop:ScrollingWinControl:VScrollerVisible >>> l_Boolean
[code]  }
  function VScrollerVisible(const aCtx: TtfwContext;
   aScrollingWinControl: TScrollingWinControl): Boolean;
   {* ���������� ����� ������� pop:ScrollingWinControl:VScrollerVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopScrollingWinControlVScrollerVisible
 
 TkwPopScrollingWinControlHScrollerVisible = class(TtfwPropertyLike)
  {* ����� ������� pop:ScrollingWinControl:HScrollerVisible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aScrollingWinControl pop:ScrollingWinControl:HScrollerVisible >>> l_Boolean
[code]  }
  function HScrollerVisible(const aCtx: TtfwContext;
   aScrollingWinControl: TScrollingWinControl): Boolean;
   {* ���������� ����� ������� pop:ScrollingWinControl:HScrollerVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopScrollingWinControlHScrollerVisible
 
end.
