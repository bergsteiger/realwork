unit Consultation_Module;
 {* Консультации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\Consultation_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "Consultation" MUID: (4ABCFB7F017B)
// Имя типа: "TConsultationModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ConsultationDomainInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3TreeInterfaces
 , SearchUnit
 , ConsultingUnit
;

type
 TConsultationModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Консультации }
  public
   procedure GiveMarkOnConsultation(const aNode: Il3SimpleNode);
   procedure OpenSendConsultation(const aQuery: IQuery);
   procedure OpenEntityAsConsultation(const aCons: IUnknown;
    const aContainer: IvcmContainer);
   procedure OpenConsultation(const aCons: IbsConsultation;
    const aContainer: IvcmContainer);
 end;//TConsultationModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DocumentUserTypes_dftConsultation_UserType
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , sdsConsultation
 , bsConsultation
 , bsUtils
 , sdsSendConsultation
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , DataAdapter
 , fsSendConsultation
 , fsConsultation
 , ConsultationMark_Form
 {$If NOT Defined(NoScripts)}
 , ConsultationMarkKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TConsultationModule.GiveMarkOnConsultation(const aNode: Il3SimpleNode);
var l_OpenConsultation: IsdsConsultation;
var l_Form: IvcmEntityForm;
var l_Cons: IsdsConsultation;
//#UC START# *4ABBA1BF0053_4ABCFB7F017B_var*
//#UC END# *4ABBA1BF0053_4ABCFB7F017B_var*
begin
//#UC START# *4ABBA1BF0053_4ABCFB7F017B_impl*
 l_Cons := TsdsConsultation.Make(
            TbsConsultation.Make(bsGetConsultation(aNode)));
 Ten_ConsultationMark.Make(vcmMakeParams(nil, CheckContainer(nil)), vcm_ztModal, 0, nil,
  l_Cons.dsConsultationMark[True]);
 // Обновим открытую консультацию:
 if CheckContainer(nil).HasForm(fm_TextForm.rFormID, vcm_ztParent,
  True, @l_Form, dftConsultation) then
 try
  if (l_Form.DataSource <> nil) and 
     l_Form.DataSource.CastUCC(IsdsConsultation, l_OpenConsultation)
   (*Supports(l_Form.DataSource.UseCaseController,
   IsdsConsultation, l_OpenConsultation)*) then
  try
   l_OpenConsultation.ConsultationWasMarked(l_Cons);
  finally
   l_OpenConsultation := nil;
  end;//try..finally
 finally
  l_Form := nil;
 end;//try..finally
//#UC END# *4ABBA1BF0053_4ABCFB7F017B_impl*
end;//TConsultationModule.GiveMarkOnConsultation

procedure TConsultationModule.OpenSendConsultation(const aQuery: IQuery);
//#UC START# *4AA53DF902C5_4ABCFB7F017B_var*
//#UC END# *4AA53DF902C5_4ABCFB7F017B_var*
begin
//#UC START# *4AA53DF902C5_4ABCFB7F017B_impl*
 if not defDataAdapter.AdministratorLogin then
  Tfs_SendConsultation.Make(TsdsSendConsultation.Make(aQuery),
                            CheckContainer(nil).NativeMainForm)
 else
  vcmSay(war_SystemLogin);
//#UC END# *4AA53DF902C5_4ABCFB7F017B_impl*
end;//TConsultationModule.OpenSendConsultation

procedure TConsultationModule.OpenEntityAsConsultation(const aCons: IUnknown;
 const aContainer: IvcmContainer);
var l_Cons: IConsultation;
//#UC START# *4AA5385C03DD_4ABCFB7F017B_var*
//#UC END# *4AA5385C03DD_4ABCFB7F017B_var*
begin
//#UC START# *4AA5385C03DD_4ABCFB7F017B_impl*
 if Supports(aCons, IConsultation, l_Cons) then
 try
  try
   OpenConsultation(TbsConsultation.Make(l_Cons), aContainer);
  except
   on EOldFormatConsultation do
    vcmSay(war_OldFormatConsultation);
  end;//try..except
 finally
  l_Cons := nil;
 end;//try..finally
//#UC END# *4AA5385C03DD_4ABCFB7F017B_impl*
end;//TConsultationModule.OpenEntityAsConsultation

procedure TConsultationModule.OpenConsultation(const aCons: IbsConsultation;
 const aContainer: IvcmContainer);
//#UC START# *4AA5363D02D0_4ABCFB7F017B_var*
//#UC END# *4AA5363D02D0_4ABCFB7F017B_var*
begin
//#UC START# *4AA5363D02D0_4ABCFB7F017B_impl*
 aCons.IsStatusChached := true;
 try
  Tfs_Consultation.Make(TsdsConsultation.Make(aCons),
                        CheckContainer(aContainer).NativeMainForm);
 finally
  aCons.IsStatusChached := false;
 end;//try..finally
//#UC END# *4AA5363D02D0_4ABCFB7F017B_impl*
end;//TConsultationModule.OpenConsultation
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
