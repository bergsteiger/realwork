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
  {* Слово скрипта pop:Reminder:Click
*Пример:*
[code]
 aReminder pop:Reminder:Click
[code]  }
  procedure Click(const aCtx: TtfwContext;
   aReminder: TvgReminder);
   {* Реализация слова скрипта pop:Reminder:Click }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderClick
 
 TkwPopReminderMove = class(TtfwClassLike)
  {* Слово скрипта pop:Reminder:Move
*Пример:*
[code]
 aDelta aReminder pop:Reminder:Move
[code]  }
  procedure Move(const aCtx: TtfwContext;
   aReminder: TvgReminder;
   const aDelta: TPoint);
   {* Реализация слова скрипта pop:Reminder:Move }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderMove
 
 TkwPopReminderFindEditor = class(TtfwClassLike)
  {* Слово скрипта pop:Reminder:FindEditor
*Тип результата:* TComponent
*Пример:*
[code]
OBJECT VAR l_TComponent
 aReminder pop:Reminder:FindEditor >>> l_TComponent
[code]  }
  function FindEditor(const aCtx: TtfwContext;
   aReminder: TvgReminder): TComponent;
   {* Реализация слова скрипта pop:Reminder:FindEditor }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderFindEditor
 
 TkwPopReminderGetPopupMenu = class(TtfwClassLike)
  {* Слово скрипта pop:Reminder:GetPopupMenu
*Тип результата:* TMenuItem
*Пример:*
[code]
OBJECT VAR l_TMenuItem
 aReminder pop:Reminder:GetPopupMenu >>> l_TMenuItem
[code]  }
  function GetPopupMenu(const aCtx: TtfwContext;
   aReminder: TvgReminder): TMenuItem;
   {* Реализация слова скрипта pop:Reminder:GetPopupMenu }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderGetPopupMenu
 
 TkwPopReminderImageIndex = class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:ImageIndex
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aReminder pop:Reminder:ImageIndex >>> l_Integer
[code]  }
  function ImageIndex(const aCtx: TtfwContext;
   aReminder: TvgReminder): Integer;
   {* Реализация слова скрипта pop:Reminder:ImageIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderImageIndex
 
 TkwPopReminderUserType = class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:UserType
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aReminder pop:Reminder:UserType >>> l_Integer
[code]  }
  function UserType(const aCtx: TtfwContext;
   aReminder: TvgReminder): Integer;
   {* Реализация слова скрипта pop:Reminder:UserType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderUserType
 
 TkwPopReminderIsBaloonVisible = class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:IsBaloonVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aReminder pop:Reminder:IsBaloonVisible >>> l_Boolean
[code]  }
  function IsBaloonVisible(const aCtx: TtfwContext;
   aReminder: TvgReminder): Boolean;
   {* Реализация слова скрипта pop:Reminder:IsBaloonVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderIsBaloonVisible
 
 TkwPopReminderVisible = class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Visible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aReminder pop:Reminder:Visible >>> l_Boolean
[code]  }
  function Visible(const aCtx: TtfwContext;
   aReminder: TvgReminder): Boolean;
   {* Реализация слова скрипта pop:Reminder:Visible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderVisible
 
 TkwPopReminderName = class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Name
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aReminder pop:Reminder:Name >>> l_String
[code]  }
  function Name(const aCtx: TtfwContext;
   aReminder: TvgReminder): AnsiString;
   {* Реализация слова скрипта pop:Reminder:Name }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderName
 
 TkwPopReminderFlash = class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Flash
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aReminder pop:Reminder:Flash >>> l_Boolean
[code]  }
  function Flash(const aCtx: TtfwContext;
   aReminder: TvgReminder): Boolean;
   {* Реализация слова скрипта pop:Reminder:Flash }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderFlash
 
 TkwPopReminderTextBackColor = class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:TextBackColor
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aReminder pop:Reminder:TextBackColor >>> l_String
[code]  }
  function TextBackColor(const aCtx: TtfwContext;
   aReminder: TvgReminder): AnsiString;
   {* Реализация слова скрипта pop:Reminder:TextBackColor }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderTextBackColor
 
 TkwPopReminderShowHint = class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:ShowHint
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aReminder pop:Reminder:ShowHint >>> l_Boolean
[code]  }
  function ShowHint(const aCtx: TtfwContext;
   aReminder: TvgReminder): Boolean;
   {* Реализация слова скрипта pop:Reminder:ShowHint }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderShowHint
 
 TkwPopReminderCaption = class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Caption
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aReminder pop:Reminder:Caption >>> l_Il3CString
[code]  }
  function Caption(const aCtx: TtfwContext;
   aReminder: TvgReminder): Il3CString;
   {* Реализация слова скрипта pop:Reminder:Caption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderCaption
 
 TkwPopReminderHint = class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Hint
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aReminder pop:Reminder:Hint >>> l_Il3CString
[code]  }
  function Hint(const aCtx: TtfwContext;
   aReminder: TvgReminder): Il3CString;
   {* Реализация слова скрипта pop:Reminder:Hint }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderHint
 
 TkwPopReminderPopupForm = class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:PopupForm
*Тип результата:* TvtPopupFormModelPart
*Пример:*
[code]
OBJECT VAR l_TvtPopupFormModelPart
 aReminder pop:Reminder:PopupForm >>> l_TvtPopupFormModelPart
[code]  }
  function PopupForm(const aCtx: TtfwContext;
   aReminder: TvgReminder): TvtPopupFormModelPart;
   {* Реализация слова скрипта pop:Reminder:PopupForm }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopReminderPopupForm
 
end.
