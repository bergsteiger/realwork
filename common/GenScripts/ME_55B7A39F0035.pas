unit tfwAxiomaticsResNameGetters;

interface

uses
 l3IntfUses
 , tfwAxiomaticsResNameGetterList
;

type
 TtfwAxiomaticsResNameGetters = class(TtfwAxiomaticsResNameGetterList)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TtfwAxiomaticsResNameGetters
 
implementation

uses
 l3ImplUses
;

end.
