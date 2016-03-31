unit NOT_COMPLETED_evLocation;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evLocation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevLocation" MUID: (4A3A5B9F0064)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evLocationBase
 , nevTools
;

type
 TevLocation = class(TevLocationBase, InevText)
  protected
   function CanBeDeleted: Boolean;
   function Modify: InevTextModify;
   function GetText: InevText; override;
 end;//TevLocation
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
;

function TevLocation.CanBeDeleted: Boolean;
//#UC START# *47C5B23101DE_4A3A5B9F0064_var*
//#UC END# *47C5B23101DE_4A3A5B9F0064_var*
begin
//#UC START# *47C5B23101DE_4A3A5B9F0064_impl*
 Result := GetCanBeDeleted;
//#UC END# *47C5B23101DE_4A3A5B9F0064_impl*
end;//TevLocation.CanBeDeleted

function TevLocation.Modify: InevTextModify;
//#UC START# *47C5B23D0301_4A3A5B9F0064_var*
//#UC END# *47C5B23D0301_4A3A5B9F0064_var*
begin
//#UC START# *47C5B23D0301_4A3A5B9F0064_impl*
 Result := Self;
//#UC END# *47C5B23D0301_4A3A5B9F0064_impl*
end;//TevLocation.Modify

function TevLocation.GetText: InevText;
//#UC START# *4A3A69AC006F_4A3A5B9F0064_var*
//#UC END# *4A3A69AC006F_4A3A5B9F0064_var*
begin
//#UC START# *4A3A69AC006F_4A3A5B9F0064_impl*
 Result := Self;
//#UC END# *4A3A69AC006F_4A3A5B9F0064_impl*
end;//TevLocation.GetText
{$IfEnd} // Defined(evUseVisibleCursors)

end.
