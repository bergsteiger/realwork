unit kwGetFontSize;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwGetFontSize = class(TtfwRegisterableWord)
  {* Возвращает установленный размер шрифта для стиля "Нормальный". }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGetFontSize
 
implementation

uses
 l3ImplUses
 , evStyleInterface
 , SysUtils
;

end.
