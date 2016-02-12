unit dsTips;
 {* Список советов дня }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\DayTips\dsTips.pas"
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
 TdsTips = {final} class(_dsCommonDiction_)
  {* Список советов дня }
  protected
   function MakeSimpleTree: Il3SimpleTree; override;
    {* Создать данные дерева }
   function MakeDocInfoForCurrentChanged(const aDoc: IDocument): IdeDocInfo; override;
   function pm_GetDictionKind: TnsDictionKind; override;
 end;//TdsTips
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , deTips
 , nsTipsTree
 , BaseTypesUnit
 , SysUtils
 , l3Base
 , vtUtils
 , vtStdRes
 , nsNewCachableNode
 , Windows
 , l3InterfacesMisc
;

type _Instance_R_ = TdsTips;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dsCommonDiction.imp.pas}

function TdsTips.MakeSimpleTree: Il3SimpleTree;
 {* Создать данные дерева }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
