unit PrimTreeAttributeFirstLevel_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimTreeAttributeFirstLevel_Form.pas"
// Начат: 27.01.2009 11:33
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimTreeAttributeFirstLevel
//
// Первый уровень дерева атрибутов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  l3TreeInterfaces,
  l3ControlsTypes,
  TreeInterfaces,
  eeTreeView,
  TreeAttribute_Form
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  QueryCardInterfaces
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  SearchLite_Strange_Controls,
  l3StringIDEx
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  nscTreeViewWithAdapterDragDrop,
  PrimTreeAttributeFirstLevel_flSituation_UserType
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  DynamicTreeUnit,
  l3Interfaces,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TPrimTreeAttributeFirstLevelForm = {abstract form} class(TTreeAttributeForm)
  {* Первый уровень дерева атрибутов }
 private
 // private fields
   f_FirstLevelContent : TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства FirstLevelContent}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   function FirstLevelContentGetItemImage(Sender: TObject;
     Index: Integer;
     var aImages: TCustomImageList): Integer;
     {* Event to get Index of Bitmap in ImageIndex. }
   procedure FirstLevelContentCurrentChanged(aSender: TObject;
     aNewCurrent: Integer;
     aOldCurrent: Integer);
     {* событие для обработки изменения текущего элемента }
   procedure FirstLevelContentNewCharPressed(aChar: AnsiChar);
     {* событие для внешней обработки WMChar }
   procedure UpdateCurrent(const aNode: Il3SimpleNode);
 protected
 // realized methods
   procedure CurrentChangedNotification(const aNode: Il3SimpleNode); override;
   procedure AttributeTree_SetParent_Execute(const aParent: Il3SimpleNode);
   procedure AttributeTree_SetParent(const aParams: IvcmExecuteParams);
   procedure AttributeTree_ExtSetRoot_Execute(const aRoot: INodeBase);
   procedure AttributeTree_ExtSetRoot(const aParams: IvcmExecuteParams);
   procedure AttributeTree_SetRoot_Execute(const aTag: Il3CString);
   procedure AttributeTree_SetRoot(const aParams: IvcmExecuteParams);
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
   procedure InitFields; override;
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected fields
   dsSimpleTree : IdsSimpleTree;
   dsTreeAttributeFirstLevel : IdsTreeAttributeFirstLevel;
   f_InternalMove : Integer;
 public
 // public properties
   property FirstLevelContent: TnscTreeViewWithAdapterDragDrop
     read f_FirstLevelContent;
 end;//TPrimTreeAttributeFirstLevelForm

 TvcmEntityFormRef = TPrimTreeAttributeFirstLevelForm;
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base,
  nsAttributeOneLevelTreeStruct,
  SearchRes,
  nsTypes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  vcmBase {a},
  StdRes {a},
  SysUtils {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

var
   { Локализуемые строки flSituationLocalConstants }
  str_flSituationCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'flSituationCaption'; rValue : 'Ситуации первого уровня (вкладка)');
   { Заголовок пользовательского типа "Ситуации первого уровня (вкладка)" }
  str_flSituationSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'flSituationSettingsCaption'; rValue : 'Поиск: Ситуации первого уровня (вкладка)');
   { Заголовок пользовательского типа "Ситуации первого уровня (вкладка)" для настройки панелей инструментов }

// start class TPrimTreeAttributeFirstLevelForm

function TPrimTreeAttributeFirstLevelForm.FirstLevelContentGetItemImage(Sender: TObject;
  Index: Integer;
  var aImages: TCustomImageList): Integer;
//#UC START# *52728D2A036D_497EC6A4022F_var*
{var
 l_l3Node    : Il3SimpleNode;
 l_Node      : INodeBase;}
//#UC END# *52728D2A036D_497EC6A4022F_var*
begin
//#UC START# *52728D2A036D_497EC6A4022F_impl*
 Result := siilFolderStart;
// !! Для всех элементов рисуем иконку с папочкой независимо от наличия детей
// т.к. ноды в CreateOneLevelView всегда возвращают HasChild = 0
{ l_l3Node := FirstLevelContent.GetNode(Index);
 try
  if Supports(l_l3Node, INodeBase, l_Node) then
  begin
   if l_Node.HasChildren then
    Result := siilFolderStart
   else
    Result := siilElementStart;

   l_Node := nil;
  end;
 finally
  l_l3Node := nil;
 end;}
//#UC END# *52728D2A036D_497EC6A4022F_impl*
end;//TPrimTreeAttributeFirstLevelForm.FirstLevelContentGetItemImage

procedure TPrimTreeAttributeFirstLevelForm.FirstLevelContentCurrentChanged(aSender: TObject;
  aNewCurrent: Integer;
  aOldCurrent: Integer);
//#UC START# *52728D32009E_497EC6A4022F_var*
//#UC END# *52728D32009E_497EC6A4022F_var*
begin
//#UC START# *52728D32009E_497EC6A4022F_impl*
 if (aNewCurrent >= 0) and (f_InternalMove = 0) then
 begin
  if (dsSimpleTree <> nil) then
   dsSimpleTree.CurrentChanged(FirstLevelContent.GetNode(aNewCurrent));
  // Принудительно перирисовываем дерево, для случая когда пользователь бежит
  // по дереву удерживая стрелку вниз\вверх
  FirstLevelContent.Update;
 end//if (aNewCurrent >= 0) and (f_InternalMove = 0) then
//#UC END# *52728D32009E_497EC6A4022F_impl*
end;//TPrimTreeAttributeFirstLevelForm.FirstLevelContentCurrentChanged

procedure TPrimTreeAttributeFirstLevelForm.FirstLevelContentNewCharPressed(aChar: AnsiChar);
//#UC START# *52728D3A0299_497EC6A4022F_var*
//#UC END# *52728D3A0299_497EC6A4022F_var*
begin
//#UC START# *52728D3A0299_497EC6A4022F_impl*
 op_AttributeTree_ExternalCharPressed.Call(Aggregate, nsCStr(aChar));
//#UC END# *52728D3A0299_497EC6A4022F_impl*
end;//TPrimTreeAttributeFirstLevelForm.FirstLevelContentNewCharPressed

procedure TPrimTreeAttributeFirstLevelForm.UpdateCurrent(const aNode: Il3SimpleNode);
//#UC START# *52728FBC02D2_497EC6A4022F_var*
//#UC END# *52728FBC02D2_497EC6A4022F_var*
begin
//#UC START# *52728FBC02D2_497EC6A4022F_impl*
 Inc(f_InternalMove);
 try
  if (FirstLevelContent.GetCurrentNode <> nil) and
     (FirstLevelContent.GetCurrentNode.IsSame(aNode)) then
   FirstLevelContent.vlbMakeItemVisible(FirstLevelContent.Current)
  else
   FirstLevelContent.GotoOnNode(aNode);
 finally
  Dec(f_InternalMove);
 end;
//#UC END# *52728FBC02D2_497EC6A4022F_impl*
end;//TPrimTreeAttributeFirstLevelForm.UpdateCurrent

procedure TPrimTreeAttributeFirstLevelForm.CurrentChangedNotification(const aNode: Il3SimpleNode);
//#UC START# *497465F501B7_497EC6A4022F_var*
//#UC END# *497465F501B7_497EC6A4022F_var*
begin
//#UC START# *497465F501B7_497EC6A4022F_impl*
 UpdateCurrent(aNode);
//#UC END# *497465F501B7_497EC6A4022F_impl*
end;//TPrimTreeAttributeFirstLevelForm.CurrentChangedNotification

procedure TPrimTreeAttributeFirstLevelForm.AttributeTree_SetParent_Execute(const aParent: Il3SimpleNode);
//#UC START# *4AEF129601AC_497EC6A4022Fexec_var*
//#UC END# *4AEF129601AC_497EC6A4022Fexec_var*
begin
//#UC START# *4AEF129601AC_497EC6A4022Fexec_impl*
 UpdateCurrent(aParent);
//#UC END# *4AEF129601AC_497EC6A4022Fexec_impl*
end;//TPrimTreeAttributeFirstLevelForm.AttributeTree_SetParent_Execute

procedure TPrimTreeAttributeFirstLevelForm.AttributeTree_SetParent(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IAttributeTree_SetParent_Params) do
  AttributeTree_SetParent_Execute(Parent);
end;

procedure TPrimTreeAttributeFirstLevelForm.AttributeTree_ExtSetRoot_Execute(const aRoot: INodeBase);
//#UC START# *4AEF14460025_497EC6A4022Fexec_var*
//#UC END# *4AEF14460025_497EC6A4022Fexec_var*
begin
//#UC START# *4AEF14460025_497EC6A4022Fexec_impl*
 Inc(f_InternalMove);
 try
  with FirstLevelContent do
   if (TreeStruct <> nil) then
   begin
    Changing;
    try
     TreeStruct := TnsAttributeOneLevelTreeStruct.Make(aRoot, TreeStruct);
    finally
     Changed;
    end;//try..finally
   end//TreeStruct <> nil
   else // в эту ветку попадать не должны
    Assert(False);
  CCaption := l3CStr(FirstLevelContent.TreeStruct.RootNode);
 finally
  Dec(f_InternalMove);
 end;//try..finally
//#UC END# *4AEF14460025_497EC6A4022Fexec_impl*
end;//TPrimTreeAttributeFirstLevelForm.AttributeTree_ExtSetRoot_Execute

procedure TPrimTreeAttributeFirstLevelForm.AttributeTree_ExtSetRoot(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IAttributeTree_ExtSetRoot_Params) do
  AttributeTree_ExtSetRoot_Execute(Root);
end;

procedure TPrimTreeAttributeFirstLevelForm.AttributeTree_SetRoot_Execute(const aTag: Il3CString);
//#UC START# *4AF3EBC001C4_497EC6A4022Fexec_var*
//#UC END# *4AF3EBC001C4_497EC6A4022Fexec_var*
begin
//#UC START# *4AF3EBC001C4_497EC6A4022Fexec_impl*
 Inc(f_InternalMove);
 try
  FirstLevelContent.TreeStruct :=
   TnsAttributeOneLevelTreeStruct.Make(aTag,
                                       FirstLevelContent.ShowRoot,
                                       True);
  if Assigned(FirstLevelContent.TreeStruct.RootNode) then
   CCaption := l3CStr(FirstLevelContent.TreeStruct.RootNode);
 finally
  Dec(f_InternalMove);
 end;//try..finally
//#UC END# *4AF3EBC001C4_497EC6A4022Fexec_impl*
end;//TPrimTreeAttributeFirstLevelForm.AttributeTree_SetRoot_Execute

procedure TPrimTreeAttributeFirstLevelForm.AttributeTree_SetRoot(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IAttributeTree_SetRoot_Params) do
  AttributeTree_SetRoot_Execute(Tag);
end;

{$If not defined(NoVCM)}
procedure TPrimTreeAttributeFirstLevelForm.Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7880236_497EC6A4022Ftest_var*
//#UC END# *4BDAF7880236_497EC6A4022Ftest_var*
begin
//#UC START# *4BDAF7880236_497EC6A4022Ftest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7880236_497EC6A4022Ftest_impl*
end;//TPrimTreeAttributeFirstLevelForm.Tree_ExpandAll_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTreeAttributeFirstLevelForm.Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7A2005C_497EC6A4022Ftest_var*
//#UC END# *4BDAF7A2005C_497EC6A4022Ftest_var*
begin
//#UC START# *4BDAF7A2005C_497EC6A4022Ftest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7A2005C_497EC6A4022Ftest_impl*
end;//TPrimTreeAttributeFirstLevelForm.Tree_CollapseAll_Test
{$IfEnd} //not NoVCM

procedure TPrimTreeAttributeFirstLevelForm.InitFields;
//#UC START# *47A042E100E2_497EC6A4022F_var*
//#UC END# *47A042E100E2_497EC6A4022F_var*
begin
//#UC START# *47A042E100E2_497EC6A4022F_impl*
 inherited;
 FirstLevelContent.Images := nsSearchRes.SearchItemsImageList;
 ActiveControl := FirstLevelContent;
//#UC END# *47A042E100E2_497EC6A4022F_impl*
end;//TPrimTreeAttributeFirstLevelForm.InitFields

{$If not defined(NoVCM)}
procedure TPrimTreeAttributeFirstLevelForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_497EC6A4022F_var*
//#UC END# *497469C90140_497EC6A4022F_var*
begin
//#UC START# *497469C90140_497EC6A4022F_impl*
 inherited;
 if (dsTreeAttributeFirstLevel <> nil) then
 begin
  CCaption := dsTreeAttributeFirstLevel.DisplayName;
  // Борьба с фильтром vs. история vs. _datasource
  if not Dispatcher.History.InBF then
   FirstLevelContent.TreeStruct := dsTreeAttributeFirstLevel.SimpleTree;
 end;//(dsTreeAttributeFirstLevel <> nil)
//#UC END# *497469C90140_497EC6A4022F_impl*
end;//TPrimTreeAttributeFirstLevelForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTreeAttributeFirstLevelForm.InitControls;
//#UC START# *4A8E8F2E0195_497EC6A4022F_var*
//#UC END# *4A8E8F2E0195_497EC6A4022F_var*
begin
//#UC START# *4A8E8F2E0195_497EC6A4022F_impl*
 inherited;
 with FirstLevelContent do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  ViewOptions := [voShowIcons];
  OnGetItemImage := FirstLevelContentGetItemImage;
  OnCurrentChanged := FirstLevelContentCurrentChanged;
  OnNewCharPressed := FirstLevelContentNewCharPressed;
  SettingId := 'stidFirstLevelContent';
 end;
//#UC END# *4A8E8F2E0195_497EC6A4022F_impl*
end;//TPrimTreeAttributeFirstLevelForm.InitControls
{$IfEnd} //not NoVCM

procedure TPrimTreeAttributeFirstLevelForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  dsSimpleTree := nil;
  dsTreeAttributeFirstLevel := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IdsSimpleTree, dsSimpleTree);
  Supports(aDsNew, IdsTreeAttributeFirstLevel, dsTreeAttributeFirstLevel);
 end;//aDsNew = nil
end;

procedure TPrimTreeAttributeFirstLevelForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_AttributeTree, nil);
  PublishFormEntity(en_Tree, nil);
  MakeEntitySupportedByControl(en_Tree, FirstLevelContent);
  PublishOpWithResult(en_AttributeTree, op_SetParent, AttributeTree_SetParent, nil, nil);
  PublishOpWithResult(en_AttributeTree, op_ExtSetRoot, AttributeTree_ExtSetRoot, nil, nil);
  PublishOpWithResult(en_AttributeTree, op_SetRoot, AttributeTree_SetRoot, nil, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_ExpandAll, nil, Tree_ExpandAll_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_CollapseAll, nil, Tree_CollapseAll_Test, nil);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

procedure TPrimTreeAttributeFirstLevelForm.MakeControls;
begin
 inherited;
 f_FirstLevelContent := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_FirstLevelContent.Name := 'FirstLevelContent';
 f_FirstLevelContent.Parent := Self;
 with AddUsertype(flSituationName,
  str_flSituationCaption,
  str_flSituationSettingsCaption,
  true,
  29,
  40,
  '',
  nil,
  nil,
  nil,
  vcm_ccDisable) do
 begin
 end;//with AddUsertype(flSituationName
end;

{$IfEnd} //not Admin

initialization
{$If not defined(Admin)}
// Инициализация str_flSituationCaption
 str_flSituationCaption.Init;
{$IfEnd} //not Admin
{$If not defined(Admin)}
// Инициализация str_flSituationSettingsCaption
 str_flSituationSettingsCaption.Init;
{$IfEnd} //not Admin
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimTreeAttributeFirstLevel
 TtfwClassRef.Register(TPrimTreeAttributeFirstLevelForm);
{$IfEnd} //not Admin AND not NoScripts

end.