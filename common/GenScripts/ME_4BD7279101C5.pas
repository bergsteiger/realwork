unit PrimConfigurationList_Form;
 {* Конфигурации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimConfigurationList_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimConfigurationList" MUID: (4BD7279101C5)
// Имя типа: "TPrimConfigurationListForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Settings_Strange_Controls
 , nscTreeViewWithAdapterDragDrop
 , eeInterfaces
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
 , SettingsUnit
;

type
 TPrimConfigurationListForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Конфигурации }
  private
   f_tvConfs: TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства tvConfs }
  private
   function tvConfsGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure tvConfsGetItemFont(Sender: TObject;
    Index: LongInt;
    const aFont: Il3Font);
   procedure tvConfsActionElement(Sender: TObject;
    Index: LongInt);
   function tvConfsGetItemIconHint(Sender: TObject;
    Index: LongInt): Il3CString;
  protected
   procedure OpenConf(const aConf: IeeNode = nil);
   procedure SetActiveConf;
   function IsCurrentConfChanged: Boolean;
    {* определяет изменена ли текущая конфигурация }
   function IsCurrentReadOnly: Boolean;
    {* текущая конфигурация предустановлена }
   class function GetConfImage(aConfType: TConfigurationType;
    aActive: Boolean;
    aChange: Boolean = False): Integer;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_GetState(var State: TvcmOperationStateIndex);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Switcher_BecomeActive_Execute;
   procedure Switcher_BecomeActive(const aParams: IvcmExecuteParamsPrim);
   {$If NOT Defined(NoVCM)}
   procedure Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_ExpandAll_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_CollapseAll_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
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
  public
   property tvConfs: TnscTreeViewWithAdapterDragDrop
    read f_tvConfs;
 end;//TPrimConfigurationListForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , ConfigInterfaces
 , SysUtils
 , nsConfigurationList
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , Graphics
 , eeTreeView
 , Math
 , ConfigurationListRes
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
 {$If NOT Defined(NoScripts)}
 , PrimConfigurationListWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimConfigurationList_utConfigurationList_UserType
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки utConfigurationListLocalConstants }
 str_utConfigurationListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utConfigurationListCaption'; rValue : 'Конфигурации');
  {* Заголовок пользовательского типа "Конфигурации" }
 str_utConfigurationListSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utConfigurationListSettingsCaption'; rValue : 'Конфигурации (вкладка)');
  {* Заголовок пользовательского типа "Конфигурации" для настройки панелей инструментов }

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
 {* определяет изменена ли текущая конфигурация }
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
 {* текущая конфигурация предустановлена }
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

function TPrimConfigurationListForm.tvConfsGetItemImage(Sender: TObject;
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
end;//TPrimConfigurationListForm.tvConfsGetItemImage

procedure TPrimConfigurationListForm.tvConfsGetItemFont(Sender: TObject;
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
end;//TPrimConfigurationListForm.tvConfsGetItemFont

procedure TPrimConfigurationListForm.tvConfsActionElement(Sender: TObject;
 Index: LongInt);
//#UC START# *51715F570116_4BD7279101C5_var*
//#UC END# *51715F570116_4BD7279101C5_var*
begin
//#UC START# *51715F570116_4BD7279101C5_impl*
 SetActiveConf;
//#UC END# *51715F570116_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.tvConfsActionElement

function TPrimConfigurationListForm.tvConfsGetItemIconHint(Sender: TObject;
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
end;//TPrimConfigurationListForm.tvConfsGetItemIconHint

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

procedure TPrimConfigurationListForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
 {* Удалить }
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

procedure TPrimConfigurationListForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Удалить }
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

procedure TPrimConfigurationListForm.Edit_Delete_GetState(var State: TvcmOperationStateIndex);
 {* Удалить }
//#UC START# *494F89C30197_4BD7279101C5getstate_var*
//#UC END# *494F89C30197_4BD7279101C5getstate_var*
begin
//#UC START# *494F89C30197_4BD7279101C5getstate_impl*
 inherited;
//#UC END# *494F89C30197_4BD7279101C5getstate_impl*
end;//TPrimConfigurationListForm.Edit_Delete_GetState

procedure TPrimConfigurationListForm.Switcher_BecomeActive_Execute;
//#UC START# *4A9807F801F9_4BD7279101C5exec_var*
//#UC END# *4A9807F801F9_4BD7279101C5exec_var*
begin
//#UC START# *4A9807F801F9_4BD7279101C5exec_impl*
 SetActiveInParent;
//#UC END# *4A9807F801F9_4BD7279101C5exec_impl*
end;//TPrimConfigurationListForm.Switcher_BecomeActive_Execute

procedure TPrimConfigurationListForm.Switcher_BecomeActive(const aParams: IvcmExecuteParamsPrim);
begin
 Self.Switcher_BecomeActive_Execute;
end;//TPrimConfigurationListForm.Switcher_BecomeActive

procedure TPrimConfigurationListForm.Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
 {* Развернуть все }
//#UC START# *4BDAF7880236_4BD7279101C5test_var*
//#UC END# *4BDAF7880236_4BD7279101C5test_var*
begin
//#UC START# *4BDAF7880236_4BD7279101C5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7880236_4BD7279101C5test_impl*
end;//TPrimConfigurationListForm.Tree_ExpandAll_Test

procedure TPrimConfigurationListForm.Tree_ExpandAll_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Развернуть все }
//#UC START# *4BDAF7880236_4BD7279101C5exec_var*
//#UC END# *4BDAF7880236_4BD7279101C5exec_var*
begin
//#UC START# *4BDAF7880236_4BD7279101C5exec_impl*
 inherited;
//#UC END# *4BDAF7880236_4BD7279101C5exec_impl*
end;//TPrimConfigurationListForm.Tree_ExpandAll_Execute

procedure TPrimConfigurationListForm.Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_4BD7279101C5test_var*
//#UC END# *4BDAF7A2005C_4BD7279101C5test_var*
begin
//#UC START# *4BDAF7A2005C_4BD7279101C5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7A2005C_4BD7279101C5test_impl*
end;//TPrimConfigurationListForm.Tree_CollapseAll_Test

procedure TPrimConfigurationListForm.Tree_CollapseAll_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_4BD7279101C5exec_var*
//#UC END# *4BDAF7A2005C_4BD7279101C5exec_var*
begin
//#UC START# *4BDAF7A2005C_4BD7279101C5exec_impl*
 inherited;
//#UC END# *4BDAF7A2005C_4BD7279101C5exec_impl*
end;//TPrimConfigurationListForm.Tree_CollapseAll_Execute

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

procedure TPrimConfigurationListForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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

procedure TPrimConfigurationListForm.MakeControls;
begin
 inherited;
 with AddUsertype(utConfigurationListName,
  str_utConfigurationListCaption,
  str_utConfigurationListSettingsCaption,
  False,
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
end;//TPrimConfigurationListForm.MakeControls

initialization
 str_utConfigurationListCaption.Init;
 {* Инициализация str_utConfigurationListCaption }
 str_utConfigurationListSettingsCaption.Init;
 {* Инициализация str_utConfigurationListSettingsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimConfigurationListForm);
 {* Регистрация PrimConfigurationList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
