unit Diction_Module;
 {* Толковый словарь }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Diction_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DynamicTreeUnit
 , l3Interfaces
 , BaseTypesUnit
 , DocumentUnit
 , l3TreeInterfaces
 , bsTypes
 , DocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimDictionOptions_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
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
 , l3StringIDEx
 , DictionContainerUserTypes_slqtDiction_UserType
 , CommonDictionInterfaces
 , DocumentUserTypes_dftDictEntry_UserType
 , DocumentAndListInterfaces
 , nevTools
 , afwInterfaces
 , FoldersDomainInterfaces
 , bsTypesNew
 , PrimDiction_utDiction_UserType
 , l3InternalInterfaces
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , PrimChild_cutForDiction_UserType
 , F1Like_FormDefinitions_Controls
 , DocumentUserTypes_dftDictSubEntry_UserType
 , DictionInterfaces
 , DictionInterfacesPrim
 , AttributesUserTypes_fDocAttribute_UserType
 , BaseDocumentWithAttributesInterfaces
 , nsLogEvent
 , PrimDictionContainer_Form
 , PrimCommonDictionOptions_Form
;

type
 TenDiction = {final} class(TPrimDictionOptionsForm, DictionFormDef)
  {* Толковый словарь }
 end;//TenDiction

 // DictEntry

 // Diction

 // DictSubEntry

 // Attribute

 // Child

 // DictionContainer

 Tfs_Diction = {final} class(TvcmFormSetFactory)
  {* Сборка форм толкового словаря }
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
   function DictionContainer_Parent_slqtDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для DictionContainer }
   function DictEntry_Parent_dftDictEntry_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для DictEntry }
   function Diction_Navigator_utDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Diction }
   function Child_Child_cutForDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Child }
   function DictSubEntry_Child_dftDictSubEntry_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для DictSubEntry }
   procedure DictSubEntry_Child_dftDictSubEntryGetFormCount(const aDataSource: IvcmFormSetDataSource;
    out aCount: Integer);
    {* Обработчик OnFormCount для DictSubEntry }
   function Attribute_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Attribute }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   procedure DoGetMainImageIndex(aSender: TObject;
    const aDataSource: IvcmFormSetDataSource;
    var aImageIndex: Integer);
    {* Обработчик OnGetMainImageIndex для Diction$FS }
   procedure DoGetMainCaption(aSender: TObject;
    const aDataSource: IvcmFormSetDataSource;
    var aCaption: Il3CString);
    {* Обработчик GetMainCaption для Diction$FS }
   class function Instance: Tfs_Diction;
    {* Метод получения экземпляра синглетона Tfs_Diction }
 end;//Tfs_Diction

 TnsOpenDictionaryEvent = class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsOpenDictionaryEvent

 TDictionContainerForm = {final} class(TPrimDictionContainerForm, DictionContainerFormDef)
 end;//TDictionContainerForm

 Ten_CommonDiction = {final} class(TPrimCommonDictionOptionsForm, CommonDictionFormDef)
  {* Совет дня }
 end;//Ten_CommonDiction

 TDictionModule = class
  {* Толковый словарь }
  protected
   procedure OpenDict;
    {* Толковый словарь }
  public
   procedure OpenTermByContext(const aContext: Il3CString;
    aLanguage: TbsLanguage);
    {* Открывает термин по подстроке }
   procedure OpenDictionary(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* Открывает толковый словарь }
 end;//TDictionModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , Base_Operations_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , nsLangToContextMap
 {$If Defined(Nemesis)}
 , nscContextFilterState
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , DictionKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , bsUtils
 , SysUtils
 , nsDocumentTools
 , l3String
 , l3MessageID
 , l3Base
 , LoggingUnit
 {$If NOT Defined(NoScripts)}
 , DictionContainerKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , CommonDictionKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , deDiction
 , l3Chars
 , nsDictionTree
 , sdsDiction
 , DataAdapter
;

var g_Tfs_Diction: Tfs_Diction = nil;
 {* Экземпляр синглетона Tfs_Diction }

const
 {* Локализуемые строки Tab consts }
 str_DictionFormSetCaptionPrefix: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DictionFormSetCaptionPrefix'; rValue : 'Текст словарной статьи');
  {* 'Текст словарной статьи' }
 {* Локализуемые строки Diction$FSCaptionLocalConstants }
 str_fsDictionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDictionCaption'; rValue : 'Толковый словарь');
  {* Заголовок фабрики сборки форм "Diction$FS" }

procedure Tfs_DictionFree;
 {* Метод освобождения экземпляра синглетона Tfs_Diction }
begin
 l3Free(g_Tfs_Diction);
end;//Tfs_DictionFree

function Tfs_Diction.DictionContainer_Parent_slqtDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для DictionContainer }
//#UC START# *B6E2EA9874BB_4A9D19450248_var*
//#UC END# *B6E2EA9874BB_4A9D19450248_var*
begin
//#UC START# *B6E2EA9874BB_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *B6E2EA9874BB_4A9D19450248_impl*
end;//Tfs_Diction.DictionContainer_Parent_slqtDiction_NeedMakeForm

function Tfs_Diction.DictEntry_Parent_dftDictEntry_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для DictEntry }
//#UC START# *956E84A5725C_4A9D19450248_var*
//#UC END# *956E84A5725C_4A9D19450248_var*
begin
//#UC START# *956E84A5725C_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *956E84A5725C_4A9D19450248_impl*
end;//Tfs_Diction.DictEntry_Parent_dftDictEntry_NeedMakeForm

function Tfs_Diction.Diction_Navigator_utDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Diction }
//#UC START# *F7505AA053D6_4A9D19450248_var*
//#UC END# *F7505AA053D6_4A9D19450248_var*
begin
//#UC START# *F7505AA053D6_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *F7505AA053D6_4A9D19450248_impl*
end;//Tfs_Diction.Diction_Navigator_utDiction_NeedMakeForm

function Tfs_Diction.Child_Child_cutForDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Child }
//#UC START# *F7E18EECF870_4A9D19450248_var*
//#UC END# *F7E18EECF870_4A9D19450248_var*
begin
//#UC START# *F7E18EECF870_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *F7E18EECF870_4A9D19450248_impl*
end;//Tfs_Diction.Child_Child_cutForDiction_NeedMakeForm

function Tfs_Diction.DictSubEntry_Child_dftDictSubEntry_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для DictSubEntry }
//#UC START# *2E81DBAB301C_4A9D19450248_var*
//#UC END# *2E81DBAB301C_4A9D19450248_var*
begin
//#UC START# *2E81DBAB301C_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *2E81DBAB301C_4A9D19450248_impl*
end;//Tfs_Diction.DictSubEntry_Child_dftDictSubEntry_NeedMakeForm

procedure Tfs_Diction.DictSubEntry_Child_dftDictSubEntryGetFormCount(const aDataSource: IvcmFormSetDataSource;
 out aCount: Integer);
 {* Обработчик OnFormCount для DictSubEntry }
//#UC START# *CF6948E21F14_4A9D19450248_var*
//#UC END# *CF6948E21F14_4A9D19450248_var*
begin
//#UC START# *CF6948E21F14_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *CF6948E21F14_4A9D19450248_impl*
end;//Tfs_Diction.DictSubEntry_Child_dftDictSubEntryGetFormCount

function Tfs_Diction.Attribute_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Attribute }
//#UC START# *28D865AEFFD5_4A9D19450248_var*
//#UC END# *28D865AEFFD5_4A9D19450248_var*
begin
//#UC START# *28D865AEFFD5_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *28D865AEFFD5_4A9D19450248_impl*
end;//Tfs_Diction.Attribute_Child_fDocAttribute_NeedMakeForm

class function Tfs_Diction.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_Diction <> nil;
end;//Tfs_Diction.Exists

procedure Tfs_Diction.DoGetMainImageIndex(aSender: TObject;
 const aDataSource: IvcmFormSetDataSource;
 var aImageIndex: Integer);
 {* Обработчик OnGetMainImageIndex для Diction$FS }
//#UC START# *C82B5B254974_4A9D19450248_var*
//#UC END# *C82B5B254974_4A9D19450248_var*
begin
//#UC START# *C82B5B254974_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *C82B5B254974_4A9D19450248_impl*
end;//Tfs_Diction.DoGetMainImageIndex

procedure Tfs_Diction.DoGetMainCaption(aSender: TObject;
 const aDataSource: IvcmFormSetDataSource;
 var aCaption: Il3CString);
 {* Обработчик GetMainCaption для Diction$FS }
//#UC START# *616F19145E64_4A9D19450248_var*
//#UC END# *616F19145E64_4A9D19450248_var*
begin
//#UC START# *616F19145E64_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *616F19145E64_4A9D19450248_impl*
end;//Tfs_Diction.DoGetMainCaption

class function Tfs_Diction.Instance: Tfs_Diction;
 {* Метод получения экземпляра синглетона Tfs_Diction }
begin
 if (g_Tfs_Diction = nil) then
 begin
  l3System.AddExitProc(Tfs_DictionFree);
  g_Tfs_Diction := Create;
 end;
 Result := g_Tfs_Diction;
end;//Tfs_Diction.Instance

procedure Tfs_Diction.InitFields;
//#UC START# *47A042E100E2_4A9D19450248_var*
//#UC END# *47A042E100E2_4A9D19450248_var*
begin
//#UC START# *47A042E100E2_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4A9D19450248_impl*
end;//Tfs_Diction.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_Diction.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4A9D19450248_var*
//#UC END# *4FFE854A009B_4A9D19450248_var*
begin
//#UC START# *4FFE854A009B_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4A9D19450248_impl*
end;//Tfs_Diction.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function Tfs_Diction.DoMakeFormSetCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
//#UC START# *54B352A903E5_4A9D19450248_var*
//#UC END# *54B352A903E5_4A9D19450248_var*
begin
//#UC START# *54B352A903E5_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *54B352A903E5_4A9D19450248_impl*
end;//Tfs_Diction.DoMakeFormSetCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function Tfs_Diction.DoMakeFormSetTabCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
//#UC START# *54B352D401E5_4A9D19450248_var*
//#UC END# *54B352D401E5_4A9D19450248_var*
begin
//#UC START# *54B352D401E5_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *54B352D401E5_4A9D19450248_impl*
end;//Tfs_Diction.DoMakeFormSetTabCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function Tfs_Diction.DoMakeFormSetTabHint(const aDataSource: IvcmFormSetDataSource): IvcmCString;
//#UC START# *54B352FB03A1_4A9D19450248_var*
//#UC END# *54B352FB03A1_4A9D19450248_var*
begin
//#UC START# *54B352FB03A1_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *54B352FB03A1_4A9D19450248_impl*
end;//Tfs_Diction.DoMakeFormSetTabHint
{$IfEnd} // NOT Defined(NoVCM)

class procedure TnsOpenDictionaryEvent.Log;
//#UC START# *4B14CE0A001F_4B14CDEA039C_var*
//#UC END# *4B14CE0A001F_4B14CDEA039C_var*
begin
//#UC START# *4B14CE0A001F_4B14CDEA039C_impl*
 GetLogger.AddEvent(LE_OPEN_DICTIONARY, MakeParamsList);
//#UC END# *4B14CE0A001F_4B14CDEA039C_impl*
end;//TnsOpenDictionaryEvent.Log

procedure TDictionModule.OpenTermByContext(const aContext: Il3CString;
 aLanguage: TbsLanguage);
 {* Открывает термин по подстроке }
//#UC START# *4A9CEF360326_4A9CE5F2036F_var*
var
 l_Map: InsLangToContextMap;
//#UC END# *4A9CEF360326_4A9CE5F2036F_var*
begin
//#UC START# *4A9CEF360326_4A9CE5F2036F_impl*
 l_Str := l3Trim(aContext, cc_AllChars - cc_ANSILetter);
 l_DictTree := TnsDictionTree.Make(ns_dkDiction, aLanguage, l_Str, True);

 Supports(l_DictTree, Il3FilterableTree, l_FilterTree);

 if not l3IsNil(aContext) and
    (l3IsNil(l_Str) or l3IsNil(l_FilterTree.CloneFilters.Context)) then
 begin
  vcmSay(inf_NothingWasFound);
  Exit;
 end;

 Supports(l_DictTree.RootNode.Child, INodeBase, l_Child);
 Assert(Assigned(l_FilterTree));

 if l_Child <> nil then
 try
  l_Child.GetEntity(l_Entity);
  try
   if Supports(l_Entity, IDocument, l_Doc) then
   try
    l_Map := TnsLangToContextMap.Make(nil);
    try
     l_Map.ByLang[aLanguage] := TnscContextFilterState.Make(True, l_Str, MaxInt);
     OpenDictionary(TdeDiction.Make(l_Doc, aLanguage, l_Map), DefaultContainer);
    finally
     l_Map := nil;
    end;
   finally
    l_Doc := nil;
   end;//try..finally
  finally
   l_Entity := nil;
  end;//try..finally
 finally
  l_Child := nil;
 end;//try..finally
//#UC END# *4A9CEF360326_4A9CE5F2036F_impl*
end;//TDictionModule.OpenTermByContext

procedure TDictionModule.OpenDictionary(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* Открывает толковый словарь }
//#UC START# *4A9D1FD20092_4A9CE5F2036F_var*
//#UC END# *4A9D1FD20092_4A9CE5F2036F_var*
begin
//#UC START# *4A9D1FD20092_4A9CE5F2036F_impl*
 TnsOpenDictionaryEvent.Log;
 Tfs_Diction.Make(TsdsDiction.Make(aDocInfo), aContainer);
//#UC END# *4A9D1FD20092_4A9CE5F2036F_impl*
end;//TDictionModule.OpenDictionary

procedure TDictionModule.OpenDict;
 {* Толковый словарь }
//#UC START# *4A9D55E901D6_4A9CE5F2036F_var*
//#UC END# *4A9D55E901D6_4A9CE5F2036F_var*
begin
//#UC START# *4A9D55E901D6_4A9CE5F2036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A9D55E901D6_4A9CE5F2036F_impl*
end;//TDictionModule.OpenDict

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenDiction);
 {* Регистрация Diction }
{$IfEnd} // NOT Defined(NoScripts)
 fm_enDiction.SetFactory(TenDiction.Make);
 {* Регистрация фабрики формы Diction }
 str_DictionFormSetCaptionPrefix.Init;
 {* Инициализация str_DictionFormSetCaptionPrefix }
 str_fsDictionCaption.Init;
 {* Инициализация str_fsDictionCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TDictionContainerForm);
 {* Регистрация DictionContainer }
{$IfEnd} // NOT Defined(NoScripts)
 fm_DictionContainerForm.SetFactory(TDictionContainerForm.Make);
 {* Регистрация фабрики формы DictionContainer }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_CommonDiction);
 {* Регистрация CommonDiction }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_CommonDiction.SetFactory(Ten_CommonDiction.Make);
 {* Регистрация фабрики формы CommonDiction }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
