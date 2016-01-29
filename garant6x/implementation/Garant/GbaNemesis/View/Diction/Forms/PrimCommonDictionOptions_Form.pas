unit PrimCommonDictionOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Diction/Forms/PrimCommonDictionOptions_Form.pas"
// Начат: 08.09.2010 18:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Встроенные продукты::Diction::View::Diction::PrimCommonDictionOptions
//
// Совет дня
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
  l3Interfaces,
  l3TreeInterfaces,
  Classes,
  l3ControlsTypes
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  CommonDictionInterfaces,
  eeTreeView
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  ,
  PrimCommonDiction_Form,
  eeTreeViewExport
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  vtPanel
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  PrimCommonDiction_utTips_UserType
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  ,
  vtLister,
  vtOutliner,
  nscTreeViewWithAdapterDragDrop
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimCommonDictionOptionsForm = {form} class(TPrimCommonDictionForm, IbsCommonDictionListener)
  {* Совет дня }
 private
 // private fields
   f_BackgroundPanel : TvtPanel;
    {* Поле для свойства BackgroundPanel}
   f_WordsTree : TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства WordsTree}
   f_ContextFilter : TnscContextFilter;
    {* Поле для свойства ContextFilter}
   f_NeedShowCurrentDiction : Boolean;
    {* Поле для свойства NeedShowCurrentDiction}
   f_ContextFilterState : InscContextFilterState;
    {* Поле для свойства ContextFilterState}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure ContextFilterChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure ContextFilterWrongContext(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure WordsTreeCountChanged(Sender: TObject;
     NewCount: LongInt);
   procedure WordsTreeCurrentChanged(Sender: TObject;
     aNewCurrent: LongInt;
     aOldCurrent: LongInt);
   function WordsTreeGetItemImage(Sender: TObject;
     Index: Integer;
     var aImages: TCustomImageList): Integer;
     {* Event to get Index of Bitmap in ImageIndex. }
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
     {* событие для внешней обработки WMChar }
   procedure WordsTreeMakeTreeSource(out theTree: Il3SimpleTree);
 protected
 // property methods
   procedure pm_SetNeedShowCurrentDiction(aValue: Boolean);
   function pm_GetContextFilterState: InscContextFilterState;
 protected
 // realized methods
   procedure CurrentUpdated;
     {* текущее значение изменилось }
   {$If not defined(NoVCM)}
   procedure Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
     {* Развернуть все }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
     {* Свернуть все }
   {$IfEnd} //not NoVCM
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   procedure ChangeDiction(aItem: Integer;
     aUpdateWithDelay: Boolean = True);
     {* изменить текущее толковани }
 protected
 // protected properties
   property NeedShowCurrentDiction: Boolean
     read f_NeedShowCurrentDiction
     write pm_SetNeedShowCurrentDiction;
   property ContextFilterState: InscContextFilterState
     read pm_GetContextFilterState;
 public
 // public properties
   property BackgroundPanel: TvtPanel
     read f_BackgroundPanel;
   property WordsTree: TnscTreeViewWithAdapterDragDrop
     read f_WordsTree;
   property ContextFilter: TnscContextFilter
     read f_ContextFilter;
 end;//TPrimCommonDictionOptionsForm

 TvcmEntityFormRef = TPrimCommonDictionOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DictionRes,
  l3String,
  vtSizeablePanel,
  SysUtils,
  nsUtils,
  PrimCommonDiction_utMedicDiction_UserType
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  nsMedicDictCache,
  DataAdapter,
  nsDictionTree,
  BaseTypesUnit
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimCommonDictionOptionsForm

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

procedure TPrimCommonDictionOptionsForm.ChangeDiction(aItem: Integer;
  aUpdateWithDelay: Boolean = True);
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

procedure TPrimCommonDictionOptionsForm.CurrentUpdated;
//#UC START# *493402BC0160_4C87A1DF00B4_var*
//#UC END# *493402BC0160_4C87A1DF00B4_var*
begin
//#UC START# *493402BC0160_4C87A1DF00B4_impl*
 WordsTree.Current := dsCommonDiction.MakeCurrentIndex(WordsTree.TreeStruct);
//#UC END# *493402BC0160_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.CurrentUpdated

{$If not defined(NoVCM)}
procedure TPrimCommonDictionOptionsForm.Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7880236_4C87A1DF00B4test_var*
//#UC END# *4BDAF7880236_4C87A1DF00B4test_var*
begin
//#UC START# *4BDAF7880236_4C87A1DF00B4test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7880236_4C87A1DF00B4test_impl*
end;//TPrimCommonDictionOptionsForm.Tree_ExpandAll_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimCommonDictionOptionsForm.Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7A2005C_4C87A1DF00B4test_var*
//#UC END# *4BDAF7A2005C_4C87A1DF00B4test_var*
begin
//#UC START# *4BDAF7A2005C_4C87A1DF00B4test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7A2005C_4C87A1DF00B4test_impl*
end;//TPrimCommonDictionOptionsForm.Tree_CollapseAll_Test
{$IfEnd} //not NoVCM

procedure TPrimCommonDictionOptionsForm.Cleanup;
//#UC START# *479731C50290_4C87A1DF00B4_var*
//#UC END# *479731C50290_4C87A1DF00B4_var*
begin
//#UC START# *479731C50290_4C87A1DF00B4_impl*
 if (DataSource <> nil) then
  DataSource.Unsubscribe(IbsCommonDictionListener(Self));
 inherited;
//#UC END# *479731C50290_4C87A1DF00B4_impl*
end;//TPrimCommonDictionOptionsForm.Cleanup

{$If not defined(NoVCM)}
procedure TPrimCommonDictionOptionsForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimCommonDictionOptionsForm.DoInit(aFromHistory: Boolean);
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimCommonDictionOptionsForm.InitControls;
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
{$IfEnd} //not NoVCM

procedure TPrimCommonDictionOptionsForm.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_ContextFilterState := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TPrimCommonDictionOptionsForm.ClearFields

procedure TPrimCommonDictionOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_Tree, nil);
  MakeEntitySupportedByControl(en_Tree, WordsTree);
  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_ExpandAll, nil, Tree_ExpandAll_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_CollapseAll, nil, Tree_CollapseAll_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Delete, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Delete, true);
  ShowInToolbar(en_Edit, op_Delete, false);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
 {$If not defined(NoVCM)}
 AddUserTypeExclude(utTipsName, en_Tree, op_ExpandAll, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(utTipsName, en_Tree, op_CollapseAll, false);
 {$IfEnd} //not NoVCM
end;

procedure TPrimCommonDictionOptionsForm.MakeControls;
begin
 inherited;
 f_BackgroundPanel := TvtPanel.Create(Self);
 f_BackgroundPanel.Name := 'BackgroundPanel';
 f_BackgroundPanel.Parent := Self;
 f_WordsTree := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_WordsTree.Name := 'WordsTree';
 f_WordsTree.Parent := BackgroundPanel;
 f_ContextFilter := TnscContextFilter.Create(Self);
 f_ContextFilter.Name := 'ContextFilter';
 f_ContextFilter.Parent := BackgroundPanel;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimCommonDictionOptions
 TtfwClassRef.Register(TPrimCommonDictionOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.