unit Diction_Module;
 {* Толковый словарь }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Diction_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "Diction" MUID: (4A9CE5F2036F)
// Имя типа: "TDictionModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 , nsLogEvent
;

type
 TnsOpenDictionaryEvent = class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsOpenDictionaryEvent

 TDictionModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
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
 , DocumentUserTypes_dftDictEntry_UserType
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
 , l3String
 , deDiction
 , l3Chars
 , SysUtils
 , nsDictionTree
 , sdsDiction
 , DataAdapter
 , LoggingUnit
;

{$If NOT Defined(NoVCM)}
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
var l_Child: INodeBase;
var l_Str: Il3CString;
var l_Entity: IEntityBase;
var l_Doc: IDocument;
var l_DictTree: Il3SimpleTree;
var l_FilterTree: Il3FilterableTree;
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
var l_Form: IvcmEntityForm;
//#UC START# *4A9D55E901D6_4A9CE5F2036F_var*
//#UC END# *4A9D55E901D6_4A9CE5F2036F_var*
begin
//#UC START# *4A9D55E901D6_4A9CE5F2036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A9D55E901D6_4A9CE5F2036F_impl*
end;//TDictionModule.OpenDict
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
