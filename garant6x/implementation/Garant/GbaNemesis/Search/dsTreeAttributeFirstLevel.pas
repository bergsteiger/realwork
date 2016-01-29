unit dsTreeAttributeFirstLevel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/dsTreeAttributeFirstLevel.pas"
// Начат: 2005/07/29 15:27:38
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Common For Shell And Monitoring::Search::Search::Search::TdsTreeAttributeFirstLevel
//
// бизнес объект формы выбранные атрибуты дерева
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
  QueryCardInterfaces,
  SearchInterfaces,
  SearchDomainInterfaces,
  l3InternalInterfaces,
  l3TreeInterfaces,
  bsInterfaces
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  vcmControllers {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 _FormDataSourceType_ = IdsTreeAttributeFirstLevel;
 {$Include ..\Search\dsSituation.imp.pas}
 TdsTreeAttributeFirstLevel = {vac} class(_dsSituation_, IdsTreeAttributeFirstLevel)
  {* бизнес объект формы выбранные атрибуты дерева }
 protected
 // realized methods
   function MakeSimpleTree: Il3SimpleTree; override;
     {* Создать данные дерева }
 end;//TdsTreeAttributeFirstLevel
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  nsAttributeOneLevelTreeStruct,
  SysUtils,
  bsUtils,
  l3Base,
  vtUtils,
  vtStdRes,
  DynamicTreeUnit,
  nsNewCachableNode,
  Windows,
  l3InterfacesMisc
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

type _Instance_R_ = TdsTreeAttributeFirstLevel;

{$Include ..\Search\dsSituation.imp.pas}

// start class TdsTreeAttributeFirstLevel

function TdsTreeAttributeFirstLevel.MakeSimpleTree: Il3SimpleTree;
//#UC START# *47F4C2B9014A_492447740299_var*
//#UC END# *47F4C2B9014A_492447740299_var*
begin
//#UC START# *47F4C2B9014A_492447740299_impl*
 Result := TnsAttributeOneLevelTreeStruct.Make(PartData.Tag, False, True);
//#UC END# *47F4C2B9014A_492447740299_impl*
end;//TdsTreeAttributeFirstLevel.MakeSimpleTree

{$IfEnd} //not Admin

end.