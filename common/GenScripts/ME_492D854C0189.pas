unit dsBaseContents;
 {* ������� ���������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseContents.pas"
// ���������: "ViewAreaControllerImp"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , l3TreeInterfaces
 , DocumentInterfaces
 , DocumentUnit
 , F1TagDataProviderInterface
 , nsTypesNew
 , l3InternalInterfaces
 , TreeInterfaces
 , bsInterfaces
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
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
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
;

type
 _FormDataSourceType_ = IdsBaseContents;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseContents.imp.pas}
 TdsBaseContents = class(_dsBaseContents_)
  {* ������� ���������� }
  protected
   function MakeSimpleTree: Il3SimpleTree; override;
    {* ������� ������ ������ }
 end;//TdsBaseContents
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , vtUtils
 , DocumentRes
 , l3String
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , dsBaseContentsRes
 , SysUtils
 , l3Base
 , vtStdRes
 , DynamicTreeUnit
 , nsNewCachableNode
 , Windows
 , l3InterfacesMisc
 {$If Defined(Nemesis)}
 , nscContextFilterState
 {$IfEnd} // Defined(Nemesis)
;

type _Instance_R_ = TdsBaseContents;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseContents.imp.pas}

function TdsBaseContents.MakeSimpleTree: Il3SimpleTree;
 {* ������� ������ ������ }
//#UC START# *47F4C2B9014A_492D854C0189_var*
//#UC END# *47F4C2B9014A_492D854C0189_var*
begin
//#UC START# *47F4C2B9014A_492D854C0189_impl*
  Result := nil;

  // ��������� Assert, ��:
  // http://mdp.garant.ru/pages/viewpage.action?pageId=303858407
  // http://mdp.garant.ru/pages/viewpage.action?pageId=297704301

  // Assert(false);

  // �� ������� ���� ��� ����������, ��. ������:
  // http://mdp.garant.ru/pages/viewpage.action?pageId=320742140

// ���� ������ ����, �� ������ http://mdp.garant.ru/pages/viewpage.action?pageId=135605187
//#UC END# *47F4C2B9014A_492D854C0189_impl*
end;//TdsBaseContents.MakeSimpleTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
