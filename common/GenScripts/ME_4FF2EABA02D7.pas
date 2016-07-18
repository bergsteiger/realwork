unit fsAAC;
 {* Сборка для документа ААК }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\fsAAC.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "AAC" MUID: (4FF2EABA02D7)
// Имя типа: "Tfs_AAC"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , fsAbstractDocument
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , AACContainer_Form
 , AACContainerPrim_AACContainer_UserType
 , WorkWithDocumentInterfaces
 , Common_FormDefinitions_Controls
 , DocumentUserTypes_dftAACLeft_UserType
 , nevTools
 , DocumentInterfaces
 , bsTypes
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentAndListInterfaces
 , DocumentUnit
 , l3Interfaces
 , bsTypesNew
 , DocumentUserTypes_dftAACRight_UserType
 , BaloonWarningUserTypes_WarnJuror_UserType
 , nsTypes
 , nevBase
;

type
 Tfs_AAC = {final} class(Tfs_AbstractDocument)
  {* Сборка для документа ААК }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoMakeFormSetCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoMakeFormSetTabCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoMakeFormSetTabHint(const aDataSource: IvcmFormSetDataSource): IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function AACContainerParentAACContainerNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для AACContainer }
   function LeftChildDftAACLeftNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Left }
   function WarnJurorChildWarnJurorNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnJuror }
   function RightMainDftAACRightNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Right }
   class function Instance: Tfs_AAC;
    {* Метод получения экземпляра синглетона Tfs_AAC }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_AAC
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3String
 , SysUtils
 , l3Base
;

var g_Tfs_AAC: Tfs_AAC = nil;
 {* Экземпляр синглетона Tfs_AAC }

const
 {* Локализуемые строки Tab consts }
 str_AACFormsetCaptionPrefix: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AACFormsetCaptionPrefix'; rValue : 'Текст');
  {* 'Текст' }
 {* Локализуемые строки AAC }
 str_fsAACCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsAACCaption'; rValue : 'Текст');
  {* Заголовок фабрики сборки форм "AAC$FormSetFactory" }

procedure Tfs_AACFree;
 {* Метод освобождения экземпляра синглетона Tfs_AAC }
begin
 l3Free(g_Tfs_AAC);
end;//Tfs_AACFree

function Tfs_AAC.AACContainerParentAACContainerNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для AACContainer }
var
 l_UseCase : IsdsAAC;
begin
 if Supports(aDataSource, IsdsAAC, l_UseCase) then
  try
   aNew := l_UseCase.Container;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AAC.AACContainerParentAACContainerNeedMakeForm

function Tfs_AAC.LeftChildDftAACLeftNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Left }
var
 l_UseCase : IsdsAAC;
begin
 if Supports(aDataSource, IsdsAAC, l_UseCase) then
  try
   aNew := l_UseCase.Left;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AAC.LeftChildDftAACLeftNeedMakeForm

function Tfs_AAC.WarnJurorChildWarnJurorNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnJuror }
var
 l_UseCase : IsdsDocument;
begin
 if Supports(aDataSource, IsdsDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AAC.WarnJurorChildWarnJurorNeedMakeForm

function Tfs_AAC.RightMainDftAACRightNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Right }
var
 l_UseCase : IsdsAAC;
begin
 if Supports(aDataSource, IsdsAAC, l_UseCase) then
  try
   aNew := l_UseCase.Right;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AAC.RightMainDftAACRightNeedMakeForm

class function Tfs_AAC.Instance: Tfs_AAC;
 {* Метод получения экземпляра синглетона Tfs_AAC }
begin
 if (g_Tfs_AAC = nil) then
 begin
  l3System.AddExitProc(Tfs_AACFree);
  g_Tfs_AAC := Create;
 end;
 Result := g_Tfs_AAC;
end;//Tfs_AAC.Instance

class function Tfs_AAC.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_AAC <> nil;
end;//Tfs_AAC.Exists

procedure Tfs_AAC.InitFields;
begin
 inherited;
 with AddZone('AACContainer', vcm_ztParent, fm_AACContainerForm) do
 begin
  UserType := AACContainer;
  with AddZone('Left', vcm_ztChild, fm_TextForm) do
  begin
   UserType := dftAACLeft;
   with AddZone('WarnJuror', vcm_ztChild, fm_WarningBaloonForm) do
   begin
    UserType := WarnJuror;
    OnNeedMakeForm := WarnJurorChildWarnJurorNeedMakeForm;
   end;
   OnNeedMakeForm := LeftChildDftAACLeftNeedMakeForm;
  end;
  with AddZone('Right', vcm_ztMain, fm_TextForm) do
  begin
   UserType := dftAACRight;
   OnNeedMakeForm := RightMainDftAACRightNeedMakeForm;
  end;
  OnNeedMakeForm := AACContainerParentAACContainerNeedMakeForm;
 end;
 Caption := str_fsAACCaption.AsCStr;
 OwnerForm := 16;
end;//Tfs_AAC.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_AAC.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_AAC.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function Tfs_AAC.DoMakeFormSetCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
//#UC START# *54B352A903E5_4FF2EABA02D7_var*
var
 l_TabCaption: IvcmCString;
//#UC END# *54B352A903E5_4FF2EABA02D7_var*
begin
//#UC START# *54B352A903E5_4FF2EABA02D7_impl*
 l_TabCaption := DoMakeFormSetTabCaption(aDataSource);
 Result := l3Cat([str_fsAACCaption.AsCStr, l3CStr(' : '), l_TabCaption]);
//#UC END# *54B352A903E5_4FF2EABA02D7_impl*
end;//Tfs_AAC.DoMakeFormSetCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function Tfs_AAC.DoMakeFormSetTabCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
//#UC START# *54B352D401E5_4FF2EABA02D7_var*
var
 l_sds: IsdsAAC;
//#UC END# *54B352D401E5_4FF2EABA02D7_var*
begin
//#UC START# *54B352D401E5_4FF2EABA02D7_impl*
 if Supports(aDataSource, IsdsAAC, l_sds) and
    (l_sds.Left <> nil) then
  Result := l_sds.Left.GetDocumentName
 else
  Result := nil;
//#UC END# *54B352D401E5_4FF2EABA02D7_impl*
end;//Tfs_AAC.DoMakeFormSetTabCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function Tfs_AAC.DoMakeFormSetTabHint(const aDataSource: IvcmFormSetDataSource): IvcmCString;
//#UC START# *54B352FB03A1_4FF2EABA02D7_var*
//#UC END# *54B352FB03A1_4FF2EABA02D7_var*
begin
//#UC START# *54B352FB03A1_4FF2EABA02D7_impl*
 Result := DoMakeFormSetCaption(aDataSource);
//#UC END# *54B352FB03A1_4FF2EABA02D7_impl*
end;//Tfs_AAC.DoMakeFormSetTabHint
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_AACFormsetCaptionPrefix.Init;
 {* Инициализация str_AACFormsetCaptionPrefix }
 str_fsAACCaption.Init;
 {* Инициализация str_fsAACCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
