unit StatusBarWords;

interface

uses
 l3IntfUses
 , nscStatusBar
 , Controls
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
 TStatusBarWordsResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TStatusBarWordsResNameGetter
 
 TkwStatusBarOrderedControl = class(TtfwClassLike)
  {* Слово скрипта StatusBar:OrderedControl
*Тип результата:* TControl
*Пример:*
[code]
OBJECT VAR l_TControl
 anIndex aStatusBar StatusBar:OrderedControl >>> l_TControl
[code]  }
  function OrderedControl(const aCtx: TtfwContext;
   aStatusBar: TnscStatusBar;
   anIndex: Integer): TControl;
   {* Реализация слова скрипта StatusBar:OrderedControl }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStatusBarOrderedControl
 
 TkwStatusBarOrderedControlsCount = class(TtfwClassLike)
  {* Слово скрипта StatusBar:OrderedControlsCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aStatusBar StatusBar:OrderedControlsCount >>> l_Integer
[code]  }
  function OrderedControlsCount(const aCtx: TtfwContext;
   aStatusBar: TnscStatusBar): Integer;
   {* Реализация слова скрипта StatusBar:OrderedControlsCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStatusBarOrderedControlsCount
 
 TkwStatusBarOrderIndex = class(TtfwClassLike)
  {* Слово скрипта StatusBar:OrderIndex
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl aStatusBar StatusBar:OrderIndex >>> l_Integer
[code]  }
  function OrderIndex(const aCtx: TtfwContext;
   aStatusBar: TnscStatusBar;
   aControl: TControl): Integer;
   {* Реализация слова скрипта StatusBar:OrderIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStatusBarOrderIndex
 
end.
