unit ReminderWordsPack;

interface

uses
 l3IntfUses
 , vgRemindersLine
 , l3Interfaces
 , vtPopupFormModelPart
 , Classes
 , Menus
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
 , l3PopupMenuHelper
 , RemindersLineWordsPack
 , Forms
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopReminderClick = class(TtfwClassLike)
  {* ����� ������� pop:Reminder:Click
*������:*
[code]
 aReminder pop:Reminder:Click
[code]  }
  procedure Click(const aCtx: TtfwContext;
   aReminder: TvgReminder);
   {* ���������� ����� ������� pop:Reminder:Click }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderClick
 
 TkwPopReminderMove = class(TtfwClassLike)
  {* ����� ������� pop:Reminder:Move
*������:*
[code]
 aDelta aReminder pop:Reminder:Move
[code]  }
  procedure Move(const aCtx: TtfwContext;
   aReminder: TvgReminder;
   const aDelta: TPoint);
   {* ���������� ����� ������� pop:Reminder:Move }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderMove
 
 TkwPopReminderFindEditor = class(TtfwClassLike)
  {* ����� ������� pop:Reminder:FindEditor
*��� ����������:* TComponent
*������:*
[code]
OBJECT VAR l_TComponent
 aReminder pop:Reminder:FindEditor >>> l_TComponent
[code]  }
  function FindEditor(const aCtx: TtfwContext;
   aReminder: TvgReminder): TComponent;
   {* ���������� ����� ������� pop:Reminder:FindEditor }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderFindEditor
 
 TkwPopReminderGetPopupMenu = class(TtfwClassLike)
  {* ����� ������� pop:Reminder:GetPopupMenu
*��� ����������:* TMenuItem
*������:*
[code]
OBJECT VAR l_TMenuItem
 aReminder pop:Reminder:GetPopupMenu >>> l_TMenuItem
[code]  }
  function GetPopupMenu(const aCtx: TtfwContext;
   aReminder: TvgReminder): TMenuItem;
   {* ���������� ����� ������� pop:Reminder:GetPopupMenu }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderGetPopupMenu
 
 TkwPopReminderImageIndex = class(TtfwPropertyLike)
  {* ����� ������� pop:Reminder:ImageIndex
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aReminder pop:Reminder:ImageIndex >>> l_Integer
[code]  }
  function ImageIndex(const aCtx: TtfwContext;
   aReminder: TvgReminder): Integer;
   {* ���������� ����� ������� pop:Reminder:ImageIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderImageIndex
 
 TkwPopReminderUserType = class(TtfwPropertyLike)
  {* ����� ������� pop:Reminder:UserType
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aReminder pop:Reminder:UserType >>> l_Integer
[code]  }
  function UserType(const aCtx: TtfwContext;
   aReminder: TvgReminder): Integer;
   {* ���������� ����� ������� pop:Reminder:UserType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderUserType
 
 TkwPopReminderIsBaloonVisible = class(TtfwPropertyLike)
  {* ����� ������� pop:Reminder:IsBaloonVisible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aReminder pop:Reminder:IsBaloonVisible >>> l_Boolean
[code]  }
  function IsBaloonVisible(const aCtx: TtfwContext;
   aReminder: TvgReminder): Boolean;
   {* ���������� ����� ������� pop:Reminder:IsBaloonVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderIsBaloonVisible
 
 TkwPopReminderVisible = class(TtfwPropertyLike)
  {* ����� ������� pop:Reminder:Visible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aReminder pop:Reminder:Visible >>> l_Boolean
[code]  }
  function Visible(const aCtx: TtfwContext;
   aReminder: TvgReminder): Boolean;
   {* ���������� ����� ������� pop:Reminder:Visible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderVisible
 
 TkwPopReminderName = class(TtfwPropertyLike)
  {* ����� ������� pop:Reminder:Name
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aReminder pop:Reminder:Name >>> l_String
[code]  }
  function Name(const aCtx: TtfwContext;
   aReminder: TvgReminder): AnsiString;
   {* ���������� ����� ������� pop:Reminder:Name }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderName
 
 TkwPopReminderFlash = class(TtfwPropertyLike)
  {* ����� ������� pop:Reminder:Flash
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aReminder pop:Reminder:Flash >>> l_Boolean
[code]  }
  function Flash(const aCtx: TtfwContext;
   aReminder: TvgReminder): Boolean;
   {* ���������� ����� ������� pop:Reminder:Flash }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderFlash
 
 TkwPopReminderTextBackColor = class(TtfwPropertyLike)
  {* ����� ������� pop:Reminder:TextBackColor
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aReminder pop:Reminder:TextBackColor >>> l_String
[code]  }
  function TextBackColor(const aCtx: TtfwContext;
   aReminder: TvgReminder): AnsiString;
   {* ���������� ����� ������� pop:Reminder:TextBackColor }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderTextBackColor
 
 TkwPopReminderShowHint = class(TtfwPropertyLike)
  {* ����� ������� pop:Reminder:ShowHint
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aReminder pop:Reminder:ShowHint >>> l_Boolean
[code]  }
  function ShowHint(const aCtx: TtfwContext;
   aReminder: TvgReminder): Boolean;
   {* ���������� ����� ������� pop:Reminder:ShowHint }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderShowHint
 
 TkwPopReminderCaption = class(TtfwPropertyLike)
  {* ����� ������� pop:Reminder:Caption
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aReminder pop:Reminder:Caption >>> l_Il3CString
[code]  }
  function Caption(const aCtx: TtfwContext;
   aReminder: TvgReminder): Il3CString;
   {* ���������� ����� ������� pop:Reminder:Caption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderCaption
 
 TkwPopReminderHint = class(TtfwPropertyLike)
  {* ����� ������� pop:Reminder:Hint
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aReminder pop:Reminder:Hint >>> l_Il3CString
[code]  }
  function Hint(const aCtx: TtfwContext;
   aReminder: TvgReminder): Il3CString;
   {* ���������� ����� ������� pop:Reminder:Hint }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderHint
 
 TkwPopReminderPopupForm = class(TtfwPropertyLike)
  {* ����� ������� pop:Reminder:PopupForm
*��� ����������:* TvtPopupFormModelPart
*������:*
[code]
OBJECT VAR l_TvtPopupFormModelPart
 aReminder pop:Reminder:PopupForm >>> l_TvtPopupFormModelPart
[code]  }
  function PopupForm(const aCtx: TtfwContext;
   aReminder: TvgReminder): TvtPopupFormModelPart;
   {* ���������� ����� ������� pop:Reminder:PopupForm }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderPopupForm
 
end.
