unit msmMultiPanelViewParentVert;

// Модуль: "w:\common\components\gui\Garant\msm\msmMultiPanelViewParentVert.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmMultiPanelViewParentVert" MUID: (57EA4EF3035E)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmMultiPanelViewParent
;

type
 TmsmMultiPanelViewParentVert = class(TmsmMultiPanelViewParent)
  protected
   function IsVert: Boolean; override;
 end;//TmsmMultiPanelViewParentVert

implementation

uses
 l3ImplUses
 //#UC START# *57EA4EF3035Eimpl_uses*
 //#UC END# *57EA4EF3035Eimpl_uses*
;

function TmsmMultiPanelViewParentVert.IsVert: Boolean;
//#UC START# *57EA4F0302FD_57EA4EF3035E_var*
//#UC END# *57EA4F0302FD_57EA4EF3035E_var*
begin
//#UC START# *57EA4F0302FD_57EA4EF3035E_impl*
 Result := true;
//#UC END# *57EA4F0302FD_57EA4EF3035E_impl*
end;//TmsmMultiPanelViewParentVert.IsVert

end.
