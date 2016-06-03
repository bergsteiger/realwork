unit PrimListAnalizer_Form;
 {* Анализ списка }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimListAnalizer_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimListAnalizer" MUID: (4AA0CE2B0073)
// Имя типа: "TPrimListAnalizerForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , vtPanel
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , eeTreeView
 , l3TreeInterfaces
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimListAnalizerForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Анализ списка }
  private
   f_BackgroundPanel: TvtPanel;
   f_ListTree: TeeTreeView;
  private
   procedure ListTreeActionElement(Sender: TObject;
    Index: LongInt);
   procedure ListTreeCanBeginDrag(const aNode: Il3SimpleNode;
    var aOkEffect: LongInt);
   function ListTreeGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
  protected
   function CanOpen(const aNode: Il3SimpleNode): Boolean;
   function TryOpen(const aNode: Il3SimpleNode): Boolean;
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aData: Il3SimpleTree;
    const aParams: IvcmMakeParams = nil;
    aZoneType: TvcmZoneType = vcm_ztAny;
    aUserType: TvcmEffectiveUserType = 0;
    const aDataSource: IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_GetState(var State: TvcmOperationStateIndex);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property BackgroundPanel: TvtPanel
    read f_BackgroundPanel;
   property ListTree: TeeTreeView
    read f_ListTree;
 end;//TPrimListAnalizerForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DynamicDocListUnit
 , BaseTypesUnit
 , nsUtils
 , DynamicTreeUnit
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , ActiveX
 , SearchRes
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimListAnalizer_listAnalize_UserType
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4AA0CE2B0073impl_uses*
 , l3ControlsTypes
 //#UC END# *4AA0CE2B0073impl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimListAnalizerForm.ListTreeActionElement(Sender: TObject;
 Index: LongInt);
//#UC START# *51C06313011B_4AA0CE2B0073_var*
//#UC END# *51C06313011B_4AA0CE2B0073_var*
begin
//#UC START# *51C06313011B_4AA0CE2B0073_impl*
 if TryOpen(ListTree.GetNode(Index)) then
  ModalResult := mrOk;
//#UC END# *51C06313011B_4AA0CE2B0073_impl*
end;//TPrimListAnalizerForm.ListTreeActionElement

procedure TPrimListAnalizerForm.ListTreeCanBeginDrag(const aNode: Il3SimpleNode;
 var aOkEffect: LongInt);
//#UC START# *51C063260008_4AA0CE2B0073_var*
//#UC END# *51C063260008_4AA0CE2B0073_var*
begin
//#UC START# *51C063260008_4AA0CE2B0073_impl*
 aOkEffect := DROPEFFECT_NONE;
//#UC END# *51C063260008_4AA0CE2B0073_impl*
end;//TPrimListAnalizerForm.ListTreeCanBeginDrag

function TPrimListAnalizerForm.ListTreeGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *51C0635E00EF_4AA0CE2B0073_var*
var
 l_l3Node : Il3SimpleNode;
//#UC END# *51C0635E00EF_4AA0CE2B0073_var*
begin
//#UC START# *51C0635E00EF_4AA0CE2B0073_impl*
 l_l3Node := ListTree.GetNode(Index);
 if (l_l3Node.Parent = nil) then
  Result := siilSelectedRoot
 else
 if l_l3Node.HasChild then
  Result := siilFolderStart
 else
  Result := siilSelectedElement;
//#UC END# *51C0635E00EF_4AA0CE2B0073_impl*
end;//TPrimListAnalizerForm.ListTreeGetItemImage

function TPrimListAnalizerForm.CanOpen(const aNode: Il3SimpleNode): Boolean;
//#UC START# *4AA0CE5D036E_4AA0CE2B0073_var*
var
 l_Node: INodeBase;
//#UC END# *4AA0CE5D036E_4AA0CE2B0073_var*
begin
//#UC START# *4AA0CE5D036E_4AA0CE2B0073_impl*
 Result := Supports(aNode, INodeBase, l_Node) and (TDynListFlags(l_Node.GetType) = DLF_ANALYSIS_NODE_HAS_DATA);
//#UC END# *4AA0CE5D036E_4AA0CE2B0073_impl*
end;//TPrimListAnalizerForm.CanOpen

function TPrimListAnalizerForm.TryOpen(const aNode: Il3SimpleNode): Boolean;
//#UC START# *4AA0CE940142_4AA0CE2B0073_var*
var
 l_Node: INodeBase;
 l_Entity: IEntityBase;
 l_List: IDynList;
//#UC END# *4AA0CE940142_4AA0CE2B0073_var*
begin
//#UC START# *4AA0CE940142_4AA0CE2B0073_impl*
 Result := False;
 if Supports(aNode, INodeBase, l_Node) then
 begin
  try
   l_Node.GetEntity(l_Entity);
   if Supports(l_Entity, IDynList, l_List) then
   begin
    nsOpenList(l_List, nil);
    Result := True;
   end;//Supports(l_Entity, IDynList, l_List)
  except
   on ENoEntity do
   begin
    Say(war_OutDatedAnalize);
    Exit;
   end;//on ENoEntity
  end;//try..except
 end;//Supports(aNode, INodeBase, l_Node)
//#UC END# *4AA0CE940142_4AA0CE2B0073_impl*
end;//TPrimListAnalizerForm.TryOpen

class function TPrimListAnalizerForm.Make(const aData: Il3SimpleTree;
 const aParams: IvcmMakeParams = nil;
 aZoneType: TvcmZoneType = vcm_ztAny;
 aUserType: TvcmEffectiveUserType = 0;
 const aDataSource: IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TPrimListAnalizerForm);
 begin
  with aForm do
  begin
  //#UC START# *4AC4FB28001B_4AA0CE2B0073_impl*
   ListTree.TreeStruct := aData;
  //#UC END# *4AC4FB28001B_4AA0CE2B0073_impl*
  end;//with aForm
 end;

var
 l_AC : TvcmInitProc;
 l_ACHack : Pointer absolute l_AC;
begin
 l_AC := l3LocalStub(@AfterCreate);
 try
  Result := inherited Make(aParams, aZoneType, aUserType, nil, aDataSource, vcm_utAny, l_AC);
 finally
  l3FreeLocalStub(l_ACHack);
 end;//try..finally
end;//TPrimListAnalizerForm.Make

procedure TPrimListAnalizerForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* Отмена }
//#UC START# *4A8AD46D0226_4AA0CE2B0073test_var*
//#UC END# *4A8AD46D0226_4AA0CE2B0073test_var*
begin
//#UC START# *4A8AD46D0226_4AA0CE2B0073test_impl*
 // Do nothing
//#UC END# *4A8AD46D0226_4AA0CE2B0073test_impl*
end;//TPrimListAnalizerForm.Result_Cancel_Test

procedure TPrimListAnalizerForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4A8AD46D0226_4AA0CE2B0073exec_var*
//#UC END# *4A8AD46D0226_4AA0CE2B0073exec_var*
begin
//#UC START# *4A8AD46D0226_4AA0CE2B0073exec_impl*
 ModalResult := mrCancel;
//#UC END# *4A8AD46D0226_4AA0CE2B0073exec_impl*
end;//TPrimListAnalizerForm.Result_Cancel_Execute

procedure TPrimListAnalizerForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4AA0CE2B0073test_var*
//#UC END# *4A97EBE702F8_4AA0CE2B0073test_var*
begin
//#UC START# *4A97EBE702F8_4AA0CE2B0073test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanOpen(ListTree.GetCurrentNode);
//#UC END# *4A97EBE702F8_4AA0CE2B0073test_impl*
end;//TPrimListAnalizerForm.Result_Ok_Test

procedure TPrimListAnalizerForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4AA0CE2B0073exec_var*
//#UC END# *4A97EBE702F8_4AA0CE2B0073exec_var*
begin
//#UC START# *4A97EBE702F8_4AA0CE2B0073exec_impl*
 if TryOpen(ListTree.GetCurrentNode) then
  ModalResult := mrOk;
//#UC END# *4A97EBE702F8_4AA0CE2B0073exec_impl*
end;//TPrimListAnalizerForm.Result_Ok_Execute

procedure TPrimListAnalizerForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
 {* OK }
//#UC START# *4A97EBE702F8_4AA0CE2B0073getstate_var*
//#UC END# *4A97EBE702F8_4AA0CE2B0073getstate_var*
begin
//#UC START# *4A97EBE702F8_4AA0CE2B0073getstate_impl*
 State := st_user_Result_Ok_Analize;
//#UC END# *4A97EBE702F8_4AA0CE2B0073getstate_impl*
end;//TPrimListAnalizerForm.Result_Ok_GetState

procedure TPrimListAnalizerForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4AA0CE2B0073_var*
//#UC END# *47EA4E9002C6_4AA0CE2B0073_var*
begin
//#UC START# *47EA4E9002C6_4AA0CE2B0073_impl*
 inherited;
 ModalResult := mrCancel;
//#UC END# *47EA4E9002C6_4AA0CE2B0073_impl*
end;//TPrimListAnalizerForm.FinishDataUpdate

procedure TPrimListAnalizerForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4AA0CE2B0073_var*
//#UC END# *49803F5503AA_4AA0CE2B0073_var*
begin
//#UC START# *49803F5503AA_4AA0CE2B0073_impl*
 ListTree.Images := nsSearchRes.SearchItemsImageList;
//#UC END# *49803F5503AA_4AA0CE2B0073_impl*
end;//TPrimListAnalizerForm.DoInit

procedure TPrimListAnalizerForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4AA0CE2B0073_var*
//#UC END# *4A8E8F2E0195_4AA0CE2B0073_var*
begin
//#UC START# *4A8E8F2E0195_4AA0CE2B0073_impl*
 ActiveControl := ListTree;
 BorderIcons := [biSystemMenu];
 FormStyle := fsStayOnTop;
 Position := poMainFormCenter;
 Scaled := False;

 with BackgroundPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
  TabOrder := 0;
 end;
 with ListTree do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  TabOrder := 0;
  MultiStrokeItem := True;
  ViewOptions := [voShowInterRowSpace, voShowIcons, voShowExpandable, voShowLines, voShowOpenChip];
  OnGetItemImage := ListTreeGetItemImage;
  OnActionElement := ListTreeActionElement;
  OnCanBeginDrag := ListTreeCanBeginDrag;
  DragAndDropSupported := True;
 end;        
//#UC END# *4A8E8F2E0195_4AA0CE2B0073_impl*
end;//TPrimListAnalizerForm.InitControls

procedure TPrimListAnalizerForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, nil);
  ShowInContextMenu(en_Result, op_Cancel, False);
  ShowInToolbar(en_Result, op_Cancel, True);
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, Result_Ok_GetState);
  ShowInContextMenu(en_Result, op_Ok, False);
  ShowInToolbar(en_Result, op_Ok, True);
 end;//with Entities.Entities
end;//TPrimListAnalizerForm.InitEntities

procedure TPrimListAnalizerForm.MakeControls;
begin
 inherited;
 with AddUsertype(listAnalizeName,
  str_listAnalizeCaption,
  str_listAnalizeCaption,
  True,
  -1,
  0,
  '',
  nil,
  nil,
  nil,
  vcm_ccDisable) do
 begin
 end;//with AddUsertype(listAnalizeName
 f_BackgroundPanel := TvtPanel.Create(Self);
 f_BackgroundPanel.Name := 'BackgroundPanel';
 f_BackgroundPanel.Parent := Self;
 f_ListTree := TeeTreeView.Create(Self);
 f_ListTree.Name := 'ListTree';
 f_ListTree.Parent := BackgroundPanel;
end;//TPrimListAnalizerForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimListAnalizerForm);
 {* Регистрация PrimListAnalizer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
