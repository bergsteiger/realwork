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
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TConsultationModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Консультации }
  protected
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TConsultationModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Services_Contracts
 , SearchUnit
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , ConsultationDomainInterfaces
 , l3TreeInterfaces
 , DocumentUserTypes_dftConsultation_UserType
 , Common_FormDefinitions_Controls
 , SysUtils
 , bsUtils
 , bsConsultation
 , sdsConsultation
 , ConsultingUnit
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , sdsSendConsultation
 , DataAdapter
 , l3Base
 , fsSendConsultation
 , fsConsultation
 , ConsultationMark_Form
 //#UC START# *4ABCFB7F017Bimpl_uses*
 , StdRes
 //#UC END# *4ABCFB7F017Bimpl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TConsultationServiceImpl = {final} class(TvcmModuleContractImplementation, IConsultationService)
  public
   procedure OpenSendConsultation(const aQuery: IQuery);
   procedure OpenEntityAsConsultation(const aCons: IUnknown;
    const aContainer: IvcmContainer);
   procedure OpenConsultation(const aCons: IbsConsultation;
    const aContainer: IvcmContainer);
   procedure GiveMarkOnConsultation(const aNode: Il3SimpleNode);
   class function Instance: TConsultationServiceImpl;
    {* Метод получения экземпляра синглетона TConsultationServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TConsultationServiceImpl

var g_TConsultationServiceImpl: TConsultationServiceImpl = nil;
 {* Экземпляр синглетона TConsultationServiceImpl }

procedure TConsultationServiceImplFree;
 {* Метод освобождения экземпляра синглетона TConsultationServiceImpl }
begin
 l3Free(g_TConsultationServiceImpl);
end;//TConsultationServiceImplFree

procedure TConsultationServiceImpl.OpenSendConsultation(const aQuery: IQuery);
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
end;//TConsultationServiceImpl.OpenSendConsultation

procedure TConsultationServiceImpl.OpenEntityAsConsultation(const aCons: IUnknown;
 const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AA5385C03DD_4ABCFB7F017B_var*
var
 l_Cons : IConsultation;
//#UC END# *4AA5385C03DD_4ABCFB7F017B_var*
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
end;//TConsultationServiceImpl.OpenEntityAsConsultation

procedure TConsultationServiceImpl.OpenConsultation(const aCons: IbsConsultation;
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
end;//TConsultationServiceImpl.OpenConsultation

procedure TConsultationServiceImpl.GiveMarkOnConsultation(const aNode: Il3SimpleNode);
var
 __WasEnter : Boolean;
//#UC START# *4ABBA1BF0053_4ABCFB7F017B_var*
var
 l_Cons : IsdsConsultation;
 l_Form : IvcmEntityForm;
 l_OpenConsultation : IsdsConsultation;
//#UC END# *4ABBA1BF0053_4ABCFB7F017B_var*
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
end;//TConsultationServiceImpl.GiveMarkOnConsultation

class function TConsultationServiceImpl.Instance: TConsultationServiceImpl;
 {* Метод получения экземпляра синглетона TConsultationServiceImpl }
begin
 if (g_TConsultationServiceImpl = nil) then
 begin
  l3System.AddExitProc(TConsultationServiceImplFree);
  g_TConsultationServiceImpl := Create;
 end;
 Result := g_TConsultationServiceImpl;
end;//TConsultationServiceImpl.Instance

class function TConsultationServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TConsultationServiceImpl <> nil;
end;//TConsultationServiceImpl.Exists

class procedure TConsultationModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(Ten_ConsultationMark);
end;//TConsultationModule.GetEntityForms

initialization
 TConsultationService.Instance.Alien := TConsultationServiceImpl.Instance;
 {* Регистрация TConsultationServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
