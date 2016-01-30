unit PrimListAnalizer_Form;
 {* Анализ списка }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimListAnalizer_Form.pas"
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
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , vtPanel
 , eeTreeView
 , l3TreeInterfaces
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3StringIDEx
;

type
 TPrimListAnalizerForm = class(TvcmEntityForm)
  {* Анализ списка }
  private
   f_BackgroundPanel: TvtPanel;
    {* Поле для свойства BackgroundPanel }
   f_ListTree: TeeTreeView;
    {* Поле для свойства ListTree }
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
  public
   class function Make(const aData: Il3SimpleTree): Result; reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property BackgroundPanel: TvtPanel
    read f_BackgroundPanel;
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
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки listAnalizeLocalConstants }
 str_listAnalizeCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'listAnalizeCaption'; rValue : 'Анализ списка');
  {* Заголовок пользовательского типа "Анализ списка" }

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

class function TPrimListAnalizerForm.Make(const aData: Il3SimpleTree): Result;
var
 l_Inst : TPrimListAnalizerForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimListAnalizerForm.Make

{$If NOT Defined(NoVCM)}
procedure TPrimListAnalizerForm.Cancel;
 {* Отмена }
//#UC START# *4A8AD46D0226_4AA0CE2B0073_var*
//#UC END# *4A8AD46D0226_4AA0CE2B0073_var*
begin
//#UC START# *4A8AD46D0226_4AA0CE2B0073_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8AD46D0226_4AA0CE2B0073_impl*
end;//TPrimListAnalizerForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListAnalizerForm.Ok;
 {* OK }
//#UC START# *4A97EBE702F8_4AA0CE2B0073_var*
//#UC END# *4A97EBE702F8_4AA0CE2B0073_var*
begin
//#UC START# *4A97EBE702F8_4AA0CE2B0073_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97EBE702F8_4AA0CE2B0073_impl*
end;//TPrimListAnalizerForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListAnalizerForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4AA0CE2B0073_var*
//#UC END# *4C762A1501FC_4AA0CE2B0073_var*
begin
//#UC START# *4C762A1501FC_4AA0CE2B0073_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4AA0CE2B0073_impl*
end;//TPrimListAnalizerForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListAnalizerForm.Cancel;
 {* Отмена }
//#UC START# *4C762AB601E1_4AA0CE2B0073_var*
//#UC END# *4C762AB601E1_4AA0CE2B0073_var*
begin
//#UC START# *4C762AB601E1_4AA0CE2B0073_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762AB601E1_4AA0CE2B0073_impl*
end;//TPrimListAnalizerForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimListAnalizerForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4AA0CE2B0073_var*
//#UC END# *47EA4E9002C6_4AA0CE2B0073_var*
begin
//#UC START# *47EA4E9002C6_4AA0CE2B0073_impl*
 inherited;
 ModalResult := mrCancel;
//#UC END# *47EA4E9002C6_4AA0CE2B0073_impl*
end;//TPrimListAnalizerForm.FinishDataUpdate

{$If NOT Defined(NoVCM)}
procedure TPrimListAnalizerForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4AA0CE2B0073_var*
//#UC END# *49803F5503AA_4AA0CE2B0073_var*
begin
//#UC START# *49803F5503AA_4AA0CE2B0073_impl*
 ListTree.Images := nsSearchRes.SearchItemsImageList;
//#UC END# *49803F5503AA_4AA0CE2B0073_impl*
end;//TPrimListAnalizerForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_listAnalizeCaption.Init;
 {* Инициализация str_listAnalizeCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimListAnalizerForm);
 {* Регистрация PrimListAnalizer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
