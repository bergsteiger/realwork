unit msmMultiPanelViewParentHorz;

// Модуль: "w:\common\components\gui\Garant\msm\msmMultiPanelViewParentHorz.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmMultiPanelViewParentHorz" MUID: (57EA4EE80184)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmMultiPanelViewParent
;

type
 TmsmMultiPanelViewParentHorz = class(TmsmMultiPanelViewParent)
  protected
   function IsVert: Boolean; override;
 end;//TmsmMultiPanelViewParentHorz

implementation

uses
 l3ImplUses
 //#UC START# *57EA4EE80184impl_uses*
 //#UC END# *57EA4EE80184impl_uses*
;

function TmsmMultiPanelViewParentHorz.IsVert: Boolean;
//#UC START# *57EA4F0302FD_57EA4EE80184_var*
//#UC END# *57EA4F0302FD_57EA4EE80184_var*
begin
//#UC START# *57EA4F0302FD_57EA4EE80184_impl*
 Result := false;
//#UC END# *57EA4F0302FD_57EA4EE80184_impl*
end;//TmsmMultiPanelViewParentHorz.IsVert

end.
