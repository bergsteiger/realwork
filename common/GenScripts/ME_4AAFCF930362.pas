unit Picture_Form;
 {* ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Picture_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimPictureOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_PictureForm: TvcmFormDescriptor = (rFormID : (rName : 'PictureForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TPictureForm }

type
 PictureFormDef = interface
  {* ������������� ����� Picture }
  ['{9794D84D-10DE-4BC6-A05D-F4C88FBEEBC7}']
 end;//PictureFormDef

 //#UC START# *4AAFCF930362ci*
 //#UC END# *4AAFCF930362ci*
 //#UC START# *4AAFCF930362cit*
 //#UC END# *4AAFCF930362cit*
 TPictureForm = {final} class(TPrimPictureOptionsForm, PictureFormDef)
  {* ������� }
 //#UC START# *4AAFCF930362publ*
  published
   property Scale;
 //#UC END# *4AAFCF930362publ*
 end;//TPictureForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , PictureKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

//#UC START# *4AAFCF930362impl*
//#UC END# *4AAFCF930362impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPictureForm);
 {* ����������� Picture }
{$IfEnd} // NOT Defined(NoScripts)
 fm_PictureForm.SetFactory(TPictureForm.Make);
 {* ����������� ������� ����� Picture }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
