unit Picture_Form;
 {* Рисунок }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Picture_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "Picture" MUID: (4AAFCF930362)
// Имя типа: "TPictureForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimPictureOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4AAFCF930362intf_uses*
 //#UC END# *4AAFCF930362intf_uses*
;

const
 fm_PictureForm: TvcmFormDescriptor = (rFormID : (rName : 'PictureForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TPictureForm }

type
 TPictureForm = class;

 PictureFormDef = interface
  {* Идентификатор формы Picture }
  ['{9794D84D-10DE-4BC6-A05D-F4C88FBEEBC7}']
 end;//PictureFormDef

 //#UC START# *4AAFCF930362ci*
 //#UC END# *4AAFCF930362ci*
 //#UC START# *4AAFCF930362cit*
 //#UC END# *4AAFCF930362cit*
 TPictureForm = {final} class(TPrimPictureOptionsForm, PictureFormDef)
  {* Рисунок }
   Entities : TvcmEntities;
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
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , PictureKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 //#UC START# *4AAFCF930362impl_uses*
 //#UC END# *4AAFCF930362impl_uses*
;

{$R *.DFM}

//#UC START# *4AAFCF930362impl*
//#UC END# *4AAFCF930362impl*

initialization
 fm_PictureForm.SetFactory(TPictureForm.Make);
 {* Регистрация фабрики формы Picture }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPictureForm);
 {* Регистрация Picture }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
