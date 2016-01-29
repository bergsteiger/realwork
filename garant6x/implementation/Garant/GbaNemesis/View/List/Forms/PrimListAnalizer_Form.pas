unit PrimListAnalizer_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/List/Forms/PrimListAnalizer_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::WorkWithList::View::List::PrimListAnalizer
//
// Анализ списка
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
  l3ControlsTypes,
  eeTreeView
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtPanel
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  l3StringIDEx,
  vtOutlinerWithDragDrop,
  vtLister
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  PrimListAnalizer_listAnalize_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimListAnalizerForm = {form} class(TvcmEntityForm)
  {* Анализ списка }
 private
 // private fields
   f_BackgroundPanel : TvtPanel;
    {* Поле для свойства BackgroundPanel}
   f_ListTree : TeeTreeView;
    {* Поле для свойства ListTree}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure ListTreeActionElement(Sender: TObject;
     Index: LongInt);
   procedure ListTreeCanBeginDrag(const aNode: Il3SimpleNode;
     var aOkEffect: LongInt);
   function ListTreeGetItemImage(Sender: TObject;
     Index: Integer;
     var aImages: TCustomImageList): Integer;
     {* Event to get Index of Bitmap in ImageIndex. }
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_GetState(var State: TvcmOperationStateIndex);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
 protected
 // overridden protected methods
   procedure FinishDataUpdate; override;
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   function CanOpen(const aNode: Il3SimpleNode): Boolean;
   function TryOpen(const aNode: Il3SimpleNode): Boolean;
 public
 // public methods
   class function Make(const aData: Il3SimpleTree;
    const aParams : IvcmMakeParams = nil;
    aZoneType     : TvcmZoneType = vcm_ztAny;
    aUserType     : TvcmEffectiveUserType = 0;
    aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 public
 // public properties
   property BackgroundPanel: TvtPanel
     read f_BackgroundPanel;
   property ListTree: TeeTreeView
     read f_ListTree;
 end;//TPrimListAnalizerForm

 TvcmEntityFormRef = TPrimListAnalizerForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DynamicDocListUnit,
  BaseTypesUnit,
  nsUtils,
  DynamicTreeUnit,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  ActiveX,
  SearchRes
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
  StdRes {a},
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки listAnalizeLocalConstants }
  str_listAnalizeCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'listAnalizeCaption'; rValue : 'Анализ списка');
   { Заголовок пользовательского типа "Анализ списка" }

// start class TPrimListAnalizerForm

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
  const aParams : IvcmMakeParams = nil;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;

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
end;

{$If not defined(NoVCM)}
procedure TPrimListAnalizerForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A8AD46D0226_4AA0CE2B0073test_var*
//#UC END# *4A8AD46D0226_4AA0CE2B0073test_var*
begin
//#UC START# *4A8AD46D0226_4AA0CE2B0073test_impl*
 // Do nothing
//#UC END# *4A8AD46D0226_4AA0CE2B0073test_impl*
end;//TPrimListAnalizerForm.Result_Cancel_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListAnalizerForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A8AD46D0226_4AA0CE2B0073exec_var*
//#UC END# *4A8AD46D0226_4AA0CE2B0073exec_var*
begin
//#UC START# *4A8AD46D0226_4AA0CE2B0073exec_impl*
 ModalResult := mrCancel;
//#UC END# *4A8AD46D0226_4AA0CE2B0073exec_impl*
end;//TPrimListAnalizerForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListAnalizerForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A97EBE702F8_4AA0CE2B0073test_var*
//#UC END# *4A97EBE702F8_4AA0CE2B0073test_var*
begin
//#UC START# *4A97EBE702F8_4AA0CE2B0073test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanOpen(ListTree.GetCurrentNode);
//#UC END# *4A97EBE702F8_4AA0CE2B0073test_impl*
end;//TPrimListAnalizerForm.Result_Ok_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListAnalizerForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4A97EBE702F8_4AA0CE2B0073getstate_var*
//#UC END# *4A97EBE702F8_4AA0CE2B0073getstate_var*
begin
//#UC START# *4A97EBE702F8_4AA0CE2B0073getstate_impl*
 State := st_user_Result_Ok_Analize;
//#UC END# *4A97EBE702F8_4AA0CE2B0073getstate_impl*
end;//TPrimListAnalizerForm.Result_Ok_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListAnalizerForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A97EBE702F8_4AA0CE2B0073exec_var*
//#UC END# *4A97EBE702F8_4AA0CE2B0073exec_var*
begin
//#UC START# *4A97EBE702F8_4AA0CE2B0073exec_impl*
 if TryOpen(ListTree.GetCurrentNode) then
  ModalResult := mrOk;
//#UC END# *4A97EBE702F8_4AA0CE2B0073exec_impl*
end;//TPrimListAnalizerForm.Result_Ok_Execute
{$IfEnd} //not NoVCM

procedure TPrimListAnalizerForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4AA0CE2B0073_var*
//#UC END# *47EA4E9002C6_4AA0CE2B0073_var*
begin
//#UC START# *47EA4E9002C6_4AA0CE2B0073_impl*
 inherited;
 ModalResult := mrCancel;
//#UC END# *47EA4E9002C6_4AA0CE2B0073_impl*
end;//TPrimListAnalizerForm.FinishDataUpdate

{$If not defined(NoVCM)}
procedure TPrimListAnalizerForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4AA0CE2B0073_var*
//#UC END# *49803F5503AA_4AA0CE2B0073_var*
begin
//#UC START# *49803F5503AA_4AA0CE2B0073_impl*
 ListTree.Images := nsSearchRes.SearchItemsImageList;
//#UC END# *49803F5503AA_4AA0CE2B0073_impl*
end;//TPrimListAnalizerForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListAnalizerForm.InitControls;
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
{$IfEnd} //not NoVCM

procedure TPrimListAnalizerForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, nil);
  ShowInContextMenu(en_Result, op_Cancel, false);
  ShowInToolbar(en_Result, op_Cancel, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, Result_Ok_GetState);
  ShowInContextMenu(en_Result, op_Ok, false);
  ShowInToolbar(en_Result, op_Ok, true);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

procedure TPrimListAnalizerForm.MakeControls;
begin
 inherited;
 with AddUsertype(listAnalizeName,
  str_listAnalizeCaption,
  str_listAnalizeCaption,
  true,
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
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_listAnalizeCaption
 str_listAnalizeCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimListAnalizer
 TtfwClassRef.Register(TPrimListAnalizerForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.