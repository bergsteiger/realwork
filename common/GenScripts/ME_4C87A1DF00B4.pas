unit PrimCommonDictionOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimCommonDictionOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimCommonDiction_Form
 , CommonDictionInterfaces
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , vtPanel
 , nscTreeViewWithAdapterDragDrop
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3TreeInterfaces
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimCommonDictionOptionsForm = class(TPrimCommonDictionForm, IbsCommonDictionListener)
  private
   f_BackgroundPanel: TvtPanel;
    {* Поле для свойства BackgroundPanel }
   f_WordsTree: TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства WordsTree }
   f_ContextFilter: TnscContextFilter;
    {* Поле для свойства ContextFilter }
   f_NeedShowCurrentDiction: Boolean;
    {* Поле для свойства NeedShowCurrentDiction }
   f_ContextFilterState: InscContextFilterState;
    {* Поле для свойства ContextFilterState }
  private
   procedure ContextFilterChange(Sender: TObject);
   procedure ContextFilterWrongContext(Sender: TObject);
   procedure WordsTreeCountChanged(Sender: TObject;
    NewCount: LongInt);
   procedure WordsTreeCurrentChanged(Sender: TObject;
    aNewCurrent: LongInt;
    aOldCurrent: LongInt);
   function WordsTreeGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure WordsTreeActionElement(Sender: TObject;
    Index: LongInt);
   procedure WordsTreeTreeChanged(aSender: TObject;
    const anOldTree: Il3SimpleTree;
    const aNewTree: Il3SimpleTree);
   procedure WordsTreeSelectCountChanged(aSender: TObject;
    anOldCount: Integer;
    aNewCount: Integer);
   procedure WordsTreeFormatStatusInfo(aSender: TObject;
    var Info: Il3CString;
    aCurrent: Integer;
    aCount: Integer;
    aSelected: Integer);
   procedure WordsTreeNewCharPressed(aChar: AnsiChar);
   procedure WordsTreeMakeTreeSource(out theTree: Il3SimpleTree);
  protected
   procedure pm_SetNeedShowCurrentDiction(aValue: Boolean);
   function pm_GetContextFilterState: InscContextFilterState;
   procedure ChangeDiction(aItem: Integer;
    aUpdateWithDelay: Boolean = True);
    {* изменить текущее толковани }
   procedure CurrentUpdated;
    {* текущее значение изменилось }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
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
   procedure ClearFields; override;
  public
   {$If NOT Defined(NoVCM)}
   procedure ExpandAll; override;
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CollapseAll; override;
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
  protected
   property NeedShowCurrentDiction: Boolean
    read f_NeedShowCurrentDiction
    write pm_SetNeedShowCurrentDiction;
   property ContextFilterState: InscContextFilterState
    read pm_GetContextFilterState;
  public
   property BackgroundPanel: TvtPanel
    read f_BackgroundPanel;
 end;//TPrimCommonDictionOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , PrimCommonDiction_utTips_UserType
 , DictionRes
 , l3String
 , vtSizeablePanel
 , SysUtils
 , nsUtils
 , PrimCommonDiction_utMedicDiction_UserType
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nsMedicDictCache
 , DataAdapter
 , nsDictionTree
 , BaseTypesUnit
 , vtLister
 , Windows
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 // ExcludeExpandAllCollapseAll

procedure TPrimCommonDictionOptionsForm.pm_SetNeedShowCurrentDiction(aValue: Boolean);
//#UC START# *5005661D0242_4C87A1DF00B4set_var*
//#UC END# *5005661D0242_4C87A1DF00B4set_var*
begin
//#UC START# *5005661D0242_4C87A1DF00B4set_impl*
 inherited;
 NeedShowCurrentDiction := false;
 Assert(False);//тут бесконечная рекурсия
//#UC END# *5005661D0242_4C87A1DF00B4set_impl*
end;//TPrimCommonDictionOptionsForm.pm_SetNeedShowCurrentDiction

function TPrimCommonDictionOptionsForm.pm_GetContextFilterState: InscContextFilterState;
//#UC START# *52F89EEA01EE_4C87A1DF00B4get_var*
//#UC END# *52F89EEA01EE_4C87A1DF00B4get_var*
begin
//#UC START# *52F89EEA01EE_4C87A1DF00B4get_impl*
 if not Assigned(f_ContextFilterState) then
  if Assigned(dsCommonDiction) then
   f_ContextFilterState := dsCommonDiction.ContextFilterState;
 Result := f_ContextFilterState;
//#UC END# *52F89EEA01EE_4C87A1DF00B4get_impl*
end;//TPrimCommonDictionOptionsForm.pm_GetContextFilterState

procedure TPrimCommonDictionOptionsForm.ChangeDiction(aItem: Integer;
 aUpdateWithDelay: Boolean = True);
 {* изменить текущее толковани }
//#UC START# *5005645F03CE_4C87A1DF00B4_var*
var
 l_l3Node : Il3SimpleNode;
//#UC END# *5005645F03CE_4C87A1DF00B4_var*
begin
//#UC START# *5005645F03CE_4C87A1DF00B4_impl*
 if aItem <> -1 then
 begin
  l_l3Node := WordsTree.GetNode(aItem);
  try
   if (dsCommonDiction <> nil) then
    dsCommonDiction.CurrentChanged(l_l3Node, aUpdateWithDelay);
  finally
   l_l3Node := nil;
  end;//try..finally
 end;//if Index <> -1 then
//#UC END# *5005645F03CE_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.ChangeDiction

procedure TPrimCommonDictionOptionsForm.ContextFilterChange(Sender: TObject);
//#UC START# *5146E2260095_4C87A1DF00B4_var*
var
 l_Tree: Il3FilterableTree;
 l_Filtered: Il3SimpleTree;
 l_Node: Il3SimpleNode;
 l_NewNodeIndex: Integer;
//#UC END# *5146E2260095_4C87A1DF00B4_var*
begin
//#UC START# *5146E2260095_4C87A1DF00B4_impl*
 if Assigned(dsCommonDiction) and
    Supports(WordsTree.TreeStruct, Il3FilterableTree, l_Tree) then
 begin
  // Сохраним параметры контекстной фильтрации для данного языка
  f_ContextFilterState := nil;
  dsCommonDiction.ContextFilterState := ContextFilter.MakeState;
  l_Filtered := l_Tree.MakeFiltered(l_Tree.CloneFilters.SetContext(ContextFilterState.ActiveContext),
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
     Changed;
    end;{try..finally}
   end;//with WordsTree do
 end;//if Supports(WordsTree.TreeStruct,
//#UC END# *5146E2260095_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.ContextFilterChange

procedure TPrimCommonDictionOptionsForm.ContextFilterWrongContext(Sender: TObject);
//#UC START# *5146E29E0040_4C87A1DF00B4_var*
//#UC END# *5146E29E0040_4C87A1DF00B4_var*
begin
//#UC START# *5146E29E0040_4C87A1DF00B4_impl*
 nsBeepWrongContext;
//#UC END# *5146E29E0040_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.ContextFilterWrongContext

procedure TPrimCommonDictionOptionsForm.WordsTreeCountChanged(Sender: TObject;
 NewCount: LongInt);
//#UC START# *5146E2F602B1_4C87A1DF00B4_var*
//#UC END# *5146E2F602B1_4C87A1DF00B4_var*
begin
//#UC START# *5146E2F602B1_4C87A1DF00B4_impl*
 UpdateStatusInfo;
//#UC END# *5146E2F602B1_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.WordsTreeCountChanged

procedure TPrimCommonDictionOptionsForm.WordsTreeCurrentChanged(Sender: TObject;
 aNewCurrent: LongInt;
 aOldCurrent: LongInt);
//#UC START# *5146E33502A3_4C87A1DF00B4_var*
//#UC END# *5146E33502A3_4C87A1DF00B4_var*
begin
//#UC START# *5146E33502A3_4C87A1DF00B4_impl*
 UpdateStatusInfo;
 // Если происходит переключения языка толкований обновлять текущий нельзя, т.к.
 // в процессе переключения произойдет поиск текущего в новом списке толкований
 // и если толкование не будет найдено, то в новом списке толкования не будет
 // устновлен текущий:
 ChangeDiction(aNewCurrent);
//#UC END# *5146E33502A3_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.WordsTreeCurrentChanged

function TPrimCommonDictionOptionsForm.WordsTreeGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *5146E621033A_4C87A1DF00B4_var*
//#UC END# *5146E621033A_4C87A1DF00B4_var*
begin
//#UC START# *5146E621033A_4C87A1DF00B4_impl*
 Result := cDictItemIcon;
//#UC END# *5146E621033A_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.WordsTreeGetItemImage

procedure TPrimCommonDictionOptionsForm.WordsTreeActionElement(Sender: TObject;
 Index: LongInt);
//#UC START# *5146E64C035F_4C87A1DF00B4_var*
//#UC END# *5146E64C035F_4C87A1DF00B4_var*
begin
//#UC START# *5146E64C035F_4C87A1DF00B4_impl*
 ChangeDiction(Index, False);
//#UC END# *5146E64C035F_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.WordsTreeActionElement

procedure TPrimCommonDictionOptionsForm.WordsTreeTreeChanged(aSender: TObject;
 const anOldTree: Il3SimpleTree;
 const aNewTree: Il3SimpleTree);
//#UC START# *5146EC920269_4C87A1DF00B4_var*
//#UC END# *5146EC920269_4C87A1DF00B4_var*
begin
//#UC START# *5146EC920269_4C87A1DF00B4_impl*
 if NeedShowCurrentDiction then
 begin
  ChangeDiction(WordsTree.Current);
  NeedShowCurrentDiction := False;
 end;//if NeedShowCurrentDiction then
//#UC END# *5146EC920269_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.WordsTreeTreeChanged

procedure TPrimCommonDictionOptionsForm.WordsTreeSelectCountChanged(aSender: TObject;
 anOldCount: Integer;
 aNewCount: Integer);
//#UC START# *5146ED3F0081_4C87A1DF00B4_var*
//#UC END# *5146ED3F0081_4C87A1DF00B4_var*
begin
//#UC START# *5146ED3F0081_4C87A1DF00B4_impl*
 UpdateStatusInfo;
//#UC END# *5146ED3F0081_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.WordsTreeSelectCountChanged

procedure TPrimCommonDictionOptionsForm.WordsTreeFormatStatusInfo(aSender: TObject;
 var Info: Il3CString;
 aCurrent: Integer;
 aCount: Integer;
 aSelected: Integer);
//#UC START# *5146ED6C00BB_4C87A1DF00B4_var*
const
 cMap: array [utTips .. utMedicDiction] of PvcmStringID = (
  @str_TipsStatusInfoFormat,   //utTips
  @str_DictionStatusInfoFormat //utMedicDiction
 );
//#UC END# *5146ED6C00BB_4C87A1DF00B4_var*
begin
//#UC START# *5146ED6C00BB_4C87A1DF00B4_impl*
 Info := vcmFmt(cMap[UserType]^,[aCurrent, aCount]);
//#UC END# *5146ED6C00BB_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.WordsTreeFormatStatusInfo

procedure TPrimCommonDictionOptionsForm.WordsTreeNewCharPressed(aChar: AnsiChar);
//#UC START# *5146ED7F005F_4C87A1DF00B4_var*
//#UC END# *5146ED7F005F_4C87A1DF00B4_var*
begin
//#UC START# *5146ED7F005F_4C87A1DF00B4_impl*
 ContextFilter.PressChar(aChar);
//#UC END# *5146ED7F005F_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.WordsTreeNewCharPressed

procedure TPrimCommonDictionOptionsForm.WordsTreeMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *52F4E7F400DE_4C87A1DF00B4_var*
var
 l_Tree: Il3FilterableTree;
 l_Node: Il3SimpleNode;
 l_NewNodeIndex: Integer;
//#UC END# *52F4E7F400DE_4C87A1DF00B4_var*
begin
//#UC START# *52F4E7F400DE_4C87A1DF00B4_impl*
(* if Assigned(dsCommonDiction) then
  if Assigned(ContextFilterState) and
     Supports(dsCommonDiction.SimpleTree, Il3FilterableTree, l_Tree) then
   theTree := l_Tree.MakeFiltered(l_Tree.CloneFilters.SetContext(ContextFilterState.Context),
                                  l_Node,
                                  l_NewNodeIndex,
                                  True,
                                  ContextFilter.NeedRefilterTree)
  else
   theTree := dsCommonDiction.SimpleTree
 else
  theTree := nil;*)
 theTree := nil;
 if Assigned(dsCommonDiction) then
  with DefDataAdapter do
   if Assigned(ContextFilterState)
    then theTree := TnsDictionTree.Make(dsCommonDiction.DictionKind, LG_RUSSIAN, ContextFilterState.Context)
    else theTree := TnsDictionTree.Make(dsCommonDiction.DictionKind, LG_RUSSIAN);
//#UC END# *52F4E7F400DE_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.WordsTreeMakeTreeSource

procedure TPrimCommonDictionOptionsForm.CurrentUpdated;
 {* текущее значение изменилось }
//#UC START# *493402BC0160_4C87A1DF00B4_var*
//#UC END# *493402BC0160_4C87A1DF00B4_var*
begin
//#UC START# *493402BC0160_4C87A1DF00B4_impl*
 WordsTree.Current := dsCommonDiction.MakeCurrentIndex(WordsTree.TreeStruct);
//#UC END# *493402BC0160_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.CurrentUpdated

{$If NOT Defined(NoVCM)}
procedure TPrimCommonDictionOptionsForm.ExpandAll;
 {* Развернуть все }
//#UC START# *4BDAF7880236_4C87A1DF00B4_var*
//#UC END# *4BDAF7880236_4C87A1DF00B4_var*
begin
//#UC START# *4BDAF7880236_4C87A1DF00B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7880236_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.ExpandAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimCommonDictionOptionsForm.CollapseAll;
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_4C87A1DF00B4_var*
//#UC END# *4BDAF7A2005C_4C87A1DF00B4_var*
begin
//#UC START# *4BDAF7A2005C_4C87A1DF00B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7A2005C_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.CollapseAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimCommonDictionOptionsForm.Delete;
 {* Удалить }
//#UC START# *4C7D0CC90052_4C87A1DF00B4_var*
//#UC END# *4C7D0CC90052_4C87A1DF00B4_var*
begin
//#UC START# *4C7D0CC90052_4C87A1DF00B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0CC90052_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimCommonDictionOptionsForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4C87A1DF00B4_var*
//#UC END# *479731C50290_4C87A1DF00B4_var*
begin
//#UC START# *479731C50290_4C87A1DF00B4_impl*
 if (DataSource <> nil) then
  DataSource.Unsubscribe(IbsCommonDictionListener(Self));
 inherited;
//#UC END# *479731C50290_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.Cleanup

{$If NOT Defined(NoVCM)}
procedure TPrimCommonDictionOptionsForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_4C87A1DF00B4_var*

 function lp_IsInit: Boolean;
 begin
  Result := (sdsBaseDocument <> nil) and not sdsBaseDocument.HasDocument;
 end;//lp_IsInit

var
 l_Index: Integer;
 l_Tree: Il3FilterableTree;
 l_Node: Il3SimpleNode;
 l_NewNodeIndex: Integer;
//#UC END# *497469C90140_4C87A1DF00B4_var*
begin
//#UC START# *497469C90140_4C87A1DF00B4_impl*
 inherited;
 if (anOld <> nil) then
  anOld.Unsubscribe(IbsCommonDictionListener(Self));
 if (aNew <> nil) then
  aNew.Subscribe(IbsCommonDictionListener(Self));
 // Возможно, что в истории лежит которого на самом деле уже нет, вследствии
 // установки базы без толкового словаря не лету
 if (dsCommonDiction <> nil) then
 begin
  // Поиск слова в толковом словаре
  if not Dispatcher.History.InBF then
  begin
   //WordsTree.TreeStruct := dsCommonDiction.SimpleTree;
   (*if Assigned(ContextFilterState) and
      Supports(dsCommonDiction.SimpleTree, Il3FilterableTree, l_Tree) then
    WordsTree.TreeStruct := l_Tree.MakeFiltered(l_Tree.CloneFilters.SetContext(ContextFilterState.Context),
                                                l_Node,
                                                l_NewNodeIndex,
                                                True,
                                                ContextFilter.NeedRefilterTree)
   else
    WordsTree.TreeStruct := dsCommonDiction.SimpleTree;*)
   WordsTree.TreeStruct;
   if not l3IsNil(dsCommonDiction.Context) then
   begin
    ContextFilter.Context := dsCommonDiction.Context;
    ContextFilter.ForceActive;
   end//if not l3IsNil(dsCommonDiction.Context) then
   // Переход по ссылке в толкованиях
   else
   begin
    // Выключаем контекст перед позиционированием
    ContextFilter.Active := False;
    // При открытии словаря показываем текущее толкование в списке (первое):
    if lp_IsInit then
    begin
     // Если дерево на экране, то покажем первое толкование:
     if WordsTree.IsTreeAssign then
      ChangeDiction(WordsTree.Current)
     // Иначе подождем когда дерево появится и покажем первое толкование:
     else
      NeedShowCurrentDiction := True;
    end//if lp_IsInit then
    // Спозиционируемся
    else
    begin
     l_Index := dsCommonDiction.MakeCurrentIndex(WordsTree.TreeStruct);
     if l_Index > -1 then
      WordsTree.Current := Pred(l_Index)
     else
      WordsTree.SetNoCurrent;
    end;//if lp_IsInit then
    if Assigned(ContextFilterState) then
     ContextFilter.AssignState(ContextFilterState);
   end;//if not l3IsNil(dsCommonDiction.Context) then
  end;//if not aFromHistory then
 end;//dsCommonDiction <> nil
//#UC END# *497469C90140_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.NotifyDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimCommonDictionOptionsForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4C87A1DF00B4_var*
//#UC END# *49803F5503AA_4C87A1DF00B4_var*
begin
//#UC START# *49803F5503AA_4C87A1DF00B4_impl*
 inherited;

 // отключаем придочивание для исключения потенциальных AV, сделано вместе с
 // http://mdp.garant.ru/pages/viewpage.action?pageId=382410422
// if Parent is TvtSizeablePanel then
//  TvtSizeablePanel(Parent).DisableAcceptInDockOver := true;

 WordsTree.Images := nsDictRes.DictImages;
 ContextFilter.Images := dmStdRes.SmallImageList;
 UpdateStatusInfo;
//#UC END# *49803F5503AA_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimCommonDictionOptionsForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4C87A1DF00B4_var*
//#UC END# *4A8E8F2E0195_4C87A1DF00B4_var*
begin
//#UC START# *4A8E8F2E0195_4C87A1DF00B4_impl*
 ActiveControl := WordsTree;
 with BackgroundPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
 with ContextFilter do
 begin
  Height := 31;
  LabelVisible := False;
  ImageIndex := 77;
  ContextFilterTarget := WordsTree;
  OnChange := ContextFilterChange;
  OnWrongContext := ContextFilterWrongContext;
 end;
 with WordsTree do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  ActionElementMode := l3_amSingleClick;
  NeedStatus := True;
  OnCountChanged := WordsTreeCountChanged;
  OnGetItemImage := WordsTreeGetItemImage;
  OnActionElement := WordsTreeActionElement;
  OnCurrentChanged := WordsTreeCurrentChanged;
  OnTreeChanged := WordsTreeTreeChanged;
  OnSelectCountChanged := WordsTreeSelectCountChanged;
  OnFormatStatusInfo := WordsTreeFormatStatusInfo;
  OnNewCharPressed := WordsTreeNewCharPressed;
  OnMakeTreeSource := WordsTreeMakeTreeSource;
  SettingId := 'stidDictionTree';
 end;
//#UC END# *4A8E8F2E0195_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimCommonDictionOptionsForm.ClearFields;
begin
 f_ContextFilterState := nil;
 inherited;
end;//TPrimCommonDictionOptionsForm.ClearFields

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimCommonDictionOptionsForm);
 {* Регистрация PrimCommonDictionOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
