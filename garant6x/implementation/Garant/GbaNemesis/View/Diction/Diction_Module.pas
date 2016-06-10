unit Diction_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Diction/Diction_Module.pas"
// Начат: 01.09.2009 13:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Встроенные продукты::Diction::View::Diction::Diction$FP
//
// Толковый словарь
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  BaseTypesUnit,
  DocumentUnit,
  DynamicTreeUnit,
  l3Interfaces,
  l3TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  ,
  bsTypes,
  DocumentAndListInterfaces,
  DictionInterfaces,
  CommonDictionInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  DocumentUserTypes_dftDictEntry_UserType,
  DocumentUserTypes_dftDictSubEntry_UserType,
  nsLogEvent,
  DocumentInterfaces,
  l3StringIDEx,
  AttributesUserTypes_fDocAttribute_UserType,
  PrimDiction_utDiction_UserType,
  Common_FormDefinitions_Controls,
  PrimCommonDictionOptions_Form,
  BaseDocumentWithAttributesInterfaces,
  DictionContainerUserTypes_slqtDiction_UserType,
  PrimDictionContainer_Form,
  PrimChild_cutForDiction_UserType,
  F1Like_FormDefinitions_Controls
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  PrimDictionOptions_Form,
  Diction_Form,
  fsDiction,
  DictionContainer_Form,
  CommonDiction_Form,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsOpenDictionaryEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log;
 end;//TnsOpenDictionaryEvent

 TDictionModule = {formspack} class(TvcmModule)
  {* Толковый словарь }
 protected
  procedure Loaded; override;
  class procedure GetEntityForms(aList : TvcmClassList); override;
 protected
 // protected methods
   procedure opOpenDictTest(const aParams: IvcmTestParamsPrim);
     {* Толковый словарь }
   procedure opOpenDict(const aParams: IvcmExecuteParamsPrim);
     {* Толковый словарь }
 public
 // public methods
   class procedure OpenTermByContext(const aContext: Il3CString;
     aLanguage: TbsLanguage);
     {* Открывает термин по подстроке }
   class procedure OpenDictionary(const aDocInfo: IdeDocInfo;
     const aContainer: IvcmContainer);
     {* Открывает толковый словарь }
 end;//TDictionModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3String
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  ,
  deDiction,
  l3Chars,
  SysUtils,
  nsDictionTree,
  sdsDiction,
  l3Base {a},
  bsUtils,
  nsDocumentTools,
  l3MessageID,
  DataAdapter,
  LoggingUnit,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces,
  Base_Operations_Strange_Controls,
  Base_Operations_Editions_Controls,
  nsLangToContextMap
  {$If defined(Nemesis)}
  ,
  nscContextFilterState
  {$IfEnd} //Nemesis
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Diction_opOpenDict
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  StdRes {a},
  vcmModuleDef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TDictionModule

class procedure TDictionModule.OpenTermByContext(const aContext: Il3CString;
  aLanguage: TbsLanguage);
var
 __WasEnter : Boolean;
//#UC START# *4A9CEF360326_4A9CE5F2036F_var*
var
 l_Map: InsLangToContextMap;
//#UC END# *4A9CEF360326_4A9CE5F2036F_var*
var
 l_Child : INodeBase;
 l_Str : Il3CString;
 l_Entity : IEntityBase;
 l_Doc : IDocument;
 l_DictTree : Il3SimpleTree;
 l_FilterTree : Il3FilterableTree;
begin
 __WasEnter := vcmEnterFactory;
 try
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TDictionModule.OpenTermByContext

class procedure TDictionModule.OpenDictionary(const aDocInfo: IdeDocInfo;
  const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4A9D1FD20092_4A9CE5F2036F_var*
//#UC END# *4A9D1FD20092_4A9CE5F2036F_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4A9D1FD20092_4A9CE5F2036F_impl*
 TnsOpenDictionaryEvent.Log;
 Tfs_Diction.Make(TsdsDiction.Make(aDocInfo), aContainer);
//#UC END# *4A9D1FD20092_4A9CE5F2036F_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TDictionModule.OpenDictionary

procedure TDictionModule.opOpenDictTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4A9D55E901D6_4A9CE5F2036Ftest_var*
//#UC END# *4A9D55E901D6_4A9CE5F2036Ftest_var*
var
 l_Form : IvcmEntityForm;
begin
//#UC START# *4A9D55E901D6_4A9CE5F2036Ftest_impl*
 with (aParams As IvcmTestParams) do
 begin
  Op.Flag[vcm_ofEnabled] := defDataAdapter.IsExplanatoryExists;
  if Op.Flag[vcm_ofEnabled] then
  begin
   if (Container <> nil) and
      Container.HasForm(fm_TextForm.rFormID, vcm_ztParent, true, @l_Form) then
   begin
    with Op.SubItems do
     if (l_Form.UserType = dftDictEntry) then
     begin
      if (Count <> 0) then
       Clear;
     end//l_Form.UserType = dftDictEntry
     else
     if (Count < 2) then
     begin
      Clear;
      Add(vcmCStr(str_SearchInDiction));
      Add(vcmCStr(str_OpenDiction));
     end;//Count < 2
   end//Container <> nil
   else
    with Op.SubItems do
     if (Count <> 0) then
      Clear;
  end;//Op.Flag[vcm_ofEnabled]
  Op.Flag[vcm_ofVisible] := Op.Flag[vcm_ofEnabled];
 end;//with aParams
//#UC END# *4A9D55E901D6_4A9CE5F2036Ftest_impl*
end;//TDictionModule.opOpenDictTest

procedure TDictionModule.opOpenDict(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A9D55E901D6_4A9CE5F2036Fexec_var*

var
 l_Cont : IvcmContainer;

 function lp_HasDictionForm: Boolean;
 begin//lp_ShowDictionForm
  Result := (l_Cont <> nil) and
            l_Cont.HasForm(fm_enDiction.rFormID, vcm_ztNavigator, True);
 end;//lp_ShowDictionForm

var
 l_CurOpIndex : Integer;
//#UC END# *4A9D55E901D6_4A9CE5F2036Fexec_var*
var
 l_Form : IvcmEntityForm;
begin
//#UC START# *4A9D55E901D6_4A9CE5F2036Fexec_impl*
 l_CurOpIndex := aParams.ItemIndex;

 l_Cont := (aParams As IvcmExecuteParams).Container;
 if (l_Cont <> nil) and
  l_Cont.HasForm(fm_TextForm.rFormID, vcm_ztParent, true, @l_Form) and
  (((l_CurOpIndex = 1) or (l_CurOpIndex = 0))) then
 begin
  // Найти толкование
  if not op_Document_FindExplanation.Call(l_Form) then
  begin
   if (l_CurOpIndex = 1) or
      (l_Form.UserType = dftDictEntry) then
   begin
    vcmSay(war_ExplanationSearchNotEnabled);
    Exit;
   end;//l_CurOpIndex = 1
  end//not op_Document_FindExplanation.Call(l_Form)
  else
   Exit;
 end;//l_Cont <> nil
 if not lp_HasDictionForm then
  OpenDictionary(nil, l_Cont);
//#UC END# *4A9D55E901D6_4A9CE5F2036Fexec_impl*
end;//TDictionModule.opOpenDict
// start class TnsOpenDictionaryEvent

class procedure TnsOpenDictionaryEvent.Log;
//#UC START# *4B14CE0A001F_4B14CDEA039C_var*
//#UC END# *4B14CE0A001F_4B14CDEA039C_var*
begin
//#UC START# *4B14CE0A001F_4B14CDEA039C_impl*
 GetLogger.AddEvent(LE_OPEN_DICTIONARY, MakeParamsList);
//#UC END# *4B14CE0A001F_4B14CDEA039C_impl*
end;//TnsOpenDictionaryEvent.Log

procedure TDictionModule.Loaded;
begin
 inherited;
 PublishOp('opOpenDict', opOpenDict, opOpenDictTest);
end;

class procedure TDictionModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TenDiction);
 aList.Add(TDictionContainerForm);
 aList.Add(Ten_CommonDiction);
end;

{$IfEnd} //not Admin AND not Monitorings

end.