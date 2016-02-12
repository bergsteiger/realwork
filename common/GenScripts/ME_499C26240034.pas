unit nscTreeView;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscTreeView.pas"
// Стереотип: "GuiControl"

{$Include nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3CacheableBase
 , l3IID
 , eeTreeView
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , Classes
 , afwInterfaces
;

type
 InscTreeState = interface
  ['{D3A66F44-F580-49C9-8CE3-2CEF63841897}']
  function pm_GetAggregate: IUnknown;
  function pm_GetWrap: Boolean;
  property Aggregate: IUnknown
   read pm_GetAggregate;
  property Wrap: Boolean
   read pm_GetWrap;
 end;//InscTreeState

 TnscTreeViewState = class(Tl3CacheableBase, InscTreeState)
  private
   f_Wrap: Boolean;
   f_Aggregate: IUnknown;
  protected
   function pm_GetAggregate: IUnknown;
   function pm_GetWrap: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aAggregate: IUnknown;
    aWrap: Boolean); reintroduce;
   class function Make(const aAggregate: IUnknown;
    aWrap: Boolean): InscTreeState; reintroduce;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
 end;//TnscTreeViewState

 _nsUnknownComponent_Parent_ = TeeTreeView;
 {$Include w:\common\components\gui\Garant\VT\nsUnknownComponent.imp.pas}
 TnscTreeViewPrim = class(_nsUnknownComponent_{$If NOT Defined(NoVCM)}
 , IvcmOperationsProvider
 {$IfEnd} // NOT Defined(NoVCM)
 , Il3CommandPublisherInfo)
  private
   f_Published: Boolean;
   f_SettingId: AnsiString;
    {* Поле для свойства SettingId }
   f_InterRowMultiplier: Integer;
    {* Поле для свойства InterRowMultiplier }
   f_DisableDragAndDropSupport: Boolean;
    {* Поле для свойства DisableDragAndDropSupport }
  protected
   procedure pm_SetSettingId(const aValue: AnsiString);
   procedure pm_SetInterRowMultiplier(aValue: Integer);
   function DoIsCommandPublished(Cmd: Tl3OperationCode): Boolean; virtual;
   function IsEmpty: Boolean;
   procedure DoProvideOps(const aPublisher: IvcmOperationsPublisher); virtual;
   function MakePath(const aSetting: AnsiString): AnsiString;
   {$If NOT Defined(NoVCM)}
   procedure ProvideOps(const aPublisher: IvcmOperationsPublisher);
    {* предоставить список доступных операций. }
   {$IfEnd} // NOT Defined(NoVCM)
   function IsCommandPublished(Cmd: Tl3OperationCode): Boolean;
   function DoKeys2Effect(aKeys: Integer): Integer; override;
   {$If NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}
   procedure LoadSettings; override;
   {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}
   procedure SaveSettings; override;
   {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)
   function GetDragAndDropSupported: Boolean; override;
   {$If NOT Defined(DesignTimeLibrary) AND NOT Defined(NoVCM)}
   function DoSaveState(out aState: IUnknown;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
   {$IfEnd} // NOT Defined(DesignTimeLibrary) AND NOT Defined(NoVCM)
   {$If NOT Defined(DesignTimeLibrary) AND NOT Defined(NoVCM)}
   function DoLoadState(const aState: IUnknown;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
   {$IfEnd} // NOT Defined(DesignTimeLibrary) AND NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Copy; override;
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Paste; override;
    {* Вставка }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SelectAll; override;
    {* Выделить всё }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Deselect; override;
    {* Снять выделение }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ExpandAll; override;
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CollapseAll; override;
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Wrap; override;
    {* Перенос по словам }
   {$IfEnd} // NOT Defined(NoVCM)
   constructor Create(AOwner: TComponent); override;
   function CalcInterRowIndent: Integer; override;
  public
   property SettingId: AnsiString
    read f_SettingId
    write pm_SetSettingId;
   property InterRowMultiplier: Integer
    read f_InterRowMultiplier
    write pm_SetInterRowMultiplier;
   property DisableDragAndDropSupport: Boolean
    read f_DisableDragAndDropSupport
    write f_DisableDragAndDropSupport;
 end;//TnscTreeViewPrim

 //#UC START# *499C26240034ci*
 //#UC END# *499C26240034ci*
 //#UC START# *499C26240034cit*
 //#UC END# *499C26240034cit*
 TnscTreeView = class(TnscTreeViewPrim)
 //#UC START# *499C26240034publ*
  published
   property SettingId;
   property InterRowMultiplier default 1;
   property DisableDragAndDropSupport default false;
 //#UC END# *499C26240034publ*
 end;//TnscTreeView
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , nscTreeViewRes
 , OvcConst
 {$If NOT Defined(NoVCM)}
 , vcmDefaultOperations
 {$IfEnd} // NOT Defined(NoVCM)
 , afwConsts
 , l3Base
 , ActiveX
 , afwFacade
 , SysUtils
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 cstWrap = 'stWrap';

constructor TnscTreeViewState.Create(const aAggregate: IUnknown;
 aWrap: Boolean);
//#UC START# *52DD083B0184_52DD07CE001D_var*
//#UC END# *52DD083B0184_52DD07CE001D_var*
begin
//#UC START# *52DD083B0184_52DD07CE001D_impl*
 inherited Create;
 f_Aggregate := aAggregate;
 f_Wrap := aWrap;
//#UC END# *52DD083B0184_52DD07CE001D_impl*
end;//TnscTreeViewState.Create

class function TnscTreeViewState.Make(const aAggregate: IUnknown;
 aWrap: Boolean): InscTreeState;
var
 l_Inst : TnscTreeViewState;
begin
 l_Inst := Create(aAggregate, aWrap);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnscTreeViewState.Make

function TnscTreeViewState.pm_GetAggregate: IUnknown;
//#UC START# *52DD07A0013B_52DD07CE001Dget_var*
//#UC END# *52DD07A0013B_52DD07CE001Dget_var*
begin
//#UC START# *52DD07A0013B_52DD07CE001Dget_impl*
 Result := f_Aggregate;
//#UC END# *52DD07A0013B_52DD07CE001Dget_impl*
end;//TnscTreeViewState.pm_GetAggregate

function TnscTreeViewState.pm_GetWrap: Boolean;
//#UC START# *52DD07B301D9_52DD07CE001Dget_var*
//#UC END# *52DD07B301D9_52DD07CE001Dget_var*
begin
//#UC START# *52DD07B301D9_52DD07CE001Dget_impl*
 Result := f_Wrap;
//#UC END# *52DD07B301D9_52DD07CE001Dget_impl*
end;//TnscTreeViewState.pm_GetWrap

procedure TnscTreeViewState.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52DD07CE001D_var*
//#UC END# *479731C50290_52DD07CE001D_var*
begin
//#UC START# *479731C50290_52DD07CE001D_impl*
 f_Aggregate := nil;
 f_Wrap := True;
 inherited;
//#UC END# *479731C50290_52DD07CE001D_impl*
end;//TnscTreeViewState.Cleanup

function TnscTreeViewState.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_52DD07CE001D_var*
//#UC END# *4A60B23E00C3_52DD07CE001D_var*
begin
//#UC START# *4A60B23E00C3_52DD07CE001D_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
  if Supports(f_Aggregate, IID.IID, Obj) then
   Result.SetOk
  else
   Result.SetNoInterface;
//#UC END# *4A60B23E00C3_52DD07CE001D_impl*
end;//TnscTreeViewState.COMQueryInterface

{$Include w:\common\components\gui\Garant\VT\nsUnknownComponent.imp.pas}

procedure TnscTreeViewPrim.pm_SetSettingId(const aValue: AnsiString);
//#UC START# *52DD08FC017B_52DD0971008Aset_var*
//#UC END# *52DD08FC017B_52DD0971008Aset_var*
begin
//#UC START# *52DD08FC017B_52DD0971008Aset_impl*
 if f_SettingId <> aValue then
 begin
  f_SettingId := aValue;
  {$IfNDef DesignTimeLibrary}
  CheckLoadSettings;
  {$EndIf DesignTimeLibrary}
 end;
//#UC END# *52DD08FC017B_52DD0971008Aset_impl*
end;//TnscTreeViewPrim.pm_SetSettingId

procedure TnscTreeViewPrim.pm_SetInterRowMultiplier(aValue: Integer);
//#UC START# *52DD09210222_52DD0971008Aset_var*
//#UC END# *52DD09210222_52DD0971008Aset_var*
begin
//#UC START# *52DD09210222_52DD0971008Aset_impl*
 if aValue < 1 then
  aValue := 1;
 if f_InterRowMultiplier <> aValue then
 begin
  f_InterRowMultiplier := aValue;
  UpdateInterRowIndent;
 end;
//#UC END# *52DD09210222_52DD0971008Aset_impl*
end;//TnscTreeViewPrim.pm_SetInterRowMultiplier

function TnscTreeViewPrim.DoIsCommandPublished(Cmd: Tl3OperationCode): Boolean;
//#UC START# *508F7F930094_52DD0971008A_var*
//#UC END# *508F7F930094_52DD0971008A_var*
begin
//#UC START# *508F7F930094_52DD0971008A_impl*
 Result := f_Published and (Cmd in [ccTreeAllExpand,
                                    ccAllSelect,
                                    ccAllDeselect]);
//#UC END# *508F7F930094_52DD0971008A_impl*
end;//TnscTreeViewPrim.DoIsCommandPublished

function TnscTreeViewPrim.IsEmpty: Boolean;
//#UC START# *52DD0A7700AD_52DD0971008A_var*
//#UC END# *52DD0A7700AD_52DD0971008A_var*
begin
//#UC START# *52DD0A7700AD_52DD0971008A_impl*
 Result := (TreeStruct.RootNode = nil) or not TreeStruct.RootNode.HasChild;
//#UC END# *52DD0A7700AD_52DD0971008A_impl*
end;//TnscTreeViewPrim.IsEmpty

procedure TnscTreeViewPrim.DoProvideOps(const aPublisher: IvcmOperationsPublisher);
//#UC START# *52DD0ACE03DC_52DD0971008A_var*
const
 cenTree = en_Tree;
 copWrap = op_Wrap;
 copExpandAll = op_ExpandAll;
 copCollapseAll = op_CollapseAll;
//#UC END# *52DD0ACE03DC_52DD0971008A_var*
begin
//#UC START# *52DD0ACE03DC_52DD0971008A_impl*
 f_Published := true;
 with aPublisher do
 begin
  PublishOp(vcm_deEdit,
            vcm_doSelectAll,
            Edit_SelectAll_Execute,
            Edit_SelectAll_Test);
  PublishOp(vcm_deEdit,
            vcm_doDeselect,
            Edit_Deselect_Execute,
            Edit_Deselect_Test);
  PublishOp(vcm_deEdit,
            vcm_doCopy,
            Edit_Copy_Execute,
            Edit_Copy_Test);
  PublishOp(vcm_deEdit,
            vcm_doPaste,
            Edit_Paste_Execute,
            Edit_Paste_Test);
  PublishOp(cenTree,
            copExpandAll,
            Tree_ExpandAll_Execute,
            Tree_ExpandAll_Test);
  PublishOp(cenTree,
            copCollapseAll,
            Tree_CollapseAll_Execute,
            Tree_CollapseAll_Test);
  PublishOp(cenTree,
            copWrap,
            Tree_Wrap_Execute,
            Tree_Wrap_Test);
 end;//with aPublisher do
//#UC END# *52DD0ACE03DC_52DD0971008A_impl*
end;//TnscTreeViewPrim.DoProvideOps

function TnscTreeViewPrim.MakePath(const aSetting: AnsiString): AnsiString;
//#UC START# *52DD0AF202C2_52DD0971008A_var*
//#UC END# *52DD0AF202C2_52DD0971008A_var*
begin
//#UC START# *52DD0AF202C2_52DD0971008A_impl*
 Result := f_SettingId + g_afwPathSep + aSetting;
//#UC END# *52DD0AF202C2_52DD0971008A_impl*
end;//TnscTreeViewPrim.MakePath

{$If NOT Defined(NoVCM)}
procedure TnscTreeViewPrim.ProvideOps(const aPublisher: IvcmOperationsPublisher);
 {* предоставить список доступных операций. }
//#UC START# *4769552100DD_52DD0971008A_var*
//#UC END# *4769552100DD_52DD0971008A_var*
begin
//#UC START# *4769552100DD_52DD0971008A_impl*
 DoProvideOps(aPublisher);
//#UC END# *4769552100DD_52DD0971008A_impl*
end;//TnscTreeViewPrim.ProvideOps
{$IfEnd} // NOT Defined(NoVCM)

function TnscTreeViewPrim.IsCommandPublished(Cmd: Tl3OperationCode): Boolean;
//#UC START# *476BFD420341_52DD0971008A_var*
//#UC END# *476BFD420341_52DD0971008A_var*
begin
//#UC START# *476BFD420341_52DD0971008A_impl*
 Result := DoIsCommandPublished(Cmd);
//#UC END# *476BFD420341_52DD0971008A_impl*
end;//TnscTreeViewPrim.IsCommandPublished

{$If NOT Defined(NoVCM)}
procedure TnscTreeViewPrim.Copy;
 {* Копировать }
//#UC START# *4951284902BD_52DD0971008A_var*
//#UC END# *4951284902BD_52DD0971008A_var*
begin
//#UC START# *4951284902BD_52DD0971008A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4951284902BD_52DD0971008A_impl*
end;//TnscTreeViewPrim.Copy
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TnscTreeViewPrim.Paste;
 {* Вставка }
//#UC START# *49EDFA3701B0_52DD0971008A_var*
//#UC END# *49EDFA3701B0_52DD0971008A_var*
begin
//#UC START# *49EDFA3701B0_52DD0971008A_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFA3701B0_52DD0971008A_impl*
end;//TnscTreeViewPrim.Paste
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TnscTreeViewPrim.SelectAll;
 {* Выделить всё }
//#UC START# *49EE01AA02BE_52DD0971008A_var*
//#UC END# *49EE01AA02BE_52DD0971008A_var*
begin
//#UC START# *49EE01AA02BE_52DD0971008A_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EE01AA02BE_52DD0971008A_impl*
end;//TnscTreeViewPrim.SelectAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TnscTreeViewPrim.Deselect;
 {* Снять выделение }
//#UC START# *49EE01BC022E_52DD0971008A_var*
//#UC END# *49EE01BC022E_52DD0971008A_var*
begin
//#UC START# *49EE01BC022E_52DD0971008A_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EE01BC022E_52DD0971008A_impl*
end;//TnscTreeViewPrim.Deselect
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TnscTreeViewPrim.ExpandAll;
 {* Развернуть все }
//#UC START# *4BDAF7880236_52DD0971008A_var*
//#UC END# *4BDAF7880236_52DD0971008A_var*
begin
//#UC START# *4BDAF7880236_52DD0971008A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7880236_52DD0971008A_impl*
end;//TnscTreeViewPrim.ExpandAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TnscTreeViewPrim.CollapseAll;
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_52DD0971008A_var*
//#UC END# *4BDAF7A2005C_52DD0971008A_var*
begin
//#UC START# *4BDAF7A2005C_52DD0971008A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7A2005C_52DD0971008A_impl*
end;//TnscTreeViewPrim.CollapseAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TnscTreeViewPrim.Wrap;
 {* Перенос по словам }
//#UC START# *4BDAF7B803CF_52DD0971008A_var*
//#UC END# *4BDAF7B803CF_52DD0971008A_var*
begin
//#UC START# *4BDAF7B803CF_52DD0971008A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7B803CF_52DD0971008A_impl*
end;//TnscTreeViewPrim.Wrap
{$IfEnd} // NOT Defined(NoVCM)

constructor TnscTreeViewPrim.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_52DD0971008A_var*
//#UC END# *47D1602000C6_52DD0971008A_var*
begin
//#UC START# *47D1602000C6_52DD0971008A_impl*
 inherited;
 f_InterRowMultiplier := 1;

 {$IfNDef DesignTimeLibrary}
 {$IfDef Nemesis}
 // http://mdp.garant.ru/pages/viewpage.action?pageId=303858572
 // на всякий случай, т.к. ограничение только для оболочки
 {$If not defined(Admin) AND not defined(Monitorings)}
  if (afw.Application <> nil) then
   DisableDragAndDropSupport := afw.Application.IsTrialMode;
 {$IfEnd} //not Admin AND not Monitorings
 {$EndIf Nemesis}
 {$EndIf DesignTimeLibrary}
//#UC END# *47D1602000C6_52DD0971008A_impl*
end;//TnscTreeViewPrim.Create

function TnscTreeViewPrim.DoKeys2Effect(aKeys: Integer): Integer;
//#UC START# *48BFB75F01ED_52DD0971008A_var*
//#UC END# *48BFB75F01ED_52DD0971008A_var*
begin
//#UC START# *48BFB75F01ED_52DD0971008A_impl*
 Result := DROPEFFECT_MOVE;
//#UC END# *48BFB75F01ED_52DD0971008A_impl*
end;//TnscTreeViewPrim.DoKeys2Effect

{$If NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}
procedure TnscTreeViewPrim.LoadSettings;
//#UC START# *4F9A5C410274_52DD0971008A_var*
//#UC END# *4F9A5C410274_52DD0971008A_var*
begin
//#UC START# *4F9A5C410274_52DD0971008A_impl*
 if f_SettingId <> '' then
  MultiStrokeItem := Settings.LoadBoolean(PAnsiChar(MakePath(cstWrap)), True);
//#UC END# *4F9A5C410274_52DD0971008A_impl*
end;//TnscTreeViewPrim.LoadSettings
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)

{$If NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}
procedure TnscTreeViewPrim.SaveSettings;
//#UC START# *4F9A5C530398_52DD0971008A_var*
//#UC END# *4F9A5C530398_52DD0971008A_var*
begin
//#UC START# *4F9A5C530398_52DD0971008A_impl*
 if f_SettingId <> '' then
  Settings.SaveBoolean(PAnsiChar(MakePath(cstWrap)), MultiStrokeItem);
//#UC END# *4F9A5C530398_52DD0971008A_impl*
end;//TnscTreeViewPrim.SaveSettings
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)

function TnscTreeViewPrim.GetDragAndDropSupported: Boolean;
//#UC START# *5152C16A028F_52DD0971008A_var*
//#UC END# *5152C16A028F_52DD0971008A_var*
begin
//#UC START# *5152C16A028F_52DD0971008A_impl*
 Result := inherited GetDragAndDropSupported;
 if DisableDragAndDropSupport then
  Result := False;
//#UC END# *5152C16A028F_52DD0971008A_impl*
end;//TnscTreeViewPrim.GetDragAndDropSupported

function TnscTreeViewPrim.CalcInterRowIndent: Integer;
//#UC START# *515584020214_52DD0971008A_var*
//#UC END# *515584020214_52DD0971008A_var*
begin
//#UC START# *515584020214_52DD0971008A_impl*
 Result := f_RowHeight * InterRowMultiplier div 3;
//#UC END# *515584020214_52DD0971008A_impl*
end;//TnscTreeViewPrim.CalcInterRowIndent

{$If NOT Defined(DesignTimeLibrary) AND NOT Defined(NoVCM)}
function TnscTreeViewPrim.DoSaveState(out aState: IUnknown;
 aStateType: TvcmStateType;
 aForClone: Boolean): Boolean;
//#UC START# *52DD0F440276_52DD0971008A_var*
//#UC END# *52DD0F440276_52DD0971008A_var*
begin
//#UC START# *52DD0F440276_52DD0971008A_impl*
 Result := inherited DoSaveState(aState, aStateType, aForClone);
 if aStateType = vcm_stContent then
 begin
  if Result then
   aState := TnscTreeViewState.Make(aState, MultiStrokeItem)
  else
   aState := TnscTreeViewState.Make(nil, MultiStrokeItem);
  Result := True;
 end;
//#UC END# *52DD0F440276_52DD0971008A_impl*
end;//TnscTreeViewPrim.DoSaveState
{$IfEnd} // NOT Defined(DesignTimeLibrary) AND NOT Defined(NoVCM)

{$If NOT Defined(DesignTimeLibrary) AND NOT Defined(NoVCM)}
function TnscTreeViewPrim.DoLoadState(const aState: IUnknown;
 aStateType: TvcmStateType;
 aForClone: Boolean): Boolean;
//#UC START# *52DD0F6F0223_52DD0971008A_var*
var
 l_Params: InscTreeState;
//#UC END# *52DD0F6F0223_52DD0971008A_var*
begin
//#UC START# *52DD0F6F0223_52DD0971008A_impl*
 if (aStateType = vcm_stContent) and
    Supports(aState, InscTreeState, l_Params) then
 try
  MultiStrokeItem := l_Params.Wrap;
  Result := True;
  if l_Params.Aggregate <> nil then
   inherited DoLoadState(l_Params.Aggregate, aStateType, aForClone);
 finally
  l_Params := nil;
 end
 else
  Result := LoadState(aState, aStateType);
//#UC END# *52DD0F6F0223_52DD0971008A_impl*
end;//TnscTreeViewPrim.DoLoadState
{$IfEnd} // NOT Defined(DesignTimeLibrary) AND NOT Defined(NoVCM)

//#UC START# *499C26240034impl*
//#UC END# *499C26240034impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscTreeViewPrim);
 {* Регистрация TnscTreeViewPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscTreeView);
 {* Регистрация TnscTreeView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
