unit fsConsultation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Consultation/fsConsultation.pas"
// Начат: 25.09.2009 21:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Пользовательские сервисы::Consultation::View::Consultation::Consultation$FP::Consultation
//
// Сборка для показа консультации
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
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  ConsultationDomainInterfaces,
  DocumentUserTypes_dftConsultation_UserType,
  l3StringIDEx,
  ListUserTypes_lftConsultation_UserType,
  Common_FormDefinitions_Controls,
  PrimConsultationMark_utcmMain_UserType
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  DocumentAndListInterfaces {a},
  DocumentUnit,
  DocumentInterfaces,
  bsTypesNew
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_Consultation = {final fsf} class(TvcmFormSetFactory)
   {* Сборка для показа консультации }
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
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
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_Consultation;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_Consultation
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  l3MessageID,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class Tfs_Consultation

var g_Tfs_Consultation : Tfs_Consultation = nil;

procedure Tfs_ConsultationFree;
begin
 l3Free(g_Tfs_Consultation);
end;

class function Tfs_Consultation.Instance: Tfs_Consultation;
begin
 if (g_Tfs_Consultation = nil) then
 begin
  l3System.AddExitProc(Tfs_ConsultationFree);
  g_Tfs_Consultation := Create;
 end;
 Result := g_Tfs_Consultation;
end;

var
    { Локализуемые строки ConsultationCaptionLocalConstants }
   str_fsConsultationCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsConsultationCaption'; rValue : 'Консультация');
    { Заголовок фабрики сборки форм "Consultation" }

// start class Tfs_Consultation

function Tfs_Consultation.TextParentDftConsultationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
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

class function Tfs_Consultation.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_Consultation <> nil;
end;//Tfs_Consultation.Exists

procedure Tfs_Consultation.InitFields;
 {-}
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

{$If not defined(NoVCM)}
class function Tfs_Consultation.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_Consultation.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsConsultationCaption
 str_fsConsultationCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.