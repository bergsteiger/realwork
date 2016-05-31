unit fsTips;
 {* Советы дня }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\fsTips.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "Tips" MUID: (4AA12AC20374)
// Имя типа: "Tfs_Tips"

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
 , DocumentUserTypes_dftTips_UserType
 , Common_FormDefinitions_Controls
 , DocumentAndListInterfaces
 , nevTools
 , DocumentInterfaces
 , bsTypes
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentUnit
 , l3Interfaces
 , bsTypesNew
 , AttributesUserTypes_fDocAttribute_UserType
 , BaseDocumentWithAttributesInterfaces
 , l3InternalInterfaces
 , l3TreeInterfaces
 , PrimCommonDiction_utTips_UserType
 , CommonDictionInterfaces
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
;

type
 // TextForm

 // Attributes

 // CommonDiction

 Tfs_Tips = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
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
var g_Tfs_Tips: Tfs_Tips = nil;
 {* Экземпляр синглетона Tfs_Tips }

const
 {* Локализуемые строки TipsCaptionLocalConstants }
 str_fsTipsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsTipsCaption'; rValue : '#1057#1086#1074#1077#1090 #1076#1085#1103');
  {* Заголовок фабрики сборки форм "Tips" }

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

class function Tfs_Tips.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA12AC20374_var*
//#UC END# *4FFE854A009B_4AA12AC20374_var*
begin
//#UC START# *4FFE854A009B_4AA12AC20374_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA12AC20374_impl*
end;//Tfs_Tips.GetInstance

initialization
 str_fsTipsCaption.Init;
 {* Инициализация str_fsTipsCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
