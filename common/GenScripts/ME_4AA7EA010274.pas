unit NOT_COMPLETED_MainWindow_Form;
 {* ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_COMPLETED_MainWindow_Form.pas"
// ���������: "VCMFinalMainForm"
// ������� ������: "MainWindow" MUID: (4AA7EA010274)
// ��� ����: "TnsMainWindow"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MainWithReminders_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_nsMainWindow: TvcmFormDescriptor = (rFormID : (rName : 'nsMainWindow'; rID : 0); rFactory : nil);
  {* ������������� ����� TnsMainWindow }

type
 TnsMainWindow = class;

 MainWindowFormDef = interface
  {* ������������� ����� MainWindow }
  ['{A88F9772-00AF-401E-BACE-E6A02B415485}']
 end;//MainWindowFormDef

 TnsMainWindow = {final} class(TMainWithRemindersForm, MainWindowFormDef)
  {* ������ }
   Entities : TvcmEntities;
 end;//TnsMainWindow
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsBaseSearcher
 , L10nInterfaces
 {$If NOT Defined(NoVCM)}
 , nsWindowsList
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , MainWindowKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnsMainWindow);
 {* ����������� MainWindow }
{$IfEnd} // NOT Defined(NoScripts)
 fm_nsMainWindow.SetFactory(TnsMainWindow.Make);
 {* ����������� ������� ����� MainWindow }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
