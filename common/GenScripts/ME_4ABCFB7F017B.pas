unit Consultation_Module;
 {* Консультации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\Consultation_Module.pas"
// Стереотип: "VCMFormsPack"

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
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimConsultationMarkOptions_Form
 , Common_FormDefinitions_Controls
 , PrimSaveLoadUserTypes_slqtConsult_UserType
 , Search_FormDefinitions_Controls
 , ConsultationInterfaces
 , QueryCardInterfaces
 , PrimQueryCard_utqcSendConsultation_UserType
 , DocumentUserTypes_dftConsultation_UserType
 , DocumentInterfaces
 , DocumentAndListInterfaces
 , DocumentUnit
 , bsTypesNew
 , ListUserTypes_lftConsultation_UserType
 , PrimConsultationMark_utcmMain_UserType
;

type
 // QueryCard

 // SaveLoad

 Tfs_SendConsultation = {final} class(TvcmFormSetFactory)
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function SaveLoad_Parent_slqtConsult_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для SaveLoad }
   function QueryCard_Parent_utqcSendConsultation_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для QueryCard }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_SendConsultation;
    {* Метод получения экземпляра синглетона Tfs_SendConsultation }
 end;//Tfs_SendConsultation

 // Text

 // List

 // Mark

 Tfs_Consultation = {final} class(TvcmFormSetFactory)
  {* Сборка для показа консультации }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Text_Parent_dftConsultation_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Text }
   function List_Child_lftConsultation_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для List }
   function Mark_Modal_utcmMain_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Mark }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_Consultation;
    {* Метод получения экземпляра синглетона Tfs_Consultation }
 end;//Tfs_Consultation

 Ten_ConsultationMark = {final} class(TPrimConsultationMarkOptionsForm, ConsultationMarkFormDef)
  {* Оценка ответа }
 end;//Ten_ConsultationMark

 TConsultationModule = class
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
 , l3StringIDEx
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
 , l3MessageID
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ConsultationMarkKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

var g_Tfs_SendConsultation: Tfs_SendConsultation = nil;
 {* Экземпляр синглетона Tfs_SendConsultation }
var g_Tfs_Consultation: Tfs_Consultation = nil;
 {* Экземпляр синглетона Tfs_Consultation }

const
 {* Локализуемые строки QueryCardCaptionLocalConstants }
 str_fszQueryCard_Parent_utqcSendConsultationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fszQueryCard_Parent_utqcSendConsultationCaption'; rValue : 'Поиск с правовой поддержкой');
  {* Заголовок зоны "QueryCard" фабрики сборки форм "SendConsultation" }
 {* Локализуемые строки SendConsultationCaptionLocalConstants }
 str_fsSendConsultationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsSendConsultationCaption'; rValue : 'Правовая поддержка');
  {* Заголовок фабрики сборки форм "SendConsultation" }

const
 {* Локализуемые строки ConsultationCaptionLocalConstants }
 str_fsConsultationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsConsultationCaption'; rValue : 'Консультация');
  {* Заголовок фабрики сборки форм "Consultation" }

procedure Tfs_SendConsultationFree;
 {* Метод освобождения экземпляра синглетона Tfs_SendConsultation }
begin
 l3Free(g_Tfs_SendConsultation);
end;//Tfs_SendConsultationFree

procedure Tfs_ConsultationFree;
 {* Метод освобождения экземпляра синглетона Tfs_Consultation }
begin
 l3Free(g_Tfs_Consultation);
end;//Tfs_ConsultationFree

function Tfs_SendConsultation.SaveLoad_Parent_slqtConsult_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для SaveLoad }
//#UC START# *CAD3716E6F7B_4AA53D3A002B_var*
//#UC END# *CAD3716E6F7B_4AA53D3A002B_var*
begin
//#UC START# *CAD3716E6F7B_4AA53D3A002B_impl*
 !!! Needs to be implemented !!!
//#UC END# *CAD3716E6F7B_4AA53D3A002B_impl*
end;//Tfs_SendConsultation.SaveLoad_Parent_slqtConsult_NeedMakeForm

function Tfs_SendConsultation.QueryCard_Parent_utqcSendConsultation_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для QueryCard }
//#UC START# *0BD7FE614FE1_4AA53D3A002B_var*
//#UC END# *0BD7FE614FE1_4AA53D3A002B_var*
begin
//#UC START# *0BD7FE614FE1_4AA53D3A002B_impl*
 !!! Needs to be implemented !!!
//#UC END# *0BD7FE614FE1_4AA53D3A002B_impl*
end;//Tfs_SendConsultation.QueryCard_Parent_utqcSendConsultation_NeedMakeForm

class function Tfs_SendConsultation.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_SendConsultation <> nil;
end;//Tfs_SendConsultation.Exists

class function Tfs_SendConsultation.Instance: Tfs_SendConsultation;
 {* Метод получения экземпляра синглетона Tfs_SendConsultation }
begin
 if (g_Tfs_SendConsultation = nil) then
 begin
  l3System.AddExitProc(Tfs_SendConsultationFree);
  g_Tfs_SendConsultation := Create;
 end;
 Result := g_Tfs_SendConsultation;
end;//Tfs_SendConsultation.Instance

procedure Tfs_SendConsultation.InitFields;
//#UC START# *47A042E100E2_4AA53D3A002B_var*
//#UC END# *47A042E100E2_4AA53D3A002B_var*
begin
//#UC START# *47A042E100E2_4AA53D3A002B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA53D3A002B_impl*
end;//Tfs_SendConsultation.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_SendConsultation.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA53D3A002B_var*
//#UC END# *4FFE854A009B_4AA53D3A002B_var*
begin
//#UC START# *4FFE854A009B_4AA53D3A002B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA53D3A002B_impl*
end;//Tfs_SendConsultation.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

function Tfs_Consultation.Text_Parent_dftConsultation_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
//#UC START# *C368BAC18740_4AA5360E0197_var*
//#UC END# *C368BAC18740_4AA5360E0197_var*
begin
//#UC START# *C368BAC18740_4AA5360E0197_impl*
 !!! Needs to be implemented !!!
//#UC END# *C368BAC18740_4AA5360E0197_impl*
end;//Tfs_Consultation.Text_Parent_dftConsultation_NeedMakeForm

function Tfs_Consultation.List_Child_lftConsultation_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для List }
//#UC START# *E34153DD0D14_4AA5360E0197_var*
//#UC END# *E34153DD0D14_4AA5360E0197_var*
begin
//#UC START# *E34153DD0D14_4AA5360E0197_impl*
 !!! Needs to be implemented !!!
//#UC END# *E34153DD0D14_4AA5360E0197_impl*
end;//Tfs_Consultation.List_Child_lftConsultation_NeedMakeForm

function Tfs_Consultation.Mark_Modal_utcmMain_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Mark }
//#UC START# *3B88C8040506_4AA5360E0197_var*
//#UC END# *3B88C8040506_4AA5360E0197_var*
begin
//#UC START# *3B88C8040506_4AA5360E0197_impl*
 !!! Needs to be implemented !!!
//#UC END# *3B88C8040506_4AA5360E0197_impl*
end;//Tfs_Consultation.Mark_Modal_utcmMain_NeedMakeForm

class function Tfs_Consultation.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_Consultation <> nil;
end;//Tfs_Consultation.Exists

class function Tfs_Consultation.Instance: Tfs_Consultation;
 {* Метод получения экземпляра синглетона Tfs_Consultation }
begin
 if (g_Tfs_Consultation = nil) then
 begin
  l3System.AddExitProc(Tfs_ConsultationFree);
  g_Tfs_Consultation := Create;
 end;
 Result := g_Tfs_Consultation;
end;//Tfs_Consultation.Instance

procedure Tfs_Consultation.InitFields;
//#UC START# *47A042E100E2_4AA5360E0197_var*
//#UC END# *47A042E100E2_4AA5360E0197_var*
begin
//#UC START# *47A042E100E2_4AA5360E0197_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA5360E0197_impl*
end;//Tfs_Consultation.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_Consultation.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA5360E0197_var*
//#UC END# *4FFE854A009B_4AA5360E0197_var*
begin
//#UC START# *4FFE854A009B_4AA5360E0197_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA5360E0197_impl*
end;//Tfs_Consultation.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

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

initialization
 str_fszQueryCard_Parent_utqcSendConsultationCaption.Init;
 {* Инициализация str_fszQueryCard_Parent_utqcSendConsultationCaption }
 str_fsSendConsultationCaption.Init;
 {* Инициализация str_fsSendConsultationCaption }
 str_fsConsultationCaption.Init;
 {* Инициализация str_fsConsultationCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_ConsultationMark);
 {* Регистрация ConsultationMark }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_ConsultationMark.SetFactory(Ten_ConsultationMark.Make);
 {* Регистрация фабрики формы ConsultationMark }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
