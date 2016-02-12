unit dsMedicDiction;
 {* Список медицинских терминов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\dsMedicDiction.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentInterfaces
 , l3TreeInterfaces
 , CommonDictionInterfaces
 , DocumentUnit
 , DynamicTreeUnit
 , DocumentAndListInterfaces
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , l3Interfaces
 , TreeInterfaces
 , bsInterfaces
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
;

type
 _InitDataType_ = IdeDocInfo;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dsCommonDiction.imp.pas}
 TdsMedicDiction = {final} class(_dsCommonDiction_)
  {* Список медицинских терминов }
  protected
   function MakeSimpleTree: Il3SimpleTree; override;
    {* Создать данные дерева }
   function MakeDocInfoForCurrentChanged(const aDoc: IDocument): IdeDocInfo; override;
   function pm_GetDictionKind: TnsDictionKind; override;
   {$If NOT Defined(NoVCM)}
   function GetIsDataAvailable: Boolean; override;
    {* существуют ли данные }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdsMedicDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , deMedicDiction
 , nsMedicDictionTree
 , DataAdapter
 , BaseTypesUnit
 , SysUtils
 , l3Base
 , vtUtils
 , vtStdRes
 , nsNewCachableNode
 , Windows
 , l3InterfacesMisc
;

{$If not Declared(_UseCaseControllerType_)}type _UseCaseControllerType_ = IvcmFormSetDataSource;{$IfEnd}

type _Instance_R_ = TdsMedicDiction;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dsCommonDiction.imp.pas}

function TdsMedicDiction.MakeSimpleTree: Il3SimpleTree;
 {* Создать данные дерева }
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

{$If NOT Defined(NoVCM)}
function TdsMedicDiction.GetIsDataAvailable: Boolean;
 {* существуют ли данные }
//#UC START# *55097FF5008E_4925595900C8_var*
//#UC END# *55097FF5008E_4925595900C8_var*
begin
//#UC START# *55097FF5008E_4925595900C8_impl*
 Result := DefDataAdapter.IsInpharmExists;
//#UC END# *55097FF5008E_4925595900C8_impl*
end;//TdsMedicDiction.GetIsDataAvailable
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
