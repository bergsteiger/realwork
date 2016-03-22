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
 , bsTypesNew
 , l3Interfaces
 , DocumentUserTypes_dftAACRight_UserType
 , BaloonWarningUserTypes_WarnJuror_UserType
 , nsTypes
 , nevBase
;

type
 // WarnJuror

 // Left

 // Right

 // AACContainer

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
   function AACContainer_Parent_AACContainer_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для AACContainer }
   function Left_Child_dftAACLeft_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Left }
   function WarnJuror_Child_WarnJuror_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnJuror }
   function Right_Main_dftAACRight_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Right }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_AAC;
    {* Метод получения экземпляра синглетона Tfs_AAC }
 end;//Tfs_AAC
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3String
 , l3MessageID
 , SysUtils
 , l3Base
;

var g_Tfs_AAC: Tfs_AAC = nil;
 {* Экземпляр синглетона Tfs_AAC }

const
 {* Локализуемые строки Tab consts }
 str_AACFormsetCaptionPrefix: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AACFormsetCaptionPrefix'; rValue : 'Текст');
  {* 'Текст' }
 {* Локализуемые строки AAC$FormSetFactoryCaptionLocalConstants }
 str_fsAACCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsAACCaption'; rValue : 'Текст');
  {* Заголовок фабрики сборки форм "AAC$FormSetFactory" }

procedure Tfs_AACFree;
 {* Метод освобождения экземпляра синглетона Tfs_AAC }
begin
 l3Free(g_Tfs_AAC);
end;//Tfs_AACFree

function Tfs_AAC.AACContainer_Parent_AACContainer_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для AACContainer }
//#UC START# *21728C230D8E_4FF2EABA02D7_var*
//#UC END# *21728C230D8E_4FF2EABA02D7_var*
begin
//#UC START# *21728C230D8E_4FF2EABA02D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *21728C230D8E_4FF2EABA02D7_impl*
end;//Tfs_AAC.AACContainer_Parent_AACContainer_NeedMakeForm

function Tfs_AAC.Left_Child_dftAACLeft_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Left }
//#UC START# *938DD0F86F72_4FF2EABA02D7_var*
//#UC END# *938DD0F86F72_4FF2EABA02D7_var*
begin
//#UC START# *938DD0F86F72_4FF2EABA02D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *938DD0F86F72_4FF2EABA02D7_impl*
end;//Tfs_AAC.Left_Child_dftAACLeft_NeedMakeForm

function Tfs_AAC.WarnJuror_Child_WarnJuror_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnJuror }
//#UC START# *595B3BC462F1_4FF2EABA02D7_var*
//#UC END# *595B3BC462F1_4FF2EABA02D7_var*
begin
//#UC START# *595B3BC462F1_4FF2EABA02D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *595B3BC462F1_4FF2EABA02D7_impl*
end;//Tfs_AAC.WarnJuror_Child_WarnJuror_NeedMakeForm

function Tfs_AAC.Right_Main_dftAACRight_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Right }
//#UC START# *C38CB7D1BCCF_4FF2EABA02D7_var*
//#UC END# *C38CB7D1BCCF_4FF2EABA02D7_var*
begin
//#UC START# *C38CB7D1BCCF_4FF2EABA02D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *C38CB7D1BCCF_4FF2EABA02D7_impl*
end;//Tfs_AAC.Right_Main_dftAACRight_NeedMakeForm

class function Tfs_AAC.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_AAC <> nil;
end;//Tfs_AAC.Exists

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

procedure Tfs_AAC.InitFields;
//#UC START# *47A042E100E2_4FF2EABA02D7_var*
//#UC END# *47A042E100E2_4FF2EABA02D7_var*
begin
//#UC START# *47A042E100E2_4FF2EABA02D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4FF2EABA02D7_impl*
end;//Tfs_AAC.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_AAC.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4FF2EABA02D7_var*
//#UC END# *4FFE854A009B_4FF2EABA02D7_var*
begin
//#UC START# *4FFE854A009B_4FF2EABA02D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4FF2EABA02D7_impl*
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
