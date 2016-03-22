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
 , DocumentUnit
 , bsTypesNew
;

type
 // TextForm

 Tfs_AutoreferatAfterSearch = {final} class(TvcmFormSetFactory)
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function TextForm_Parent_dftAutoreferatAfterSearch_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для TextForm }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_AutoreferatAfterSearch;
    {* Метод получения экземпляра синглетона Tfs_AutoreferatAfterSearch }
 end;//Tfs_AutoreferatAfterSearch
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 , SysUtils
 , l3Base
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

function Tfs_AutoreferatAfterSearch.TextForm_Parent_dftAutoreferatAfterSearch_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для TextForm }
//#UC START# *CAF00B32945C_4AA4B28D02A1_var*
//#UC END# *CAF00B32945C_4AA4B28D02A1_var*
begin
//#UC START# *CAF00B32945C_4AA4B28D02A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *CAF00B32945C_4AA4B28D02A1_impl*
end;//Tfs_AutoreferatAfterSearch.TextForm_Parent_dftAutoreferatAfterSearch_NeedMakeForm

class function Tfs_AutoreferatAfterSearch.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_AutoreferatAfterSearch <> nil;
end;//Tfs_AutoreferatAfterSearch.Exists

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

procedure Tfs_AutoreferatAfterSearch.InitFields;
//#UC START# *47A042E100E2_4AA4B28D02A1_var*
//#UC END# *47A042E100E2_4AA4B28D02A1_var*
begin
//#UC START# *47A042E100E2_4AA4B28D02A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA4B28D02A1_impl*
end;//Tfs_AutoreferatAfterSearch.InitFields

class function Tfs_AutoreferatAfterSearch.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA4B28D02A1_var*
//#UC END# *4FFE854A009B_4AA4B28D02A1_var*
begin
//#UC START# *4FFE854A009B_4AA4B28D02A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA4B28D02A1_impl*
end;//Tfs_AutoreferatAfterSearch.GetInstance

initialization
 str_fsAutoreferatAfterSearchCaption.Init;
 {* Инициализация str_fsAutoreferatAfterSearchCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
