unit dsTips;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DayTips"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/DayTips/dsTips.pas"
// Начат: 2008/02/20 13:01:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Интерфейсные элементы::DayTips::DayTips::DayTips::TdsTips
//
// Список советов дня
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentInterfaces,
  DocumentUnit,
  DynamicTreeUnit,
  l3TreeInterfaces
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  DocumentAndListInterfaces,
  CommonDictionInterfaces,
  l3InternalInterfaces,
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
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsCommonDiction;
 _InitDataType_ = IdeDocInfo;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dsCommonDiction.imp.pas}
 TdsTips = {final vac} class(_dsCommonDiction_)
  {* Список советов дня }
 protected
 // realized methods
   function MakeSimpleTree: Il3SimpleTree; override;
     {* Создать данные дерева }
   function MakeDocInfoForCurrentChanged(const aDoc: IDocument): IdeDocInfo; override;
   function pm_GetDictionKind: TnsDictionKind; override;
 end;//TdsTips
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  deTips,
  nsTipsTree,
  BaseTypesUnit,
  SysUtils,
  l3Base,
  vtUtils,
  vtStdRes,
  nsNewCachableNode,
  Windows,
  l3InterfacesMisc
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsTips;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dsCommonDiction.imp.pas}

// start class TdsTips

function TdsTips.MakeSimpleTree: Il3SimpleTree;
//#UC START# *47F4C2B9014A_49254BC1019C_var*
//#UC END# *47F4C2B9014A_49254BC1019C_var*
begin
//#UC START# *47F4C2B9014A_49254BC1019C_impl*
 Result := TnsTipsTree.Make;
//#UC END# *47F4C2B9014A_49254BC1019C_impl*
end;//TdsTips.MakeSimpleTree

function TdsTips.MakeDocInfoForCurrentChanged(const aDoc: IDocument): IdeDocInfo;
//#UC START# *49254515003C_49254BC1019C_var*
//#UC END# *49254515003C_49254BC1019C_var*
begin
//#UC START# *49254515003C_49254BC1019C_impl*
 Result := TdeTips.Make(aDoc);
//#UC END# *49254515003C_49254BC1019C_impl*
end;//TdsTips.MakeDocInfoForCurrentChanged

function TdsTips.pm_GetDictionKind: TnsDictionKind;
//#UC START# *5571EB84007F_49254BC1019Cget_var*
//#UC END# *5571EB84007F_49254BC1019Cget_var*
begin
//#UC START# *5571EB84007F_49254BC1019Cget_impl*
 Result := ns_dkDayTips;
//#UC END# *5571EB84007F_49254BC1019Cget_impl*
end;//TdsTips.pm_GetDictionKind

{$IfEnd} //not Admin AND not Monitorings

end.