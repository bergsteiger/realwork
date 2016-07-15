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
 , DocumentAndListInterfaces
 , DocumentUnit
 , bsTypesNew
 , PrimNewsLine_nltMain_UserType
;

type
 Tfs_Autoreferat = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function TextFormParentDftAutoreferatNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для TextForm }
   function NewsLineNavigatorNltMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для NewsLine }
   class function Instance: Tfs_Autoreferat;
    {* Метод получения экземпляра синглетона Tfs_Autoreferat }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_Autoreferat
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

function Tfs_Autoreferat.TextFormParentDftAutoreferatNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для TextForm }
var
 l_UseCase : IsdsAutoreferat;
begin
 if Supports(aDataSource, IsdsAutoreferat, l_UseCase) then
  try
  //#UC START# *4FFA8808003ENeedMake_impl*
   aNew := l_UseCase.dsDocument;
  //#UC END# *4FFA8808003ENeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Autoreferat.TextFormParentDftAutoreferatNeedMakeForm

function Tfs_Autoreferat.NewsLineNavigatorNltMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для NewsLine }
var
 l_UseCase : IsdsAutoreferat;
begin
 if Supports(aDataSource, IsdsAutoreferat, l_UseCase) then
  try
  //#UC START# *4FFA88E3034ENeedMake_impl*
   aNew := l_UseCase.MakeNewsLineFakeDS;
  //#UC END# *4FFA88E3034ENeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Autoreferat.NewsLineNavigatorNltMainNeedMakeForm

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

class function Tfs_Autoreferat.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_Autoreferat <> nil;
end;//Tfs_Autoreferat.Exists

procedure Tfs_Autoreferat.InitFields;
begin
 inherited;
 with AddZone('TextForm', vcm_ztParent, fm_TextForm) do
 begin
  UserType := dftAutoreferat;
  OnNeedMakeForm := TextFormParentDftAutoreferatNeedMakeForm;
 end;
 with AddZone('NewsLine', vcm_ztNavigator, fm_enNewsLine) do
 begin
  UserType := nltMain;
  ActivateIfUpdate := wafIfNotActivated;
  OnNeedMakeForm := NewsLineNavigatorNltMainNeedMakeForm;
 end;
 Caption := str_fsAutoreferatCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_Autoreferat.InitFields

class function Tfs_Autoreferat.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_Autoreferat.GetInstance

initialization
 str_fsAutoreferatCaption.Init;
 {* Инициализация str_fsAutoreferatCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
