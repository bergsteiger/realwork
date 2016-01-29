unit dt_User;

interface

uses
 l3IntfUses
;

type
 TUserManager = class
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TUserManager
 
implementation

uses
 l3ImplUses
;

end.
