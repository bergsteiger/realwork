unit PrimConfigurationList_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/PrimConfigurationList_Form.pas"
// Начат: 27.04.2010 22:06
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Основные прецеденты::Settings::View::Settings::PrimConfigurationList
//
// Конфигурации
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
  SettingsUnit,
  l3Interfaces,
  l3ControlsTypes,
  eeInterfaces
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  Base_Operations_Strange_Controls,
  Base_Operations_Editions_Controls
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  Settings_Strange_Controls,
  l3StringIDEx
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  ,
  vtLister
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  nscTreeViewWithAdapterDragDrop,
  PrimConfigurationList_utConfigurationList_UserType,
  l3TreeInterfaces,
  vcmExternalInterfaces {a},
  vcmInterfaces {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimConfigurationListForm = {form} class(TvcmEntityForm)
  {* Конфигурации }
 private
 // private fields
   f_tvConfs : TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства tvConfs}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   function TvConfsGetItemImage(Sender: TObject;
     Index: Integer;
     var aImages: TCustomImageList): Integer;
     {* Event to get Index of Bitmap in ImageIndex. }
   procedure TvConfsGetItemFont(Sender: TObject;
     Index: LongInt;
     const aFont: Il3Font);
     {* event to get Font of the item cell
событие для получения шрифта элемента. }
   procedure TvConfsActionElement(Sender: TObject;
     Index: LongInt);
   function TvConfsGetItemIconHint(Sender: TObject;
     Index: LongInt): Il3CString;
     {* event to get Hint String; }
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Delete_GetState(var State: TvcmOperationStateIndex);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Удалить }
   {$IfEnd} //not NoVCM
   procedure Switcher_BecomeActive_Execute;
   procedure Switcher_BecomeActive(const aParams: IvcmExecuteParams);
   {$If not defined(NoVCM)}
   procedure Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
     {* Развернуть все }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Tree_ExpandAll_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Развернуть все }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
     {* Свернуть все }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Tree_CollapseAll_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Свернуть все }
   {$IfEnd} //not NoVCM
   procedure PopupMenu_DoActive_Test(const aParams: IvcmTestParamsPrim);
   procedure PopupMenu_DoActive_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure PopupMenu_Modify_Test(const aParams: IvcmTestParamsPrim);
   procedure PopupMenu_Modify_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure PopupMenu_CopyConfig_Test(const aParams: IvcmTestParamsPrim);
   procedure PopupMenu_CopyConfig_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure PopupMenu_ConfInfo_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure PopupMenu_RestoreAllSettings_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure PopupMenu_RestoreConf_Test(const aParams: IvcmTestParamsPrim);
   procedure PopupMenu_RestoreConf_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure PopupMenu_SaveAsDefaultConf_Test(const aParams: IvcmTestParamsPrim);
   procedure PopupMenu_SaveAsDefaultConf_Execute(const aParams: IvcmExecuteParamsPrim);
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   procedure OpenConf(const aConf: IeeNode = nil);
   procedure SetActiveConf;
   function IsCurrentConfChanged: Boolean;
     {* определяет изменена ли текущая конфигурация }
   function IsCurrentReadOnly: Boolean;
     {* текущая конфигурация предустановлена }
   class function GetConfImage(aConfType: TConfigurationType;
     aActive: Boolean;
     aChange: Boolean = False): Integer;
 public
 // public properties
   property tvConfs: TnscTreeViewWithAdapterDragDrop
     read f_tvConfs;
 end;//TPrimConfigurationListForm

 TvcmEntityFormRef = TPrimConfigurationListForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  ConfigInterfaces,
  SysUtils,
  nsConfigurationList
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  Graphics,
  eeTreeView,
  Math,
  ConfigurationListRes
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
  l3Base {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки utConfigurationListLocalConstants }
  str_utConfigurationListCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utConfigurationListCaption'; rValue : 'Конфигурации');
   { Заголовок пользовательского типа "Конфигурации" }
  str_utConfigurationListSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utConfigurationListSettingsCaption'; rValue : 'Конфигурации (вкладка)');
   { Заголовок пользовательского типа "Конфигурации" для настройки панелей инструментов }

// start class TPrimConfigurationListForm

function TPrimConfigurationListForm.TvConfsGetItemImage(Sender: TObject;
  Index: Integer;
  var aImages: TCustomImageList): Integer;
//#UC START# *51715EE202AC_4BD7279101C5_var*
var
 l_Node : InsConfigNode;
 l_eeNode : IeeNode;
//#UC END# *51715EE202AC_4BD7279101C5_var*
begin
//#UC START# *51715EE202AC_4BD7279101C5_impl*
 l_eeNode := tvConfs.TreeView.GetNode(Index);
 try
  if Supports(l_eeNode, InsConfigNode, l_Node) then
  try
   Result := GetConfImage(l_Node.Config.Configuration.GetType,
    l_Node.COnfig.IsActive, l_Node.Config.IsDifferFromDefault);
  finally
   l_Node := nil;
  end
  else
   Result := -1;
 finally
  l_eeNode := nil;
 end;
//#UC END# *51715EE202AC_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.TvConfsGetItemImage

procedure TPrimConfigurationListForm.TvConfsGetItemFont(Sender: TObject;
  Index: LongInt;
  const aFont: Il3Font);
//#UC START# *51715F4A00F1_4BD7279101C5_var*
var
 l_Node : IeeNode;
 l_Conf : InsConfigNode;
//#UC END# *51715F4A00F1_4BD7279101C5_var*
begin
//#UC START# *51715F4A00F1_4BD7279101C5_impl*
 l_Node := tvConfs.TreeView.GetNode(Index);
 try
  if Assigned(l_Node) and Supports(l_Node, InsConfigNode, l_Conf) then
  try
   { Шрифт для текущей конфигурации }
   if l_Conf.Config.IsActive then
    with aFont do
     Style := Style + [fsBold];
  finally
   l_Conf := nil;
  end;
 finally
  l_Node := nil;
 end;
//#UC END# *51715F4A00F1_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.TvConfsGetItemFont

procedure TPrimConfigurationListForm.TvConfsActionElement(Sender: TObject;
  Index: LongInt);
//#UC START# *51715F570116_4BD7279101C5_var*
//#UC END# *51715F570116_4BD7279101C5_var*
begin
//#UC START# *51715F570116_4BD7279101C5_impl*
 SetActiveConf;
//#UC END# *51715F570116_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.TvConfsActionElement

function TPrimConfigurationListForm.TvConfsGetItemIconHint(Sender: TObject;
  Index: LongInt): Il3CString;
//#UC START# *51715F680175_4BD7279101C5_var*
var
 l_Node : IeeNode;
 l_Conf : InsConfigNode;
//#UC END# *51715F680175_4BD7279101C5_var*
begin
//#UC START# *51715F680175_4BD7279101C5_impl*
 Result := nil;
 with TeeTreeView(Sender) do
  l_Node := tvConfs.TreeView.GetNode(Index);
  try
   if Supports(l_Node, InsConfigNode, l_Conf) then
   try
    Result := l_Conf.Config.ConfigHint;
   finally
    l_Conf := nil;
   end;//try..finally
  finally
   l_Node := nil;
  end;//try..finally
//#UC END# *51715F680175_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.TvConfsGetItemIconHint

procedure TPrimConfigurationListForm.OpenConf(const aConf: IeeNode = nil);
//#UC START# *4C408D790107_4BD7279101C5_var*
var
 l_Node     : IeeNode;
 lConfNode : InsConfigNode;
//#UC END# *4C408D790107_4BD7279101C5_var*
begin
//#UC START# *4C408D790107_4BD7279101C5_impl*
 l_Node := aConf;
 try
  if not Assigned(l_Node) then
   l_Node := tvConfs.TreeView.CurrentNode;
  if Assigned(l_Node) and Supports(l_Node, InsConfigNode, lConfNode) then
  try
   TdmStdRes.LoadSettings(Aggregate, lConfNode.Config);
   tvConfs.Invalidate;
  finally
   lConfNode := nil;
  end;
 finally
  l_Node := nil;
 end;
//#UC END# *4C408D790107_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.OpenConf

procedure TPrimConfigurationListForm.SetActiveConf;
//#UC START# *4C408D970189_4BD7279101C5_var*
var
 lConfChildNode: InsConfigNode;
//#UC END# *4C408D970189_4BD7279101C5_var*
begin
//#UC START# *4C408D970189_4BD7279101C5_impl*
 if Assigned(tvConfs.TreeView.CurrentNode) then
 begin
  { Получим текущую выбранную конфигурацию }
  if Supports(tvConfs.TreeView.CurrentNode, InsConfigNode, lConfChildNode) then
  try
   ConfigurationList.ActivateConfig(lConfChildNode);
  finally
   lConfChildNode := nil;
  end;
 end;
//#UC END# *4C408D970189_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.SetActiveConf

function TPrimConfigurationListForm.IsCurrentConfChanged: Boolean;
//#UC START# *4C408DAB0071_4BD7279101C5_var*
var
 lConfNode : InsConfigNode;
//#UC END# *4C408DAB0071_4BD7279101C5_var*
begin
//#UC START# *4C408DAB0071_4BD7279101C5_impl*
 Result := False;
 { Получим текущую конфигурацию }
 if Supports(tvConfs.TreeView.CurrentNode, InsConfigNode, lConfNode) then
 try
  Result := lConfNode.Config.IsDifferFromDefault;
 finally
  lConfNode := nil;
 end;
//#UC END# *4C408DAB0071_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.IsCurrentConfChanged

function TPrimConfigurationListForm.IsCurrentReadOnly: Boolean;
//#UC START# *4C408DC602F1_4BD7279101C5_var*
var
 l_ConfChild : InsConfigNode;
//#UC END# *4C408DC602F1_4BD7279101C5_var*
begin
//#UC START# *4C408DC602F1_4BD7279101C5_impl*
 Result := False;
 if Assigned(tvConfs.TreeView.CurrentNode) and
   Supports(tvConfs.TreeView.CurrentNode, InsConfigNode, l_ConfChild) then
 try
  Result := l_ConfChild.Config.IsPredefined;
 finally
  l_ConfChild := nil;
 end;
//#UC END# *4C408DC602F1_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.IsCurrentReadOnly

class function TPrimConfigurationListForm.GetConfImage(aConfType: TConfigurationType;
  aActive: Boolean;
  aChange: Boolean = False): Integer;
//#UC START# *517176BE0397_4BD7279101C5_var*
//#UC END# *517176BE0397_4BD7279101C5_var*
begin
//#UC START# *517176BE0397_4BD7279101C5_impl*
 case aConfType of
  CT_STANDARD:
   Result := IfThen(aChange,
    IfThen(aActive, cimgStandartChangeActive, cimgStandartChange),
    IfThen(aActive, cimgStandartActive,       cimgStandart));
  CT_GARANT5X:
   Result := IfThen(aChange,
    IfThen(aActive, cimgGarant5xChangeActive, cimgGarant5xChange),
    IfThen(aActive, cimgGarant5xActive,       cimgGarant5x));
 else
  Result := IfThen(aChange,
   IfThen(aActive, cimgUserChangeActive, cimgUserChange),
   IfThen(aActive, cimgUserActive,       cimgUser));
 end;
//#UC END# *517176BE0397_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.GetConfImage

{$If not defined(NoVCM)}
procedure TPrimConfigurationListForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *494F89C30197_4BD7279101C5test_var*
var
 l_Conf : InsConfigNode;
//#UC END# *494F89C30197_4BD7279101C5test_var*
begin
//#UC START# *494F89C30197_4BD7279101C5test_impl*
 if Supports(tvConfs.TreeView.CurrentNode, InsConfigNode, l_Conf) then
 try
  with aParams do
  begin
   Op.Hint := vcmFmt(str_DeleteConfigConfirmHint, [l_Conf.Config.ConfigName]);
   Op.Flag[vcm_ofEnabled] := not l_Conf.Config.IsActive and
    not l_Conf.Config.IsPredefined;
  end;//with aParams
 finally
  l_Conf := nil;
 end;//try..finally
//#UC END# *494F89C30197_4BD7279101C5test_impl*
end;//TPrimConfigurationListForm.Edit_Delete_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimConfigurationListForm.Edit_Delete_GetState(var State: TvcmOperationStateIndex);
//#UC START# *494F89C30197_4BD7279101C5getstate_var*
//#UC END# *494F89C30197_4BD7279101C5getstate_var*
begin
//#UC START# *494F89C30197_4BD7279101C5getstate_impl*
 inherited;
//#UC END# *494F89C30197_4BD7279101C5getstate_impl*
end;//TPrimConfigurationListForm.Edit_Delete_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimConfigurationListForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *494F89C30197_4BD7279101C5exec_var*
var
 l_ConfNode : InsConfigNode;
//#UC END# *494F89C30197_4BD7279101C5exec_var*
begin
//#UC START# *494F89C30197_4BD7279101C5exec_impl*
 if Assigned(tvConfs.TreeView.CurrentNode) and
  Supports(tvConfs.TreeView.CurrentNode, InsConfigNode, l_ConfNode) then
 try
  if Ask(qr_ConfigurationDelete, [l_ConfNode.Config.ConfigName]) then
  try
   ConfigurationList.DeleteConfig(l_ConfNode);
   { Закроем форму если она была открыта }
   Aggregate.Operation(TdmStdRes.opcode_Result_Cancel);
  except
   on EConfigurationIsActiveNow do
    Say(err_ActiveConfigurationCannotDelete);
  end;
 finally
  l_ConfNode := nil;
 end;
//#UC END# *494F89C30197_4BD7279101C5exec_impl*
end;//TPrimConfigurationListForm.Edit_Delete_Execute
{$IfEnd} //not NoVCM

procedure TPrimConfigurationListForm.Switcher_BecomeActive_Execute;
//#UC START# *4A9807F801F9_4BD7279101C5exec_var*
//#UC END# *4A9807F801F9_4BD7279101C5exec_var*
begin
//#UC START# *4A9807F801F9_4BD7279101C5exec_impl*
 SetActiveInParent;
//#UC END# *4A9807F801F9_4BD7279101C5exec_impl*
end;//TPrimConfigurationListForm.Switcher_BecomeActive_Execute

procedure TPrimConfigurationListForm.Switcher_BecomeActive(const aParams: IvcmExecuteParams);
begin
 Switcher_BecomeActive_Execute;
end;

{$If not defined(NoVCM)}
procedure TPrimConfigurationListForm.Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7880236_4BD7279101C5test_var*
//#UC END# *4BDAF7880236_4BD7279101C5test_var*
begin
//#UC START# *4BDAF7880236_4BD7279101C5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7880236_4BD7279101C5test_impl*
end;//TPrimConfigurationListForm.Tree_ExpandAll_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimConfigurationListForm.Tree_ExpandAll_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4BDAF7880236_4BD7279101C5exec_var*
//#UC END# *4BDAF7880236_4BD7279101C5exec_var*
begin
//#UC START# *4BDAF7880236_4BD7279101C5exec_impl*
 inherited;
//#UC END# *4BDAF7880236_4BD7279101C5exec_impl*
end;//TPrimConfigurationListForm.Tree_ExpandAll_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimConfigurationListForm.Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7A2005C_4BD7279101C5test_var*
//#UC END# *4BDAF7A2005C_4BD7279101C5test_var*
begin
//#UC START# *4BDAF7A2005C_4BD7279101C5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7A2005C_4BD7279101C5test_impl*
end;//TPrimConfigurationListForm.Tree_CollapseAll_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimConfigurationListForm.Tree_CollapseAll_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4BDAF7A2005C_4BD7279101C5exec_var*
//#UC END# *4BDAF7A2005C_4BD7279101C5exec_var*
begin
//#UC START# *4BDAF7A2005C_4BD7279101C5exec_impl*
 inherited;
//#UC END# *4BDAF7A2005C_4BD7279101C5exec_impl*
end;//TPrimConfigurationListForm.Tree_CollapseAll_Execute
{$IfEnd} //not NoVCM

procedure TPrimConfigurationListForm.PopupMenu_DoActive_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C4088D301A1_4BD7279101C5test_var*
var
 lConf : InsConfigNode;
//#UC END# *4C4088D301A1_4BD7279101C5test_var*
begin
//#UC START# *4C4088D301A1_4BD7279101C5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(tvConfs.TreeView.CurrentNode);
 if Assigned(tvConfs.TreeView.CurrentNode) and
   Supports(tvConfs.TreeView.CurrentNode, InsConfigNode, lConf) then
 try
  aParams.Op.Flag[vcm_ofEnabled] := not lConf.Config.IsActive;
 finally
  lConf := nil;
 end;
//#UC END# *4C4088D301A1_4BD7279101C5test_impl*
end;//TPrimConfigurationListForm.PopupMenu_DoActive_Test

procedure TPrimConfigurationListForm.PopupMenu_DoActive_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C4088D301A1_4BD7279101C5exec_var*
//#UC END# *4C4088D301A1_4BD7279101C5exec_var*
begin
//#UC START# *4C4088D301A1_4BD7279101C5exec_impl*
 SetActiveConf;
//#UC END# *4C4088D301A1_4BD7279101C5exec_impl*
end;//TPrimConfigurationListForm.PopupMenu_DoActive_Execute

procedure TPrimConfigurationListForm.PopupMenu_Modify_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C4088E801E0_4BD7279101C5test_var*
//#UC END# *4C4088E801E0_4BD7279101C5test_var*
begin
//#UC START# *4C4088E801E0_4BD7279101C5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(tvConfs.TreeView.CurrentNode);
//#UC END# *4C4088E801E0_4BD7279101C5test_impl*
end;//TPrimConfigurationListForm.PopupMenu_Modify_Test

procedure TPrimConfigurationListForm.PopupMenu_Modify_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C4088E801E0_4BD7279101C5exec_var*
//#UC END# *4C4088E801E0_4BD7279101C5exec_var*
begin
//#UC START# *4C4088E801E0_4BD7279101C5exec_impl*
 OpenConf;
//#UC END# *4C4088E801E0_4BD7279101C5exec_impl*
end;//TPrimConfigurationListForm.PopupMenu_Modify_Execute

procedure TPrimConfigurationListForm.PopupMenu_CopyConfig_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C4088F60021_4BD7279101C5test_var*
//#UC END# *4C4088F60021_4BD7279101C5test_var*
begin
//#UC START# *4C4088F60021_4BD7279101C5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(tvConfs.TreeView.CurrentNode);
//#UC END# *4C4088F60021_4BD7279101C5test_impl*
end;//TPrimConfigurationListForm.PopupMenu_CopyConfig_Test

procedure TPrimConfigurationListForm.PopupMenu_CopyConfig_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C4088F60021_4BD7279101C5exec_var*
var
 l_eeNode   : IeeNode;
 lConfNode : InsConfigNode;
//#UC END# *4C4088F60021_4BD7279101C5exec_var*
begin
//#UC START# *4C4088F60021_4BD7279101C5exec_impl*
 { Получим текущую конфигурацию }
 if Supports(tvConfs.TreeView.CurrentNode, InsConfigNode, lConfNode) then
 try
  l_eeNode := ConfigurationList.CopyConfig(lConfNode,
                                          vcmCStr(str_CopyConfSingle),
                                          vcmCStr(str_CopyConfDuplicate)) as IeeNode;
  try
   tvConfs.TreeView.GotoNode(l_eeNode);
   OpenConf(l_eeNode);
  finally
   l_eeNode := nil;
  end;//try..finally
 finally
  lConfNode := nil;
 end;//try..finally
//#UC END# *4C4088F60021_4BD7279101C5exec_impl*
end;//TPrimConfigurationListForm.PopupMenu_CopyConfig_Execute

procedure TPrimConfigurationListForm.PopupMenu_ConfInfo_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C40890403A9_4BD7279101C5exec_var*
var
 lConfNode : InsConfigNode;
//#UC END# *4C40890403A9_4BD7279101C5exec_var*
begin
//#UC START# *4C40890403A9_4BD7279101C5exec_impl*
 if Assigned(tvConfs.TreeView.CurrentNode) and
   Supports(tvConfs.TreeView.CurrentNode, InsConfigNode, lConfNode) then
 try
  Say(inf_AnyInformation, [lConfNode.Config.ConfigHint]);
 finally
  lConfNode := nil;
 end;
//#UC END# *4C40890403A9_4BD7279101C5exec_impl*
end;//TPrimConfigurationListForm.PopupMenu_ConfInfo_Execute

procedure TPrimConfigurationListForm.PopupMenu_RestoreAllSettings_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C408917021D_4BD7279101C5exec_var*
var
 l_ConfChild : InsConfigNode;
//#UC END# *4C408917021D_4BD7279101C5exec_var*
begin
//#UC START# *4C408917021D_4BD7279101C5exec_impl*
 if Assigned(tvConfs.TreeView.CurrentNode) and
  Supports(tvConfs.TreeView.CurrentNode, InsConfigNode, l_ConfChild) then
 try
  if Ask(qr_RestoreAllSettings) then
  begin
   l_ConfChild.Config.RestoreAllSettings;
   l_ConfChild.Config.DoneEditing;
   tvConfs.Invalidate;
  end;
 finally
  l_ConfChild := nil;
 end;
//#UC END# *4C408917021D_4BD7279101C5exec_impl*
end;//TPrimConfigurationListForm.PopupMenu_RestoreAllSettings_Execute

procedure TPrimConfigurationListForm.PopupMenu_RestoreConf_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C40892F0293_4BD7279101C5test_var*
//#UC END# *4C40892F0293_4BD7279101C5test_var*
begin
//#UC START# *4C40892F0293_4BD7279101C5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := IsCurrentConfChanged;
//#UC END# *4C40892F0293_4BD7279101C5test_impl*
end;//TPrimConfigurationListForm.PopupMenu_RestoreConf_Test

procedure TPrimConfigurationListForm.PopupMenu_RestoreConf_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C40892F0293_4BD7279101C5exec_var*
var
 l_ConfChild : InsConfigNode;
//#UC END# *4C40892F0293_4BD7279101C5exec_var*
begin
//#UC START# *4C40892F0293_4BD7279101C5exec_impl*
 if Assigned(tvConfs.TreeView.CurrentNode) and
  Supports(tvConfs.TreeView.CurrentNode, InsConfigNode, l_ConfChild) then
 try
  if Ask(qr_RestoreDefaultValuesConf) then
  begin
   l_ConfChild.Config.Load(True);
   l_ConfChild.Config.DoneEditing;
   tvConfs.Invalidate;
  end;
 finally
  l_ConfChild := nil;
 end;
//#UC END# *4C40892F0293_4BD7279101C5exec_impl*
end;//TPrimConfigurationListForm.PopupMenu_RestoreConf_Execute

procedure TPrimConfigurationListForm.PopupMenu_SaveAsDefaultConf_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C408C950385_4BD7279101C5test_var*
//#UC END# *4C408C950385_4BD7279101C5test_var*
begin
//#UC START# *4C408C950385_4BD7279101C5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := IsCurrentConfChanged and not IsCurrentReadOnly;
//#UC END# *4C408C950385_4BD7279101C5test_impl*
end;//TPrimConfigurationListForm.PopupMenu_SaveAsDefaultConf_Test

procedure TPrimConfigurationListForm.PopupMenu_SaveAsDefaultConf_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C408C950385_4BD7279101C5exec_var*
var
 l_ConfChild : InsConfigNode;
//#UC END# *4C408C950385_4BD7279101C5exec_var*
begin
//#UC START# *4C408C950385_4BD7279101C5exec_impl*
 if Assigned(tvConfs.TreeView.CurrentNode) and
  Supports(tvConfs.TreeView.CurrentNode, InsConfigNode, l_ConfChild) then
 try
  if Ask(qr_SaveAsDefaultValuesConf) then
  begin
   l_ConfChild.Config.Load;
   l_ConfChild.Config.Save(True);
   l_ConfChild.Config.DoneEditing;
   tvConfs.Invalidate;
  end;
 finally
  l_ConfChild := nil;
 end;
//#UC END# *4C408C950385_4BD7279101C5exec_impl*
end;//TPrimConfigurationListForm.PopupMenu_SaveAsDefaultConf_Execute

{$If not defined(NoVCM)}
procedure TPrimConfigurationListForm.InitControls;
//#UC START# *4A8E8F2E0195_4BD7279101C5_var*
//#UC END# *4A8E8F2E0195_4BD7279101C5_var*
begin
//#UC START# *4A8E8F2E0195_4BD7279101C5_impl*
 inherited;

 Scaled := False;

 tvConfs.Align := alClient;
 tvConfs.BorderStyle := bsNone;
 tvConfs.MultiStrokeItem := True;
 tvConfs.ActionElementMode := l3_amSecondSingleClick;
 tvConfs.ViewOptions := [voShowInterRowSpace, voShowIcons, voShowExpandable];
 tvConfs.OnGetItemIconHint := tvConfsGetItemIconHint;
 tvConfs.OnGetItemImage := tvConfsGetItemImage;
 tvConfs.OnActionElement := tvConfsActionElement;
 tvConfs.OnGetItemFont := tvConfsGetItemFont;
 tvConfs.SettingId := 'stidtvConfs';

 tvConfs.Images := dmConfigurationList.ilConfs;
 tvConfs.ViewOptions := tvConfs.ViewOptions - [voShowLines];
 tvConfs.TreeView.Tree.Root := ConfigurationList.ConfigTree;
//#UC END# *4A8E8F2E0195_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.InitControls
{$IfEnd} //not NoVCM

procedure TPrimConfigurationListForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_Switcher, nil);
  PublishFormEntity(en_Tree, nil);
  PublishFormEntity(en_PopupMenu, nil);
  ContextMenuWeight(en_Switcher, 10);
  ContextMenuWeight(en_PopupMenu, 20);
  ContextMenuWeight(en_Edit, 30);
  ContextMenuWeight(en_Tree, 40);
  MakeEntitySupportedByControl(en_Edit, tvConfs);
  MakeEntitySupportedByControl(en_Tree, tvConfs);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Delete, Edit_Delete_Execute, Edit_Delete_Test, Edit_Delete_GetState);
  {$IfEnd} //not NoVCM

  PublishOpWithResult(en_Switcher, op_BecomeActive, Switcher_BecomeActive, nil, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_ExpandAll, Tree_ExpandAll_Execute, Tree_ExpandAll_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_CollapseAll, Tree_CollapseAll_Execute, Tree_CollapseAll_Test, nil);
  {$IfEnd} //not NoVCM

  PublishOp(en_PopupMenu, op_DoActive, PopupMenu_DoActive_Execute, PopupMenu_DoActive_Test, nil);
  ShowInContextMenu(en_PopupMenu, op_DoActive, true);
  ShowInToolbar(en_PopupMenu, op_DoActive, true);
  PublishOp(en_PopupMenu, op_Modify, PopupMenu_Modify_Execute, PopupMenu_Modify_Test, nil);
  ShowInContextMenu(en_PopupMenu, op_Modify, true);
  ShowInToolbar(en_PopupMenu, op_Modify, true);
  PublishOp(en_PopupMenu, op_CopyConfig, PopupMenu_CopyConfig_Execute, PopupMenu_CopyConfig_Test, nil);
  ShowInContextMenu(en_PopupMenu, op_CopyConfig, true);
  ShowInToolbar(en_PopupMenu, op_CopyConfig, true);
  PublishOp(en_PopupMenu, op_ConfInfo, PopupMenu_ConfInfo_Execute, nil, nil);
  ShowInContextMenu(en_PopupMenu, op_ConfInfo, true);
  ShowInToolbar(en_PopupMenu, op_ConfInfo, true);
  PublishOp(en_PopupMenu, op_RestoreAllSettings, PopupMenu_RestoreAllSettings_Execute, nil, nil);
  ShowInContextMenu(en_PopupMenu, op_RestoreAllSettings, true);
  ShowInToolbar(en_PopupMenu, op_RestoreAllSettings, true);
  PublishOp(en_PopupMenu, op_RestoreConf, PopupMenu_RestoreConf_Execute, PopupMenu_RestoreConf_Test, nil);
  ShowInToolbar(en_PopupMenu, op_RestoreConf, true);
  PublishOp(en_PopupMenu, op_SaveAsDefaultConf, PopupMenu_SaveAsDefaultConf_Execute, PopupMenu_SaveAsDefaultConf_Test, nil);
  ShowInContextMenu(en_PopupMenu, op_SaveAsDefaultConf, true);
  ShowInToolbar(en_PopupMenu, op_SaveAsDefaultConf, true);
 end;//with Entities.Entities
end;

procedure TPrimConfigurationListForm.MakeControls;
begin
 inherited;
 with AddUsertype(utConfigurationListName,
  str_utConfigurationListCaption,
  str_utConfigurationListSettingsCaption,
  true,
  74,
  30,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utConfigurationListName
 f_tvConfs := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_tvConfs.Name := 'tvConfs';
 f_tvConfs.Parent := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utConfigurationListCaption
 str_utConfigurationListCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utConfigurationListSettingsCaption
 str_utConfigurationListSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimConfigurationList
 TtfwClassRef.Register(TPrimConfigurationListForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.