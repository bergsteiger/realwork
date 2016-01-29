unit PrimNavigator_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/PrimNavigator_Form.pas"
// Начат: 02.11.2009 16:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Common::View::Common::PrimNavigator
//
// Меню
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
  l3TreeInterfaces,
  Classes,
  l3ControlsTypes,
  bsInterfaces,
  eeTreeView
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
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
  Common_Strange_Controls,
  l3StringIDEx,
  vtLister
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  vtOutliner,
  nscTreeViewWithAdapterDragDrop,
  PrimNavigator_utNavigator_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimNavigatorForm = {form} class(TvcmEntityForm, InsTreeDataListener)
  {* Меню }
 private
 // private fields
   f_BackgroundPanel : TvtPanel;
    {* Поле для свойства BackgroundPanel}
   f_ContextFilter : TnscContextFilter;
    {* Поле для свойства ContextFilter}
   f_NavigatorTree : TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства NavigatorTree}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure NavigatorTreeActionElement(Sender: TObject;
     Index: LongInt);
   function NavigatorTreeGetItemImage(Sender: TObject;
     Index: Integer;
     var aImages: TCustomImageList): Integer;
     {* Event to get Index of Bitmap in ImageIndex. }
   procedure NavigatorTreeNewCharPressed(aChar: AnsiChar);
     {* событие для внешней обработки WMChar }
   procedure NavigatorTreeMakeTreeSource(out theTree: Il3SimpleTree);
   procedure ContextFilterChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure NavigatorTreeTreeChanged(aSender: TObject;
     const anOldTree: Il3SimpleTree;
     const aNewTree: Il3SimpleTree);
   procedure ContextFilterWrongContext(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
 protected
 // realized methods
   procedure Navigator_SetCurrent_Execute(const aNode: Il3SimpleNode);
   procedure Navigator_SetCurrent(const aParams: IvcmExecuteParams);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected fields
   f_Lock : Integer;
 protected
 // protected methods
   procedure ExecuteCurrentElement;
 public
 // public properties
   property BackgroundPanel: TvtPanel
     read f_BackgroundPanel;
   property ContextFilter: TnscContextFilter
     read f_ContextFilter;
   property NavigatorTree: TnscTreeViewWithAdapterDragDrop
     read f_NavigatorTree;
 end;//TPrimNavigatorForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  NavigatorUtils,
  DynamicTreeUnit,
  nsUtils,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  NavigatorRes,
  nsNavigatorTreeStruct,
  BaseTypesUnit,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки utNavigatorLocalConstants }
  str_utNavigatorCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utNavigatorCaption'; rValue : 'Меню');
   { Заголовок пользовательского типа "Меню" }
  str_utNavigatorSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utNavigatorSettingsCaption'; rValue : 'Меню (вкладка)');
   { Заголовок пользовательского типа "Меню" для настройки панелей инструментов }

// start class TPrimNavigatorForm

procedure TPrimNavigatorForm.NavigatorTreeActionElement(Sender: TObject;
  Index: LongInt);
//#UC START# *5240075C038B_4AEEE269033F_var*
//#UC END# *5240075C038B_4AEEE269033F_var*
begin
//#UC START# *5240075C038B_4AEEE269033F_impl*
 if (f_Lock = 0) then
 begin
  Inc(f_Lock);
  try
   ExecuteCurrentElement;
  finally
   Dec(f_Lock);
  end;//try..finally
 end;//f_Lock = 0
//#UC END# *5240075C038B_4AEEE269033F_impl*
end;//TPrimNavigatorForm.NavigatorTreeActionElement

function TPrimNavigatorForm.NavigatorTreeGetItemImage(Sender: TObject;
  Index: Integer;
  var aImages: TCustomImageList): Integer;
//#UC START# *524007670210_4AEEE269033F_var*
var
 l_l3Node: Il3SimpleNode;
 l_Node: INodeBase;
//#UC END# *524007670210_4AEEE269033F_var*
begin
//#UC START# *524007670210_4AEEE269033F_impl*
 Result := -1;
 l_l3Node := NavigatorTree.GetNode(Index);
 try
  if Supports(l_l3Node, INodeBase, l_Node) then
  try
   Result := NavigatorRes.GetMainMenuImageIndex(l_Node, TNavigatorMenuItemType(l_Node.GetType));
  finally
   l_Node := nil;
  end;{try..finally}
 finally
 end;{try..finally}
//#UC END# *524007670210_4AEEE269033F_impl*
end;//TPrimNavigatorForm.NavigatorTreeGetItemImage

procedure TPrimNavigatorForm.NavigatorTreeNewCharPressed(aChar: AnsiChar);
//#UC START# *5240077701D5_4AEEE269033F_var*
//#UC END# *5240077701D5_4AEEE269033F_var*
begin
//#UC START# *5240077701D5_4AEEE269033F_impl*
 ContextFilter.PressChar(aChar);
//#UC END# *5240077701D5_4AEEE269033F_impl*
end;//TPrimNavigatorForm.NavigatorTreeNewCharPressed

procedure TPrimNavigatorForm.NavigatorTreeMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *524007800305_4AEEE269033F_var*
//#UC END# *524007800305_4AEEE269033F_var*
begin
//#UC START# *524007800305_4AEEE269033F_impl*
 theTree := TnsNavigatorTreeStruct.Make;
//#UC END# *524007800305_4AEEE269033F_impl*
end;//TPrimNavigatorForm.NavigatorTreeMakeTreeSource

procedure TPrimNavigatorForm.ContextFilterChange(Sender: TObject);
//#UC START# *5240078A00F5_4AEEE269033F_var*
var
 l_Tree: Il3FilterableTree;
 l_Filtered: Il3SimpleTree;
 l_Node: Il3SimpleNode;
 l_NewNodeIndex: Integer;
//#UC END# *5240078A00F5_4AEEE269033F_var*
begin
//#UC START# *5240078A00F5_4AEEE269033F_impl*
 if Supports(NavigatorTree.TreeStruct, Il3FilterableTree, l_Tree) then
 try
  Inc(f_Lock);
  try
   l_Node := NavigatorTree.GetCurrentNode;
   try
    l_Filtered := l_Tree.MakeFiltered(l_Tree.CloneFilters.SetContext(ContextFilter.ActiveContext),
                                      l_Node,
                                      l_NewNodeIndex,
                                      True,
                                      ContextFilter.NeedRefilterTree);
    if Assigned(l_Filtered) and (l_Filtered.CountView > 0) then
    begin
     NavigatorTree.TreeStruct := l_Filtered;
     if l_Node <> nil then
      NavigatorTree.GotoOnNode(l_Node);
    end;
   finally
    l_Node := nil;
   end;
  finally
   Dec(f_Lock);
  end;
 finally
  l_Tree := nil;
 end;
//#UC END# *5240078A00F5_4AEEE269033F_impl*
end;//TPrimNavigatorForm.ContextFilterChange

procedure TPrimNavigatorForm.NavigatorTreeTreeChanged(aSender: TObject;
  const anOldTree: Il3SimpleTree;
  const aNewTree: Il3SimpleTree);
//#UC START# *5240079601A2_4AEEE269033F_var*
//#UC END# *5240079601A2_4AEEE269033F_var*
begin
//#UC START# *5240079601A2_4AEEE269033F_impl*
 if (anOldTree <> nil) then
  anOldTree.Unsubscribe(InsTreeDataListener(Self));
 if (aNewTree <> nil) then
  aNewTree.Subscribe(InsTreeDataListener(Self));
//#UC END# *5240079601A2_4AEEE269033F_impl*
end;//TPrimNavigatorForm.NavigatorTreeTreeChanged

procedure TPrimNavigatorForm.ContextFilterWrongContext(Sender: TObject);
//#UC START# *524007A00200_4AEEE269033F_var*
//#UC END# *524007A00200_4AEEE269033F_var*
begin
//#UC START# *524007A00200_4AEEE269033F_impl*
 nsBeepWrongContext;
//#UC END# *524007A00200_4AEEE269033F_impl*
end;//TPrimNavigatorForm.ContextFilterWrongContext

procedure TPrimNavigatorForm.ExecuteCurrentElement;
//#UC START# *4C87A9640232_4AEEE269033F_var*
//#UC END# *4C87A9640232_4AEEE269033F_var*
begin
//#UC START# *4C87A9640232_4AEEE269033F_impl*
 ExecuteNavigatorItem(NavigatorTree.GetCurrentNode, NavigatorTree, NativeMainForm);
//#UC END# *4C87A9640232_4AEEE269033F_impl*
end;//TPrimNavigatorForm.ExecuteCurrentElement

procedure TPrimNavigatorForm.Navigator_SetCurrent_Execute(const aNode: Il3SimpleNode);
//#UC START# *4AEEE2D40157_4AEEE269033Fexec_var*
//#UC END# *4AEEE2D40157_4AEEE269033Fexec_var*
begin
//#UC START# *4AEEE2D40157_4AEEE269033Fexec_impl*
 if f_Lock > 0 then
  Exit;

 Inc(f_Lock);
 try
  NavigatorTree.GotoOnNode(aNode);
 finally
  Dec(f_Lock);
 end;//try..finally
//#UC END# *4AEEE2D40157_4AEEE269033Fexec_impl*
end;//TPrimNavigatorForm.Navigator_SetCurrent_Execute

procedure TPrimNavigatorForm.Navigator_SetCurrent(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As INavigator_SetCurrent_Params) do
  Navigator_SetCurrent_Execute(Node);
end;

procedure TPrimNavigatorForm.Cleanup;
//#UC START# *479731C50290_4AEEE269033F_var*
//#UC END# *479731C50290_4AEEE269033F_var*
begin
//#UC START# *479731C50290_4AEEE269033F_impl*
 if (NavigatorTree.TreeStruct <> nil) then
  NavigatorTree.TreeStruct.Unsubscribe(InsTreeDataListener(Self));
 inherited;
//#UC END# *479731C50290_4AEEE269033F_impl*
end;//TPrimNavigatorForm.Cleanup

{$If not defined(NoVCM)}
procedure TPrimNavigatorForm.InitControls;
//#UC START# *4A8E8F2E0195_4AEEE269033F_var*
//#UC END# *4A8E8F2E0195_4AEEE269033F_var*
begin
//#UC START# *4A8E8F2E0195_4AEEE269033F_impl*
 f_Lock := 0;
 NavigatorTree.Images := nsNavigatorRes.NavigatorItemsImageList;
 NavigatorTree.TreeStruct := TnsNavigatorTreeStruct.Make;
 ContextFilter.Images := dmStdRes.SmallImageList;

 ActiveControl := NavigatorTree;
 FormStyle := fsStayOnTop;
 Scaled := False;
 with BackgroundPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
  TabOrder := 0;
 end;
 with ContextFilter do
 begin
  ImageIndex := 77;
  LabelVisible := False;
  ContextFilterTarget := NavigatorTree;
  OnChange := ContextFilterChange;
  OnWrongContext := ContextFilterWrongContext;
 end;
 with NavigatorTree do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  TabOrder := 1;
  ActionElementMode := l3_amSingleClick;
  OnMakeTreeSource := NavigatorTreeMakeTreeSource;
  OnGetItemImage := NavigatorTreeGetItemImage;
  OnActionElement := NavigatorTreeActionElement;
  OnTreeChanged := NavigatorTreeTreeChanged;
  OnNewCharPressed := NavigatorTreeNewCharPressed;
  SettingId := 'stidNavigatorTree';
 end;
//#UC END# *4A8E8F2E0195_4AEEE269033F_impl*
end;//TPrimNavigatorForm.InitControls
{$IfEnd} //not NoVCM

procedure TPrimNavigatorForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Navigator, nil);
  PublishOpWithResult(en_Navigator, op_SetCurrent, Navigator_SetCurrent, nil, nil);
 end;//with Entities.Entities
end;

procedure TPrimNavigatorForm.MakeControls;
begin
 inherited;
 with AddUsertype(utNavigatorName,
  str_utNavigatorCaption,
  str_utNavigatorSettingsCaption,
  true,
  44,
  10,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utNavigatorName
 f_BackgroundPanel := TvtPanel.Create(Self);
 f_BackgroundPanel.Name := 'BackgroundPanel';
 f_BackgroundPanel.Parent := Self;
 f_ContextFilter := TnscContextFilter.Create(Self);
 f_ContextFilter.Name := 'ContextFilter';
 f_ContextFilter.Parent := BackgroundPanel;
 f_NavigatorTree := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_NavigatorTree.Name := 'NavigatorTree';
 f_NavigatorTree.Parent := BackgroundPanel;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utNavigatorCaption
 str_utNavigatorCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utNavigatorSettingsCaption
 str_utNavigatorSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimNavigator
 TtfwClassRef.Register(TPrimNavigatorForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.