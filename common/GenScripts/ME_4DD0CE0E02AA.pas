unit tfwSysUtilsWord;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
;

type
 TtfwSysUtilsWord = class(TtfwRegisterableWord)
  {* Поддержка слов из SysUtils }
 end;//TtfwSysUtilsWord
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Base
;

end.
