unit Folders_Form;
 {* ��� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\Folders_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFoldersOptions_Form
 , Common_FormDefinitions_Controls
;

type
 TcfFolders = {final} class(TPrimFoldersOptionsForm, FoldersFormDef)
  {* ��� ��������� }
 end;//TcfFolders
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , FoldersKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TcfFolders);
 {* ����������� Folders }
{$IfEnd} // NOT Defined(NoScripts)
 fm_cfFolders.SetFactory(TcfFolders.Make);
 {* ����������� ������� ����� Folders }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
