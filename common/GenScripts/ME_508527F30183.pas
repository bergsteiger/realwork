unit tfwControlString;

interface

uses
 l3IntfUses
 , tfwString
;

type
 TtfwControlString = class(TtfwString)
  {* Слово для регистрации контрола и его класса }
  procedure Register(const aName: AnsiString;
   aClass: TClass);
 end;//TtfwControlString
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3Except
 , tfwClassRef
 , SysUtils
 , StrUtils
;

end.
