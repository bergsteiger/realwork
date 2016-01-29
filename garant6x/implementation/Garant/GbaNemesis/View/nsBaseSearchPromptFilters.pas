unit nsBaseSearchPromptFilters;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsBaseSearchPromptFilters.pas"
// Начат: 2008/06/25 08:04:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::BaseSearch::TnsBaseSearchPromptFilters
//
// Коллеги, это что?
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  l3TreeFilters,
  BaseSearchInterfaces,
  l3TreeInterfaces
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TnsBaseSearchPromptFilters = class(Tl3TreeFilters, InsBaseSearchPromptFilters)
  {* Коллеги, это что? }
 private
 // private fields
   f_PromptForDoc : InsPromptForDocFilter;
   f_Leaf : InsCutToLeafFilter;
 protected
 // realized methods
   function pm_GetLeaf: InsCutToLeafFilter;
   function SetLeaf(const aFilter: InsCutToLeafFilter): InsBaseSearchPromptFilters;
   function Get_ForDoc: InsPromptForDocFilter;
   function SetPromptForDoc(const aFilter: InsPromptForDocFilter): InsBaseSearchPromptFilters;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   constructor Create(const aSource: Il3TreeFilters); override;
 end;//TnsBaseSearchPromptFilters
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  nsCutToLeafFilter,
  SysUtils,
  nsPromptForDocFilter
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class TnsBaseSearchPromptFilters

function TnsBaseSearchPromptFilters.pm_GetLeaf: InsCutToLeafFilter;
//#UC START# *4901F76E0360_4901FC9F0096get_var*
//#UC END# *4901F76E0360_4901FC9F0096get_var*
begin
//#UC START# *4901F76E0360_4901FC9F0096get_impl*
 Result := f_Leaf;
//#UC END# *4901F76E0360_4901FC9F0096get_impl*
end;//TnsBaseSearchPromptFilters.pm_GetLeaf

function TnsBaseSearchPromptFilters.SetLeaf(const aFilter: InsCutToLeafFilter): InsBaseSearchPromptFilters;
//#UC START# *4901F789034B_4901FC9F0096_var*
//#UC END# *4901F789034B_4901FC9F0096_var*
begin
//#UC START# *4901F789034B_4901FC9F0096_impl*
 f_Leaf := aFilter;
 Result := Self;
//#UC END# *4901F789034B_4901FC9F0096_impl*
end;//TnsBaseSearchPromptFilters.SetLeaf

function TnsBaseSearchPromptFilters.Get_ForDoc: InsPromptForDocFilter;
//#UC START# *4AA4D5710363_4901FC9F0096get_var*
//#UC END# *4AA4D5710363_4901FC9F0096get_var*
begin
//#UC START# *4AA4D5710363_4901FC9F0096get_impl*
 Result := f_PromptForDoc;
//#UC END# *4AA4D5710363_4901FC9F0096get_impl*
end;//TnsBaseSearchPromptFilters.Get_ForDoc

function TnsBaseSearchPromptFilters.SetPromptForDoc(const aFilter: InsPromptForDocFilter): InsBaseSearchPromptFilters;
//#UC START# *4AA4D7930085_4901FC9F0096_var*
//#UC END# *4AA4D7930085_4901FC9F0096_var*
begin
//#UC START# *4AA4D7930085_4901FC9F0096_impl*
 f_PromptForDoc := aFilter;
 Result := Self;
//#UC END# *4AA4D7930085_4901FC9F0096_impl*
end;//TnsBaseSearchPromptFilters.SetPromptForDoc

procedure TnsBaseSearchPromptFilters.Cleanup;
//#UC START# *479731C50290_4901FC9F0096_var*
//#UC END# *479731C50290_4901FC9F0096_var*
begin
//#UC START# *479731C50290_4901FC9F0096_impl*
 f_Leaf := nil;
 f_PromptForDoc := nil;
 inherited;
//#UC END# *479731C50290_4901FC9F0096_impl*
end;//TnsBaseSearchPromptFilters.Cleanup

constructor TnsBaseSearchPromptFilters.Create(const aSource: Il3TreeFilters);
//#UC START# *48FF4F47010F_4901FC9F0096_var*
var
 l_Filter: InsBaseSearchPromptFilters;
//#UC END# *48FF4F47010F_4901FC9F0096_var*
begin
//#UC START# *48FF4F47010F_4901FC9F0096_impl*
 inherited Create(aSource);
 if Supports(aSource, InsBaseSearchPromptFilters, l_Filter) then
 begin
  if Assigned(l_Filter.Leaf) then
   f_Leaf := TnsCutToLeafFilter.Make(l_Filter.Leaf.LeafCount);
  if Assigned(l_Filter.ForDoc) then
   f_PromptForDoc := TnsPromptForDocFilter.Make(l_Filter.ForDoc.InternalDocNumber);
 end;
//#UC END# *48FF4F47010F_4901FC9F0096_impl*
end;//TnsBaseSearchPromptFilters.Create

{$IfEnd} //not Admin

end.