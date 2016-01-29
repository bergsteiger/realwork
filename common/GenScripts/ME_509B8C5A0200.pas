unit kwSetFontSize;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwSetFontSize = class(TtfwRegisterableWord)
  {* Устанавливает размер шрифта для стиля "Нормальный". }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSetFontSize
 
implementation

uses
 l3ImplUses
 , evStyleInterface
 , SysUtils
;

end.
