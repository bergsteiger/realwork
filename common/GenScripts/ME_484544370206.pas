unit evEditor;

interface

uses
 l3IntfUses
 , evTunedEditor
;

type
 TevEditor = class(TevTunedEditor)
  {* Полноценный компонент-редактор. Для конечного пользователя (программиста). }
 end;//TevEditor
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
