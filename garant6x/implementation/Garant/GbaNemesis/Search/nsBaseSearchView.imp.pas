{$IfNDef nsBaseSearchView_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsBaseSearchView.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nsBaseSearchView" MUID: (56F240F40312)
// Имя типа: "_nsBaseSearchView_"

{$Define nsBaseSearchView_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _nsBaseSearchView_ = class(InsBaseSearchView)
  private
   f_BaseSearchController: Pointer;
  protected
   procedure DoOnBaseSearchModelChanged(const aModel: InsBaseSearchModel); virtual;
    {* Вызывается при изменении данных модели }
   procedure DoOnControllerSet(const aController: InsBaseSearchController); virtual;
    {* Вызывается при присвоении контроллера базового поиска }
   procedure NotifyBaseSearchModelChanged(const aModel: InsBaseSearchModel);
   function pm_GetBaseSearchController: InsBaseSearchController;
   procedure pm_SetBaseSearchController(const aValue: InsBaseSearchController);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
 end;//_nsBaseSearchView_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_nsBaseSearchView_ = ;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else nsBaseSearchView_imp}

{$IfNDef nsBaseSearchView_imp_impl}

{$Define nsBaseSearchView_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
procedure _nsBaseSearchView_.DoOnBaseSearchModelChanged(const aModel: InsBaseSearchModel);
 {* Вызывается при изменении данных модели }
//#UC START# *56F24196035F_56F240F40312_var*
//#UC END# *56F24196035F_56F240F40312_var*
begin
//#UC START# *56F24196035F_56F240F40312_impl*
 !!! Needs to be implemented !!!
//#UC END# *56F24196035F_56F240F40312_impl*
end;//_nsBaseSearchView_.DoOnBaseSearchModelChanged

procedure _nsBaseSearchView_.DoOnControllerSet(const aController: InsBaseSearchController);
 {* Вызывается при присвоении контроллера базового поиска }
//#UC START# *56F241BB031B_56F240F40312_var*
//#UC END# *56F241BB031B_56F240F40312_var*
begin
//#UC START# *56F241BB031B_56F240F40312_impl*
 !!! Needs to be implemented !!!
//#UC END# *56F241BB031B_56F240F40312_impl*
end;//_nsBaseSearchView_.DoOnControllerSet

procedure _nsBaseSearchView_.NotifyBaseSearchModelChanged(const aModel: InsBaseSearchModel);
//#UC START# *56D4305A00EA_56F240F40312_var*
//#UC END# *56D4305A00EA_56F240F40312_var*
begin
//#UC START# *56D4305A00EA_56F240F40312_impl*
 !!! Needs to be implemented !!!
//#UC END# *56D4305A00EA_56F240F40312_impl*
end;//_nsBaseSearchView_.NotifyBaseSearchModelChanged

function _nsBaseSearchView_.pm_GetBaseSearchController: InsBaseSearchController;
//#UC START# *56EBA1AA03CC_56F240F40312get_var*
//#UC END# *56EBA1AA03CC_56F240F40312get_var*
begin
//#UC START# *56EBA1AA03CC_56F240F40312get_impl*
 !!! Needs to be implemented !!!
//#UC END# *56EBA1AA03CC_56F240F40312get_impl*
end;//_nsBaseSearchView_.pm_GetBaseSearchController

procedure _nsBaseSearchView_.pm_SetBaseSearchController(const aValue: InsBaseSearchController);
//#UC START# *56EBA1AA03CC_56F240F40312set_var*
//#UC END# *56EBA1AA03CC_56F240F40312set_var*
begin
//#UC START# *56EBA1AA03CC_56F240F40312set_impl*
 !!! Needs to be implemented !!!
//#UC END# *56EBA1AA03CC_56F240F40312set_impl*
end;//_nsBaseSearchView_.pm_SetBaseSearchController

procedure _nsBaseSearchView_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56F240F40312_var*
//#UC END# *479731C50290_56F240F40312_var*
begin
//#UC START# *479731C50290_56F240F40312_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_56F240F40312_impl*
end;//_nsBaseSearchView_.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf nsBaseSearchView_imp_impl}

{$EndIf nsBaseSearchView_imp}

