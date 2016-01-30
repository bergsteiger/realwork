unit PrimNavigator_Form;
 {* Меню }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimNavigator_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , bsInterfaces
 , Common_Strange_Controls
 , vtPanel
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , nscTreeViewWithAdapterDragDrop
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3TreeInterfaces
 , l3StringIDEx
;

type
 TPrimNavigatorForm = class(TvcmEntityForm, InsTreeDataListener)
  {* Меню }
  private
   f_BackgroundPanel: TvtPanel;
    {* Поле для свойства BackgroundPanel }
   f_ContextFilter: TnscContextFilter;
    {* Поле для свойства ContextFilter }
   f_NavigatorTree: TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства NavigatorTree }
  protected
   f_Lock: Integer;
  private
   procedure NavigatorTreeActionElement(Sender: TObject;
    Index: LongInt);
   function NavigatorTreeGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure NavigatorTreeNewCharPressed(aChar: AnsiChar);
   procedure NavigatorTreeMakeTreeSource(out theTree: Il3SimpleTree);
   procedure ContextFilterChange(Sender: TObject);
   procedure NavigatorTreeTreeChanged(aSender: TObject;
    const anOldTree: Il3SimpleTree;
    const aNewTree: Il3SimpleTree);
   procedure ContextFilterWrongContext(Sender: TObject);
  protected
   procedure ExecuteCurrentElement;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure SetCurrent; override;
  public
   property BackgroundPanel: TvtPanel
    read f_BackgroundPanel;
 end;//TPrimNavigatorForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , NavigatorUtils
 , DynamicTreeUnit
 , nsUtils
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , NavigatorRes
 , nsNavigatorTreeStruct
 , BaseTypesUnit
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки utNavigatorLocalConstants }
 str_utNavigatorCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utNavigatorCaption'; rValue : 'Меню');
  {* Заголовок пользовательского типа "Меню" }
 str_utNavigatorSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utNavigatorSettingsCaption'; rValue : 'Меню (вкладка)');
  {* Заголовок пользовательского типа "Меню" для настройки панелей инструментов }

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

procedure TPrimNavigatorForm.SetCurrent;
//#UC START# *4AEEE2D40157_4AEEE269033F_var*
//#UC END# *4AEEE2D40157_4AEEE269033F_var*
begin
//#UC START# *4AEEE2D40157_4AEEE269033F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEEE2D40157_4AEEE269033F_impl*
end;//TPrimNavigatorForm.SetCurrent

procedure TPrimNavigatorForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AEEE269033F_var*
//#UC END# *479731C50290_4AEEE269033F_var*
begin
//#UC START# *479731C50290_4AEEE269033F_impl*
 if (NavigatorTree.TreeStruct <> nil) then
  NavigatorTree.TreeStruct.Unsubscribe(InsTreeDataListener(Self));
 inherited;
//#UC END# *479731C50290_4AEEE269033F_impl*
end;//TPrimNavigatorForm.Cleanup

{$If NOT Defined(NoVCM)}
procedure TPrimNavigatorForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_utNavigatorCaption.Init;
 {* Инициализация str_utNavigatorCaption }
 str_utNavigatorSettingsCaption.Init;
 {* Инициализация str_utNavigatorSettingsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimNavigatorForm);
 {* Регистрация PrimNavigator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
