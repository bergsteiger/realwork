unit tfwCStringArraySing2;

interface

uses
 l3IntfUses
 , tfwCStringArray
;

type
 TtfwCStringArraySing2 = class(TtfwCStringArray)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TtfwCStringArraySing2
 
implementation

uses
 l3ImplUses
;

end.
