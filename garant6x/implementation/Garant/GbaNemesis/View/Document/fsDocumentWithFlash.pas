unit fsDocumentWithFlash;
 {* Схема }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\fsDocumentWithFlash.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "DocumentWithFlash" MUID: (4AA126F9032A)
// Имя типа: "Tfs_DocumentWithFlash"

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
 , DocumentWithFlashUserTypes_dwftMain_UserType
 , Common_FormDefinitions_Controls
 , DocInfoInterfaces
 , DocumentInterfaces
 , nevTools
 , bsTypes
 , evdInterfaces
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentAndListInterfaces
 , DocumentUnit
 , l3Interfaces
 , bsTypesNew
;

type
 Tfs_DocumentWithFlash = {final} class(Tfs_AbstractDocument)
  {* Схема }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function TextParentDwftMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Text }
   class function Instance: Tfs_DocumentWithFlash;
    {* Метод получения экземпляра синглетона Tfs_DocumentWithFlash }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_DocumentWithFlash
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Base
 //#UC START# *4AA126F9032Aimpl_uses*
 //#UC END# *4AA126F9032Aimpl_uses*
;

var g_Tfs_DocumentWithFlash: Tfs_DocumentWithFlash = nil;
 {* Экземпляр синглетона Tfs_DocumentWithFlash }

const
 {* Локализуемые строки DocumentWithFlash }
 str_fsDocumentWithFlashCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDocumentWithFlashCaption'; rValue : 'Схема');
  {* Заголовок фабрики сборки форм "DocumentWithFlash$FSF" }

procedure Tfs_DocumentWithFlashFree;
 {* Метод освобождения экземпляра синглетона Tfs_DocumentWithFlash }
begin
 l3Free(g_Tfs_DocumentWithFlash);
end;//Tfs_DocumentWithFlashFree

function Tfs_DocumentWithFlash.TextParentDwftMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsDocumentWithFlash;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_DocumentWithFlash.TextParentDwftMainNeedMakeForm

class function Tfs_DocumentWithFlash.Instance: Tfs_DocumentWithFlash;
 {* Метод получения экземпляра синглетона Tfs_DocumentWithFlash }
begin
 if (g_Tfs_DocumentWithFlash = nil) then
 begin
  l3System.AddExitProc(Tfs_DocumentWithFlashFree);
  g_Tfs_DocumentWithFlash := Create;
 end;
 Result := g_Tfs_DocumentWithFlash;
end;//Tfs_DocumentWithFlash.Instance

class function Tfs_DocumentWithFlash.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_DocumentWithFlash <> nil;
end;//Tfs_DocumentWithFlash.Exists

procedure Tfs_DocumentWithFlash.InitFields;
begin
 inherited;
 with AddZone('Text', vcm_ztParent, fm_DocumentWithFlashForm) do
 begin
  UserType := dwftMain;
  OnNeedMakeForm := TextParentDwftMainNeedMakeForm;
 end;
 Caption := str_fsDocumentWithFlashCaption.AsCStr;
 OwnerForm := 16;
end;//Tfs_DocumentWithFlash.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_DocumentWithFlash.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_DocumentWithFlash.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_fsDocumentWithFlashCaption.Init;
 {* Инициализация str_fsDocumentWithFlashCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
