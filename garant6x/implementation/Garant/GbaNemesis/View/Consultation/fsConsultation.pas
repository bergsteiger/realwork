unit fsConsultation;
 {* Сборка для показа консультации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\fsConsultation.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "Consultation" MUID: (4AA5360E0197)
// Имя типа: "Tfs_Consultation"

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
 Tfs_Consultation = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Сборка для показа консультации }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoGetCanCloneFormSet(const aFormSet: IvcmFormSet): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoGetCanSaveFormSetToHistory(const aFormSet: IvcmFormSet): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function TextParentDftConsultationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Text }
   function ListChildLftConsultationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для List }
   function MarkModalUtcmMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Mark }
   class function Instance: Tfs_Consultation;
    {* Метод получения экземпляра синглетона Tfs_Consultation }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_Consultation
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Base
 //#UC START# *4AA5360E0197impl_uses*
 //#UC END# *4AA5360E0197impl_uses*
;

{$If NOT Defined(NoVCM)}
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

function Tfs_Consultation.TextParentDftConsultationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
var
 l_UseCase : IsdsConsultation;
begin
 if Supports(aDataSource, IsdsConsultation, l_UseCase) then
  try
  //#UC START# *4FFADAFD02F1NeedMake_impl*
   aNew := l_UseCase.dsConsultation;
  //#UC END# *4FFADAFD02F1NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Consultation.TextParentDftConsultationNeedMakeForm

function Tfs_Consultation.ListChildLftConsultationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для List }
var
 l_UseCase : IsdsConsultation;
begin
 if Supports(aDataSource, IsdsConsultation, l_UseCase) then
  try
  //#UC START# *4FFADCDA016FNeedMake_impl*
   aNew := l_UseCase.dsList;
  //#UC END# *4FFADCDA016FNeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Consultation.ListChildLftConsultationNeedMakeForm

function Tfs_Consultation.MarkModalUtcmMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Mark }
var
 l_UseCase : IsdsConsultation;
begin
 if Supports(aDataSource, IsdsConsultation, l_UseCase) then
  try
  //#UC START# *4FFADD000158NeedMake_impl*
   aNew := l_UseCase.dsConsultationMark[false];
  //#UC END# *4FFADD000158NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Consultation.MarkModalUtcmMainNeedMakeForm

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

class function Tfs_Consultation.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_Consultation <> nil;
end;//Tfs_Consultation.Exists

procedure Tfs_Consultation.InitFields;
begin
 inherited;
 with AddZone('Text', vcm_ztParent, fm_TextForm) do
 begin
  UserType := dftConsultation;
  OnNeedMakeForm := TextParentDftConsultationNeedMakeForm;
 end;
 with AddZone('List', vcm_ztChild, fm_efList) do
 begin
  UserType := lftConsultation;
  OnNeedMakeForm := ListChildLftConsultationNeedMakeForm;
 end;
 with AddZone('Mark', vcm_ztModal, fm_en_ConsultationMark) do
 begin
  UserType := utcmMain;
  OnNeedMakeForm := MarkModalUtcmMainNeedMakeForm;
 end;
 Caption := str_fsConsultationCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_Consultation.InitFields

class function Tfs_Consultation.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_Consultation.GetInstance

function Tfs_Consultation.DoGetCanCloneFormSet(const aFormSet: IvcmFormSet): Boolean;
//#UC START# *55E00AAB006B_4AA5360E0197_var*
var
 l_sds: IsdsConsultation;
//#UC END# *55E00AAB006B_4AA5360E0197_var*
begin
//#UC START# *55E00AAB006B_4AA5360E0197_impl*
 Result := inherited DoGetCanCloneFormset(aFormSet);
 if Supports(aFormSet.DataSource, IsdsConsultation, l_sds) then
  Result := (l_sds.BsConsultation <> nil) and (not l_sds.BsConsultation.WasDeleted);
//#UC END# *55E00AAB006B_4AA5360E0197_impl*
end;//Tfs_Consultation.DoGetCanCloneFormSet

function Tfs_Consultation.DoGetCanSaveFormSetToHistory(const aFormSet: IvcmFormSet): Boolean;
//#UC START# *55E020470097_4AA5360E0197_var*
//#UC END# *55E020470097_4AA5360E0197_var*
begin
//#UC START# *55E020470097_4AA5360E0197_impl*
 Result := DoGetCanCloneFormSet(aFormSet);
//#UC END# *55E020470097_4AA5360E0197_impl*
end;//Tfs_Consultation.DoGetCanSaveFormSetToHistory

initialization
 str_fsConsultationCaption.Init;
 {* Инициализация str_fsConsultationCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
