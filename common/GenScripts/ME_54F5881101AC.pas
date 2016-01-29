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
  {* Слово скрипта pop:Control:VScrollerVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:VScrollerVisible >>> l_Boolean
[code]  }
  function VScrollerVisible(const aCtx: TtfwContext;
   aControl: TWinControl): Boolean;
   {* Реализация слова скрипта pop:Control:VScrollerVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlVScrollerVisible
 
 TkwPopControlHScrollerVisible = class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:HScrollerVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:HScrollerVisible >>> l_Boolean
[code]  }
  function HScrollerVisible(const aCtx: TtfwContext;
   aControl: TWinControl): Boolean;
   {* Реализация слова скрипта pop:Control:HScrollerVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopControlHScrollerVisible
 
 TkwPopScrollingWinControlVScrollerVisible = class(TtfwPropertyLike)
  {* Слово скрипта pop:ScrollingWinControl:VScrollerVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aScrollingWinControl pop:ScrollingWinControl:VScrollerVisible >>> l_Boolean
[code]  }
  function VScrollerVisible(const aCtx: TtfwContext;
   aScrollingWinControl: TScrollingWinControl): Boolean;
   {* Реализация слова скрипта pop:ScrollingWinControl:VScrollerVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopScrollingWinControlVScrollerVisible
 
 TkwPopScrollingWinControlHScrollerVisible = class(TtfwPropertyLike)
  {* Слово скрипта pop:ScrollingWinControl:HScrollerVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aScrollingWinControl pop:ScrollingWinControl:HScrollerVisible >>> l_Boolean
[code]  }
  function HScrollerVisible(const aCtx: TtfwContext;
   aScrollingWinControl: TScrollingWinControl): Boolean;
   {* Реализация слова скрипта pop:ScrollingWinControl:HScrollerVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopScrollingWinControlHScrollerVisible
 
end.
