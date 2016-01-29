unit MenuWordsPack;

interface

uses
 l3IntfUses
 , Menus
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;

implementation

uses
 l3ImplUses
 , Controls
 , Forms
 , l3ScreenService
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TMenuWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TMenuWordsPackResNameGetter
 
 TMenuItemFriend = class(TMenuItem)
  {* Друг для TMenuItem }
 end;//TMenuItemFriend
 
 TkwMenuItemClick = class(TtfwClassLike)
  {* Слово скрипта menuitem:Click
*Пример:*
[code]
 aMenuItem menuitem:Click
[code]  }
  procedure Click(const aCtx: TtfwContext;
   aMenuItem: TMenuItem);
   {* Реализация слова скрипта menuitem:Click }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMenuItemClick
 
 TkwMenuItemGetItem = class(TtfwClassLike)
  {* Слово скрипта menuitem:GetItem
*Тип результата:* TMenuItem
*Пример:*
[code]
OBJECT VAR l_TMenuItem
 anIndex aMenuItem menuitem:GetItem >>> l_TMenuItem
[code]  }
  function GetItem(const aCtx: TtfwContext;
   aMenuItem: TMenuItem;
   anIndex: Integer): TMenuItem;
   {* Реализация слова скрипта menuitem:GetItem }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMenuItemGetItem
 
 TkwMenuItemGetMenuHeight = class(TtfwClassLike)
  {* Слово скрипта menuitem:GetMenuHeight
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aMenuItem menuitem:GetMenuHeight >>> l_Integer
[code]  }
  function GetMenuHeight(const aCtx: TtfwContext;
   aMenuItem: TMenuItem): Integer;
   {* Реализация слова скрипта menuitem:GetMenuHeight }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMenuItemGetMenuHeight
 
 TkwMenuItemCaption = class(TtfwPropertyLike)
  {* Слово скрипта menuitem:GetCaption
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aMenuItem menuitem:GetCaption >>> l_String
[code]  }
  function Caption(const aCtx: TtfwContext;
   aMenuItem: TMenuItem): AnsiString;
   {* Реализация слова скрипта menuitem:GetCaption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMenuItemCaption
 
 TkwMenuItemCount = class(TtfwPropertyLike)
  {* Слово скрипта menuitem:GetCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aMenuItem menuitem:GetCount >>> l_Integer
[code]  }
  function Count(const aCtx: TtfwContext;
   aMenuItem: TMenuItem): Integer;
   {* Реализация слова скрипта menuitem:GetCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMenuItemCount
 
 TkwMenuItemEnabled = class(TtfwPropertyLike)
  {* Слово скрипта menuitem:IsEnabled
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aMenuItem menuitem:IsEnabled >>> l_Boolean
[code]  }
  function Enabled(const aCtx: TtfwContext;
   aMenuItem: TMenuItem): Boolean;
   {* Реализация слова скрипта menuitem:IsEnabled }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMenuItemEnabled
 
 TkwMenuItemVisible = class(TtfwPropertyLike)
  {* Слово скрипта menuitem:IsVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aMenuItem menuitem:IsVisible >>> l_Boolean
[code]  }
  function Visible(const aCtx: TtfwContext;
   aMenuItem: TMenuItem): Boolean;
   {* Реализация слова скрипта menuitem:IsVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMenuItemVisible
 
end.
