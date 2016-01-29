unit vcmTabbedMenuWordsPack;

interface

uses
 l3IntfUses
 , vcmBaseMenuForChromeLike
 , Menus
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TvcmTabbedMenuWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TvcmTabbedMenuWordsPackResNameGetter
 
 TvcmBaseMenuForChromeLikeFriend = class(TvcmBaseMenuForChromeLike)
  {* Друг для TvcmBaseMenuForChromeLike }
 end;//TvcmBaseMenuForChromeLikeFriend
 
 TkwPopMenuForChromeLikeActive = class(TtfwClassLike)
  {* Слово скрипта pop:MenuForChromeLike:Active
*Тип результата:* TvcmBaseMenuForChromeLike
*Пример:*
[code]
OBJECT VAR l_TvcmBaseMenuForChromeLike
 aMenuForChromeLike pop:MenuForChromeLike:Active >>> l_TvcmBaseMenuForChromeLike
[code]  }
  function Active(const aCtx: TtfwContext;
   aMenuForChromeLike: TvcmBaseMenuForChromeLike): TvcmBaseMenuForChromeLike;
   {* Реализация слова скрипта pop:MenuForChromeLike:Active }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopMenuForChromeLikeActive
 
 TkwPopMenuForChromeLikeHovered = class(TtfwClassLike)
  {* Слово скрипта pop:MenuForChromeLike:Hovered
*Тип результата:* TMenuItem
*Пример:*
[code]
OBJECT VAR l_TMenuItem
 aMenuForChromeLike pop:MenuForChromeLike:Hovered >>> l_TMenuItem
[code]  }
  function Hovered(const aCtx: TtfwContext;
   aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
   {* Реализация слова скрипта pop:MenuForChromeLike:Hovered }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopMenuForChromeLikeHovered
 
 TkwPopMenuForChromeLikeMenuItem = class(TtfwClassLike)
  {* Слово скрипта pop:MenuForChromeLike:MenuItem
*Тип результата:* TMenuItem
*Пример:*
[code]
OBJECT VAR l_TMenuItem
 aMenuForChromeLike pop:MenuForChromeLike:MenuItem >>> l_TMenuItem
[code]  }
  function MenuItem(const aCtx: TtfwContext;
   aMenuForChromeLike: TvcmBaseMenuForChromeLike): TMenuItem;
   {* Реализация слова скрипта pop:MenuForChromeLike:MenuItem }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopMenuForChromeLikeMenuItem
 
end.
