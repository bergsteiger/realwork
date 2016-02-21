unit fsConsultation;
 {* Сборка для показа консультации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\fsConsultation.pas"
// Стереотип: "VCMFormSetFactory"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentUserTypes_dftConsultation_UserType
 , Common_FormDefinitions_Controls
 , ConsultationDomainInterfaces
 , DocumentInterfaces
 , DocumentAndListInterfaces
 , DocumentUnit
 , bsTypesNew
 , ListUserTypes_lftConsultation_UserType
 , PrimConsultationMark_utcmMain_UserType
;

type
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 , SysUtils
 , l3Base
;

var g_Tfs_Consultation: Tfs_Consultation = nil;
 {* Экземпляр синглетона Tfs_Consultation }

const
 {* Локализуемые строки ConsultationCaptionLocalConstants }
 str_fsConsultationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsConsultationCaption'; rValue : 'Консультация');
  {* Заголовок фабрики сборки форм "Consultation" }

procedure Tfs_ConsultationFree;
 {* Метод освобождения экземпляра синглетона Tfs_Consultation }
begin
 l3Free(g_Tfs_Consultation);
end;//Tfs_ConsultationFree

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

initialization
 str_fsConsultationCaption.Init;
 {* Инициализация str_fsConsultationCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
