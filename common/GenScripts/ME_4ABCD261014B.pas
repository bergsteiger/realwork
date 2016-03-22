unit FoldersInfo_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\FoldersInfo_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "FoldersInfo" MUID: (4ABCD261014B)
// ��� ����: "TcfFoldersInfo"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFoldersInfoOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_cfFoldersInfo: TvcmFormDescriptor = (rFormID : (rName : 'cfFoldersInfo'; rID : 0); rFactory : nil);
  {* ������������� ����� TcfFoldersInfo }

type
 FoldersInfoFormDef = interface
  {* ������������� ����� FoldersInfo }
  ['{A7FC5777-8418-45E1-9EE1-511BCC3B18B5}']
 end;//FoldersInfoFormDef

 TcfFoldersInfo = {final} class(TPrimFoldersInfoOptionsForm, FoldersInfoFormDef)
 end;//TcfFoldersInfo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , FoldersInfoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TcfFoldersInfo);
 {* ����������� FoldersInfo }
{$IfEnd} // NOT Defined(NoScripts)
 fm_cfFoldersInfo.SetFactory(TcfFoldersInfo.Make);
 {* ����������� ������� ����� FoldersInfo }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
