unit fsAutoreferat;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\fsAutoreferat.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "Autoreferat" MUID: (4AA4B279031D)
// Имя типа: "Tfs_Autoreferat"

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
 , DocumentUserTypes_dftAutoreferat_UserType
 , Common_FormDefinitions_Controls
 , AutoreferatInterfaces
 , DocumentInterfaces
 , DocumentUnit
 , bsTypesNew
 , PrimNewsLine_nltMain_UserType
;

type
 // TextForm

 // NewsLine

 Tfs_Autoreferat = {final} class(TvcmFormSetFactory)
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function TextForm_Parent_dftAutoreferat_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для TextForm }
   function NewsLine_Navigator_nltMain_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для NewsLine }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_Autoreferat;
    {* Метод получения экземпляра синглетона Tfs_Autoreferat }
 end;//Tfs_Autoreferat
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
var g_Tfs_Autoreferat: Tfs_Autoreferat = nil;
 {* Экземпляр синглетона Tfs_Autoreferat }

const
 {* Локализуемые строки AutoreferatCaptionLocalConstants }
 str_fsAutoreferatCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsAutoreferatCaption'; rValue : '#1044#1086#1082#1091#1084#1077#1085#1090');
  {* Заголовок фабрики сборки форм "Autoreferat" }

procedure Tfs_AutoreferatFree;
 {* Метод освобождения экземпляра синглетона Tfs_Autoreferat }
begin
 l3Free(g_Tfs_Autoreferat);
end;//Tfs_AutoreferatFree

function Tfs_Autoreferat.TextForm_Parent_dftAutoreferat_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для TextForm }
//#UC START# *FDD93F11843B_4AA4B279031D_var*
//#UC END# *FDD93F11843B_4AA4B279031D_var*
begin
//#UC START# *FDD93F11843B_4AA4B279031D_impl*
 !!! Needs to be implemented !!!
//#UC END# *FDD93F11843B_4AA4B279031D_impl*
end;//Tfs_Autoreferat.TextForm_Parent_dftAutoreferat_NeedMakeForm

function Tfs_Autoreferat.NewsLine_Navigator_nltMain_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для NewsLine }
//#UC START# *28B4B9654C1B_4AA4B279031D_var*
//#UC END# *28B4B9654C1B_4AA4B279031D_var*
begin
//#UC START# *28B4B9654C1B_4AA4B279031D_impl*
 !!! Needs to be implemented !!!
//#UC END# *28B4B9654C1B_4AA4B279031D_impl*
end;//Tfs_Autoreferat.NewsLine_Navigator_nltMain_NeedMakeForm

class function Tfs_Autoreferat.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_Autoreferat <> nil;
end;//Tfs_Autoreferat.Exists

class function Tfs_Autoreferat.Instance: Tfs_Autoreferat;
 {* Метод получения экземпляра синглетона Tfs_Autoreferat }
begin
 if (g_Tfs_Autoreferat = nil) then
 begin
  l3System.AddExitProc(Tfs_AutoreferatFree);
  g_Tfs_Autoreferat := Create;
 end;
 Result := g_Tfs_Autoreferat;
end;//Tfs_Autoreferat.Instance

procedure Tfs_Autoreferat.InitFields;
//#UC START# *47A042E100E2_4AA4B279031D_var*
//#UC END# *47A042E100E2_4AA4B279031D_var*
begin
//#UC START# *47A042E100E2_4AA4B279031D_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA4B279031D_impl*
end;//Tfs_Autoreferat.InitFields

class function Tfs_Autoreferat.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA4B279031D_var*
//#UC END# *4FFE854A009B_4AA4B279031D_var*
begin
//#UC START# *4FFE854A009B_4AA4B279031D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA4B279031D_impl*
end;//Tfs_Autoreferat.GetInstance

initialization
 str_fsAutoreferatCaption.Init;
 {* Инициализация str_fsAutoreferatCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
