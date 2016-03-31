unit PrimDiction_Form;
 {* Толковый словарь }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimDiction_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimDiction" MUID: (4979D40E0180)
// Имя типа: "TPrimDictionForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DictionInterfaces
 , Diction_Strange_Controls
 , CommonDictionInterfaces
 , vtPanel
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , nscTreeViewWithAdapterDragDrop
 , bsTypes
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3TreeInterfaces
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentAndListInterfaces
;

type
 _BaseDocument_Parent_ = TvcmEntityForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}
 TPrimDictionForm = class(_BaseDocument_, IbsDictionListener)
  {* Толковый словарь }
  private
   f_InternalChange: Integer;
   f_BackgroundPanel: TvtPanel;
    {* Поле для свойства BackgroundPanel }
   f_ContextFilter: TnscContextFilter;
    {* Поле для свойства ContextFilter }
   f_WordsTree: TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства WordsTree }
   f_ContextMap: InsLangToContextMap;
    {* Поле для свойства ContextMap }
  protected
   CommonDiction: IdsCommonDiction;
   Diction: IdsDiction;
  private
   procedure ContextFilterChange(Sender: TObject);
   procedure ContextFilterWrongContext(Sender: TObject);
   function WordsTreeGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure WordsTreeNewCharPressed(aChar: AnsiChar);
   procedure WordsTreeActionElement(Sender: TObject;
    Index: LongInt);
   procedure WordsTreeMakeTreeSource(out theTree: Il3SimpleTree);
   procedure WordsTreeSelectCountChanged(aSender: TObject;
    anOldCount: Integer;
    aNewCount: Integer);
   procedure WordsTreeCountChanged(Sender: TObject;
    NewCount: LongInt);
   procedure WordsTreeCurrentChanged(Sender: TObject;
    aNewCurrent: LongInt;
    aOldCurrent: LongInt);
   procedure WordsTreeFormatStatusInfo(aSender: TObject;
    var Info: Il3CString;
    aCurrent: Integer;
    aCount: Integer;
    aSelected: Integer);
   procedure RestoreContextFilter;
  protected
   function pm_GetContextMap: InsLangToContextMap;
   procedure ChangeLang(aLang: TbsLanguage);
    {* изменить язык списка толкований }
   procedure CheckLang(aLang: TbsLanguage;
    const aParams: IvcmTestParamsPrim);
    {* проверим наличие толкований языка }
   procedure ChangeDiction(aItem: Integer;
    aUpdateWithDelay: Boolean = True);
    {* изменить текущее толкование }
   procedure CurrentUpdated;
    {* текущее значение изменилось }
   procedure UpdateLanguage(aLanguage: TbsLanguage);
    {* обновить язык списка толкований }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FormInsertedIntoContainer; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   procedure Lang_Russian_Test(const aParams: IvcmTestParamsPrim);
   procedure Lang_Russian_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Lang_English_Test(const aParams: IvcmTestParamsPrim);
   procedure Lang_English_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Lang_French_Test(const aParams: IvcmTestParamsPrim);
   procedure Lang_French_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Lang_Deutch_Test(const aParams: IvcmTestParamsPrim);
   procedure Lang_Deutch_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Lang_Italian_Test(const aParams: IvcmTestParamsPrim);
   procedure Lang_Italian_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Lang_Spanish_Test(const aParams: IvcmTestParamsPrim);
   procedure Lang_Spanish_Execute(const aParams: IvcmExecuteParamsPrim);
   {$If NOT Defined(NoVCM)}
   function NeedDrawCaption: Boolean; override;
    {* Нужно ли рисовать заголовок зоны }
   {$IfEnd} // NOT Defined(NoVCM)
  private
   property ContextMap: InsLangToContextMap
    read pm_GetContextMap;
  public
   property BackgroundPanel: TvtPanel
    read f_BackgroundPanel;
 end;//TPrimDictionForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , BaseTypesUnit
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3String
 , DictionRes
 , nsUtils
 , DataAdapter
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Common_FormDefinitions_Controls
 , nsDictCache
 , nsDictionTree
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки utDictionLocalConstants }
 str_utDictionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utDictionCaption'; rValue : 'Толковый словарь');
  {* Заголовок пользовательского типа "Толковый словарь" }
 str_utDictionSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utDictionSettingsCaption'; rValue : 'Толковый словарь: Список терминов (вкладка)');
  {* Заголовок пользовательского типа "Толковый словарь" для настройки панелей инструментов }

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}

function TPrimDictionForm.pm_GetContextMap: InsLangToContextMap;
//#UC START# *51B7302E015F_4979D40E0180get_var*
//#UC END# *51B7302E015F_4979D40E0180get_var*
begin
//#UC START# *51B7302E015F_4979D40E0180get_impl*
 if f_ContextMap = nil then
  f_ContextMap := Diction.ContextMap;
 Result := f_ContextMap;
//#UC END# *51B7302E015F_4979D40E0180get_impl*
end;//TPrimDictionForm.pm_GetContextMap

procedure TPrimDictionForm.ChangeLang(aLang: TbsLanguage);
 {* изменить язык списка толкований }
//#UC START# *4C85134102E7_4979D40E0180_var*
var
 l_Index: Integer;
//#UC END# *4C85134102E7_4979D40E0180_var*
begin
//#UC START# *4C85134102E7_4979D40E0180_impl*
 if (Assigned(Diction) and (Diction.Language <> aLang)) then
 begin
  inc(f_InternalChange);
  try
   with WordsTree do
    if Assigned(Diction) and (Current >= 0) then
      Diction.CurrentChanged(GetNode(Current));
   ContextMap.ByLang[Diction.Language] := ContextFilter.MakeState;
   if Assigned(Diction) then
    Diction.Language := aLang;
   // Получим новое дерево
   with WordsTree do
   begin
    ContextFilter.BeginAssignState;
    try
     Changing;
     try
      ContextFilter.AssignState(ContextMap.ByLang[aLang]);
      if ContextFilter.Active then
       TreeStruct := TnsDictionTree.Make(ns_dkDiction, aLang, ContextMap.ByLang[aLang].ActiveContext, True)
      else
       TreeStruct := TnsDictionTree.Make(ns_dkDiction, aLang);
     finally
      Changed;
     end;{try..finally}
    finally
     ContextFilter.EndAssignState
    end;
    // При смене словаря толкования может не быть или в этом словаре может быть
    // последнее успешно полученное толкование (переключились в другой словарь,
    // толкования нет, переключаемся обратно, текущее толкование
    // восстанавливается)
    if Assigned(Diction) and l3IsNil(ContextFilter.ActiveContext) then
    begin
     l_Index := Diction.MakeCurrentIndex(TreeStruct);
     if l_Index < 0 then
      SetNoCurrent
     else
     begin
       Current := l_Index;
       vlbMakeItemVisible(l_Index);
     end;//if l_Index < 0 then
    end;//if Assigned(Diction) then
   end;//with WordsTree do
  finally
   Dec(f_InternalChange);
  end;{try..finally}
 end;//if (Assigned(Diction) and (Diction.Language <> aLang))
//#UC END# *4C85134102E7_4979D40E0180_impl*
end;//TPrimDictionForm.ChangeLang

procedure TPrimDictionForm.CheckLang(aLang: TbsLanguage;
 const aParams: IvcmTestParamsPrim);
 {* проверим наличие толкований языка }
//#UC START# *4C8513680142_4979D40E0180_var*
//#UC END# *4C8513680142_4979D40E0180_var*
begin
//#UC START# *4C8513680142_4979D40E0180_impl*
 if Assigned(Diction) then
 begin
  aParams.Op.Flag[vcm_ofVisible] := TnsDictCache.Instance.ContainsLang(aLang);
  aParams.Op.Flag[vcm_ofEnabled] := aParams.Op.Flag[vcm_ofVisible];
  aParams.Op.Flag[vcm_ofChecked] := Diction.Language = aLang
 end
 else
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C8513680142_4979D40E0180_impl*
end;//TPrimDictionForm.CheckLang

procedure TPrimDictionForm.ContextFilterChange(Sender: TObject);
//#UC START# *51B72C1D0310_4979D40E0180_var*
var
 l_Tree: Il3FilterableTree;
 l_Filtered: Il3SimpleTree;
 l_Node: Il3SimpleNode;
 l_NewNodeIndex: Integer;
//#UC END# *51B72C1D0310_4979D40E0180_var*
begin
//#UC START# *51B72C1D0310_4979D40E0180_impl*
 if Assigned(Diction) and
    Supports(WordsTree.TreeStruct, Il3FilterableTree, l_Tree) then
 begin
  // Сохраним параметры контекстной фильтрации для данного языка
  ContextMap.ByLang[Diction.Language] := ContextFilter.MakeState;
  l_Filtered := l_Tree.MakeFiltered(l_Tree.CloneFilters.SetContext(ContextFilter.ActiveContext),
                                    l_Node,
                                    l_NewNodeIndex,
                                    True,
                                    ContextFilter.NeedRefilterTree);
  if Assigned(l_Filtered) and (l_Filtered.CountView > 0) then
   with WordsTree do
   begin
    Changing;
    try
     TreeStruct := l_Filtered;
     vlbMakeItemVisible(Current);
    finally
     if not ContextFilter.Active then
      Inc(f_InternalChange);
     try
      Changed;
     finally
      if not ContextFilter.Active then
       Dec(f_InternalChange);
     end;
    end;{try..finally}
   end;//with WordsTree do
 end;//if Supports(WordsTree.TreeStruct,
//#UC END# *51B72C1D0310_4979D40E0180_impl*
end;//TPrimDictionForm.ContextFilterChange

procedure TPrimDictionForm.ContextFilterWrongContext(Sender: TObject);
//#UC START# *51B72C29024A_4979D40E0180_var*
//#UC END# *51B72C29024A_4979D40E0180_var*
begin
//#UC START# *51B72C29024A_4979D40E0180_impl*
 nsBeepWrongContext;
//#UC END# *51B72C29024A_4979D40E0180_impl*
end;//TPrimDictionForm.ContextFilterWrongContext

function TPrimDictionForm.WordsTreeGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *51B72D1B027D_4979D40E0180_var*
//#UC END# *51B72D1B027D_4979D40E0180_var*
begin
//#UC START# *51B72D1B027D_4979D40E0180_impl*
 Result := cDictItemIcon;
//#UC END# *51B72D1B027D_4979D40E0180_impl*
end;//TPrimDictionForm.WordsTreeGetItemImage

procedure TPrimDictionForm.WordsTreeNewCharPressed(aChar: AnsiChar);
//#UC START# *51B72D240241_4979D40E0180_var*
//#UC END# *51B72D240241_4979D40E0180_var*
begin
//#UC START# *51B72D240241_4979D40E0180_impl*
 ContextFilter.PressChar(aChar);
//#UC END# *51B72D240241_4979D40E0180_impl*
end;//TPrimDictionForm.WordsTreeNewCharPressed

procedure TPrimDictionForm.WordsTreeActionElement(Sender: TObject;
 Index: LongInt);
//#UC START# *51B72D300088_4979D40E0180_var*
//#UC END# *51B72D300088_4979D40E0180_var*
begin
//#UC START# *51B72D300088_4979D40E0180_impl*
 ChangeDiction(Index, False);
//#UC END# *51B72D300088_4979D40E0180_impl*
end;//TPrimDictionForm.WordsTreeActionElement

procedure TPrimDictionForm.WordsTreeMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *51B72D3B02F2_4979D40E0180_var*
//#UC END# *51B72D3B02F2_4979D40E0180_var*
begin
//#UC START# *51B72D3B02F2_4979D40E0180_impl*
 theTree := nil;
 if Assigned(Diction) and TnsDictCache.Instance.ContainsLang(Diction.Language) then
  with DefDataAdapter do
   theTree := TnsDictionTree.Make(ns_dkDiction, Diction.Language, ContextMap.ByLang[Diction.Language].ActiveContext);
//#UC END# *51B72D3B02F2_4979D40E0180_impl*
end;//TPrimDictionForm.WordsTreeMakeTreeSource

procedure TPrimDictionForm.WordsTreeSelectCountChanged(aSender: TObject;
 anOldCount: Integer;
 aNewCount: Integer);
//#UC START# *51B72D4603E7_4979D40E0180_var*
//#UC END# *51B72D4603E7_4979D40E0180_var*
begin
//#UC START# *51B72D4603E7_4979D40E0180_impl*
 UpdateStatusInfo;
//#UC END# *51B72D4603E7_4979D40E0180_impl*
end;//TPrimDictionForm.WordsTreeSelectCountChanged

procedure TPrimDictionForm.WordsTreeCountChanged(Sender: TObject;
 NewCount: LongInt);
//#UC START# *51B72D520161_4979D40E0180_var*
//#UC END# *51B72D520161_4979D40E0180_var*
begin
//#UC START# *51B72D520161_4979D40E0180_impl*
 UpdateStatusInfo;
//#UC END# *51B72D520161_4979D40E0180_impl*
end;//TPrimDictionForm.WordsTreeCountChanged

procedure TPrimDictionForm.WordsTreeCurrentChanged(Sender: TObject;
 aNewCurrent: LongInt;
 aOldCurrent: LongInt);
//#UC START# *51B72D5E02DC_4979D40E0180_var*
//#UC END# *51B72D5E02DC_4979D40E0180_var*
begin
//#UC START# *51B72D5E02DC_4979D40E0180_impl*
 UpdateStatusInfo;
 // Если происходит переключения языка толкований обновлять текущий нельзя, т.к.
 // в процессе переключения произойдет поиск текущего в новом списке толкований
 // и если толкование не будет найдено, то в новом списке толкования не будет
 // устновлен текущий:
 if f_InternalChange = 0 then
  ChangeDiction(aNewCurrent);
//#UC END# *51B72D5E02DC_4979D40E0180_impl*
end;//TPrimDictionForm.WordsTreeCurrentChanged

procedure TPrimDictionForm.WordsTreeFormatStatusInfo(aSender: TObject;
 var Info: Il3CString;
 aCurrent: Integer;
 aCount: Integer;
 aSelected: Integer);
//#UC START# *51B72D6C0297_4979D40E0180_var*
//#UC END# *51B72D6C0297_4979D40E0180_var*
begin
//#UC START# *51B72D6C0297_4979D40E0180_impl*
 Info := vcmFmt(str_DictionStatusInfoFormat,[aCurrent, aCount]);
//#UC END# *51B72D6C0297_4979D40E0180_impl*
end;//TPrimDictionForm.WordsTreeFormatStatusInfo

procedure TPrimDictionForm.ChangeDiction(aItem: Integer;
 aUpdateWithDelay: Boolean = True);
 {* изменить текущее толкование }
//#UC START# *50056A9D02BE_4979D40E0180_var*
var
 l_l3Node : Il3SimpleNode;
//#UC END# *50056A9D02BE_4979D40E0180_var*
begin
//#UC START# *50056A9D02BE_4979D40E0180_impl*
 if aItem <> -1 then
 begin
  l_l3Node := WordsTree.GetNode(aItem);
  try
   if (CommonDiction <> nil) then
    CommonDiction.CurrentChanged(l_l3Node, aUpdateWithDelay);
  finally
   l_l3Node := nil;
  end;//try..finally
 end;//if Index <> -1 then
//#UC END# *50056A9D02BE_4979D40E0180_impl*
end;//TPrimDictionForm.ChangeDiction

procedure TPrimDictionForm.RestoreContextFilter;
//#UC START# *52A5A17003E1_4979D40E0180_var*
//#UC END# *52A5A17003E1_4979D40E0180_var*
begin
//#UC START# *52A5A17003E1_4979D40E0180_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=382410166
 if (Diction <> nil) then
  ContextFilter.AssignState(Diction.ContextMap.ByLang[Diction.Language]);
//#UC END# *52A5A17003E1_4979D40E0180_impl*
end;//TPrimDictionForm.RestoreContextFilter

procedure TPrimDictionForm.CurrentUpdated;
 {* текущее значение изменилось }
//#UC START# *493402BC0160_4979D40E0180_var*
//#UC END# *493402BC0160_4979D40E0180_var*
begin
//#UC START# *493402BC0160_4979D40E0180_impl*
 WordsTree.Current := Diction.MakeCurrentIndex(WordsTree.TreeStruct);
//#UC END# *493402BC0160_4979D40E0180_impl*
end;//TPrimDictionForm.CurrentUpdated

procedure TPrimDictionForm.UpdateLanguage(aLanguage: TbsLanguage);
 {* обновить язык списка толкований }
//#UC START# *4934035F013E_4979D40E0180_var*
//#UC END# *4934035F013E_4979D40E0180_var*
begin
//#UC START# *4934035F013E_4979D40E0180_impl*
 ChangeLang(aLanguage);
//#UC END# *4934035F013E_4979D40E0180_impl*
end;//TPrimDictionForm.UpdateLanguage

procedure TPrimDictionForm.Lang_Russian_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C850FD40034_4979D40E0180test_var*
//#UC END# *4C850FD40034_4979D40E0180test_var*
begin
//#UC START# *4C850FD40034_4979D40E0180test_impl*
 CheckLang(LG_RUSSIAN, aParams);
//#UC END# *4C850FD40034_4979D40E0180test_impl*
end;//TPrimDictionForm.Lang_Russian_Test

procedure TPrimDictionForm.Lang_Russian_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C850FD40034_4979D40E0180exec_var*
//#UC END# *4C850FD40034_4979D40E0180exec_var*
begin
//#UC START# *4C850FD40034_4979D40E0180exec_impl*
 ChangeLang(LG_RUSSIAN);
//#UC END# *4C850FD40034_4979D40E0180exec_impl*
end;//TPrimDictionForm.Lang_Russian_Execute

procedure TPrimDictionForm.Lang_English_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C850FFB01EF_4979D40E0180test_var*
//#UC END# *4C850FFB01EF_4979D40E0180test_var*
begin
//#UC START# *4C850FFB01EF_4979D40E0180test_impl*
 CheckLang(LG_ENGLISH, aParams);
//#UC END# *4C850FFB01EF_4979D40E0180test_impl*
end;//TPrimDictionForm.Lang_English_Test

procedure TPrimDictionForm.Lang_English_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C850FFB01EF_4979D40E0180exec_var*
//#UC END# *4C850FFB01EF_4979D40E0180exec_var*
begin
//#UC START# *4C850FFB01EF_4979D40E0180exec_impl*
 ChangeLang(LG_ENGLISH);
//#UC END# *4C850FFB01EF_4979D40E0180exec_impl*
end;//TPrimDictionForm.Lang_English_Execute

procedure TPrimDictionForm.Lang_French_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C85100D0398_4979D40E0180test_var*
//#UC END# *4C85100D0398_4979D40E0180test_var*
begin
//#UC START# *4C85100D0398_4979D40E0180test_impl*
 CheckLang(LG_FRENCH, aParams);
//#UC END# *4C85100D0398_4979D40E0180test_impl*
end;//TPrimDictionForm.Lang_French_Test

procedure TPrimDictionForm.Lang_French_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C85100D0398_4979D40E0180exec_var*
//#UC END# *4C85100D0398_4979D40E0180exec_var*
begin
//#UC START# *4C85100D0398_4979D40E0180exec_impl*
 ChangeLang(LG_FRENCH);
//#UC END# *4C85100D0398_4979D40E0180exec_impl*
end;//TPrimDictionForm.Lang_French_Execute

procedure TPrimDictionForm.Lang_Deutch_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C85101F0258_4979D40E0180test_var*
//#UC END# *4C85101F0258_4979D40E0180test_var*
begin
//#UC START# *4C85101F0258_4979D40E0180test_impl*
 CheckLang(LG_GERMAN, aParams);
//#UC END# *4C85101F0258_4979D40E0180test_impl*
end;//TPrimDictionForm.Lang_Deutch_Test

procedure TPrimDictionForm.Lang_Deutch_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C85101F0258_4979D40E0180exec_var*
//#UC END# *4C85101F0258_4979D40E0180exec_var*
begin
//#UC START# *4C85101F0258_4979D40E0180exec_impl*
 ChangeLang(LG_GERMAN);
//#UC END# *4C85101F0258_4979D40E0180exec_impl*
end;//TPrimDictionForm.Lang_Deutch_Execute

procedure TPrimDictionForm.Lang_Italian_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C851041010D_4979D40E0180test_var*
//#UC END# *4C851041010D_4979D40E0180test_var*
begin
//#UC START# *4C851041010D_4979D40E0180test_impl*
 CheckLang(LG_ITALIAN, aParams);
//#UC END# *4C851041010D_4979D40E0180test_impl*
end;//TPrimDictionForm.Lang_Italian_Test

procedure TPrimDictionForm.Lang_Italian_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C851041010D_4979D40E0180exec_var*
//#UC END# *4C851041010D_4979D40E0180exec_var*
begin
//#UC START# *4C851041010D_4979D40E0180exec_impl*
 ChangeLang(LG_ITALIAN);
//#UC END# *4C851041010D_4979D40E0180exec_impl*
end;//TPrimDictionForm.Lang_Italian_Execute

procedure TPrimDictionForm.Lang_Spanish_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8510570231_4979D40E0180test_var*
//#UC END# *4C8510570231_4979D40E0180test_var*
begin
//#UC START# *4C8510570231_4979D40E0180test_impl*
 CheckLang(LG_SPANISH, aParams);
//#UC END# *4C8510570231_4979D40E0180test_impl*
end;//TPrimDictionForm.Lang_Spanish_Test

procedure TPrimDictionForm.Lang_Spanish_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8510570231_4979D40E0180exec_var*
//#UC END# *4C8510570231_4979D40E0180exec_var*
begin
//#UC START# *4C8510570231_4979D40E0180exec_impl*
 ChangeLang(LG_SPANISH);
//#UC END# *4C8510570231_4979D40E0180exec_impl*
end;//TPrimDictionForm.Lang_Spanish_Execute

procedure TPrimDictionForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4979D40E0180_var*
//#UC END# *479731C50290_4979D40E0180_var*
begin
//#UC START# *479731C50290_4979D40E0180_impl*
// f_ContextMap := nil;
 f_InternalChange := 0;
 if (DataSource <> nil) then
  DataSource.Unsubscribe(IbsDictionListener(Self));
 inherited;
 f_ContextMap := nil;
 // - эта строчка переехала сюда ибо - http://mdp.garant.ru/pages/viewpage.action?pageId=356071766&focusedCommentId=514879111#comment-514879111
 //   но лучше бы это переписать 
//#UC END# *479731C50290_4979D40E0180_impl*
end;//TPrimDictionForm.Cleanup

procedure TPrimDictionForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4979D40E0180_var*
//#UC END# *47EA4E9002C6_4979D40E0180_var*
begin
//#UC START# *47EA4E9002C6_4979D40E0180_impl*
 inherited;
 // Если после переключения базы выясняется, что на новой базе ТС нет -
 // откроем ОМ
 // http://mdp.garant.ru/pages/viewpage.action?pageId=285507600
 // - не прошло.
 // Пытаемся вернуться по истории, пока не дойдем до другой формы,
 // при этом отрезая тот кусок истории, в котором были словарные статьи
 if (not DefDataAdapter.IsExplanatoryExists) then
 begin
   while (((vcmDispatcher.FormDispatcher.CurrentMainForm.AsContainer).HasForm(fm_enDiction.rFormID)) and
    (vcmDispatcher.History.CanBack)) do
     vcmDispatcher.History.Back(True);
 end;
//#UC END# *47EA4E9002C6_4979D40E0180_impl*
end;//TPrimDictionForm.FinishDataUpdate

procedure TPrimDictionForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_4979D40E0180_var*
 function lp_IsInit: Boolean;
 begin
  Result := (sdsBaseDocument <> nil) and not sdsBaseDocument.HasDocument;
 end;//lp_IsInit

 procedure lp_SetCurrent;
 var
  l_Index: Integer;
  //l_Old: Integer;
 begin
  l_Index := Diction.MakeCurrentIndex(WordsTree.TreeStruct);
  if (l_Index > -1) then
   WordsTree.Current := Pred(l_Index)
  else
  begin
   {l_Old := WordsTree.Current;
   WordsTree.SetNoCurrent;
   Inc(f_InternalChange);
   try
    WordsTree.Current := l_Old;
   finally
    Dec(f_InternalChange);
   end;}
  end;
 end;
//#UC END# *497469C90140_4979D40E0180_var*
begin
//#UC START# *497469C90140_4979D40E0180_impl*
 inherited;
 if (anOld <> nil) then
 begin
  //http://mdp.garant.ru/pages/viewpage.action?pageId=382410166,
  //http://mdp.garant.ru/pages/viewpage.action?pageId=370384532&focusedCommentId=516173700#comment-516173700
  if (Diction <> nil) and (not Dispatcher.History.InBF) and (f_ContextMap <> nil) then
  try
   f_ContextMap.Unsubscribe(WordsTree);
  finally
   f_ContextMap := nil;
  end;
  anOld.Unsubscribe(IbsDictionListener(Self));
 end;
 if (aNew <> nil) then
  aNew.Subscribe(IbsDictionListener(Self));
 // Возможно, что в истории лежит которого на самом деле уже нет, в следствии
 // установки базы без толкового словаря не лету
 if (Diction <> nil) and
  TnsDictCache.Instance.ContainsLang(Diction.Language) then
 begin
  // Покажем дерево толкований, в случае если изменился язык. Язык не меняется,
  // когда происходит переход по ссылке в толковании
  ChangeLang(Diction.Language);
  // Поиск слова в толковом словаре
  if not Dispatcher.History.InBF then
  begin
   // Получим TreeStruct. K-147489521
   // По хорошему COntextMap можно было бы вынести на ds и сделать там MakeSimpleTree
   // а тутошние обработчики по изготовлению TreeStruct снести
   WordsTree.TreeStruct;

   ContextMap.Subscribe(WordsTree);

   if not l3IsNil(Diction.ContextMap.ByLang[Diction.Language].Context) then
   begin
    RestoreContextFilter;
    lp_SetCurrent;
   end//if not l3IsNil(Diction.Context) then
   // Переход по ссылке в толкованиях
   else
   begin
    // Выключаем контекст перед позиционированием
    ContextFilter.Active := False;
    // При открытии словаря показываем текущее толкование в списке (первое):
    if lp_IsInit then
     ChangeDiction(WordsTree.Current) // Если дерево на экране, то покажем первое толкование
    else
     lp_SetCurrent;
    //http://mdp.garant.ru/pages/viewpage.action?pageId=382410166
    RestoreContextFilter;
   end;//if not l3IsNil(Diction.Context) then
  end;//if not aFromHistory then
 end;//Diction <> nil
//#UC END# *497469C90140_4979D40E0180_impl*
end;//TPrimDictionForm.NotifyDataSourceChanged

procedure TPrimDictionForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4979D40E0180_var*
//#UC END# *49803F5503AA_4979D40E0180_var*
begin
//#UC START# *49803F5503AA_4979D40E0180_impl*
 inherited;

 // отключаем придочивание только в ТС, чтобы не случались разные извращения
 // http://mdp.garant.ru/pages/viewpage.action?pageId=382410422
 // http://mdp.garant.ru/pages/viewpage.action?pageId=290947184
 // http://mdp.garant.ru/pages/viewpage.action?pageId=290947672
 //if Parent is TvtSizeablePanel then
  //TvtSizeablePanel(Parent).DisableAcceptInDockOver := true;

 WordsTree.Images := nsDictRes.DictImages;
 ContextFilter.Images := dmStdRes.SmallImageList;
 UpdateStatusInfo;
//#UC END# *49803F5503AA_4979D40E0180_impl*
end;//TPrimDictionForm.DoInit

function TPrimDictionForm.NeedDrawCaption: Boolean;
 {* Нужно ли рисовать заголовок зоны }
//#UC START# *4A84183701B9_4979D40E0180_var*
//#UC END# *4A84183701B9_4979D40E0180_var*
begin
//#UC START# *4A84183701B9_4979D40E0180_impl*
 Result := false;
//#UC END# *4A84183701B9_4979D40E0180_impl*
end;//TPrimDictionForm.NeedDrawCaption

procedure TPrimDictionForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4979D40E0180_var*
//#UC END# *4A8E8F2E0195_4979D40E0180_var*
begin
//#UC START# *4A8E8F2E0195_4979D40E0180_impl*
 inherited;
 ActiveControl := WordsTree;
 Style.Toolbars.Bottom.MergeWithContainer := vcm_bFalse;
 Style.Toolbars.Bottom.ImageSize := isSmall;

 Width := 273;
 Height := 451;

 with BackgroundPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;

 with ContextFilter do
 begin
  ImageIndex := 77;
  LabelVisible := False;
  ContextFilterTarget := WordsTree;
  OnChange := ContextFilterChange;
  OnWrongContext := ContextFilterWrongContext;
 end;

 with WordsTree do
 begin
  OnCountChanged := WordsTreeCountChanged;
  Align := alClient;
  BorderStyle := bsNone;
  TabOrder := 1;
  ActionElementMode := l3_amSingleClick;
  NeedStatus := True;
  OnMakeTreeSource := WordsTreeMakeTreeSource;
  OnGetItemImage := WordsTreeGetItemImage;
  OnActionElement := WordsTreeActionElement;
  OnCurrentChanged := WordsTreeCurrentChanged;
  OnSelectCountChanged := WordsTreeSelectCountChanged;
  OnFormatStatusInfo := WordsTreeFormatStatusInfo;
  OnNewCharPressed := WordsTreeNewCharPressed;
  SettingId := 'stidDictionTree';
 end;
//#UC END# *4A8E8F2E0195_4979D40E0180_impl*
end;//TPrimDictionForm.InitControls

procedure TPrimDictionForm.FormInsertedIntoContainer;
//#UC START# *4F7C65380244_4979D40E0180_var*
//#UC END# *4F7C65380244_4979D40E0180_var*
begin
//#UC START# *4F7C65380244_4979D40E0180_impl*
 inherited;
 WordsTree.Width := MaxInt; // без этого не появляется скролл в дереве почему-то
//#UC END# *4F7C65380244_4979D40E0180_impl*
end;//TPrimDictionForm.FormInsertedIntoContainer

procedure TPrimDictionForm.ClearFields;
begin
 f_ContextMap := nil;
 inherited;
end;//TPrimDictionForm.ClearFields

initialization
 str_utDictionCaption.Init;
 {* Инициализация str_utDictionCaption }
 str_utDictionSettingsCaption.Init;
 {* Инициализация str_utDictionSettingsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDictionForm);
 {* Регистрация PrimDiction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
