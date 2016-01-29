unit tfwRegisteredEnums;

interface

uses
 l3IntfUses
 , tfwRTTITypeInfoList
;

type
 TtfwRegisteredEnums = class(TtfwRTTITypeInfoList)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TtfwRegisteredEnums
 
implementation

uses
 l3ImplUses
;

end.
