unit vtOutlinerWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\vtOutlinerWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "vtOutlinerWordsPack" MUID: (503F914E00EF)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , vtOutliner
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , l3TreeInterfaces
 , tfwAxiomaticsResNameGetter
 , l3Nodes
 , l3String
 , l3Interfaces
 , l3Chars
 , l3Types
 , l3Base
 , l3Filer
 , SysUtils
 , l3Tree_TLB
 , l3Bits
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwTreeCheckFlag = {final} class(TtfwClassLike)
  {* ����� ������� tree:CheckFlag }
  private
   function tree_CheckFlag(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner;
    aFlag: Integer;
    aNodeID: Integer): Boolean;
    {* ���������� ����� ������� tree:CheckFlag }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeCheckFlag

 TkwTreeCollapseAll = {final} class(TtfwClassLike)
  {* ����� ������� tree:CollapseAll }
  private
   procedure tree_CollapseAll(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner);
    {* ���������� ����� ������� tree:CollapseAll }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeCollapseAll

 TkwTreeCurrentNodeIsExpanded = {final} class(TtfwClassLike)
  {* ����� ������� tree:CurrentNode:IsExpanded }
  private
   function tree_CurrentNode_IsExpanded(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner): Boolean;
    {* ���������� ����� ������� tree:CurrentNode:IsExpanded }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeCurrentNodeIsExpanded

 TkwTreeDeleteAllChildren = {final} class(TtfwClassLike)
  {* ����� ������� tree:DeleteAllChildren }
  private
   procedure tree_DeleteAllChildren(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner);
    {* ���������� ����� ������� tree:DeleteAllChildren }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeDeleteAllChildren

 TkwTreeExpandAll = {final} class(TtfwClassLike)
  {* ����� ������� tree:ExpandAll }
  private
   procedure tree_ExpandAll(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner);
    {* ���������� ����� ������� tree:ExpandAll }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeExpandAll

 TkwTreeCurrentNode = {final} class(TtfwClassLike)
  {* ����� ������� tree:CurrentNode }
  private
   function tree_CurrentNode(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner): Il3SimpleNode;
    {* ���������� ����� ������� tree:CurrentNode }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeCurrentNode

 TkwTreeGetItem = {final} class(TtfwClassLike)
  {* ����� ������� tree:GetItem }
  private
   function tree_GetItem(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner;
    anIndex: Integer): Il3SimpleNode;
    {* ���������� ����� ������� tree:GetItem }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeGetItem

 TkwTreeGetItemsCount = {final} class(TtfwClassLike)
  {* ����� ������� tree:GetItemsCount }
  private
   function tree_GetItemsCount(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner): Integer;
    {* ���������� ����� ������� tree:GetItemsCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeGetItemsCount

 TkwTreeIterateNodes = {final} class(TtfwClassLike)
  {* ����� ������� tree:IterateNodes }
  private
   procedure tree_IterateNodes(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner;
    aLambda: TtfwWord);
    {* ���������� ����� ������� tree:IterateNodes }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeIterateNodes

 TkwTreeSaveState2File = {final} class(TtfwClassLike)
  {* ����� ������� tree:SaveState2File }
  private
   procedure tree_SaveState2File(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner;
    const aFileName: AnsiString);
    {* ���������� ����� ������� tree:SaveState2File }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeSaveState2File

 TkwTreeChildrenCount = {final} class(TtfwClassLike)
  {* ����� ������� tree:ChildrenCount }
  private
   function tree_ChildrenCount(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner;
    anIndex: Integer): Integer;
    {* ���������� ����� ������� tree:ChildrenCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeChildrenCount

 TkwTreeExpand = {final} class(TtfwClassLike)
  {* ����� ������� tree:���������� }
  private
   procedure tree_expand(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner;
    anIndex: Integer);
    {* ���������� ����� ������� tree:���������� }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeExpand

 TkwTreeGetItemHeight = {final} class(TtfwClassLike)
  {* ����� ������� tree:GetItem:Height }
  private
   function tree_GetItem_Height(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner;
    anIndex: Integer): Integer;
    {* ���������� ����� ������� tree:GetItem:Height }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeGetItemHeight

 TkwTreeGetItemImageIndex = {final} class(TtfwClassLike)
  {* ����� ������� tree:GetItemImageIndex }
  private
   function tree_GetItemImageIndex(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner;
    anIndex: Integer): Integer;
    {* ���������� ����� ������� tree:GetItemImageIndex }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeGetItemImageIndex

 TkwTreeGetItemLeft = {final} class(TtfwClassLike)
  {* ����� ������� tree:GetItem:Left }
  private
   function tree_GetItem_Left(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner;
    anIndex: Integer): Integer;
    {* ���������� ����� ������� tree:GetItem:Left }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeGetItemLeft

 TkwTreeGetItemTop = {final} class(TtfwClassLike)
  {* ����� ������� tree:GetItem:Top }
  private
   function tree_GetItem_Top(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner;
    anIndex: Integer): Integer;
    {* ���������� ����� ������� tree:GetItem:Top }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeGetItemTop

 TkwTreeGetItemWidth = {final} class(TtfwClassLike)
  {* ����� ������� tree:GetItem:Width }
  private
   function tree_GetItem_Width(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner;
    anIndex: Integer): Integer;
    {* ���������� ����� ������� tree:GetItem:Width }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeGetItemWidth

 TkwTreeGetSelected = {final} class(TtfwClassLike)
  {* ����� ������� tree:GetSelected }
  private
   function tree_GetSelected(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner;
    anIndex: Integer): Boolean;
    {* ���������� ����� ������� tree:GetSelected }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeGetSelected

 TkwTreeSetSelected = {final} class(TtfwClassLike)
  {* ����� ������� tree:SetSelected }
  private
   procedure tree_SetSelected(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner;
    anIndex: Integer;
    aValue: Boolean);
    {* ���������� ����� ������� tree:SetSelected }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeSetSelected

 TkwTreeCollapse = {final} class(TtfwClassLike)
  {* ����� ������� tree:�������� }
  private
   procedure tree_collapse(const aCtx: TtfwContext;
    aTree: TvtCustomOutliner;
    anIndex: Integer);
    {* ���������� ����� ������� tree:�������� }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTreeCollapse

 TvtCustomOutlinerFriend = {abstract} class(TvtCustomOutliner)
  {* ���� � ������ TvtCustomOutliner }
 end;//TvtCustomOutlinerFriend

 TvtOutlinerWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  public
   class function ResName: AnsiString; override;
 end;//TvtOutlinerWordsPackResNameGetter

function TkwTreeCheckFlag.tree_CheckFlag(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner;
 aFlag: Integer;
 aNodeID: Integer): Boolean;
 {* ���������� ����� ������� tree:CheckFlag }
//#UC START# *552FEA840365_3A8F612BD250_var*
//#UC END# *552FEA840365_3A8F612BD250_var*
begin
//#UC START# *552FEA840365_3A8F612BD250_impl*
 Result := l3TestMask(aTree.CTree.CNodes[aNodeID].Flags, aFlag);
//#UC END# *552FEA840365_3A8F612BD250_impl*
end;//TkwTreeCheckFlag.tree_CheckFlag

procedure TkwTreeCheckFlag.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
var l_aFlag: Integer;
var l_aNodeID: Integer;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFlag := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFlag: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aNodeID := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNodeID: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(tree_CheckFlag(aCtx, l_aTree, l_aFlag, l_aNodeID));
end;//TkwTreeCheckFlag.DoDoIt

class function TkwTreeCheckFlag.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:CheckFlag';
end;//TkwTreeCheckFlag.GetWordNameForRegister

function TkwTreeCheckFlag.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwTreeCheckFlag.GetResultTypeInfo

function TkwTreeCheckFlag.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwTreeCheckFlag.GetAllParamsCount

function TkwTreeCheckFlag.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner), TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwTreeCheckFlag.ParamsTypes

procedure TkwTreeCollapseAll.tree_CollapseAll(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner);
 {* ���������� ����� ������� tree:CollapseAll }
//#UC START# *552FEAD4014B_DCC8D602858A_var*
//#UC END# *552FEAD4014B_DCC8D602858A_var*
begin
//#UC START# *552FEAD4014B_DCC8D602858A_impl*
 aTree.TreeStruct.RootNode.ExpandCollapseAll(False);
//#UC END# *552FEAD4014B_DCC8D602858A_impl*
end;//TkwTreeCollapseAll.tree_CollapseAll

procedure TkwTreeCollapseAll.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 tree_CollapseAll(aCtx, l_aTree);
end;//TkwTreeCollapseAll.DoDoIt

class function TkwTreeCollapseAll.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:CollapseAll';
end;//TkwTreeCollapseAll.GetWordNameForRegister

function TkwTreeCollapseAll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwTreeCollapseAll.GetResultTypeInfo

function TkwTreeCollapseAll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTreeCollapseAll.GetAllParamsCount

function TkwTreeCollapseAll.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner)]);
end;//TkwTreeCollapseAll.ParamsTypes

function TkwTreeCurrentNodeIsExpanded.tree_CurrentNode_IsExpanded(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner): Boolean;
 {* ���������� ����� ������� tree:CurrentNode:IsExpanded }
//#UC START# *552FEAF60072_24EBB16818DB_var*
//#UC END# *552FEAF60072_24EBB16818DB_var*
begin
//#UC START# *552FEAF60072_24EBB16818DB_impl*
 Result := aTree.TreeStruct.IsExpanded(aTree.GetCurrentNode);
//#UC END# *552FEAF60072_24EBB16818DB_impl*
end;//TkwTreeCurrentNodeIsExpanded.tree_CurrentNode_IsExpanded

procedure TkwTreeCurrentNodeIsExpanded.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(tree_CurrentNode_IsExpanded(aCtx, l_aTree));
end;//TkwTreeCurrentNodeIsExpanded.DoDoIt

class function TkwTreeCurrentNodeIsExpanded.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:CurrentNode:IsExpanded';
end;//TkwTreeCurrentNodeIsExpanded.GetWordNameForRegister

function TkwTreeCurrentNodeIsExpanded.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwTreeCurrentNodeIsExpanded.GetResultTypeInfo

function TkwTreeCurrentNodeIsExpanded.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTreeCurrentNodeIsExpanded.GetAllParamsCount

function TkwTreeCurrentNodeIsExpanded.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner)]);
end;//TkwTreeCurrentNodeIsExpanded.ParamsTypes

procedure TkwTreeDeleteAllChildren.tree_DeleteAllChildren(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner);
 {* ���������� ����� ������� tree:DeleteAllChildren }
//#UC START# *552FEB150182_88EA9B4D8249_var*
var
 l_Node   : Il3SimpleNode;
 l_Current: Il3SimpleNode;
//#UC END# *552FEB150182_88EA9B4D8249_var*
begin
//#UC START# *552FEB150182_88EA9B4D8249_impl*
 l_Current := aTree.CurrentCNode;
 while l_Current.HasChild do
 begin
  l_Node := l_Current.Child;
  l_Node.Delete;
 end; // while l_Current.HasChld do
//#UC END# *552FEB150182_88EA9B4D8249_impl*
end;//TkwTreeDeleteAllChildren.tree_DeleteAllChildren

procedure TkwTreeDeleteAllChildren.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 tree_DeleteAllChildren(aCtx, l_aTree);
end;//TkwTreeDeleteAllChildren.DoDoIt

class function TkwTreeDeleteAllChildren.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:DeleteAllChildren';
end;//TkwTreeDeleteAllChildren.GetWordNameForRegister

function TkwTreeDeleteAllChildren.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwTreeDeleteAllChildren.GetResultTypeInfo

function TkwTreeDeleteAllChildren.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTreeDeleteAllChildren.GetAllParamsCount

function TkwTreeDeleteAllChildren.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner)]);
end;//TkwTreeDeleteAllChildren.ParamsTypes

procedure TkwTreeExpandAll.tree_ExpandAll(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner);
 {* ���������� ����� ������� tree:ExpandAll }
//#UC START# *552FEB5A0289_11D7E325A602_var*
//#UC END# *552FEB5A0289_11D7E325A602_var*
begin
//#UC START# *552FEB5A0289_11D7E325A602_impl*
 aTree.TreeStruct.RootNode.ExpandCollapseAll(True);
//#UC END# *552FEB5A0289_11D7E325A602_impl*
end;//TkwTreeExpandAll.tree_ExpandAll

procedure TkwTreeExpandAll.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 tree_ExpandAll(aCtx, l_aTree);
end;//TkwTreeExpandAll.DoDoIt

class function TkwTreeExpandAll.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:ExpandAll';
end;//TkwTreeExpandAll.GetWordNameForRegister

function TkwTreeExpandAll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwTreeExpandAll.GetResultTypeInfo

function TkwTreeExpandAll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTreeExpandAll.GetAllParamsCount

function TkwTreeExpandAll.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner)]);
end;//TkwTreeExpandAll.ParamsTypes

function TkwTreeCurrentNode.tree_CurrentNode(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner): Il3SimpleNode;
 {* ���������� ����� ������� tree:CurrentNode }
//#UC START# *552FEB8A0123_6EB6AE69700F_var*
//#UC END# *552FEB8A0123_6EB6AE69700F_var*
begin
//#UC START# *552FEB8A0123_6EB6AE69700F_impl*
 Result := aTree.GetCurrentNode;
//#UC END# *552FEB8A0123_6EB6AE69700F_impl*
end;//TkwTreeCurrentNode.tree_CurrentNode

procedure TkwTreeCurrentNode.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(tree_CurrentNode(aCtx, l_aTree), TypeInfo(Il3SimpleNode));
end;//TkwTreeCurrentNode.DoDoIt

class function TkwTreeCurrentNode.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:CurrentNode';
end;//TkwTreeCurrentNode.GetWordNameForRegister

function TkwTreeCurrentNode.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Il3SimpleNode);
end;//TkwTreeCurrentNode.GetResultTypeInfo

function TkwTreeCurrentNode.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTreeCurrentNode.GetAllParamsCount

function TkwTreeCurrentNode.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner)]);
end;//TkwTreeCurrentNode.ParamsTypes

function TkwTreeGetItem.tree_GetItem(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner;
 anIndex: Integer): Il3SimpleNode;
 {* ���������� ����� ������� tree:GetItem }
//#UC START# *552FEBB50243_E66BB4447886_var*
//#UC END# *552FEBB50243_E66BB4447886_var*
begin
//#UC START# *552FEBB50243_E66BB4447886_impl*
 Result := aTree.TreeStruct.Nodes[anIndex];
//#UC END# *552FEBB50243_E66BB4447886_impl*
end;//TkwTreeGetItem.tree_GetItem

procedure TkwTreeGetItem.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
var l_anIndex: Integer;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(tree_GetItem(aCtx, l_aTree, l_anIndex), TypeInfo(Il3SimpleNode));
end;//TkwTreeGetItem.DoDoIt

class function TkwTreeGetItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:GetItem';
end;//TkwTreeGetItem.GetWordNameForRegister

function TkwTreeGetItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Il3SimpleNode);
end;//TkwTreeGetItem.GetResultTypeInfo

function TkwTreeGetItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwTreeGetItem.GetAllParamsCount

function TkwTreeGetItem.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner), TypeInfo(Integer)]);
end;//TkwTreeGetItem.ParamsTypes

function TkwTreeGetItemsCount.tree_GetItemsCount(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner): Integer;
 {* ���������� ����� ������� tree:GetItemsCount }
//#UC START# *552FEBDB031D_6AA86FBC7A2F_var*
//#UC END# *552FEBDB031D_6AA86FBC7A2F_var*
begin
//#UC START# *552FEBDB031D_6AA86FBC7A2F_impl*
 Result := aTree.TreeStruct.CountView;
//#UC END# *552FEBDB031D_6AA86FBC7A2F_impl*
end;//TkwTreeGetItemsCount.tree_GetItemsCount

procedure TkwTreeGetItemsCount.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(tree_GetItemsCount(aCtx, l_aTree));
end;//TkwTreeGetItemsCount.DoDoIt

class function TkwTreeGetItemsCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:GetItemsCount';
end;//TkwTreeGetItemsCount.GetWordNameForRegister

function TkwTreeGetItemsCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwTreeGetItemsCount.GetResultTypeInfo

function TkwTreeGetItemsCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTreeGetItemsCount.GetAllParamsCount

function TkwTreeGetItemsCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner)]);
end;//TkwTreeGetItemsCount.ParamsTypes

procedure TkwTreeIterateNodes.tree_IterateNodes(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner;
 aLambda: TtfwWord);
 {* ���������� ����� ������� tree:IterateNodes }
//#UC START# *552FEBFF016C_57DF7C56BA33_var*

 function DoItem(const aNode: Il3Node): Boolean;
 begin//DoItem
  Result := false;
  aCtx.rEngine.PushIntf(aNode, TypeInfo(Il3Node));
  aLambda.DoIt(aCtx);
 end;//DoItem
 
//#UC END# *552FEBFF016C_57DF7C56BA33_var*
begin
//#UC START# *552FEBFF016C_57DF7C56BA33_impl*
 try
  aTree.IterateF(l3L2NA(@DoItem), 0);
 except
  on EtfwBreakIterator do ;
 end;//try..except
//#UC END# *552FEBFF016C_57DF7C56BA33_impl*
end;//TkwTreeIterateNodes.tree_IterateNodes

procedure TkwTreeIterateNodes.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
var l_aLambda: TtfwWord;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLambda := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLambda: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 tree_IterateNodes(aCtx, l_aTree, l_aLambda);
end;//TkwTreeIterateNodes.DoDoIt

class function TkwTreeIterateNodes.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:IterateNodes';
end;//TkwTreeIterateNodes.GetWordNameForRegister

function TkwTreeIterateNodes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwTreeIterateNodes.GetResultTypeInfo

function TkwTreeIterateNodes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwTreeIterateNodes.GetAllParamsCount

function TkwTreeIterateNodes.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner), TypeInfo(TtfwWord)]);
end;//TkwTreeIterateNodes.ParamsTypes

procedure TkwTreeSaveState2File.tree_SaveState2File(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner;
 const aFileName: AnsiString);
 {* ���������� ����� ������� tree:SaveState2File }
//#UC START# *552FEC260349_B4D43BCE4979_var*
var
 l_F : Tl3CustomDosFiler;
 
 function lp_IterateNode(const aCurNode : Il3Node) : Boolean;
 var
  i       : Integer;
  l_CStr  : Il3CString;
  l_Name  : AnsiString;
  l_Level : Integer;
 begin
  Result := false;
  l_Name  := '';
  with aTree.CTree do
  begin
   if not aTree.CTree.IsExpanded(aCurNode.ParentNode) then Exit;
   l_Level := GetLevel(aCurNode);
   if ShowRoot then Dec(l_Level);
  end; // with aTreeControl.CTree do
  for i := l_Level downto 2 do
   l_Name := l_Name + '  ';
  l_CStr := l3CStr(aCurNode.Text);
  l3DeleteChars(l_CStr, [cc_SoftEnter, cc_HardEnter, cc_SoftSpace]);
  l_Name := Format('%s%s - Flags: %d', [l_Name, l3Str(l_CStr), aCurNode.Flags]);
  l_F.WriteLn(l_Name);
 end;

var
 l_S : AnsiString;
//#UC END# *552FEC260349_B4D43BCE4979_var*
begin
//#UC START# *552FEC260349_B4D43BCE4979_impl*
 l_S := aCtx.rCaller.ResolveOutputFilePath(aFileName);
 l_S := ChangeFileExt(l_S, '.tree');
 l_F := Tl3CustomDosFiler.Make(l_S, l3_fmWrite, false);
 try
  l_F.Open;
  aTree.CTree.CRootNode.IterateF(l3L2NA(@lp_IterateNode), imExpandOnly);
  l_F.Close;
 finally
  FreeAndNil(l_F);
 end;//try..finally
//#UC END# *552FEC260349_B4D43BCE4979_impl*
end;//TkwTreeSaveState2File.tree_SaveState2File

procedure TkwTreeSaveState2File.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
var l_aFileName: AnsiString;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFileName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFileName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 tree_SaveState2File(aCtx, l_aTree, l_aFileName);
end;//TkwTreeSaveState2File.DoDoIt

class function TkwTreeSaveState2File.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:SaveState2File';
end;//TkwTreeSaveState2File.GetWordNameForRegister

function TkwTreeSaveState2File.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwTreeSaveState2File.GetResultTypeInfo

function TkwTreeSaveState2File.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwTreeSaveState2File.GetAllParamsCount

function TkwTreeSaveState2File.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner), @tfw_tiString]);
end;//TkwTreeSaveState2File.ParamsTypes

function TkwTreeChildrenCount.tree_ChildrenCount(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner;
 anIndex: Integer): Integer;
 {* ���������� ����� ������� tree:ChildrenCount }
//#UC START# *552FF5F001F8_015D1248A6CF_var*
//#UC END# *552FF5F001F8_015D1248A6CF_var*
begin
//#UC START# *552FF5F001F8_015D1248A6CF_impl*
 Result := aTree.GetNode(anIndex).ThisChildrenCount;
//#UC END# *552FF5F001F8_015D1248A6CF_impl*
end;//TkwTreeChildrenCount.tree_ChildrenCount

procedure TkwTreeChildrenCount.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
var l_anIndex: Integer;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(tree_ChildrenCount(aCtx, l_aTree, l_anIndex));
end;//TkwTreeChildrenCount.DoDoIt

class function TkwTreeChildrenCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:ChildrenCount';
end;//TkwTreeChildrenCount.GetWordNameForRegister

function TkwTreeChildrenCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwTreeChildrenCount.GetResultTypeInfo

function TkwTreeChildrenCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwTreeChildrenCount.GetAllParamsCount

function TkwTreeChildrenCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner), TypeInfo(Integer)]);
end;//TkwTreeChildrenCount.ParamsTypes

procedure TkwTreeExpand.tree_expand(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner;
 anIndex: Integer);
 {* ���������� ����� ������� tree:���������� }
//#UC START# *552FF61301F5_B776D637E7D3_var*
//#UC END# *552FF61301F5_B776D637E7D3_var*
begin
//#UC START# *552FF61301F5_B776D637E7D3_impl*
 aTree.ExpandNode(aTree.GetNode(anIndex), True);
//#UC END# *552FF61301F5_B776D637E7D3_impl*
end;//TkwTreeExpand.tree_expand

procedure TkwTreeExpand.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
var l_anIndex: Integer;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 tree_expand(aCtx, l_aTree, l_anIndex);
end;//TkwTreeExpand.DoDoIt

class function TkwTreeExpand.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:����������';
end;//TkwTreeExpand.GetWordNameForRegister

function TkwTreeExpand.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwTreeExpand.GetResultTypeInfo

function TkwTreeExpand.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwTreeExpand.GetAllParamsCount

function TkwTreeExpand.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner), TypeInfo(Integer)]);
end;//TkwTreeExpand.ParamsTypes

function TkwTreeGetItemHeight.tree_GetItem_Height(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner;
 anIndex: Integer): Integer;
 {* ���������� ����� ������� tree:GetItem:Height }
//#UC START# *552FF6740129_62AE36AC72B7_var*
//#UC END# *552FF6740129_62AE36AC72B7_var*
begin
//#UC START# *552FF6740129_62AE36AC72B7_impl*
 with TvtCustomOutlinerFriend(aTree).GetDrawRect(anIndex) do
  Result := (Bottom - Top);
//#UC END# *552FF6740129_62AE36AC72B7_impl*
end;//TkwTreeGetItemHeight.tree_GetItem_Height

procedure TkwTreeGetItemHeight.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
var l_anIndex: Integer;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(tree_GetItem_Height(aCtx, l_aTree, l_anIndex));
end;//TkwTreeGetItemHeight.DoDoIt

class function TkwTreeGetItemHeight.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:GetItem:Height';
end;//TkwTreeGetItemHeight.GetWordNameForRegister

function TkwTreeGetItemHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwTreeGetItemHeight.GetResultTypeInfo

function TkwTreeGetItemHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwTreeGetItemHeight.GetAllParamsCount

function TkwTreeGetItemHeight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner), TypeInfo(Integer)]);
end;//TkwTreeGetItemHeight.ParamsTypes

function TkwTreeGetItemImageIndex.tree_GetItemImageIndex(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner;
 anIndex: Integer): Integer;
 {* ���������� ����� ������� tree:GetItemImageIndex }
//#UC START# *552FF69A0228_A8F9DB23E07A_var*
var
 l_IL: TCustomImageList;
//#UC END# *552FF69A0228_A8F9DB23E07A_var*
begin
//#UC START# *552FF69A0228_A8F9DB23E07A_impl*
 if Assigned(aTree.OnGetItemImage) then
  Result := aTree.OnGetItemImage(aTree, anIndex, l_IL)
 else
  Result := vtItemWithoutImage;
//#UC END# *552FF69A0228_A8F9DB23E07A_impl*
end;//TkwTreeGetItemImageIndex.tree_GetItemImageIndex

procedure TkwTreeGetItemImageIndex.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
var l_anIndex: Integer;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(tree_GetItemImageIndex(aCtx, l_aTree, l_anIndex));
end;//TkwTreeGetItemImageIndex.DoDoIt

class function TkwTreeGetItemImageIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:GetItemImageIndex';
end;//TkwTreeGetItemImageIndex.GetWordNameForRegister

function TkwTreeGetItemImageIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwTreeGetItemImageIndex.GetResultTypeInfo

function TkwTreeGetItemImageIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwTreeGetItemImageIndex.GetAllParamsCount

function TkwTreeGetItemImageIndex.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner), TypeInfo(Integer)]);
end;//TkwTreeGetItemImageIndex.ParamsTypes

function TkwTreeGetItemLeft.tree_GetItem_Left(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner;
 anIndex: Integer): Integer;
 {* ���������� ����� ������� tree:GetItem:Left }
//#UC START# *552FF6CC0186_6CAA56491F95_var*
//#UC END# *552FF6CC0186_6CAA56491F95_var*
begin
//#UC START# *552FF6CC0186_6CAA56491F95_impl*
 with TvtCustomOutlinerFriend(aTree).GetDrawRect(anIndex) do
  Result := Left;
//#UC END# *552FF6CC0186_6CAA56491F95_impl*
end;//TkwTreeGetItemLeft.tree_GetItem_Left

procedure TkwTreeGetItemLeft.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
var l_anIndex: Integer;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(tree_GetItem_Left(aCtx, l_aTree, l_anIndex));
end;//TkwTreeGetItemLeft.DoDoIt

class function TkwTreeGetItemLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:GetItem:Left';
end;//TkwTreeGetItemLeft.GetWordNameForRegister

function TkwTreeGetItemLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwTreeGetItemLeft.GetResultTypeInfo

function TkwTreeGetItemLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwTreeGetItemLeft.GetAllParamsCount

function TkwTreeGetItemLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner), TypeInfo(Integer)]);
end;//TkwTreeGetItemLeft.ParamsTypes

function TkwTreeGetItemTop.tree_GetItem_Top(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner;
 anIndex: Integer): Integer;
 {* ���������� ����� ������� tree:GetItem:Top }
//#UC START# *552FF6F802D9_5F6D76A66CAD_var*
//#UC END# *552FF6F802D9_5F6D76A66CAD_var*
begin
//#UC START# *552FF6F802D9_5F6D76A66CAD_impl*
 with TvtCustomOutlinerFriend(aTree).GetDrawRect(anIndex) do
  Result := Top;
//#UC END# *552FF6F802D9_5F6D76A66CAD_impl*
end;//TkwTreeGetItemTop.tree_GetItem_Top

procedure TkwTreeGetItemTop.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
var l_anIndex: Integer;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(tree_GetItem_Top(aCtx, l_aTree, l_anIndex));
end;//TkwTreeGetItemTop.DoDoIt

class function TkwTreeGetItemTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:GetItem:Top';
end;//TkwTreeGetItemTop.GetWordNameForRegister

function TkwTreeGetItemTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwTreeGetItemTop.GetResultTypeInfo

function TkwTreeGetItemTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwTreeGetItemTop.GetAllParamsCount

function TkwTreeGetItemTop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner), TypeInfo(Integer)]);
end;//TkwTreeGetItemTop.ParamsTypes

function TkwTreeGetItemWidth.tree_GetItem_Width(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner;
 anIndex: Integer): Integer;
 {* ���������� ����� ������� tree:GetItem:Width }
//#UC START# *552FF71D00BE_645DA96C0332_var*
//#UC END# *552FF71D00BE_645DA96C0332_var*
begin
//#UC START# *552FF71D00BE_645DA96C0332_impl*
 with TvtCustomOutlinerFriend(aTree).GetDrawRect(anIndex) do
  Result := (Right - Left);
//#UC END# *552FF71D00BE_645DA96C0332_impl*
end;//TkwTreeGetItemWidth.tree_GetItem_Width

procedure TkwTreeGetItemWidth.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
var l_anIndex: Integer;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(tree_GetItem_Width(aCtx, l_aTree, l_anIndex));
end;//TkwTreeGetItemWidth.DoDoIt

class function TkwTreeGetItemWidth.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:GetItem:Width';
end;//TkwTreeGetItemWidth.GetWordNameForRegister

function TkwTreeGetItemWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwTreeGetItemWidth.GetResultTypeInfo

function TkwTreeGetItemWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwTreeGetItemWidth.GetAllParamsCount

function TkwTreeGetItemWidth.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner), TypeInfo(Integer)]);
end;//TkwTreeGetItemWidth.ParamsTypes

function TkwTreeGetSelected.tree_GetSelected(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner;
 anIndex: Integer): Boolean;
 {* ���������� ����� ������� tree:GetSelected }
//#UC START# *552FF745039F_5AEA5F2D19AB_var*
//#UC END# *552FF745039F_5AEA5F2D19AB_var*
begin
//#UC START# *552FF745039F_5AEA5F2D19AB_impl*
 Result := aTree.Selected[anIndex];
//#UC END# *552FF745039F_5AEA5F2D19AB_impl*
end;//TkwTreeGetSelected.tree_GetSelected

procedure TkwTreeGetSelected.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
var l_anIndex: Integer;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(tree_GetSelected(aCtx, l_aTree, l_anIndex));
end;//TkwTreeGetSelected.DoDoIt

class function TkwTreeGetSelected.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:GetSelected';
end;//TkwTreeGetSelected.GetWordNameForRegister

function TkwTreeGetSelected.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwTreeGetSelected.GetResultTypeInfo

function TkwTreeGetSelected.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwTreeGetSelected.GetAllParamsCount

function TkwTreeGetSelected.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner), TypeInfo(Integer)]);
end;//TkwTreeGetSelected.ParamsTypes

procedure TkwTreeSetSelected.tree_SetSelected(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner;
 anIndex: Integer;
 aValue: Boolean);
 {* ���������� ����� ������� tree:SetSelected }
//#UC START# *552FF76C0114_017A97801F00_var*
//#UC END# *552FF76C0114_017A97801F00_var*
begin
//#UC START# *552FF76C0114_017A97801F00_impl*
 aTree.Selected[anIndex] := aValue;
//#UC END# *552FF76C0114_017A97801F00_impl*
end;//TkwTreeSetSelected.tree_SetSelected

procedure TkwTreeSetSelected.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
var l_anIndex: Integer;
var l_aValue: Boolean;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 tree_SetSelected(aCtx, l_aTree, l_anIndex, l_aValue);
end;//TkwTreeSetSelected.DoDoIt

class function TkwTreeSetSelected.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:SetSelected';
end;//TkwTreeSetSelected.GetWordNameForRegister

function TkwTreeSetSelected.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwTreeSetSelected.GetResultTypeInfo

function TkwTreeSetSelected.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwTreeSetSelected.GetAllParamsCount

function TkwTreeSetSelected.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner), TypeInfo(Integer), TypeInfo(Boolean)]);
end;//TkwTreeSetSelected.ParamsTypes

procedure TkwTreeCollapse.tree_collapse(const aCtx: TtfwContext;
 aTree: TvtCustomOutliner;
 anIndex: Integer);
 {* ���������� ����� ������� tree:�������� }
//#UC START# *5530E0B20024_9749EACE054F_var*
//#UC END# *5530E0B20024_9749EACE054F_var*
begin
//#UC START# *5530E0B20024_9749EACE054F_impl*
 aTree.ExpandNode(aTree.GetNode(anIndex), false);
//#UC END# *5530E0B20024_9749EACE054F_impl*
end;//TkwTreeCollapse.tree_collapse

procedure TkwTreeCollapse.DoDoIt(const aCtx: TtfwContext);
var l_aTree: TvtCustomOutliner;
var l_anIndex: Integer;
begin
 try
  l_aTree := TvtCustomOutliner(aCtx.rEngine.PopObjAs(TvtCustomOutliner));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTree: TvtCustomOutliner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 tree_collapse(aCtx, l_aTree, l_anIndex);
end;//TkwTreeCollapse.DoDoIt

class function TkwTreeCollapse.GetWordNameForRegister: AnsiString;
begin
 Result := 'tree:��������';
end;//TkwTreeCollapse.GetWordNameForRegister

function TkwTreeCollapse.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwTreeCollapse.GetResultTypeInfo

function TkwTreeCollapse.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwTreeCollapse.GetAllParamsCount

function TkwTreeCollapse.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomOutliner), TypeInfo(Integer)]);
end;//TkwTreeCollapse.ParamsTypes

class function TvtOutlinerWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'vtOutlinerWordsPack';
end;//TvtOutlinerWordsPackResNameGetter.ResName

 {$R vtOutlinerWordsPack.res}

initialization
 TkwTreeCheckFlag.RegisterInEngine;
 {* ����������� tree_CheckFlag }
 TkwTreeCollapseAll.RegisterInEngine;
 {* ����������� tree_CollapseAll }
 TkwTreeCurrentNodeIsExpanded.RegisterInEngine;
 {* ����������� tree_CurrentNode_IsExpanded }
 TkwTreeDeleteAllChildren.RegisterInEngine;
 {* ����������� tree_DeleteAllChildren }
 TkwTreeExpandAll.RegisterInEngine;
 {* ����������� tree_ExpandAll }
 TkwTreeCurrentNode.RegisterInEngine;
 {* ����������� tree_CurrentNode }
 TkwTreeGetItem.RegisterInEngine;
 {* ����������� tree_GetItem }
 TkwTreeGetItemsCount.RegisterInEngine;
 {* ����������� tree_GetItemsCount }
 TkwTreeIterateNodes.RegisterInEngine;
 {* ����������� tree_IterateNodes }
 TkwTreeSaveState2File.RegisterInEngine;
 {* ����������� tree_SaveState2File }
 TkwTreeChildrenCount.RegisterInEngine;
 {* ����������� tree_ChildrenCount }
 TkwTreeExpand.RegisterInEngine;
 {* ����������� tree_expand }
 TkwTreeGetItemHeight.RegisterInEngine;
 {* ����������� tree_GetItem_Height }
 TkwTreeGetItemImageIndex.RegisterInEngine;
 {* ����������� tree_GetItemImageIndex }
 TkwTreeGetItemLeft.RegisterInEngine;
 {* ����������� tree_GetItem_Left }
 TkwTreeGetItemTop.RegisterInEngine;
 {* ����������� tree_GetItem_Top }
 TkwTreeGetItemWidth.RegisterInEngine;
 {* ����������� tree_GetItem_Width }
 TkwTreeGetSelected.RegisterInEngine;
 {* ����������� tree_GetSelected }
 TkwTreeSetSelected.RegisterInEngine;
 {* ����������� tree_SetSelected }
 TkwTreeCollapse.RegisterInEngine;
 {* ����������� tree_collapse }
 TvtOutlinerWordsPackResNameGetter.Register;
 {* ����������� ������������ ����������� }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCustomOutliner));
 {* ����������� ���� TvtCustomOutliner }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3SimpleNode));
 {* ����������� ���� Il3SimpleNode }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* ����������� ���� Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* ����������� ���� TtfwWord }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� AnsiString }
{$IfEnd} // NOT Defined(NoScripts)

end.
