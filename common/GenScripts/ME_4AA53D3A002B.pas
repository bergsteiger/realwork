unit fsSendConsultation;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\fsSendConsultation.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "SendConsultation" MUID: (4AA53D3A002B)
// Имя типа: "Tfs_SendConsultation"

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
 , PrimSaveLoadUserTypes_slqtConsult_UserType
 , Search_FormDefinitions_Controls
 , ConsultationInterfaces
 , QueryCardInterfaces
 , PrimQueryCard_utqcSendConsultation_UserType
;

type
 Tfs_SendConsultation = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function SaveLoadParentSlqtConsultNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для SaveLoad }
   function QueryCardParentUtqcSendConsultationNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для QueryCard }
   class function Instance: Tfs_SendConsultation;
    {* Метод получения экземпляра синглетона Tfs_SendConsultation }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_SendConsultation
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
var g_Tfs_SendConsultation: Tfs_SendConsultation = nil;
 {* Экземпляр синглетона Tfs_SendConsultation }

const
 {* Локализуемые строки QueryCardCaptionLocalConstants }
 str_fszQueryCard_Parent_utqcSendConsultationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fszQueryCard_Parent_utqcSendConsultationCaption'; rValue : 'Поиск с правовой поддержкой');
  {* Заголовок зоны "QueryCard" фабрики сборки форм "SendConsultation" }
 {* Локализуемые строки SendConsultationCaptionLocalConstants }
 str_fsSendConsultationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsSendConsultationCaption'; rValue : 'Правовая поддержка');
  {* Заголовок фабрики сборки форм "SendConsultation" }

procedure Tfs_SendConsultationFree;
 {* Метод освобождения экземпляра синглетона Tfs_SendConsultation }
begin
 l3Free(g_Tfs_SendConsultation);
end;//Tfs_SendConsultationFree

function Tfs_SendConsultation.SaveLoadParentSlqtConsultNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для SaveLoad }
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
 {* Обработчик OnNeedMakeForm для QueryCard }
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

class function Tfs_SendConsultation.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_SendConsultation <> nil;
end;//Tfs_SendConsultation.Exists

procedure Tfs_SendConsultation.InitFields;
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

class function Tfs_SendConsultation.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_SendConsultation.GetInstance

initialization
 str_fszQueryCard_Parent_utqcSendConsultationCaption.Init;
 {* Инициализация str_fszQueryCard_Parent_utqcSendConsultationCaption }
 str_fsSendConsultationCaption.Init;
 {* Инициализация str_fsSendConsultationCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
