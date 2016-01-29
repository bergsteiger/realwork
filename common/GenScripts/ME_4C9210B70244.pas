unit Navigator.imp;

interface

uses
 l3IntfUses
 , evCustomEditorWindow
 , l3Variant
;

type
 _Navigator_ = class
  procedure Navigate(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
   {* Устанавливает курсор или выделение }
 end;//_Navigator_
 
implementation

uses
 l3ImplUses
;

end.
