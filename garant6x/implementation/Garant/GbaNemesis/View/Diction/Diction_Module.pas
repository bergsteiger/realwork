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
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsLogEvent
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
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
   procedure opOpenDictTest(const aParams: IvcmTestParamsPrim);
    {* Толковый словарь }
   procedure opOpenDictExecute(const aParams: IvcmExecuteParamsPrim);
    {* Толковый словарь }
   procedure Loaded; override;
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TDictionModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3ProtoObject
 , Base_Operations_F1Services_Contracts
 , DocumentInterfaces
 , DynamicTreeUnit
 , l3Interfaces
 , BaseTypesUnit
 , DocumentUnit
 , l3TreeInterfaces
 , bsTypes
 , Base_Operations_Strange_Controls
 , DocumentUserTypes_dftDictEntry_UserType
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , nsLangToContextMap
 {$If Defined(Nemesis)}
 , nscContextFilterState
 {$IfEnd} // Defined(Nemesis)
 , sdsDiction
 , nsDictionTree
 , deDiction
 , DataAdapter
 , LoggingUnit
 , SysUtils
 , l3Base
 , l3String
 , l3Chars
 , Diction_Form
 , fsDiction
 , DictionContainer_Form
 , CommonDiction_Form
 , Common_FormDefinitions_Controls
 //#UC START# *4A9CE5F2036Fimpl_uses*
 , CommonDictionInterfaces
 , DictionInterfaces
 , StdRes
 //#UC END# *4A9CE5F2036Fimpl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TDictionServiceImpl = {final} class(Tl3ProtoObject, IDictionService)
  public
   procedure OpenDictionary(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* Открывает толковый словарь }
   procedure OpenTermByContext(const aContext: Il3CString;
    aLanguage: TbsLanguage);
    {* Открывает термин по подстроке }
   class function Instance: TDictionServiceImpl;
    {* Метод получения экземпляра синглетона TDictionServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TDictionServiceImpl

var g_TDictionServiceImpl: TDictionServiceImpl = nil;
 {* Экземпляр синглетона TDictionServiceImpl }

procedure TDictionServiceImplFree;
 {* Метод освобождения экземпляра синглетона TDictionServiceImpl }
begin
 l3Free(g_TDictionServiceImpl);
end;//TDictionServiceImplFree

class procedure TnsOpenDictionaryEvent.Log;
//#UC START# *4B14CE0A001F_4B14CDEA039C_var*
//#UC END# *4B14CE0A001F_4B14CDEA039C_var*
begin
//#UC START# *4B14CE0A001F_4B14CDEA039C_impl*
 GetLogger.AddEvent(LE_OPEN_DICTIONARY, MakeParamsList);
//#UC END# *4B14CE0A001F_4B14CDEA039C_impl*
end;//TnsOpenDictionaryEvent.Log

procedure TDictionServiceImpl.OpenDictionary(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* Открывает толковый словарь }
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
end;//TDictionServiceImpl.OpenDictionary

procedure TDictionServiceImpl.OpenTermByContext(const aContext: Il3CString;
 aLanguage: TbsLanguage);
 {* Открывает термин по подстроке }
var l_Child: INodeBase;
var l_Str: Il3CString;
var l_Entity: IEntityBase;
var l_Doc: IDocument;
var l_DictTree: Il3SimpleTree;
var l_FilterTree: Il3FilterableTree;
var
 __WasEnter : Boolean;
//#UC START# *4A9CEF360326_4A9CE5F2036F_var*
var
 l_Map: InsLangToContextMap;
//#UC END# *4A9CEF360326_4A9CE5F2036F_var*
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
end;//TDictionServiceImpl.OpenTermByContext

class function TDictionServiceImpl.Instance: TDictionServiceImpl;
 {* Метод получения экземпляра синглетона TDictionServiceImpl }
begin
 if (g_TDictionServiceImpl = nil) then
 begin
  l3System.AddExitProc(TDictionServiceImplFree);
  g_TDictionServiceImpl := Create;
 end;
 Result := g_TDictionServiceImpl;
end;//TDictionServiceImpl.Instance

class function TDictionServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TDictionServiceImpl <> nil;
end;//TDictionServiceImpl.Exists

procedure TDictionModule.opOpenDictTest(const aParams: IvcmTestParamsPrim);
 {* Толковый словарь }
var l_Form: IvcmEntityForm;
//#UC START# *4A9D55E901D6_4A9CE5F2036Ftest_var*
//#UC END# *4A9D55E901D6_4A9CE5F2036Ftest_var*
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

procedure TDictionModule.opOpenDictExecute(const aParams: IvcmExecuteParamsPrim);
 {* Толковый словарь }
var l_Form: IvcmEntityForm;
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
end;//TDictionModule.opOpenDictExecute

procedure TDictionModule.Loaded;
begin
 inherited;
 PublishOp('opOpenDict', opOpenDictExecute, opOpenDictTest);
end;//TDictionModule.Loaded

class procedure TDictionModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TenDiction);
 aList.Add(TDictionContainerForm);
 aList.Add(Ten_CommonDiction);
end;//TDictionModule.GetEntityForms

initialization
 TDictionService.Instance.Alien := TDictionServiceImpl.Instance;
 {* Регистрация TDictionServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
