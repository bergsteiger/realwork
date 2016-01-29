unit TreeNodeWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$RTLandVCL"
// Модуль: "TreeNodeWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$RTLandVCL::TreeViewWords::TreeNodeWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  ComCtrls,
  tfwScriptingInterfaces,
  tfwClassLike
  ;

{$IfEnd} //not NoScripts AND not NoVCL

implementation

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopTreeNodeGetNext = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetNext
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetNext >>> l_TTreeNode
[code]  }
 private
 // private methods
   function GetNext(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): TTreeNode;
     {* Реализация слова скрипта pop:TreeNode:GetNext }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeGetNext

// start class TkwPopTreeNodeGetNext

function TkwPopTreeNodeGetNext.GetNext(const aCtx: TtfwContext;
  aTreeNode: TTreeNode): TTreeNode;
//#UC START# *F036C8335C15_A78303612230_var*
//#UC END# *F036C8335C15_A78303612230_var*
begin
//#UC START# *F036C8335C15_A78303612230_impl*
 Result := aTreeNode.GetNext;
//#UC END# *F036C8335C15_A78303612230_impl*
end;//TkwPopTreeNodeGetNext.GetNext

procedure TkwPopTreeNodeGetNext.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTreeNode : TTreeNode;
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
 aCtx.rEngine.PushObj((GetNext(aCtx, l_aTreeNode)));
end;//TkwPopTreeNodeGetNext.DoDoIt

class function TkwPopTreeNodeGetNext.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:TreeNode:GetNext';
end;//TkwPopTreeNodeGetNext.GetWordNameForRegister

function TkwPopTreeNodeGetNext.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeNodeGetNext.GetResultTypeInfo

function TkwPopTreeNodeGetNext.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopTreeNodeGetNext.GetAllParamsCount

function TkwPopTreeNodeGetNext.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeGetNext.ParamsTypes

type
 TkwPopTreeNodeHasChildren = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:HasChildren
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTreeNode pop:TreeNode:HasChildren >>> l_Boolean
[code]  }
 private
 // private methods
   function HasChildren(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): Boolean;
     {* Реализация слова скрипта pop:TreeNode:HasChildren }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeHasChildren

// start class TkwPopTreeNodeHasChildren

function TkwPopTreeNodeHasChildren.HasChildren(const aCtx: TtfwContext;
  aTreeNode: TTreeNode): Boolean;
//#UC START# *A5D06F0C77D0_5E7363490ED0_var*
//#UC END# *A5D06F0C77D0_5E7363490ED0_var*
begin
//#UC START# *A5D06F0C77D0_5E7363490ED0_impl*
 Result := aTreeNode.HasChildren;
//#UC END# *A5D06F0C77D0_5E7363490ED0_impl*
end;//TkwPopTreeNodeHasChildren.HasChildren

procedure TkwPopTreeNodeHasChildren.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTreeNode : TTreeNode;
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
 aCtx.rEngine.PushBool((HasChildren(aCtx, l_aTreeNode)));
end;//TkwPopTreeNodeHasChildren.DoDoIt

class function TkwPopTreeNodeHasChildren.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:TreeNode:HasChildren';
end;//TkwPopTreeNodeHasChildren.GetWordNameForRegister

function TkwPopTreeNodeHasChildren.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopTreeNodeHasChildren.GetResultTypeInfo

function TkwPopTreeNodeHasChildren.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopTreeNodeHasChildren.GetAllParamsCount

function TkwPopTreeNodeHasChildren.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeHasChildren.ParamsTypes

type
 TkwPopTreeNodeGetPrev = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetPrev
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetPrev >>> l_TTreeNode
[code]  }
 private
 // private methods
   function GetPrev(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): TTreeNode;
     {* Реализация слова скрипта pop:TreeNode:GetPrev }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeGetPrev

// start class TkwPopTreeNodeGetPrev

function TkwPopTreeNodeGetPrev.GetPrev(const aCtx: TtfwContext;
  aTreeNode: TTreeNode): TTreeNode;
//#UC START# *AB6849BAAE6B_55B024C23EBF_var*
//#UC END# *AB6849BAAE6B_55B024C23EBF_var*
begin
//#UC START# *AB6849BAAE6B_55B024C23EBF_impl*
 Result := aTreeNode.GetPrev;
//#UC END# *AB6849BAAE6B_55B024C23EBF_impl*
end;//TkwPopTreeNodeGetPrev.GetPrev

procedure TkwPopTreeNodeGetPrev.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTreeNode : TTreeNode;
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
 aCtx.rEngine.PushObj((GetPrev(aCtx, l_aTreeNode)));
end;//TkwPopTreeNodeGetPrev.DoDoIt

class function TkwPopTreeNodeGetPrev.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:TreeNode:GetPrev';
end;//TkwPopTreeNodeGetPrev.GetWordNameForRegister

function TkwPopTreeNodeGetPrev.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeNodeGetPrev.GetResultTypeInfo

function TkwPopTreeNodeGetPrev.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopTreeNodeGetPrev.GetAllParamsCount

function TkwPopTreeNodeGetPrev.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeGetPrev.ParamsTypes

type
 TkwPopTreeNodeGetFirstChild = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetFirstChild
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetFirstChild >>> l_TTreeNode
[code]  }
 private
 // private methods
   function GetFirstChild(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): TTreeNode;
     {* Реализация слова скрипта pop:TreeNode:GetFirstChild }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeGetFirstChild

// start class TkwPopTreeNodeGetFirstChild

function TkwPopTreeNodeGetFirstChild.GetFirstChild(const aCtx: TtfwContext;
  aTreeNode: TTreeNode): TTreeNode;
//#UC START# *200474EC25F0_5EA990C4D795_var*
//#UC END# *200474EC25F0_5EA990C4D795_var*
begin
//#UC START# *200474EC25F0_5EA990C4D795_impl*
 Result := aTreeNode.GetFirstChild; 
//#UC END# *200474EC25F0_5EA990C4D795_impl*
end;//TkwPopTreeNodeGetFirstChild.GetFirstChild

procedure TkwPopTreeNodeGetFirstChild.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTreeNode : TTreeNode;
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
 aCtx.rEngine.PushObj((GetFirstChild(aCtx, l_aTreeNode)));
end;//TkwPopTreeNodeGetFirstChild.DoDoIt

class function TkwPopTreeNodeGetFirstChild.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:TreeNode:GetFirstChild';
end;//TkwPopTreeNodeGetFirstChild.GetWordNameForRegister

function TkwPopTreeNodeGetFirstChild.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeNodeGetFirstChild.GetResultTypeInfo

function TkwPopTreeNodeGetFirstChild.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopTreeNodeGetFirstChild.GetAllParamsCount

function TkwPopTreeNodeGetFirstChild.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeGetFirstChild.ParamsTypes

type
 TkwPopTreeNodeGetLastChild = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetLastChild
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetLastChild >>> l_TTreeNode
[code]  }
 private
 // private methods
   function GetLastChild(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): TTreeNode;
     {* Реализация слова скрипта pop:TreeNode:GetLastChild }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeGetLastChild

// start class TkwPopTreeNodeGetLastChild

function TkwPopTreeNodeGetLastChild.GetLastChild(const aCtx: TtfwContext;
  aTreeNode: TTreeNode): TTreeNode;
//#UC START# *E2F8A6090E56_C6C1AF6914F1_var*
//#UC END# *E2F8A6090E56_C6C1AF6914F1_var*
begin
//#UC START# *E2F8A6090E56_C6C1AF6914F1_impl*
 Result := aTreeNode.GetLastChild;
//#UC END# *E2F8A6090E56_C6C1AF6914F1_impl*
end;//TkwPopTreeNodeGetLastChild.GetLastChild

procedure TkwPopTreeNodeGetLastChild.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTreeNode : TTreeNode;
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
 aCtx.rEngine.PushObj((GetLastChild(aCtx, l_aTreeNode)));
end;//TkwPopTreeNodeGetLastChild.DoDoIt

class function TkwPopTreeNodeGetLastChild.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:TreeNode:GetLastChild';
end;//TkwPopTreeNodeGetLastChild.GetWordNameForRegister

function TkwPopTreeNodeGetLastChild.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeNodeGetLastChild.GetResultTypeInfo

function TkwPopTreeNodeGetLastChild.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopTreeNodeGetLastChild.GetAllParamsCount

function TkwPopTreeNodeGetLastChild.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeGetLastChild.ParamsTypes

type
 TkwPopTreeNodeGetNextSibling = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetNextSibling
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetNextSibling >>> l_TTreeNode
[code]  }
 private
 // private methods
   function GetNextSibling(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): TTreeNode;
     {* Реализация слова скрипта pop:TreeNode:GetNextSibling }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeGetNextSibling

// start class TkwPopTreeNodeGetNextSibling

function TkwPopTreeNodeGetNextSibling.GetNextSibling(const aCtx: TtfwContext;
  aTreeNode: TTreeNode): TTreeNode;
//#UC START# *B86DC202F7D8_D75C1EAFB29F_var*
//#UC END# *B86DC202F7D8_D75C1EAFB29F_var*
begin
//#UC START# *B86DC202F7D8_D75C1EAFB29F_impl*
 Result := aTreeNode.GetNextSibling;
//#UC END# *B86DC202F7D8_D75C1EAFB29F_impl*
end;//TkwPopTreeNodeGetNextSibling.GetNextSibling

procedure TkwPopTreeNodeGetNextSibling.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTreeNode : TTreeNode;
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
 aCtx.rEngine.PushObj((GetNextSibling(aCtx, l_aTreeNode)));
end;//TkwPopTreeNodeGetNextSibling.DoDoIt

class function TkwPopTreeNodeGetNextSibling.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:TreeNode:GetNextSibling';
end;//TkwPopTreeNodeGetNextSibling.GetWordNameForRegister

function TkwPopTreeNodeGetNextSibling.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeNodeGetNextSibling.GetResultTypeInfo

function TkwPopTreeNodeGetNextSibling.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopTreeNodeGetNextSibling.GetAllParamsCount

function TkwPopTreeNodeGetNextSibling.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeGetNextSibling.ParamsTypes

type
 TkwPopTreeNodeGetPrevSibling = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetPrevSibling
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetPrevSibling >>> l_TTreeNode
[code]  }
 private
 // private methods
   function GetPrevSibling(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): TTreeNode;
     {* Реализация слова скрипта pop:TreeNode:GetPrevSibling }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeGetPrevSibling

// start class TkwPopTreeNodeGetPrevSibling

function TkwPopTreeNodeGetPrevSibling.GetPrevSibling(const aCtx: TtfwContext;
  aTreeNode: TTreeNode): TTreeNode;
//#UC START# *CBAF62383CA2_35C934477819_var*
//#UC END# *CBAF62383CA2_35C934477819_var*
begin
//#UC START# *CBAF62383CA2_35C934477819_impl*
 Result := aTreeNode.GetPrevSibling;
//#UC END# *CBAF62383CA2_35C934477819_impl*
end;//TkwPopTreeNodeGetPrevSibling.GetPrevSibling

procedure TkwPopTreeNodeGetPrevSibling.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTreeNode : TTreeNode;
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
 aCtx.rEngine.PushObj((GetPrevSibling(aCtx, l_aTreeNode)));
end;//TkwPopTreeNodeGetPrevSibling.DoDoIt

class function TkwPopTreeNodeGetPrevSibling.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:TreeNode:GetPrevSibling';
end;//TkwPopTreeNodeGetPrevSibling.GetWordNameForRegister

function TkwPopTreeNodeGetPrevSibling.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeNodeGetPrevSibling.GetResultTypeInfo

function TkwPopTreeNodeGetPrevSibling.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopTreeNodeGetPrevSibling.GetAllParamsCount

function TkwPopTreeNodeGetPrevSibling.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeGetPrevSibling.ParamsTypes

type
 TkwPopTreeNodeGetNextVisible = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetNextVisible
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetNextVisible >>> l_TTreeNode
[code]  }
 private
 // private methods
   function GetNextVisible(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): TTreeNode;
     {* Реализация слова скрипта pop:TreeNode:GetNextVisible }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeGetNextVisible

// start class TkwPopTreeNodeGetNextVisible

function TkwPopTreeNodeGetNextVisible.GetNextVisible(const aCtx: TtfwContext;
  aTreeNode: TTreeNode): TTreeNode;
//#UC START# *8DB4489FF36F_4D009DB53D61_var*
//#UC END# *8DB4489FF36F_4D009DB53D61_var*
begin
//#UC START# *8DB4489FF36F_4D009DB53D61_impl*
 Result := aTreeNode.GetNextVisible;
//#UC END# *8DB4489FF36F_4D009DB53D61_impl*
end;//TkwPopTreeNodeGetNextVisible.GetNextVisible

procedure TkwPopTreeNodeGetNextVisible.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTreeNode : TTreeNode;
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
 aCtx.rEngine.PushObj((GetNextVisible(aCtx, l_aTreeNode)));
end;//TkwPopTreeNodeGetNextVisible.DoDoIt

class function TkwPopTreeNodeGetNextVisible.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:TreeNode:GetNextVisible';
end;//TkwPopTreeNodeGetNextVisible.GetWordNameForRegister

function TkwPopTreeNodeGetNextVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeNodeGetNextVisible.GetResultTypeInfo

function TkwPopTreeNodeGetNextVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopTreeNodeGetNextVisible.GetAllParamsCount

function TkwPopTreeNodeGetNextVisible.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeGetNextVisible.ParamsTypes

type
 TkwPopTreeNodeGetPrevVisible = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetPrevVisible
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetPrevVisible >>> l_TTreeNode
[code]  }
 private
 // private methods
   function GetPrevVisible(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): TTreeNode;
     {* Реализация слова скрипта pop:TreeNode:GetPrevVisible }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeGetPrevVisible

// start class TkwPopTreeNodeGetPrevVisible

function TkwPopTreeNodeGetPrevVisible.GetPrevVisible(const aCtx: TtfwContext;
  aTreeNode: TTreeNode): TTreeNode;
//#UC START# *4529C267C83B_CA039569FA58_var*
//#UC END# *4529C267C83B_CA039569FA58_var*
begin
//#UC START# *4529C267C83B_CA039569FA58_impl*
 Result := aTreeNode.GetPrevVisible;
//#UC END# *4529C267C83B_CA039569FA58_impl*
end;//TkwPopTreeNodeGetPrevVisible.GetPrevVisible

procedure TkwPopTreeNodeGetPrevVisible.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTreeNode : TTreeNode;
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
 aCtx.rEngine.PushObj((GetPrevVisible(aCtx, l_aTreeNode)));
end;//TkwPopTreeNodeGetPrevVisible.DoDoIt

class function TkwPopTreeNodeGetPrevVisible.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:TreeNode:GetPrevVisible';
end;//TkwPopTreeNodeGetPrevVisible.GetWordNameForRegister

function TkwPopTreeNodeGetPrevVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeNodeGetPrevVisible.GetResultTypeInfo

function TkwPopTreeNodeGetPrevVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopTreeNodeGetPrevVisible.GetAllParamsCount

function TkwPopTreeNodeGetPrevVisible.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeGetPrevVisible.ParamsTypes

type
 TkwPopTreeNodeExpand = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:Expand
*Пример:*
[code]
 aRecurse aTreeNode pop:TreeNode:Expand
[code]  }
 private
 // private methods
   procedure Expand(const aCtx: TtfwContext;
    aTreeNode: TTreeNode;
    aRecurse: Boolean);
     {* Реализация слова скрипта pop:TreeNode:Expand }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeExpand

// start class TkwPopTreeNodeExpand

procedure TkwPopTreeNodeExpand.Expand(const aCtx: TtfwContext;
  aTreeNode: TTreeNode;
  aRecurse: Boolean);
//#UC START# *64F2C36D9582_53AEF2794BFD_var*
//#UC END# *64F2C36D9582_53AEF2794BFD_var*
begin
//#UC START# *64F2C36D9582_53AEF2794BFD_impl*
 aTreeNode.Expand(aRecurse);
//#UC END# *64F2C36D9582_53AEF2794BFD_impl*
end;//TkwPopTreeNodeExpand.Expand

procedure TkwPopTreeNodeExpand.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTreeNode : TTreeNode;
 l_aRecurse : Boolean;
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

class function TkwPopTreeNodeExpand.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:TreeNode:Expand';
end;//TkwPopTreeNodeExpand.GetWordNameForRegister

function TkwPopTreeNodeExpand.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopTreeNodeExpand.GetResultTypeInfo

function TkwPopTreeNodeExpand.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopTreeNodeExpand.GetAllParamsCount

function TkwPopTreeNodeExpand.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode), TypeInfo(Boolean)]);
end;//TkwPopTreeNodeExpand.ParamsTypes
{$IfEnd} //not NoScripts AND not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_TreeNode_GetNext
 TkwPopTreeNodeGetNext.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_TreeNode_HasChildren
 TkwPopTreeNodeHasChildren.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_TreeNode_GetPrev
 TkwPopTreeNodeGetPrev.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_TreeNode_GetFirstChild
 TkwPopTreeNodeGetFirstChild.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_TreeNode_GetLastChild
 TkwPopTreeNodeGetLastChild.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_TreeNode_GetNextSibling
 TkwPopTreeNodeGetNextSibling.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_TreeNode_GetPrevSibling
 TkwPopTreeNodeGetPrevSibling.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_TreeNode_GetNextVisible
 TkwPopTreeNodeGetNextVisible.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_TreeNode_GetPrevVisible
 TkwPopTreeNodeGetPrevVisible.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_TreeNode_Expand
 TkwPopTreeNodeExpand.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TTreeNode
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTreeNode));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts AND not NoVCL

end.