unit Consultation_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Consultation/Consultation_Module.pas"
// Начат: 25.09.2009 21:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Пользовательские сервисы::Consultation::View::Consultation::Consultation$FP
//
// Консультации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  ConsultingUnit,
  SearchUnit,
  l3TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  ,
  ConsultationInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  ConsultationDomainInterfaces,
  DocumentUserTypes_dftConsultation_UserType,
  l3StringIDEx,
  ListUserTypes_lftConsultation_UserType,
  PrimSaveLoadUserTypes_slqtConsult_UserType,
  PrimQueryCard_utqcSendConsultation_UserType,
  Common_FormDefinitions_Controls,
  Search_FormDefinitions_Controls,
  PrimConsultationMarkOptions_Form,
  PrimConsultationMark_utcmMain_UserType
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  fsSendConsultation,
  fsConsultation,
  ConsultationMark_Form,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TConsultationModule = {formspack} class(TvcmModule)
  {* Консультации }
 protected
  class procedure GetEntityForms(aList : TvcmClassList); override;
 public
 // public methods
   class procedure GiveMarkOnConsultation(const aNode: Il3SimpleNode);
   class procedure OpenSendConsultation(const aQuery: IQuery);
   class procedure OpenEntityAsConsultation(const aCons: IUnknown;
     const aContainer: IvcmContainer);
   class procedure OpenConsultation(const aCons: IbsConsultation;
     const aContainer: IvcmContainer);
 end;//TConsultationModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  sdsConsultation,
  bsConsultation,
  bsUtils,
  sdsSendConsultation
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  ,
  DataAdapter,
  l3Base {a},
  l3MessageID,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TConsultationModule

class procedure TConsultationModule.GiveMarkOnConsultation(const aNode: Il3SimpleNode);
var
 __WasEnter : Boolean;
//#UC START# *4ABBA1BF0053_4ABCFB7F017B_var*
//#UC END# *4ABBA1BF0053_4ABCFB7F017B_var*
var
 l_OpenConsultation : IsdsConsultation;
 l_Form : IvcmEntityForm;
 l_Cons : IsdsConsultation;
begin
 __WasEnter := vcmEnterFactory;
 try
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TConsultationModule.GiveMarkOnConsultation

class procedure TConsultationModule.OpenSendConsultation(const aQuery: IQuery);
var
 __WasEnter : Boolean;
//#UC START# *4AA53DF902C5_4ABCFB7F017B_var*
//#UC END# *4AA53DF902C5_4ABCFB7F017B_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA53DF902C5_4ABCFB7F017B_impl*
 if not defDataAdapter.AdministratorLogin then
  Tfs_SendConsultation.Make(TsdsSendConsultation.Make(aQuery),
                            CheckContainer(nil).NativeMainForm)
 else
  vcmSay(war_SystemLogin);
//#UC END# *4AA53DF902C5_4ABCFB7F017B_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TConsultationModule.OpenSendConsultation

class procedure TConsultationModule.OpenEntityAsConsultation(const aCons: IUnknown;
  const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AA5385C03DD_4ABCFB7F017B_var*
//#UC END# *4AA5385C03DD_4ABCFB7F017B_var*
var
 l_Cons : IConsultation;
begin
 __WasEnter := vcmEnterFactory;
 try
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TConsultationModule.OpenEntityAsConsultation

class procedure TConsultationModule.OpenConsultation(const aCons: IbsConsultation;
  const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AA5363D02D0_4ABCFB7F017B_var*
//#UC END# *4AA5363D02D0_4ABCFB7F017B_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA5363D02D0_4ABCFB7F017B_impl*
 aCons.IsStatusChached := true;
 try
  Tfs_Consultation.Make(TsdsConsultation.Make(aCons),
                        CheckContainer(aContainer).NativeMainForm);
 finally
  aCons.IsStatusChached := false;
 end;//try..finally
//#UC END# *4AA5363D02D0_4ABCFB7F017B_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TConsultationModule.OpenConsultation

class procedure TConsultationModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(Ten_ConsultationMark);
end;

{$IfEnd} //not Admin AND not Monitorings

end.