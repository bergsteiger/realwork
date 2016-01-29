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
  {* ���� ��� TvgRemindersLine }
 end;//TvgRemindersLineFriend
 
 TkwPopRemindersLineClientToScreen = class(TtfwClassLike)
  {* ����� ������� pop:RemindersLine:ClientToScreen
*��� ����������:* TPoint
*������:*
[code]
VAR l_TPoint
 aPoint aRemindersLine pop:RemindersLine:ClientToScreen >>> l_TPoint
[code]  }
  function ClientToScreen(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine;
   const aPoint: TPoint): TPoint;
   {* ���������� ����� ������� pop:RemindersLine:ClientToScreen }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineClientToScreen
 
 TkwPopRemindersLineGetReminder = class(TtfwClassLike)
  {* ����� ������� pop:RemindersLine:GetReminder
*��� ����������:* TvgReminder
*������:*
[code]
OBJECT VAR l_TvgReminder
 anIndex aRemindersLine pop:RemindersLine:GetReminder >>> l_TvgReminder
[code]  }
  function GetReminder(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine;
   anIndex: Integer): TvgReminder;
   {* ���������� ����� ������� pop:RemindersLine:GetReminder }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineGetReminder
 
 TkwPopRemindersLineAbsLeft = class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:AbsLeft
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:AbsLeft >>> l_Integer
[code]  }
  function AbsLeft(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine): Integer;
   {* ���������� ����� ������� pop:RemindersLine:AbsLeft }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineAbsLeft
 
 TkwPopRemindersLineAbsTop = class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:AbsTop
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:AbsTop >>> l_Integer
[code]  }
  function AbsTop(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine): Integer;
   {* ���������� ����� ������� pop:RemindersLine:AbsTop }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineAbsTop
 
 TkwPopRemindersLineCount = class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Count
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Count >>> l_Integer
[code]  }
  function Count(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine): Integer;
   {* ���������� ����� ������� pop:RemindersLine:Count }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineCount
 
 TkwPopRemindersLineHeight = class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Height
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Height >>> l_Integer
[code]  }
  function Height(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine): Integer;
   {* ���������� ����� ������� pop:RemindersLine:Height }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineHeight
 
 TkwPopRemindersLineLeft = class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Left
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Left >>> l_Integer
[code]  }
  function Left(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine): Integer;
   {* ���������� ����� ������� pop:RemindersLine:Left }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineLeft
 
 TkwPopRemindersLineTop = class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Top
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Top >>> l_Integer
[code]  }
  function Top(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine): Integer;
   {* ���������� ����� ������� pop:RemindersLine:Top }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineTop
 
 TkwPopRemindersLineVisible = class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Visible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aRemindersLine pop:RemindersLine:Visible >>> l_Boolean
[code]  }
  function Visible(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine): Boolean;
   {* ���������� ����� ������� pop:RemindersLine:Visible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineVisible
 
 TkwPopRemindersLineWidth = class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Width
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Width >>> l_Integer
[code]  }
  function Width(const aCtx: TtfwContext;
   aRemindersLine: TvgRemindersLine): Integer;
   {* ���������� ����� ������� pop:RemindersLine:Width }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRemindersLineWidth
 
end.
