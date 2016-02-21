unit AACPrim_Module;
 {* Реализация прецедента "Актуальная аналитика". [RequestLink:365838080] }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\AACPrim_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , AACTextContainerPrim_Form
 , AACContainerPrim_Form
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , fsAbstractDocument
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , AACContainerPrim_AACContentsContainer_UserType
 , WorkWithDocumentInterfaces
 , Common_FormDefinitions_Controls
 , DocumentUserTypes_dftAACContentsLeft_UserType
 , nevTools
 , bsTypes
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentAndListInterfaces
 , DocumentUnit
 , bsTypesNew
 , l3Interfaces
 , DocumentUserTypes_dftAACContentsRight_UserType
 , AACContainerPrim_AACContainer_UserType
 , DocumentUserTypes_dftAACLeft_UserType
 , DocumentUserTypes_dftAACRight_UserType
 , BaloonWarningUserTypes_WarnJuror_UserType
 , nsTypes
 , nevBase
;

const
 fm_AACContainerForm: TvcmFormDescriptor = (rFormID : (rName : 'AACContainerForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TAACContainerForm }

const
 fm_AACContentsContainerForm: TvcmFormDescriptor = (rFormID : (rName : 'AACContentsContainerForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TAACContentsContainerForm }

type
 AACContainerFormDef = interface
  {* Идентификатор формы AACContainer }
  ['{548CB0E3-A19F-4AD8-A785-C6FB8E70BF73}']
 end;//AACContainerFormDef

 TAACContainerForm = {final} class(TAACTextContainerPrimForm, AACContainerFormDef)
 end;//TAACContainerForm

 AACContentsContainerFormDef = interface
  {* Идентификатор формы AACContentsContainer }
  ['{3EBD2AC1-BEED-4678-BF35-5B80CE4A6852}']
 end;//AACContentsContainerFormDef

 TAACContentsContainerForm = {final} class(TAACContainerPrimForm, AACContentsContainerFormDef)
 end;//TAACContentsContainerForm

 // Left

 // Right

 // AACContainer

 Tfs_AACContents = {final} class(TvcmFormSetFactory)
  {* Сборка для документа ОГЛАВЛЕНИЯ ААК }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function AACContainer_Parent_AACContentsContainer_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для AACContainer }
   function Left_Child_dftAACContentsLeft_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Left }
   function Right_Main_dftAACContentsRight_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Right }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_AACContents;
    {* Метод получения экземпляра синглетона Tfs_AACContents }
 end;//Tfs_AACContents

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

 TAACPrimModule = class
  {* Реализация прецедента "Актуальная аналитика". [RequestLink:365838080] }
  public
   procedure MakeAAC(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* Создаёт сборку для документа ААК }
   procedure MakeAACContents(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* Создаёт сборку для документа ОГЛАВЛЕНИЯ ААК }
 end;//TAACPrimModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , sdsAAC
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , AACContainerKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , AACContentsContainerKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 , l3String
 , l3MessageID
;

var g_Tfs_AACContents: Tfs_AACContents = nil;
 {* Экземпляр синглетона Tfs_AACContents }
var g_Tfs_AAC: Tfs_AAC = nil;
 {* Экземпляр синглетона Tfs_AAC }

const
 {* Локализуемые строки Tab consts }
 str_AACFormsetCaptionPrefix: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AACFormsetCaptionPrefix'; rValue : 'Текст');
  {* 'Текст' }
 {* Локализуемые строки AAC$FormSetFactoryCaptionLocalConstants }
 str_fsAACCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsAACCaption'; rValue : 'Текст');
  {* Заголовок фабрики сборки форм "AAC$FormSetFactory" }

procedure Tfs_AACContentsFree;
 {* Метод освобождения экземпляра синглетона Tfs_AACContents }
begin
 l3Free(g_Tfs_AACContents);
end;//Tfs_AACContentsFree

procedure Tfs_AACFree;
 {* Метод освобождения экземпляра синглетона Tfs_AAC }
begin
 l3Free(g_Tfs_AAC);
end;//Tfs_AACFree

function Tfs_AACContents.AACContainer_Parent_AACContentsContainer_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для AACContainer }
//#UC START# *F555D8D7FD5B_4FF4428702F0_var*
//#UC END# *F555D8D7FD5B_4FF4428702F0_var*
begin
//#UC START# *F555D8D7FD5B_4FF4428702F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *F555D8D7FD5B_4FF4428702F0_impl*
end;//Tfs_AACContents.AACContainer_Parent_AACContentsContainer_NeedMakeForm

function Tfs_AACContents.Left_Child_dftAACContentsLeft_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Left }
//#UC START# *0CFD7C2853E7_4FF4428702F0_var*
//#UC END# *0CFD7C2853E7_4FF4428702F0_var*
begin
//#UC START# *0CFD7C2853E7_4FF4428702F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *0CFD7C2853E7_4FF4428702F0_impl*
end;//Tfs_AACContents.Left_Child_dftAACContentsLeft_NeedMakeForm

function Tfs_AACContents.Right_Main_dftAACContentsRight_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Right }
//#UC START# *88C068C02878_4FF4428702F0_var*
//#UC END# *88C068C02878_4FF4428702F0_var*
begin
//#UC START# *88C068C02878_4FF4428702F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *88C068C02878_4FF4428702F0_impl*
end;//Tfs_AACContents.Right_Main_dftAACContentsRight_NeedMakeForm

class function Tfs_AACContents.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_AACContents <> nil;
end;//Tfs_AACContents.Exists

class function Tfs_AACContents.Instance: Tfs_AACContents;
 {* Метод получения экземпляра синглетона Tfs_AACContents }
begin
 if (g_Tfs_AACContents = nil) then
 begin
  l3System.AddExitProc(Tfs_AACContentsFree);
  g_Tfs_AACContents := Create;
 end;
 Result := g_Tfs_AACContents;
end;//Tfs_AACContents.Instance

procedure Tfs_AACContents.InitFields;
//#UC START# *47A042E100E2_4FF4428702F0_var*
//#UC END# *47A042E100E2_4FF4428702F0_var*
begin
//#UC START# *47A042E100E2_4FF4428702F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4FF4428702F0_impl*
end;//Tfs_AACContents.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_AACContents.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4FF4428702F0_var*
//#UC END# *4FFE854A009B_4FF4428702F0_var*
begin
//#UC START# *4FFE854A009B_4FF4428702F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4FF4428702F0_impl*
end;//Tfs_AACContents.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

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
//#UC END# *54B352A903E5_4FF2EABA02D7_var*
begin
//#UC START# *54B352A903E5_4FF2EABA02D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *54B352A903E5_4FF2EABA02D7_impl*
end;//Tfs_AAC.DoMakeFormSetCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function Tfs_AAC.DoMakeFormSetTabCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
//#UC START# *54B352D401E5_4FF2EABA02D7_var*
//#UC END# *54B352D401E5_4FF2EABA02D7_var*
begin
//#UC START# *54B352D401E5_4FF2EABA02D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *54B352D401E5_4FF2EABA02D7_impl*
end;//Tfs_AAC.DoMakeFormSetTabCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function Tfs_AAC.DoMakeFormSetTabHint(const aDataSource: IvcmFormSetDataSource): IvcmCString;
//#UC START# *54B352FB03A1_4FF2EABA02D7_var*
//#UC END# *54B352FB03A1_4FF2EABA02D7_var*
begin
//#UC START# *54B352FB03A1_4FF2EABA02D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *54B352FB03A1_4FF2EABA02D7_impl*
end;//Tfs_AAC.DoMakeFormSetTabHint
{$IfEnd} // NOT Defined(NoVCM)

procedure TAACPrimModule.MakeAAC(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* Создаёт сборку для документа ААК }
//#UC START# *4FF3FEC70302_4FF2E5C70060_var*
//#UC END# *4FF3FEC70302_4FF2E5C70060_var*
begin
//#UC START# *4FF3FEC70302_4FF2E5C70060_impl*
  Tfs_AAC.Make(TsdsAAC.Make(aDocInfo), CheckContainer(aContainer));
//#UC END# *4FF3FEC70302_4FF2E5C70060_impl*
end;//TAACPrimModule.MakeAAC

procedure TAACPrimModule.MakeAACContents(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* Создаёт сборку для документа ОГЛАВЛЕНИЯ ААК }
//#UC START# *4FF428150001_4FF2E5C70060_var*
//#UC END# *4FF428150001_4FF2E5C70060_var*
begin
//#UC START# *4FF428150001_4FF2E5C70060_impl*
  Tfs_AACContents.Make(TsdsAAC.Make(aDocInfo), CheckContainer(aContainer));
//#UC END# *4FF428150001_4FF2E5C70060_impl*
end;//TAACPrimModule.MakeAACContents

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAACContainerForm);
 {* Регистрация AACContainer }
{$IfEnd} // NOT Defined(NoScripts)
 fm_AACContainerForm.SetFactory(TAACContainerForm.Make);
 {* Регистрация фабрики формы AACContainer }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAACContentsContainerForm);
 {* Регистрация AACContentsContainer }
{$IfEnd} // NOT Defined(NoScripts)
 fm_AACContentsContainerForm.SetFactory(TAACContentsContainerForm.Make);
 {* Регистрация фабрики формы AACContentsContainer }
 str_AACFormsetCaptionPrefix.Init;
 {* Инициализация str_AACFormsetCaptionPrefix }
 str_fsAACCaption.Init;
 {* Инициализация str_fsAACCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
