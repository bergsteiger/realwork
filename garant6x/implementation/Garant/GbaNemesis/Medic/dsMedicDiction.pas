unit dsMedicDiction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/dsMedicDiction.pas"
// Начат: 2008/03/06 10:02:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic::TdsMedicDiction
//
// Список медицинских терминов
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
 TdsMedicDiction = {final vac} class(_dsCommonDiction_)
  {* Список медицинских терминов }
 protected
 // realized methods
   function MakeSimpleTree: Il3SimpleTree; override;
     {* Создать данные дерева }
   function MakeDocInfoForCurrentChanged(const aDoc: IDocument): IdeDocInfo; override;
   function pm_GetDictionKind: TnsDictionKind; override;
 protected
 // overridden protected methods
    {$If not defined(NoVCM)}
   function GetIsDataAvailable: Boolean; override;
     {* существуют ли данные }
    {$IfEnd} //not NoVCM
 end;//TdsMedicDiction
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  deMedicDiction,
  nsMedicDictionTree,
  DataAdapter,
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

type _Instance_R_ = TdsMedicDiction;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dsCommonDiction.imp.pas}

// start class TdsMedicDiction

function TdsMedicDiction.MakeSimpleTree: Il3SimpleTree;
//#UC START# *47F4C2B9014A_4925595900C8_var*
//#UC END# *47F4C2B9014A_4925595900C8_var*
begin
//#UC START# *47F4C2B9014A_4925595900C8_impl*
 Result := TnsMedicDictionTree.Make;
//#UC END# *47F4C2B9014A_4925595900C8_impl*
end;//TdsMedicDiction.MakeSimpleTree

function TdsMedicDiction.MakeDocInfoForCurrentChanged(const aDoc: IDocument): IdeDocInfo;
//#UC START# *49254515003C_4925595900C8_var*
//#UC END# *49254515003C_4925595900C8_var*
begin
//#UC START# *49254515003C_4925595900C8_impl*
 Result := TdeMedicDiction.Make(aDoc);
//#UC END# *49254515003C_4925595900C8_impl*
end;//TdsMedicDiction.MakeDocInfoForCurrentChanged

function TdsMedicDiction.pm_GetDictionKind: TnsDictionKind;
//#UC START# *5571EB84007F_4925595900C8get_var*
//#UC END# *5571EB84007F_4925595900C8get_var*
begin
//#UC START# *5571EB84007F_4925595900C8get_impl*
 Result := ns_dkMedic; 
//#UC END# *5571EB84007F_4925595900C8get_impl*
end;//TdsMedicDiction.pm_GetDictionKind

{$If not defined(NoVCM)}
function TdsMedicDiction.GetIsDataAvailable: Boolean;
//#UC START# *55097FF5008E_4925595900C8_var*
//#UC END# *55097FF5008E_4925595900C8_var*
begin
//#UC START# *55097FF5008E_4925595900C8_impl*
 Result := DefDataAdapter.IsInpharmExists;
//#UC END# *55097FF5008E_4925595900C8_impl*
end;//TdsMedicDiction.GetIsDataAvailable
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.