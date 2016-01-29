unit VarWorkingPack;

interface

uses
 l3IntfUses
 , tfwTypeInfo
 , tfwConst
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
;

type
 TkwCONST = class(TtfwConst)
  {* Определяет константу.
Пример:
[code]
 CONST cFake1 5
[code] }
 end;//TkwCONST
 
end.
