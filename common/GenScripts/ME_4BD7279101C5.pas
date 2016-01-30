unit PrimConfigurationList_Form;
 {* Конфигурации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimConfigurationList_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

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
 , l3StringIDEx
;

type
 TPrimConfigurationListForm = class(TvcmEntityForm)
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
  public
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure BecomeActive; override;
   {$If NOT Defined(NoVCM)}
   procedure ExpandAll; override;
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CollapseAll; override;
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure DoActive; override;
   procedure Modify; override;
   procedure CopyConfig; override;
   procedure ConfInfo; override;
   procedure RestoreAllSettings; override;
   procedure RestoreConf; override;
   procedure SaveAsDefaultConf; override;
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property tvConfs: TnscTreeViewWithAdapterDragDrop
    read f_tvConfs;
 end;//TPrimConfigurationListForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
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
;

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

{$If NOT Defined(NoVCM)}
procedure TPrimConfigurationListForm.Delete;
 {* Удалить }
//#UC START# *494F89C30197_4BD7279101C5_var*
//#UC END# *494F89C30197_4BD7279101C5_var*
begin
//#UC START# *494F89C30197_4BD7279101C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *494F89C30197_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimConfigurationListForm.BecomeActive;
//#UC START# *4A9807F801F9_4BD7279101C5_var*
//#UC END# *4A9807F801F9_4BD7279101C5_var*
begin
//#UC START# *4A9807F801F9_4BD7279101C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A9807F801F9_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.BecomeActive

{$If NOT Defined(NoVCM)}
procedure TPrimConfigurationListForm.ExpandAll;
 {* Развернуть все }
//#UC START# *4BDAF7880236_4BD7279101C5_var*
//#UC END# *4BDAF7880236_4BD7279101C5_var*
begin
//#UC START# *4BDAF7880236_4BD7279101C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7880236_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.ExpandAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimConfigurationListForm.CollapseAll;
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_4BD7279101C5_var*
//#UC END# *4BDAF7A2005C_4BD7279101C5_var*
begin
//#UC START# *4BDAF7A2005C_4BD7279101C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7A2005C_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.CollapseAll
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimConfigurationListForm.DoActive;
//#UC START# *4C4088D301A1_4BD7279101C5_var*
//#UC END# *4C4088D301A1_4BD7279101C5_var*
begin
//#UC START# *4C4088D301A1_4BD7279101C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C4088D301A1_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.DoActive

procedure TPrimConfigurationListForm.Modify;
//#UC START# *4C4088E801E0_4BD7279101C5_var*
//#UC END# *4C4088E801E0_4BD7279101C5_var*
begin
//#UC START# *4C4088E801E0_4BD7279101C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C4088E801E0_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.Modify

procedure TPrimConfigurationListForm.CopyConfig;
//#UC START# *4C4088F60021_4BD7279101C5_var*
//#UC END# *4C4088F60021_4BD7279101C5_var*
begin
//#UC START# *4C4088F60021_4BD7279101C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C4088F60021_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.CopyConfig

procedure TPrimConfigurationListForm.ConfInfo;
//#UC START# *4C40890403A9_4BD7279101C5_var*
//#UC END# *4C40890403A9_4BD7279101C5_var*
begin
//#UC START# *4C40890403A9_4BD7279101C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C40890403A9_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.ConfInfo

procedure TPrimConfigurationListForm.RestoreAllSettings;
//#UC START# *4C408917021D_4BD7279101C5_var*
//#UC END# *4C408917021D_4BD7279101C5_var*
begin
//#UC START# *4C408917021D_4BD7279101C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C408917021D_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.RestoreAllSettings

procedure TPrimConfigurationListForm.RestoreConf;
//#UC START# *4C40892F0293_4BD7279101C5_var*
//#UC END# *4C40892F0293_4BD7279101C5_var*
begin
//#UC START# *4C40892F0293_4BD7279101C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C40892F0293_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.RestoreConf

procedure TPrimConfigurationListForm.SaveAsDefaultConf;
//#UC START# *4C408C950385_4BD7279101C5_var*
//#UC END# *4C408C950385_4BD7279101C5_var*
begin
//#UC START# *4C408C950385_4BD7279101C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C408C950385_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.SaveAsDefaultConf

{$If NOT Defined(NoVCM)}
procedure TPrimConfigurationListForm.Delete;
 {* Удалить }
//#UC START# *4C7D0CC90052_4BD7279101C5_var*
//#UC END# *4C7D0CC90052_4BD7279101C5_var*
begin
//#UC START# *4C7D0CC90052_4BD7279101C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0CC90052_4BD7279101C5_impl*
end;//TPrimConfigurationListForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_utConfigurationListCaption.Init;
 {* Инициализация str_utConfigurationListCaption }
 str_utConfigurationListSettingsCaption.Init;
 {* Инициализация str_utConfigurationListSettingsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimConfigurationListForm);
 {* Регистрация PrimConfigurationList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
