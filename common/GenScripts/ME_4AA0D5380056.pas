unit DayTips_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\DayTips_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , CommonDictionInterfaces
 , DayTipsInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
 , DocumentUserTypes_dftTips_UserType
 , Common_FormDefinitions_Controls
 , DocumentAndListInterfaces
 , nevTools
 , bsTypes
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentUnit
 , bsTypesNew
 , l3Interfaces
 , AttributesUserTypes_fDocAttribute_UserType
 , BaseDocumentWithAttributesInterfaces
 , l3InternalInterfaces
 , l3TreeInterfaces
 , PrimCommonDiction_utTips_UserType
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , PrimStartupTips_Form
;

const
 fm_efStartupTips: TvcmFormDescriptor = (rFormID : (rName : 'efStartupTips'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefStartupTips }

type
 // TextForm

 // Attributes

 // CommonDiction

 Tfs_Tips = {final} class(TvcmFormSetFactory)
  {* Советы дня }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function TextForm_Parent_dftTips_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для TextForm }
   function Attributes_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Attributes }
   function CommonDiction_Navigator_utTips_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для CommonDiction }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_Tips;
    {* Метод получения экземпляра синглетона Tfs_Tips }
 end;//Tfs_Tips

 StartupTipsFormDef = interface
  {* Идентификатор формы StartupTips }
  ['{69581B33-5C00-46C8-8723-A5DE81DDD577}']
 end;//StartupTipsFormDef

 TefStartupTips = {final} class(TPrimStartupTipsForm, StartupTipsFormDef)
  {* Совет дня }
 end;//TefStartupTips

 TDayTipsModule = class
  protected
   procedure OpenTipsPrim(const aSDS: IsdsCommonDiction;
    const aContainer: IvcmContainer);
   procedure ShowDayTips;
  public
   procedure OpenTip(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* Открывает совет дня }
   function ShowDayTipsAtStartup: IvcmEntityForm;
 end;//TDayTipsModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3MessageID
 , SysUtils
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , StartupTipsKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , sdsTips
 , nsStartupTips
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , DataAdapter
;

var g_Tfs_Tips: Tfs_Tips = nil;
 {* Экземпляр синглетона Tfs_Tips }

const
 {* Локализуемые строки TipsCaptionLocalConstants }
 str_fsTipsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsTipsCaption'; rValue : '#1057#1086#1074#1077#1090 #1076#1085#1103');
  {* Заголовок фабрики сборки форм "Tips" }

const
 {* Локализуемые строки ut_StartupTipsLocalConstants }
 str_ut_StartupTipsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_StartupTipsCaption'; rValue : 'Совет дня');
  {* Заголовок пользовательского типа "Совет дня" }

procedure Tfs_TipsFree;
 {* Метод освобождения экземпляра синглетона Tfs_Tips }
begin
 l3Free(g_Tfs_Tips);
end;//Tfs_TipsFree

function Tfs_Tips.TextForm_Parent_dftTips_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для TextForm }
//#UC START# *0BF256C9E281_4AA12AC20374_var*
//#UC END# *0BF256C9E281_4AA12AC20374_var*
begin
//#UC START# *0BF256C9E281_4AA12AC20374_impl*
 !!! Needs to be implemented !!!
//#UC END# *0BF256C9E281_4AA12AC20374_impl*
end;//Tfs_Tips.TextForm_Parent_dftTips_NeedMakeForm

function Tfs_Tips.Attributes_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Attributes }
//#UC START# *1AA136DA5D1F_4AA12AC20374_var*
//#UC END# *1AA136DA5D1F_4AA12AC20374_var*
begin
//#UC START# *1AA136DA5D1F_4AA12AC20374_impl*
 !!! Needs to be implemented !!!
//#UC END# *1AA136DA5D1F_4AA12AC20374_impl*
end;//Tfs_Tips.Attributes_Child_fDocAttribute_NeedMakeForm

function Tfs_Tips.CommonDiction_Navigator_utTips_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для CommonDiction }
//#UC START# *EE98F6F4F387_4AA12AC20374_var*
//#UC END# *EE98F6F4F387_4AA12AC20374_var*
begin
//#UC START# *EE98F6F4F387_4AA12AC20374_impl*
 !!! Needs to be implemented !!!
//#UC END# *EE98F6F4F387_4AA12AC20374_impl*
end;//Tfs_Tips.CommonDiction_Navigator_utTips_NeedMakeForm

class function Tfs_Tips.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_Tips <> nil;
end;//Tfs_Tips.Exists

class function Tfs_Tips.Instance: Tfs_Tips;
 {* Метод получения экземпляра синглетона Tfs_Tips }
begin
 if (g_Tfs_Tips = nil) then
 begin
  l3System.AddExitProc(Tfs_TipsFree);
  g_Tfs_Tips := Create;
 end;
 Result := g_Tfs_Tips;
end;//Tfs_Tips.Instance

procedure Tfs_Tips.InitFields;
//#UC START# *47A042E100E2_4AA12AC20374_var*
//#UC END# *47A042E100E2_4AA12AC20374_var*
begin
//#UC START# *47A042E100E2_4AA12AC20374_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA12AC20374_impl*
end;//Tfs_Tips.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_Tips.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA12AC20374_var*
//#UC END# *4FFE854A009B_4AA12AC20374_var*
begin
//#UC START# *4FFE854A009B_4AA12AC20374_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA12AC20374_impl*
end;//Tfs_Tips.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

procedure TDayTipsModule.OpenTip(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* Открывает совет дня }
//#UC START# *4AA11A2E0144_4AA0D5380056_var*
//#UC END# *4AA11A2E0144_4AA0D5380056_var*
begin
//#UC START# *4AA11A2E0144_4AA0D5380056_impl*
 OpenTipsPrim(TsdsTips.Make(aDocInfo), aContainer);
//#UC END# *4AA11A2E0144_4AA0D5380056_impl*
end;//TDayTipsModule.OpenTip

procedure TDayTipsModule.OpenTipsPrim(const aSDS: IsdsCommonDiction;
 const aContainer: IvcmContainer);
//#UC START# *4AA52EC603DC_4AA0D5380056_var*
//#UC END# *4AA52EC603DC_4AA0D5380056_var*
begin
//#UC START# *4AA52EC603DC_4AA0D5380056_impl*
 Tfs_Tips.Make(aSDS, aContainer);
//#UC END# *4AA52EC603DC_4AA0D5380056_impl*
end;//TDayTipsModule.OpenTipsPrim

function TDayTipsModule.ShowDayTipsAtStartup: IvcmEntityForm;
//#UC START# *4AB9DAAC00AC_4AA0D5380056_var*
//#UC END# *4AB9DAAC00AC_4AA0D5380056_var*
begin
//#UC START# *4AB9DAAC00AC_4AA0D5380056_impl*
 l_Data := TnsStartupTips.Make;
 if Assigned(l_Data) then
  Result := TefStartupTips.MakeSingleChild(l_Data,
                                 CheckContainer(nil),
                                 vcm_ztFloating)
 else
  Result := nil;
//#UC END# *4AB9DAAC00AC_4AA0D5380056_impl*
end;//TDayTipsModule.ShowDayTipsAtStartup

procedure TDayTipsModule.ShowDayTips;
//#UC START# *4AB9DBA1038E_4AA0D5380056_var*
//#UC END# *4AB9DBA1038E_4AA0D5380056_var*
begin
//#UC START# *4AB9DBA1038E_4AA0D5380056_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB9DBA1038E_4AA0D5380056_impl*
end;//TDayTipsModule.ShowDayTips

initialization
 str_fsTipsCaption.Init;
 {* Инициализация str_fsTipsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefStartupTips);
 {* Регистрация StartupTips }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efStartupTips.SetFactory(TefStartupTips.Make);
 {* Регистрация фабрики формы StartupTips }
 str_ut_StartupTipsCaption.Init;
 {* Инициализация str_ut_StartupTipsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
