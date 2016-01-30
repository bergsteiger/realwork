unit PrimGroupList_Form;
 {* Группы пользователей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupList_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Admin_Users_Controls
 , F1Like_InternalOperations_Controls
 , AdminInterfaces
 , vtPanel
 , eeTreeView
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3TreeInterfaces
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

type
 TPrimGroupListForm = class(TvcmEntityForm, IbsGroupListViewListener)
  {* Группы пользователей }
  private
   f_BackgroundPanel: TvtPanel;
    {* Поле для свойства BackgroundPanel }
   f_GroupsTree: TeeTreeView;
    {* Поле для свойства GroupsTree }
  protected
   : IdsGroupsList;
  private
   procedure GroupsTreeCountChanged(Sender: TObject;
    NewCount: LongInt);
   function GroupsTreeGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure GroupsTreeCurrentChanged(Sender: TObject;
    aNewCurrent: LongInt;
    aOldCurrent: LongInt);
   procedure GroupsTreeTreeChanged(aSender: TObject;
    const anOldTree: Il3SimpleTree;
    const aNewTree: Il3SimpleTree);
   procedure GroupsTreeSelectCountChanged(aSender: TObject;
    anOldCount: Integer;
    aNewCount: Integer);
   procedure GroupsTreeFormatStatusInfo(aSender: TObject;
    var Info: Il3CString;
    aCurrent: Integer;
    aCount: Integer;
    aSelected: Integer);
  protected
   procedure UpdateCurrent;
   function IsCurrentUsual: Boolean;
   procedure TreeViewInvalidate;
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Add; override;
    {* Добавить }
   procedure ChangeBaseAccess; override;
   procedure Rename; override;
    {* Переименовать группу }
   procedure BecomeActive; override;
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property BackgroundPanel: TvtPanel
    read f_BackgroundPanel;
 end;//TPrimGroupListForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , nsTypes
 , AdminRes
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsUserNodes
 , SecurityUnit
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки admGroupListLocalConstants }
 str_admGroupListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admGroupListCaption'; rValue : 'Группы пользователей');
  {* Заголовок пользовательского типа "Группы пользователей" }
 str_admGroupListSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admGroupListSettingsCaption'; rValue : 'Группы пользователей (вкладка)');
  {* Заголовок пользовательского типа "Группы пользователей" для настройки панелей инструментов }

procedure TPrimGroupListForm.GroupsTreeCountChanged(Sender: TObject;
 NewCount: LongInt);
//#UC START# *5236E2780163_49EC75B5022C_var*
//#UC END# *5236E2780163_49EC75B5022C_var*
begin
//#UC START# *5236E2780163_49EC75B5022C_impl*
 UpdateStatusInfo;
//#UC END# *5236E2780163_49EC75B5022C_impl*
end;//TPrimGroupListForm.GroupsTreeCountChanged

function TPrimGroupListForm.GroupsTreeGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *5236E28202F7_49EC75B5022C_var*
const
 cImageIndexMap: array [TbsGroupNodeType] of Integer = (
  ciiGroup, // gntUnknown,
  ciiSystemGroup, // gntSystem,
  ciiGroup // gntUsual
 );
//#UC END# *5236E28202F7_49EC75B5022C_var*
begin
//#UC START# *5236E28202F7_49EC75B5022C_impl*
 if Assigned(ViewArea) then
  Result := cImageIndexMap[ViewArea.GroupsListNodeType(GroupsTree.GetNode(Index))]
 else
  Result := ciiUser_NA;
//#UC END# *5236E28202F7_49EC75B5022C_impl*
end;//TPrimGroupListForm.GroupsTreeGetItemImage

procedure TPrimGroupListForm.GroupsTreeCurrentChanged(Sender: TObject;
 aNewCurrent: LongInt;
 aOldCurrent: LongInt);
//#UC START# *5236E28B0222_49EC75B5022C_var*
//#UC END# *5236E28B0222_49EC75B5022C_var*
begin
//#UC START# *5236E28B0222_49EC75B5022C_impl*
 UpdateCurrent;
//#UC END# *5236E28B0222_49EC75B5022C_impl*
end;//TPrimGroupListForm.GroupsTreeCurrentChanged

procedure TPrimGroupListForm.GroupsTreeTreeChanged(aSender: TObject;
 const anOldTree: Il3SimpleTree;
 const aNewTree: Il3SimpleTree);
//#UC START# *5236E2940127_49EC75B5022C_var*
//#UC END# *5236E2940127_49EC75B5022C_var*
begin
//#UC START# *5236E2940127_49EC75B5022C_impl*
 UpdateStatusInfo;
//#UC END# *5236E2940127_49EC75B5022C_impl*
end;//TPrimGroupListForm.GroupsTreeTreeChanged

procedure TPrimGroupListForm.GroupsTreeSelectCountChanged(aSender: TObject;
 anOldCount: Integer;
 aNewCount: Integer);
//#UC START# *5236E29C02A7_49EC75B5022C_var*
//#UC END# *5236E29C02A7_49EC75B5022C_var*
begin
//#UC START# *5236E29C02A7_49EC75B5022C_impl*
 UpdateStatusInfo;
//#UC END# *5236E29C02A7_49EC75B5022C_impl*
end;//TPrimGroupListForm.GroupsTreeSelectCountChanged

procedure TPrimGroupListForm.GroupsTreeFormatStatusInfo(aSender: TObject;
 var Info: Il3CString;
 aCurrent: Integer;
 aCount: Integer;
 aSelected: Integer);
//#UC START# *5236E2A600F9_49EC75B5022C_var*
//#UC END# *5236E2A600F9_49EC75B5022C_var*
begin
//#UC START# *5236E2A600F9_49EC75B5022C_impl*
 if GroupsTree.TreeStruct.RootNode.HasChild then
  Info := vcmFmt(vcmCStr(str_GroupsListStatus),[GroupsTree.TreeStruct.RootNode.ThisChildrenCount])
 else
  Info := nil;
//#UC END# *5236E2A600F9_49EC75B5022C_impl*
end;//TPrimGroupListForm.GroupsTreeFormatStatusInfo

procedure TPrimGroupListForm.UpdateCurrent;
//#UC START# *5236F5A00279_49EC75B5022C_var*
//#UC END# *5236F5A00279_49EC75B5022C_var*
begin
//#UC START# *5236F5A00279_49EC75B5022C_impl*
 ViewArea.CurrentChanged(GroupsTree.GetCurrentNode);
 UpdateStatusInfo;
//#UC END# *5236F5A00279_49EC75B5022C_impl*
end;//TPrimGroupListForm.UpdateCurrent

function TPrimGroupListForm.IsCurrentUsual: Boolean;
//#UC START# *5236F5CD009F_49EC75B5022C_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *5236F5CD009F_49EC75B5022C_var*
begin
//#UC START# *5236F5CD009F_49EC75B5022C_impl*
 l_Node := GroupsTree.GetCurrentNode;
 Result := ViewArea.GroupsListNodeType(l_Node) = gntUsual;
//#UC END# *5236F5CD009F_49EC75B5022C_impl*
end;//TPrimGroupListForm.IsCurrentUsual

{$If NOT Defined(NoVCM)}
procedure TPrimGroupListForm.Delete;
 {* Удалить }
//#UC START# *494F89C30197_49EC75B5022C_var*
//#UC END# *494F89C30197_49EC75B5022C_var*
begin
//#UC START# *494F89C30197_49EC75B5022C_impl*
 !!! Needs to be implemented !!!
//#UC END# *494F89C30197_49EC75B5022C_impl*
end;//TPrimGroupListForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimGroupListForm.Add;
 {* Добавить }
//#UC START# *49EC7545036C_49EC75B5022C_var*
//#UC END# *49EC7545036C_49EC75B5022C_var*
begin
//#UC START# *49EC7545036C_49EC75B5022C_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EC7545036C_49EC75B5022C_impl*
end;//TPrimGroupListForm.Add

procedure TPrimGroupListForm.ChangeBaseAccess;
//#UC START# *49EC755501FB_49EC75B5022C_var*
//#UC END# *49EC755501FB_49EC75B5022C_var*
begin
//#UC START# *49EC755501FB_49EC75B5022C_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EC755501FB_49EC75B5022C_impl*
end;//TPrimGroupListForm.ChangeBaseAccess

procedure TPrimGroupListForm.Rename;
 {* Переименовать группу }
//#UC START# *49EEF22D004A_49EC75B5022C_var*
//#UC END# *49EEF22D004A_49EC75B5022C_var*
begin
//#UC START# *49EEF22D004A_49EC75B5022C_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EEF22D004A_49EC75B5022C_impl*
end;//TPrimGroupListForm.Rename

procedure TPrimGroupListForm.BecomeActive;
//#UC START# *4AEF3E8C02F5_49EC75B5022C_var*
//#UC END# *4AEF3E8C02F5_49EC75B5022C_var*
begin
//#UC START# *4AEF3E8C02F5_49EC75B5022C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEF3E8C02F5_49EC75B5022C_impl*
end;//TPrimGroupListForm.BecomeActive

{$If NOT Defined(NoVCM)}
procedure TPrimGroupListForm.Delete;
 {* Удалить }
//#UC START# *4C7D0CC90052_49EC75B5022C_var*
//#UC END# *4C7D0CC90052_49EC75B5022C_var*
begin
//#UC START# *4C7D0CC90052_49EC75B5022C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0CC90052_49EC75B5022C_impl*
end;//TPrimGroupListForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimGroupListForm.TreeViewInvalidate;
//#UC START# *5492EBB90042_49EC75B5022C_var*
//#UC END# *5492EBB90042_49EC75B5022C_var*
begin
//#UC START# *5492EBB90042_49EC75B5022C_impl*
 GroupsTree.Invalidate;
//#UC END# *5492EBB90042_49EC75B5022C_impl*
end;//TPrimGroupListForm.TreeViewInvalidate

{$If NOT Defined(NoVCM)}
procedure TPrimGroupListForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_49EC75B5022C_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *497469C90140_49EC75B5022C_var*
begin
//#UC START# *497469C90140_49EC75B5022C_impl*
 if (anOld <> nil) then
  anOld.Unsubscribe(IbsGroupListViewListener(Self));
 if (aNew <> nil) then
  aNew.Subscribe(IbsGroupListViewListener(Self));

 if Assigned(ViewArea) then
 begin
  with GroupsTree do
  begin
   Images := ViewArea.ImageList.Hack;
   //if not aFromHistory then
   begin
    TreeStruct := ViewArea.SimpleTree;
    l_Node := GetUserByID(GROUP_ALL_ID, TreeStruct);
    if Assigned(l_Node) then
     GotoOnNode(l_Node);
   end;
   UpdateStatusInfo;
   ViewArea.CurrentChanged(GetCurrentNode)
  end;
 end;
//#UC END# *497469C90140_49EC75B5022C_impl*
end;//TPrimGroupListForm.NotifyDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimGroupListForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_49EC75B5022C_var*
//#UC END# *4A8E8F2E0195_49EC75B5022C_var*
begin
//#UC START# *4A8E8F2E0195_49EC75B5022C_impl*
 ActiveControl := GroupsTree;
 FormStyle := fsStayOnTop;
 Scaled := False;

 with BackgroundPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;

 with GroupsTree do
 begin
  ActionElementMode := l3_amSingleClick;
  Align := alClient;
  BorderStyle := bsNone;
  DragAndDropSupported := True;
  TabOrder := 0;
  ViewOptions := [voShowIcons];
  OnGetItemImage := GroupsTreeGetItemImage;
  OnCurrentChanged := GroupsTreeCurrentChanged;
  OnTreeChanged := GroupsTreeTreeChanged;
  OnSelectCountChanged := GroupsTreeSelectCountChanged;
  OnFormatStatusInfo := GroupsTreeFormatStatusInfo;
  OnCountChanged := GroupsTreeCountChanged;
 end;
 
 UpdateStatusInfo; 
//#UC END# *4A8E8F2E0195_49EC75B5022C_impl*
end;//TPrimGroupListForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_admGroupListCaption.Init;
 {* Инициализация str_admGroupListCaption }
 str_admGroupListSettingsCaption.Init;
 {* Инициализация str_admGroupListSettingsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimGroupListForm);
 {* Регистрация PrimGroupList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
