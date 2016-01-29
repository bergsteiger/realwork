unit kwDEFAULT;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwDEFAULT = class(TtfwRegisterableWord)
  {* Внутреннее слово для определения ветки по умолчанию в скомпилированном Case. Не предназначено для прямого вызова. }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDEFAULT
 
implementation

uses
 l3ImplUses
;

end.
