unit afwSettingsImplSing;

interface

uses
 l3IntfUses
 , afwSettingsImplPersistent
;

type
 TafwSettingsImplSing = class(TafwSettingsImplPersistent)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TafwSettingsImplSing
 
implementation

uses
 l3ImplUses
;

end.
