unit npControlsList;

interface

uses
 l3IntfUses
 , npControlsListPrim
;

type
 TnpControlsList = class(TnpControlsListPrim)
  {* список навигаторов на форме, от которых были отстыкованы компоненты. }
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TnpControlsList
 
implementation

uses
 l3ImplUses
;

end.
