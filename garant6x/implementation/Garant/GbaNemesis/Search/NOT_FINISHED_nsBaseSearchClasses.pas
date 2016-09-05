unit NOT_FINISHED_nsBaseSearchClasses;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\NOT_FINISHED_nsBaseSearchClasses.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsBaseSearchClasses" MUID: (5625F9E3015F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseSearchInterfaces
 , DynamicTreeUnit
 , l3Interfaces
;

type
 TnsBaseSearchClass = class(InsBaseSearchClass)
  protected
   function pm_GetAdapterNode: INodeBase;
   function pm_GetName: Il3CString;
   function IsSame(const aAnother: InsBaseSearchClass): Boolean;
 end;//TnsBaseSearchClass

 TnsBaseSearchClasses = class
 end;//TnsBaseSearchClasses
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsBaseSearchClassList
 //#UC START# *5625F9E3015Fimpl_uses*
 //#UC END# *5625F9E3015Fimpl_uses*
;

type
 TnsBaseSearchClassesEnumerator = class(InsBaseSearchClassesEnumerator)
  protected
   function pm_GetCurrent: InsBaseSearchClass;
   procedure Reset;
   function MoveNext: Boolean;
 end;//TnsBaseSearchClassesEnumerator

function TnsBaseSearchClassesEnumerator.pm_GetCurrent: InsBaseSearchClass;
//#UC START# *5625E74C0183_5625FA270228get_var*
//#UC END# *5625E74C0183_5625FA270228get_var*
begin
//#UC START# *5625E74C0183_5625FA270228get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5625E74C0183_5625FA270228get_impl*
end;//TnsBaseSearchClassesEnumerator.pm_GetCurrent

procedure TnsBaseSearchClassesEnumerator.Reset;
//#UC START# *5625E75802C9_5625FA270228_var*
//#UC END# *5625E75802C9_5625FA270228_var*
begin
//#UC START# *5625E75802C9_5625FA270228_impl*
 !!! Needs to be implemented !!!
//#UC END# *5625E75802C9_5625FA270228_impl*
end;//TnsBaseSearchClassesEnumerator.Reset

function TnsBaseSearchClassesEnumerator.MoveNext: Boolean;
//#UC START# *56273B63001B_5625FA270228_var*
//#UC END# *56273B63001B_5625FA270228_var*
begin
//#UC START# *56273B63001B_5625FA270228_impl*
 !!! Needs to be implemented !!!
//#UC END# *56273B63001B_5625FA270228_impl*
end;//TnsBaseSearchClassesEnumerator.MoveNext

function TnsBaseSearchClass.pm_GetAdapterNode: INodeBase;
//#UC START# *5626252201EE_5625F9F90025get_var*
//#UC END# *5626252201EE_5625F9F90025get_var*
begin
//#UC START# *5626252201EE_5625F9F90025get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5626252201EE_5625F9F90025get_impl*
end;//TnsBaseSearchClass.pm_GetAdapterNode

function TnsBaseSearchClass.pm_GetName: Il3CString;
//#UC START# *5626254502B1_5625F9F90025get_var*
//#UC END# *5626254502B1_5625F9F90025get_var*
begin
//#UC START# *5626254502B1_5625F9F90025get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5626254502B1_5625F9F90025get_impl*
end;//TnsBaseSearchClass.pm_GetName

function TnsBaseSearchClass.IsSame(const aAnother: InsBaseSearchClass): Boolean;
//#UC START# *56262560021F_5625F9F90025_var*
//#UC END# *56262560021F_5625F9F90025_var*
begin
//#UC START# *56262560021F_5625F9F90025_impl*
 !!! Needs to be implemented !!!
//#UC END# *56262560021F_5625F9F90025_impl*
end;//TnsBaseSearchClass.IsSame
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
