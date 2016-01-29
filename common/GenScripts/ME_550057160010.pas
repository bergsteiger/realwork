unit RemindersLineWordsPack;

interface

uses
 l3IntfUses
 , vgRemindersLine
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
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TvgRemindersLineFriend = class(TvgRemindersLine)
  {* Друг для TvgRemindersLine }
 end;//TvgRemindersLineFriend
 
 TkwPopRemindersLineClientToScreen = class(TtfwClassLike)
  {* Слово скрипта pop:RemindersLine:ClientToScreen
*Тип результата:* TPoint
*Пример:*
[code]
VAR l_TPoint
 aPoint aRemindersLine pop:RemindersLine:ClientToScreen >>> l_TPoint
[code]  }
  function ClientToScreen(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine;
   const aPoint: TPoint): TPoint;
   {* Реализация слова скрипта pop:RemindersLine:ClientToScreen }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineClientToScreen
 
 TkwPopRemindersLineGetReminder = class(TtfwClassLike)
  {* Слово скрипта pop:RemindersLine:GetReminder
*Тип результата:* TvgReminder
*Пример:*
[code]
OBJECT VAR l_TvgReminder
 anIndex aRemindersLine pop:RemindersLine:GetReminder >>> l_TvgReminder
[code]  }
  function GetReminder(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine;
   anIndex: Integer): TvgReminder;
   {* Реализация слова скрипта pop:RemindersLine:GetReminder }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineGetReminder
 
 TkwPopRemindersLineAbsLeft = class(TtfwPropertyLike)
  {* Слово скрипта pop:RemindersLine:AbsLeft
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:AbsLeft >>> l_Integer
[code]  }
  function AbsLeft(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine): Integer;
   {* Реализация слова скрипта pop:RemindersLine:AbsLeft }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineAbsLeft
 
 TkwPopRemindersLineAbsTop = class(TtfwPropertyLike)
  {* Слово скрипта pop:RemindersLine:AbsTop
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:AbsTop >>> l_Integer
[code]  }
  function AbsTop(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine): Integer;
   {* Реализация слова скрипта pop:RemindersLine:AbsTop }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineAbsTop
 
 TkwPopRemindersLineCount = class(TtfwPropertyLike)
  {* Слово скрипта pop:RemindersLine:Count
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Count >>> l_Integer
[code]  }
  function Count(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine): Integer;
   {* Реализация слова скрипта pop:RemindersLine:Count }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineCount
 
 TkwPopRemindersLineHeight = class(TtfwPropertyLike)
  {* Слово скрипта pop:RemindersLine:Height
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Height >>> l_Integer
[code]  }
  function Height(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine): Integer;
   {* Реализация слова скрипта pop:RemindersLine:Height }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineHeight
 
 TkwPopRemindersLineLeft = class(TtfwPropertyLike)
  {* Слово скрипта pop:RemindersLine:Left
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Left >>> l_Integer
[code]  }
  function Left(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine): Integer;
   {* Реализация слова скрипта pop:RemindersLine:Left }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineLeft
 
 TkwPopRemindersLineTop = class(TtfwPropertyLike)
  {* Слово скрипта pop:RemindersLine:Top
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Top >>> l_Integer
[code]  }
  function Top(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine): Integer;
   {* Реализация слова скрипта pop:RemindersLine:Top }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineTop
 
 TkwPopRemindersLineVisible = class(TtfwPropertyLike)
  {* Слово скрипта pop:RemindersLine:Visible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aRemindersLine pop:RemindersLine:Visible >>> l_Boolean
[code]  }
  function Visible(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine): Boolean;
   {* Реализация слова скрипта pop:RemindersLine:Visible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineVisible
 
 TkwPopRemindersLineWidth = class(TtfwPropertyLike)
  {* Слово скрипта pop:RemindersLine:Width
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Width >>> l_Integer
[code]  }
  function Width(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine): Integer;
   {* Реализация слова скрипта pop:RemindersLine:Width }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineWidth
 
end.
