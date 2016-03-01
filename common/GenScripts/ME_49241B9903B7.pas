unit dsSelectedAttributes;
 {* ������ ������ ����� "��������� �������� ������" }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Search\dsSelectedAttributes.pas"
// ���������: "ViewAreaControllerImp"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , SearchInterfaces
 , l3TreeInterfaces
 , SearchDomainInterfaces
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
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _InitDataType_ = IdeSelectedAttributes;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Search\dsTagSimpleTree.imp.pas}
 TdsSelectedAttributes = {final} class(_dsTagSimpleTree_, IdsSelectedAttributes)
  {* ������ ������ ����� "��������� �������� ������" }
  private
   f_RefreshValues: InsSelectedAttributesIterators;
  protected
   function MakeSimpleTree: Il3SimpleTree; override;
    {* ������� ������ ������ }
   function pm_GetRefreshValues: InsSelectedAttributesIterators;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   {$If NOT Defined(NoVCM)}
   procedure GotData; override;
    {* - ������ ����������. }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdsSelectedAttributes
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , bsUtils
 , l3Base
 , vtUtils
 , vtStdRes
 , DynamicTreeUnit
 , nsNewCachableNode
 , Windows
 , l3InterfacesMisc
;

type _Instance_R_ = TdsSelectedAttributes;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Search\dsTagSimpleTree.imp.pas}

function TdsSelectedAttributes.MakeSimpleTree: Il3SimpleTree;
 {* ������� ������ ������ }
//#UC START# *47F4C2B9014A_49241B9903B7_var*
//#UC END# *47F4C2B9014A_49241B9903B7_var*
begin
//#UC START# *47F4C2B9014A_49241B9903B7_impl*
 Result := nil;
 Assert(false);
 // ���� ������ ����, �� ������ http://mdp.garant.ru/pages/viewpage.action?pageId=135605187
//#UC END# *47F4C2B9014A_49241B9903B7_impl*
end;//TdsSelectedAttributes.MakeSimpleTree

function TdsSelectedAttributes.pm_GetRefreshValues: InsSelectedAttributesIterators;
//#UC START# *49241D5D01C0_49241B9903B7get_var*
//#UC END# *49241D5D01C0_49241B9903B7get_var*
begin
//#UC START# *49241D5D01C0_49241B9903B7get_impl*
 Result := f_RefreshValues;
//#UC END# *49241D5D01C0_49241B9903B7get_impl*
end;//TdsSelectedAttributes.pm_GetRefreshValues

procedure TdsSelectedAttributes.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_49241B9903B7_var*
//#UC END# *479731C50290_49241B9903B7_var*
begin
//#UC START# *479731C50290_49241B9903B7_impl*
 f_RefreshValues := nil;
 inherited;
//#UC END# *479731C50290_49241B9903B7_impl*
end;//TdsSelectedAttributes.Cleanup

{$If NOT Defined(NoVCM)}
procedure TdsSelectedAttributes.GotData;
 {* - ������ ����������. }
//#UC START# *492ACF630072_49241B9903B7_var*
//#UC END# *492ACF630072_49241B9903B7_var*
begin
//#UC START# *492ACF630072_49241B9903B7_impl*
 inherited;
 f_RefreshValues := PartData.RefreshValues;
//#UC END# *492ACF630072_49241B9903B7_impl*
end;//TdsSelectedAttributes.GotData
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin)
end.
