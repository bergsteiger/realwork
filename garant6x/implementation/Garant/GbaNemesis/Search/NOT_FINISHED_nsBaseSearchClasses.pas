unit NOT_FINISHED_nsBaseSearchClasses;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search$Lib"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/NOT_FINISHED_nsBaseSearchClasses.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::Search$Lib::BaseSearch::TnsBaseSearchClasses
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  BaseSearchInterfaces,
  DynamicTreeUnit,
  l3Interfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsBaseSearchClass = class(, InsBaseSearchClass)
 protected
 // realized methods
   function pm_GetAdapterNode: INodeBase;
   function pm_GetName: Il3CString;
   function IsSame(const aAnother: InsBaseSearchClass): Boolean;
 end;//TnsBaseSearchClass

 TnsBaseSearchClasses = class
 end;//TnsBaseSearchClasses
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsBaseSearchClassList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type
  TnsBaseSearchClassesEnumerator = class(, InsBaseSearchClassesEnumerator)
  protected
  // realized methods
   function pm_GetCurrent: InsBaseSearchClass;
   procedure Reset;
   function MoveNext: Boolean;
  end;//TnsBaseSearchClassesEnumerator

// start class TnsBaseSearchClassesEnumerator

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
// start class TnsBaseSearchClass

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

{$IfEnd} //not Admin AND not Monitorings

end.