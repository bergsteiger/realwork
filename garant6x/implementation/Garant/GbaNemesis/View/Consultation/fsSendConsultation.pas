unit fsSendConsultation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Consultation/fsSendConsultation.pas"
// Начат: 25.09.2009 21:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Пользовательские сервисы::Consultation::View::Consultation::Consultation$FP::SendConsultation
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
  ,
  ConsultationInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx,
  PrimSaveLoadUserTypes_slqtConsult_UserType,
  PrimQueryCard_utqcSendConsultation_UserType,
  Search_FormDefinitions_Controls
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  QueryCardInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_SendConsultation = {final fsf} class(TvcmFormSetFactory)
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function SaveLoadParentSlqtConsultNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для SaveLoad }
   function QueryCardParentUtqcSendConsultationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для QueryCard }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_SendConsultation;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_SendConsultation
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


// start class Tfs_SendConsultation

var g_Tfs_SendConsultation : Tfs_SendConsultation = nil;

procedure Tfs_SendConsultationFree;
begin
 l3Free(g_Tfs_SendConsultation);
end;

class function Tfs_SendConsultation.Instance: Tfs_SendConsultation;
begin
 if (g_Tfs_SendConsultation = nil) then
 begin
  l3System.AddExitProc(Tfs_SendConsultationFree);
  g_Tfs_SendConsultation := Create;
 end;
 Result := g_Tfs_SendConsultation;
end;

var
    { Локализуемые строки QueryCardCaptionLocalConstants }
   str_fszQueryCard_Parent_utqcSendConsultationCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fszQueryCard_Parent_utqcSendConsultationCaption'; rValue : 'Поиск с правовой поддержкой');
    { Заголовок зоны "QueryCard" фабрики сборки форм "SendConsultation" }

var
    { Локализуемые строки SendConsultationCaptionLocalConstants }
   str_fsSendConsultationCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsSendConsultationCaption'; rValue : 'Правовая поддержка');
    { Заголовок фабрики сборки форм "SendConsultation" }

// start class Tfs_SendConsultation

function Tfs_SendConsultation.SaveLoadParentSlqtConsultNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsQuery;
begin
 if Supports(aDataSource, IsdsQuery, l_UseCase) then
  try
//#UC START# *4FFAE62E0209NeedMake_impl*
   aNew := l_UseCase.dsSaveLoad;
//#UC END# *4FFAE62E0209NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_SendConsultation.SaveLoadParentSlqtConsultNeedMakeForm

function Tfs_SendConsultation.QueryCardParentUtqcSendConsultationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsQuery;
begin
 if Supports(aDataSource, IsdsQuery, l_UseCase) then
  try
//#UC START# *4FFAE7500345NeedMake_impl*
   aNew := l_UseCase.dsQuery;
//#UC END# *4FFAE7500345NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_SendConsultation.QueryCardParentUtqcSendConsultationNeedMakeForm

class function Tfs_SendConsultation.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_SendConsultation <> nil;
end;//Tfs_SendConsultation.Exists

procedure Tfs_SendConsultation.InitFields;
 {-}
begin
 inherited;
 with AddZone('SaveLoad', vcm_ztParent, fm_cfSaveLoad) do
 begin
  UserType := slqtConsult;
  with AddZone('QueryCard', vcm_ztParent, fm_enQueryCard) do
  begin
   Caption := str_fszQueryCard_Parent_utqcSendConsultationCaption.AsCStr;
   UserType := utqcSendConsultation;
   OnNeedMakeForm := QueryCardParentUtqcSendConsultationNeedMakeForm;
  end;
  OnNeedMakeForm := SaveLoadParentSlqtConsultNeedMakeForm;
 end;
 Caption := str_fsSendConsultationCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_SendConsultation.InitFields

{$If not defined(NoVCM)}
class function Tfs_SendConsultation.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_SendConsultation.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fszQueryCard_Parent_utqcSendConsultationCaption
 str_fszQueryCard_Parent_utqcSendConsultationCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsSendConsultationCaption
 str_fsSendConsultationCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.