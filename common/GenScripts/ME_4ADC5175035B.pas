unit nsWindowsList;

interface

uses
 l3IntfUses
 , nsWindowsListPrim
;

type
 TnsWindowsList = class(TnsWindowsListPrim)
  {* класс управл€ющий списком окон }
  function Exists: Boolean;
   {* ѕровер€ет создан экземпл€р синглетона или нет }
 end;//TnsWindowsList
 
implementation

uses
 l3ImplUses
;

end.
