unit TreeNodeWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\TreeNodeWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "TreeNodeWordsPack" MUID: (55C9CBB10045)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , ComCtrls
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopTreeNodeGetNext = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetNext }
  private
   function GetNext(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): TTreeNode;
    {* Реализация слова скрипта pop:TreeNode:GetNext }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeGetNext

 TkwPopTreeNodeHasChildren = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:HasChildren }
  private
   function HasChildren(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): Boolean;
    {* Реализация слова скрипта pop:TreeNode:HasChildren }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeHasChildren

 TkwPopTreeNodeGetPrev = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetPrev }
  private
   function GetPrev(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): TTreeNode;
    {* Реализация слова скрипта pop:TreeNode:GetPrev }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeGetPrev

 TkwPopTreeNodeGetFirstChild = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetFirstChild }
  private
   function GetFirstChild(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): TTreeNode;
    {* Реализация слова скрипта pop:TreeNode:GetFirstChild }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeGetFirstChild

 TkwPopTreeNodeGetLastChild = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetLastChild }
  private
   function GetLastChild(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): TTreeNode;
    {* Реализация слова скрипта pop:TreeNode:GetLastChild }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeGetLastChild

 TkwPopTreeNodeGetNextSibling = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetNextSibling }
  private
   function GetNextSibling(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): TTreeNode;
    {* Реализация слова скрипта pop:TreeNode:GetNextSibling }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeGetNextSibling

 TkwPopTreeNodeGetPrevSibling = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetPrevSibling }
  private
   function GetPrevSibling(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): TTreeNode;
    {* Реализация слова скрипта pop:TreeNode:GetPrevSibling }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeGetPrevSibling

 TkwPopTreeNodeGetNextVisible = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetNextVisible }
  private
   function GetNextVisible(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): TTreeNode;
    {* Реализация слова скрипта pop:TreeNode:GetNextVisible }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeGetNextVisible

 TkwPopTreeNodeGetPrevVisible = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetPrevVisible }
  private
   function GetPrevVisible(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): TTreeNode;
    {* Реализация слова скрипта pop:TreeNode:GetPrevVisible }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeGetPrevVisible

 TkwPopTreeNodeExpand = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:Expand }
  private
   procedure Expand(const aCtx: TtfwContext;
    aTreeNode: TTreeNode;
    aRecurse: Boolean);
    {* Реализация слова скрипта pop:TreeNode:Expand }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeExpand

function TkwPopTreeNodeGetNext.GetNext(const aCtx: TtfwContext;
 aTreeNode: TTreeNode): TTreeNode;
 {* Реализация слова скрипта pop:TreeNode:GetNext }
//#UC START# *55C9CBEB0063_55C9CBEB0063_512F3FCB02F3_Word_var*
//#UC END# *55C9CBEB0063_55C9CBEB0063_512F3FCB02F3_Word_var*
begin
//#UC START# *55C9CBEB0063_55C9CBEB0063_512F3FCB02F3_Word_impl*
 Result := aTreeNode.GetNext;
//#UC END# *55C9CBEB0063_55C9CBEB0063_512F3FCB02F3_Word_impl*
end;//TkwPopTreeNodeGetNext.GetNext

class function TkwPopTreeNodeGetNext.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TreeNode:GetNext';
end;//TkwPopTreeNodeGetNext.GetWordNameForRegister

function TkwPopTreeNodeGetNext.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeNodeGetNext.GetResultTypeInfo

function TkwPopTreeNodeGetNext.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTreeNodeGetNext.GetAllParamsCount

function TkwPopTreeNodeGetNext.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeGetNext.ParamsTypes

procedure TkwPopTreeNodeGetNext.DoDoIt(const aCtx: TtfwContext);
var l_aTreeNode: TTreeNode;
begin
 try
  l_aTreeNode := TTreeNode(aCtx.rEngine.PopObjAs(TTreeNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTreeNode: TTreeNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetNext(aCtx, l_aTreeNode));
end;//TkwPopTreeNodeGetNext.DoDoIt

function TkwPopTreeNodeHasChildren.HasChildren(const aCtx: TtfwContext;
 aTreeNode: TTreeNode): Boolean;
 {* Реализация слова скрипта pop:TreeNode:HasChildren }
//#UC START# *55C9CBF80354_55C9CBF80354_512F3FCB02F3_Word_var*
//#UC END# *55C9CBF80354_55C9CBF80354_512F3FCB02F3_Word_var*
begin
//#UC START# *55C9CBF80354_55C9CBF80354_512F3FCB02F3_Word_impl*
 Result := aTreeNode.HasChildren;
//#UC END# *55C9CBF80354_55C9CBF80354_512F3FCB02F3_Word_impl*
end;//TkwPopTreeNodeHasChildren.HasChildren

class function TkwPopTreeNodeHasChildren.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TreeNode:HasChildren';
end;//TkwPopTreeNodeHasChildren.GetWordNameForRegister

function TkwPopTreeNodeHasChildren.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopTreeNodeHasChildren.GetResultTypeInfo

function TkwPopTreeNodeHasChildren.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTreeNodeHasChildren.GetAllParamsCount

function TkwPopTreeNodeHasChildren.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeHasChildren.ParamsTypes

procedure TkwPopTreeNodeHasChildren.DoDoIt(const aCtx: TtfwContext);
var l_aTreeNode: TTreeNode;
begin
 try
  l_aTreeNode := TTreeNode(aCtx.rEngine.PopObjAs(TTreeNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTreeNode: TTreeNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(HasChildren(aCtx, l_aTreeNode));
end;//TkwPopTreeNodeHasChildren.DoDoIt

function TkwPopTreeNodeGetPrev.GetPrev(const aCtx: TtfwContext;
 aTreeNode: TTreeNode): TTreeNode;
 {* Реализация слова скрипта pop:TreeNode:GetPrev }
//#UC START# *55C9D4D302CC_55C9D4D302CC_512F3FCB02F3_Word_var*
//#UC END# *55C9D4D302CC_55C9D4D302CC_512F3FCB02F3_Word_var*
begin
//#UC START# *55C9D4D302CC_55C9D4D302CC_512F3FCB02F3_Word_impl*
 Result := aTreeNode.GetPrev;
//#UC END# *55C9D4D302CC_55C9D4D302CC_512F3FCB02F3_Word_impl*
end;//TkwPopTreeNodeGetPrev.GetPrev

class function TkwPopTreeNodeGetPrev.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TreeNode:GetPrev';
end;//TkwPopTreeNodeGetPrev.GetWordNameForRegister

function TkwPopTreeNodeGetPrev.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeNodeGetPrev.GetResultTypeInfo

function TkwPopTreeNodeGetPrev.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTreeNodeGetPrev.GetAllParamsCount

function TkwPopTreeNodeGetPrev.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeGetPrev.ParamsTypes

procedure TkwPopTreeNodeGetPrev.DoDoIt(const aCtx: TtfwContext);
var l_aTreeNode: TTreeNode;
begin
 try
  l_aTreeNode := TTreeNode(aCtx.rEngine.PopObjAs(TTreeNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTreeNode: TTreeNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetPrev(aCtx, l_aTreeNode));
end;//TkwPopTreeNodeGetPrev.DoDoIt

function TkwPopTreeNodeGetFirstChild.GetFirstChild(const aCtx: TtfwContext;
 aTreeNode: TTreeNode): TTreeNode;
 {* Реализация слова скрипта pop:TreeNode:GetFirstChild }
//#UC START# *55C9D4EA0111_55C9D4EA0111_512F3FCB02F3_Word_var*
//#UC END# *55C9D4EA0111_55C9D4EA0111_512F3FCB02F3_Word_var*
begin
//#UC START# *55C9D4EA0111_55C9D4EA0111_512F3FCB02F3_Word_impl*
 Result := aTreeNode.GetFirstChild; 
//#UC END# *55C9D4EA0111_55C9D4EA0111_512F3FCB02F3_Word_impl*
end;//TkwPopTreeNodeGetFirstChild.GetFirstChild

class function TkwPopTreeNodeGetFirstChild.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TreeNode:GetFirstChild';
end;//TkwPopTreeNodeGetFirstChild.GetWordNameForRegister

function TkwPopTreeNodeGetFirstChild.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeNodeGetFirstChild.GetResultTypeInfo

function TkwPopTreeNodeGetFirstChild.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTreeNodeGetFirstChild.GetAllParamsCount

function TkwPopTreeNodeGetFirstChild.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeGetFirstChild.ParamsTypes

procedure TkwPopTreeNodeGetFirstChild.DoDoIt(const aCtx: TtfwContext);
var l_aTreeNode: TTreeNode;
begin
 try
  l_aTreeNode := TTreeNode(aCtx.rEngine.PopObjAs(TTreeNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTreeNode: TTreeNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetFirstChild(aCtx, l_aTreeNode));
end;//TkwPopTreeNodeGetFirstChild.DoDoIt

function TkwPopTreeNodeGetLastChild.GetLastChild(const aCtx: TtfwContext;
 aTreeNode: TTreeNode): TTreeNode;
 {* Реализация слова скрипта pop:TreeNode:GetLastChild }
//#UC START# *55C9D4FD035F_55C9D4FD035F_512F3FCB02F3_Word_var*
//#UC END# *55C9D4FD035F_55C9D4FD035F_512F3FCB02F3_Word_var*
begin
//#UC START# *55C9D4FD035F_55C9D4FD035F_512F3FCB02F3_Word_impl*
 Result := aTreeNode.GetLastChild;
//#UC END# *55C9D4FD035F_55C9D4FD035F_512F3FCB02F3_Word_impl*
end;//TkwPopTreeNodeGetLastChild.GetLastChild

class function TkwPopTreeNodeGetLastChild.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TreeNode:GetLastChild';
end;//TkwPopTreeNodeGetLastChild.GetWordNameForRegister

function TkwPopTreeNodeGetLastChild.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeNodeGetLastChild.GetResultTypeInfo

function TkwPopTreeNodeGetLastChild.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTreeNodeGetLastChild.GetAllParamsCount

function TkwPopTreeNodeGetLastChild.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeGetLastChild.ParamsTypes

procedure TkwPopTreeNodeGetLastChild.DoDoIt(const aCtx: TtfwContext);
var l_aTreeNode: TTreeNode;
begin
 try
  l_aTreeNode := TTreeNode(aCtx.rEngine.PopObjAs(TTreeNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTreeNode: TTreeNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetLastChild(aCtx, l_aTreeNode));
end;//TkwPopTreeNodeGetLastChild.DoDoIt

function TkwPopTreeNodeGetNextSibling.GetNextSibling(const aCtx: TtfwContext;
 aTreeNode: TTreeNode): TTreeNode;
 {* Реализация слова скрипта pop:TreeNode:GetNextSibling }
//#UC START# *55C9D5BB0220_55C9D5BB0220_512F3FCB02F3_Word_var*
//#UC END# *55C9D5BB0220_55C9D5BB0220_512F3FCB02F3_Word_var*
begin
//#UC START# *55C9D5BB0220_55C9D5BB0220_512F3FCB02F3_Word_impl*
 Result := aTreeNode.GetNextSibling;
//#UC END# *55C9D5BB0220_55C9D5BB0220_512F3FCB02F3_Word_impl*
end;//TkwPopTreeNodeGetNextSibling.GetNextSibling

class function TkwPopTreeNodeGetNextSibling.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TreeNode:GetNextSibling';
end;//TkwPopTreeNodeGetNextSibling.GetWordNameForRegister

function TkwPopTreeNodeGetNextSibling.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeNodeGetNextSibling.GetResultTypeInfo

function TkwPopTreeNodeGetNextSibling.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTreeNodeGetNextSibling.GetAllParamsCount

function TkwPopTreeNodeGetNextSibling.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeGetNextSibling.ParamsTypes

procedure TkwPopTreeNodeGetNextSibling.DoDoIt(const aCtx: TtfwContext);
var l_aTreeNode: TTreeNode;
begin
 try
  l_aTreeNode := TTreeNode(aCtx.rEngine.PopObjAs(TTreeNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTreeNode: TTreeNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetNextSibling(aCtx, l_aTreeNode));
end;//TkwPopTreeNodeGetNextSibling.DoDoIt

function TkwPopTreeNodeGetPrevSibling.GetPrevSibling(const aCtx: TtfwContext;
 aTreeNode: TTreeNode): TTreeNode;
 {* Реализация слова скрипта pop:TreeNode:GetPrevSibling }
//#UC START# *55C9D5D00259_55C9D5D00259_512F3FCB02F3_Word_var*
//#UC END# *55C9D5D00259_55C9D5D00259_512F3FCB02F3_Word_var*
begin
//#UC START# *55C9D5D00259_55C9D5D00259_512F3FCB02F3_Word_impl*
 Result := aTreeNode.GetPrevSibling;
//#UC END# *55C9D5D00259_55C9D5D00259_512F3FCB02F3_Word_impl*
end;//TkwPopTreeNodeGetPrevSibling.GetPrevSibling

class function TkwPopTreeNodeGetPrevSibling.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TreeNode:GetPrevSibling';
end;//TkwPopTreeNodeGetPrevSibling.GetWordNameForRegister

function TkwPopTreeNodeGetPrevSibling.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeNodeGetPrevSibling.GetResultTypeInfo

function TkwPopTreeNodeGetPrevSibling.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTreeNodeGetPrevSibling.GetAllParamsCount

function TkwPopTreeNodeGetPrevSibling.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeGetPrevSibling.ParamsTypes

procedure TkwPopTreeNodeGetPrevSibling.DoDoIt(const aCtx: TtfwContext);
var l_aTreeNode: TTreeNode;
begin
 try
  l_aTreeNode := TTreeNode(aCtx.rEngine.PopObjAs(TTreeNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTreeNode: TTreeNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetPrevSibling(aCtx, l_aTreeNode));
end;//TkwPopTreeNodeGetPrevSibling.DoDoIt

function TkwPopTreeNodeGetNextVisible.GetNextVisible(const aCtx: TtfwContext;
 aTreeNode: TTreeNode): TTreeNode;
 {* Реализация слова скрипта pop:TreeNode:GetNextVisible }
//#UC START# *55C9D5F401A4_55C9D5F401A4_512F3FCB02F3_Word_var*
//#UC END# *55C9D5F401A4_55C9D5F401A4_512F3FCB02F3_Word_var*
begin
//#UC START# *55C9D5F401A4_55C9D5F401A4_512F3FCB02F3_Word_impl*
 Result := aTreeNode.GetNextVisible;
//#UC END# *55C9D5F401A4_55C9D5F401A4_512F3FCB02F3_Word_impl*
end;//TkwPopTreeNodeGetNextVisible.GetNextVisible

class function TkwPopTreeNodeGetNextVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TreeNode:GetNextVisible';
end;//TkwPopTreeNodeGetNextVisible.GetWordNameForRegister

function TkwPopTreeNodeGetNextVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeNodeGetNextVisible.GetResultTypeInfo

function TkwPopTreeNodeGetNextVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTreeNodeGetNextVisible.GetAllParamsCount

function TkwPopTreeNodeGetNextVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeGetNextVisible.ParamsTypes

procedure TkwPopTreeNodeGetNextVisible.DoDoIt(const aCtx: TtfwContext);
var l_aTreeNode: TTreeNode;
begin
 try
  l_aTreeNode := TTreeNode(aCtx.rEngine.PopObjAs(TTreeNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTreeNode: TTreeNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetNextVisible(aCtx, l_aTreeNode));
end;//TkwPopTreeNodeGetNextVisible.DoDoIt

function TkwPopTreeNodeGetPrevVisible.GetPrevVisible(const aCtx: TtfwContext;
 aTreeNode: TTreeNode): TTreeNode;
 {* Реализация слова скрипта pop:TreeNode:GetPrevVisible }
//#UC START# *55C9D6120364_55C9D6120364_512F3FCB02F3_Word_var*
//#UC END# *55C9D6120364_55C9D6120364_512F3FCB02F3_Word_var*
begin
//#UC START# *55C9D6120364_55C9D6120364_512F3FCB02F3_Word_impl*
 Result := aTreeNode.GetPrevVisible;
//#UC END# *55C9D6120364_55C9D6120364_512F3FCB02F3_Word_impl*
end;//TkwPopTreeNodeGetPrevVisible.GetPrevVisible

class function TkwPopTreeNodeGetPrevVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TreeNode:GetPrevVisible';
end;//TkwPopTreeNodeGetPrevVisible.GetWordNameForRegister

function TkwPopTreeNodeGetPrevVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeNodeGetPrevVisible.GetResultTypeInfo

function TkwPopTreeNodeGetPrevVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTreeNodeGetPrevVisible.GetAllParamsCount

function TkwPopTreeNodeGetPrevVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeGetPrevVisible.ParamsTypes

procedure TkwPopTreeNodeGetPrevVisible.DoDoIt(const aCtx: TtfwContext);
var l_aTreeNode: TTreeNode;
begin
 try
  l_aTreeNode := TTreeNode(aCtx.rEngine.PopObjAs(TTreeNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTreeNode: TTreeNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetPrevVisible(aCtx, l_aTreeNode));
end;//TkwPopTreeNodeGetPrevVisible.DoDoIt

procedure TkwPopTreeNodeExpand.Expand(const aCtx: TtfwContext;
 aTreeNode: TTreeNode;
 aRecurse: Boolean);
 {* Реализация слова скрипта pop:TreeNode:Expand }
//#UC START# *55C9D632015E_55C9D632015E_512F3FCB02F3_Word_var*
//#UC END# *55C9D632015E_55C9D632015E_512F3FCB02F3_Word_var*
begin
//#UC START# *55C9D632015E_55C9D632015E_512F3FCB02F3_Word_impl*
 aTreeNode.Expand(aRecurse);
//#UC END# *55C9D632015E_55C9D632015E_512F3FCB02F3_Word_impl*
end;//TkwPopTreeNodeExpand.Expand

class function TkwPopTreeNodeExpand.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TreeNode:Expand';
end;//TkwPopTreeNodeExpand.GetWordNameForRegister

function TkwPopTreeNodeExpand.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopTreeNodeExpand.GetResultTypeInfo

function TkwPopTreeNodeExpand.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopTreeNodeExpand.GetAllParamsCount

function TkwPopTreeNodeExpand.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode), TypeInfo(Boolean)]);
end;//TkwPopTreeNodeExpand.ParamsTypes

procedure TkwPopTreeNodeExpand.DoDoIt(const aCtx: TtfwContext);
var l_aTreeNode: TTreeNode;
var l_aRecurse: Boolean;
begin
 try
  l_aTreeNode := TTreeNode(aCtx.rEngine.PopObjAs(TTreeNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTreeNode: TTreeNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aRecurse := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRecurse: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Expand(aCtx, l_aTreeNode, l_aRecurse);
end;//TkwPopTreeNodeExpand.DoDoIt

initialization
 TkwPopTreeNodeGetNext.RegisterInEngine;
 {* Регистрация pop_TreeNode_GetNext }
 TkwPopTreeNodeHasChildren.RegisterInEngine;
 {* Регистрация pop_TreeNode_HasChildren }
 TkwPopTreeNodeGetPrev.RegisterInEngine;
 {* Регистрация pop_TreeNode_GetPrev }
 TkwPopTreeNodeGetFirstChild.RegisterInEngine;
 {* Регистрация pop_TreeNode_GetFirstChild }
 TkwPopTreeNodeGetLastChild.RegisterInEngine;
 {* Регистрация pop_TreeNode_GetLastChild }
 TkwPopTreeNodeGetNextSibling.RegisterInEngine;
 {* Регистрация pop_TreeNode_GetNextSibling }
 TkwPopTreeNodeGetPrevSibling.RegisterInEngine;
 {* Регистрация pop_TreeNode_GetPrevSibling }
 TkwPopTreeNodeGetNextVisible.RegisterInEngine;
 {* Регистрация pop_TreeNode_GetNextVisible }
 TkwPopTreeNodeGetPrevVisible.RegisterInEngine;
 {* Регистрация pop_TreeNode_GetPrevVisible }
 TkwPopTreeNodeExpand.RegisterInEngine;
 {* Регистрация pop_TreeNode_Expand }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTreeNode));
 {* Регистрация типа TTreeNode }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
