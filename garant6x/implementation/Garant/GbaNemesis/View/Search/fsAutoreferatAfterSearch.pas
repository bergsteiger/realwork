unit fsAutoreferatAfterSearch;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\fsAutoreferatAfterSearch.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "AutoreferatAfterSearch" MUID: (4AA4B28D02A1)
// Имя типа: "Tfs_AutoreferatAfterSearch"

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
 , DocumentUserTypes_dftAutoreferatAfterSearch_UserType
 , Common_FormDefinitions_Controls
 , AutoreferatInterfaces
 , DocumentInterfaces
 , DocumentAndListInterfaces
 , DocumentUnit
 , bsTypesNew
;

type
 Tfs_AutoreferatAfterSearch = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function TextFormParentDftAutoreferatAfterSearchNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для TextForm }
   class function Instance: Tfs_AutoreferatAfterSearch;
    {* Метод получения экземпляра синглетона Tfs_AutoreferatAfterSearch }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_AutoreferatAfterSearch
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Base
 //#UC START# *4AA4B28D02A1impl_uses*
 //#UC END# *4AA4B28D02A1impl_uses*
;

{$If NOT Defined(NoVCM)}
var g_Tfs_AutoreferatAfterSearch: Tfs_AutoreferatAfterSearch = nil;
 {* Экземпляр синглетона Tfs_AutoreferatAfterSearch }

const
 {* Локализуемые строки AutoreferatAfterSearchCaptionLocalConstants }
 str_fsAutoreferatAfterSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsAutoreferatAfterSearchCaption'; rValue : '#1040#1074#1090#1086#1088#1077#1092#1077#1088#1072#1090 #1087#1086#1089#1083#1077 #1087#1086#1080#1089#1082#1072');
  {* Заголовок фабрики сборки форм "AutoreferatAfterSearch" }

procedure Tfs_AutoreferatAfterSearchFree;
 {* Метод освобождения экземпляра синглетона Tfs_AutoreferatAfterSearch }
begin
 l3Free(g_Tfs_AutoreferatAfterSearch);
end;//Tfs_AutoreferatAfterSearchFree

function Tfs_AutoreferatAfterSearch.TextFormParentDftAutoreferatAfterSearchNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для TextForm }
var
 l_UseCase : IsdsAutoreferat;
begin
 if Supports(aDataSource, IsdsAutoreferat, l_UseCase) then
  try
  //#UC START# *4FFA92850358NeedMake_impl*
   aNew := l_UseCase.dsDocument;
  //#UC END# *4FFA92850358NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AutoreferatAfterSearch.TextFormParentDftAutoreferatAfterSearchNeedMakeForm

class function Tfs_AutoreferatAfterSearch.Instance: Tfs_AutoreferatAfterSearch;
 {* Метод получения экземпляра синглетона Tfs_AutoreferatAfterSearch }
begin
 if (g_Tfs_AutoreferatAfterSearch = nil) then
 begin
  l3System.AddExitProc(Tfs_AutoreferatAfterSearchFree);
  g_Tfs_AutoreferatAfterSearch := Create;
 end;
 Result := g_Tfs_AutoreferatAfterSearch;
end;//Tfs_AutoreferatAfterSearch.Instance

class function Tfs_AutoreferatAfterSearch.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_AutoreferatAfterSearch <> nil;
end;//Tfs_AutoreferatAfterSearch.Exists

procedure Tfs_AutoreferatAfterSearch.InitFields;
begin
 inherited;
 with AddZone('TextForm', vcm_ztParent, fm_TextForm) do
 begin
  UserType := dftAutoreferatAfterSearch;
  OnNeedMakeForm := TextFormParentDftAutoreferatAfterSearchNeedMakeForm;
 end;
 Caption := str_fsAutoreferatAfterSearchCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_AutoreferatAfterSearch.InitFields

class function Tfs_AutoreferatAfterSearch.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_AutoreferatAfterSearch.GetInstance

initialization
 str_fsAutoreferatAfterSearchCaption.Init;
 {* Инициализация str_fsAutoreferatAfterSearchCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
