unit fsDocument;
 {* Документ }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\fsDocument.pas"
// Стереотип: "VCMFormSetFactory"

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
 , DocumentUserTypes_dftDocument_UserType
 , Common_FormDefinitions_Controls
 , DocumentAndListInterfaces
 , nevTools
 , DocumentInterfaces
 , bsTypes
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentUnit
 , bsTypesNew
 , l3Interfaces
 , BaloonWarningUserTypes_WarnJuror_UserType
 , WorkWithDocumentInterfaces
 , nsTypes
 , nevBase
 , BaloonWarningUserTypes_WarnPreActive_UserType
 , BaloonWarningUserTypes_WarnIsAbolished_UserType
 , BaloonWarningUserTypes_WarnOnControl_UserType
 , BaloonWarningUserTypes_WarnInactualDocument_UserType
 , BaloonWarningUserTypes_WarnTimeMachineOn_UserType
 , BaloonWarningUserTypes_WarnRedaction_UserType
 , BaloonWarningUserTypes_WarnTimeMachineWarning_UserType
 , BaloonWarningUserTypes_WarnTimeMachineException_UserType
;

type
 // WarnJuror

 // WarnPreActive

 // WarnIsAbolished

 // WarnOnControl

 // WarnInactualDocument

 // WarnTimeMachineOn

 // WarnRedaction

 // WarnTimeMachineWarning

 // WarnTimeMachineException

 // Text

 Tfs_Document = {final} class(Tfs_AbstractDocument)
  {* Документ }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Text_Parent_dftDocument_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Text }
   function WarnJuror_Child_WarnJuror_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnJuror }
   function WarnPreActive_Child_WarnPreActive_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnPreActive }
   function WarnIsAbolished_Child_WarnIsAbolished_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnIsAbolished }
   function WarnOnControl_Child_WarnOnControl_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnOnControl }
   function WarnInactualDocument_Child_WarnInactualDocument_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnInactualDocument }
   function WarnTimeMachineOn_Child_WarnTimeMachineOn_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnTimeMachineOn }
   function WarnRedaction_Child_WarnRedaction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnRedaction }
   function WarnTimeMachineWarning_Child_WarnTimeMachineWarning_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnTimeMachineWarning }
   function WarnTimeMachineException_Child_WarnTimeMachineException_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnTimeMachineException }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_Document;
    {* Метод получения экземпляра синглетона Tfs_Document }
 end;//Tfs_Document
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , bsUtils
 , l3MessageID
 , SysUtils
 , l3Base
;

var g_Tfs_Document: Tfs_Document = nil;
 {* Экземпляр синглетона Tfs_Document }

const
 {* Локализуемые строки DocumentCaptionLocalConstants }
 str_fsDocumentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDocumentCaption'; rValue : 'Текст');
  {* Заголовок фабрики сборки форм "Document" }

procedure Tfs_DocumentFree;
 {* Метод освобождения экземпляра синглетона Tfs_Document }
begin
 l3Free(g_Tfs_Document);
end;//Tfs_DocumentFree

function Tfs_Document.Text_Parent_dftDocument_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
//#UC START# *DF28287EBCC9_4AA126C401AD_var*
//#UC END# *DF28287EBCC9_4AA126C401AD_var*
begin
//#UC START# *DF28287EBCC9_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *DF28287EBCC9_4AA126C401AD_impl*
end;//Tfs_Document.Text_Parent_dftDocument_NeedMakeForm

function Tfs_Document.WarnJuror_Child_WarnJuror_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnJuror }
//#UC START# *25A9BEF142E9_4AA126C401AD_var*
//#UC END# *25A9BEF142E9_4AA126C401AD_var*
begin
//#UC START# *25A9BEF142E9_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *25A9BEF142E9_4AA126C401AD_impl*
end;//Tfs_Document.WarnJuror_Child_WarnJuror_NeedMakeForm

function Tfs_Document.WarnPreActive_Child_WarnPreActive_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnPreActive }
//#UC START# *3D661BE47244_4AA126C401AD_var*
//#UC END# *3D661BE47244_4AA126C401AD_var*
begin
//#UC START# *3D661BE47244_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *3D661BE47244_4AA126C401AD_impl*
end;//Tfs_Document.WarnPreActive_Child_WarnPreActive_NeedMakeForm

function Tfs_Document.WarnIsAbolished_Child_WarnIsAbolished_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnIsAbolished }
//#UC START# *DC9C49363B56_4AA126C401AD_var*
//#UC END# *DC9C49363B56_4AA126C401AD_var*
begin
//#UC START# *DC9C49363B56_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *DC9C49363B56_4AA126C401AD_impl*
end;//Tfs_Document.WarnIsAbolished_Child_WarnIsAbolished_NeedMakeForm

function Tfs_Document.WarnOnControl_Child_WarnOnControl_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnOnControl }
//#UC START# *ADB5561ABC86_4AA126C401AD_var*
//#UC END# *ADB5561ABC86_4AA126C401AD_var*
begin
//#UC START# *ADB5561ABC86_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *ADB5561ABC86_4AA126C401AD_impl*
end;//Tfs_Document.WarnOnControl_Child_WarnOnControl_NeedMakeForm

function Tfs_Document.WarnInactualDocument_Child_WarnInactualDocument_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnInactualDocument }
//#UC START# *A0E6E9A93B48_4AA126C401AD_var*
//#UC END# *A0E6E9A93B48_4AA126C401AD_var*
begin
//#UC START# *A0E6E9A93B48_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *A0E6E9A93B48_4AA126C401AD_impl*
end;//Tfs_Document.WarnInactualDocument_Child_WarnInactualDocument_NeedMakeForm

function Tfs_Document.WarnTimeMachineOn_Child_WarnTimeMachineOn_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnTimeMachineOn }
//#UC START# *354A37DBC5E2_4AA126C401AD_var*
//#UC END# *354A37DBC5E2_4AA126C401AD_var*
begin
//#UC START# *354A37DBC5E2_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *354A37DBC5E2_4AA126C401AD_impl*
end;//Tfs_Document.WarnTimeMachineOn_Child_WarnTimeMachineOn_NeedMakeForm

function Tfs_Document.WarnRedaction_Child_WarnRedaction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnRedaction }
//#UC START# *36AE71BFE5A8_4AA126C401AD_var*
//#UC END# *36AE71BFE5A8_4AA126C401AD_var*
begin
//#UC START# *36AE71BFE5A8_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *36AE71BFE5A8_4AA126C401AD_impl*
end;//Tfs_Document.WarnRedaction_Child_WarnRedaction_NeedMakeForm

function Tfs_Document.WarnTimeMachineWarning_Child_WarnTimeMachineWarning_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnTimeMachineWarning }
//#UC START# *8676CCD264AD_4AA126C401AD_var*
//#UC END# *8676CCD264AD_4AA126C401AD_var*
begin
//#UC START# *8676CCD264AD_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *8676CCD264AD_4AA126C401AD_impl*
end;//Tfs_Document.WarnTimeMachineWarning_Child_WarnTimeMachineWarning_NeedMakeForm

function Tfs_Document.WarnTimeMachineException_Child_WarnTimeMachineException_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnTimeMachineException }
//#UC START# *37EF13598A94_4AA126C401AD_var*
//#UC END# *37EF13598A94_4AA126C401AD_var*
begin
//#UC START# *37EF13598A94_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *37EF13598A94_4AA126C401AD_impl*
end;//Tfs_Document.WarnTimeMachineException_Child_WarnTimeMachineException_NeedMakeForm

class function Tfs_Document.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_Document <> nil;
end;//Tfs_Document.Exists

class function Tfs_Document.Instance: Tfs_Document;
 {* Метод получения экземпляра синглетона Tfs_Document }
begin
 if (g_Tfs_Document = nil) then
 begin
  l3System.AddExitProc(Tfs_DocumentFree);
  g_Tfs_Document := Create;
 end;
 Result := g_Tfs_Document;
end;//Tfs_Document.Instance

procedure Tfs_Document.InitFields;
//#UC START# *47A042E100E2_4AA126C401AD_var*
//#UC END# *47A042E100E2_4AA126C401AD_var*
begin
//#UC START# *47A042E100E2_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA126C401AD_impl*
end;//Tfs_Document.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_Document.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA126C401AD_var*
//#UC END# *4FFE854A009B_4AA126C401AD_var*
begin
//#UC START# *4FFE854A009B_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA126C401AD_impl*
end;//Tfs_Document.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_fsDocumentCaption.Init;
 {* Инициализация str_fsDocumentCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
