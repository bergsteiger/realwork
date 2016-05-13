unit InterfacedNodeWords;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\InterfacedNodeWords.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "InterfacedNodeWords" MUID: (53B532DE0203)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Interfaces
 , l3Tree_TLB
 , l3TreeInterfaces
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwAxiomaticsResNameGetter
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwNodeCaption = {final} class(TtfwPropertyLike)
  {* Слово скрипта Node:Caption }
  private
   function Caption(const aCtx: TtfwContext;
    const aNode: Il3Node): Tl3WString;
    {* Реализация слова скрипта Node:Caption }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNodeCaption

 TkwNodeIndex = {final} class(TtfwPropertyLike)
  {* Слово скрипта Node:Index }
  private
   function Index(const aCtx: TtfwContext;
    const aNode: Il3Node): Integer;
    {* Реализация слова скрипта Node:Index }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNodeIndex

 TkwNodeIndexInTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта Node:IndexInTree }
  private
   function IndexInTree(const aCtx: TtfwContext;
    const aNode: Il3Node): Integer;
    {* Реализация слова скрипта Node:IndexInTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNodeIndexInTree

 TInterfacedNodeWordsResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TInterfacedNodeWordsResNameGetter

function TkwNodeCaption.Caption(const aCtx: TtfwContext;
 const aNode: Il3Node): Tl3WString;
 {* Реализация слова скрипта Node:Caption }
//#UC START# *4F99944CAE02_925538F9D93F_var*
//#UC END# *4F99944CAE02_925538F9D93F_var*
begin
//#UC START# *4F99944CAE02_925538F9D93F_impl*
 Result := aNode.Text;
//#UC END# *4F99944CAE02_925538F9D93F_impl*
end;//TkwNodeCaption.Caption

procedure TkwNodeCaption.DoDoIt(const aCtx: TtfwContext);
var l_aNode: Il3Node;
begin
 try
  l_aNode := Il3Node(aCtx.rEngine.PopIntf(Il3Node));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNode: Il3Node : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Caption(aCtx, l_aNode));
end;//TkwNodeCaption.DoDoIt

class function TkwNodeCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'Node:Caption';
end;//TkwNodeCaption.GetWordNameForRegister

function TkwNodeCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwNodeCaption.GetResultTypeInfo

function TkwNodeCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNodeCaption.GetAllParamsCount

function TkwNodeCaption.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Il3Node)]);
end;//TkwNodeCaption.ParamsTypes

procedure TkwNodeCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Caption', aCtx);
end;//TkwNodeCaption.SetValuePrim

function TkwNodeIndex.Index(const aCtx: TtfwContext;
 const aNode: Il3Node): Integer;
 {* Реализация слова скрипта Node:Index }
//#UC START# *5ED2FC5C7948_34FBBF0F2ACD_var*
//#UC END# *5ED2FC5C7948_34FBBF0F2ACD_var*
begin
//#UC START# *5ED2FC5C7948_34FBBF0F2ACD_impl*
 Result := aNode.GetNumInParent;
//#UC END# *5ED2FC5C7948_34FBBF0F2ACD_impl*
end;//TkwNodeIndex.Index

procedure TkwNodeIndex.DoDoIt(const aCtx: TtfwContext);
var l_aNode: Il3Node;
begin
 try
  l_aNode := Il3Node(aCtx.rEngine.PopIntf(Il3Node));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNode: Il3Node : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Index(aCtx, l_aNode));
end;//TkwNodeIndex.DoDoIt

class function TkwNodeIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'Node:Index';
end;//TkwNodeIndex.GetWordNameForRegister

function TkwNodeIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwNodeIndex.GetResultTypeInfo

function TkwNodeIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNodeIndex.GetAllParamsCount

function TkwNodeIndex.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Il3Node)]);
end;//TkwNodeIndex.ParamsTypes

procedure TkwNodeIndex.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Index', aCtx);
end;//TkwNodeIndex.SetValuePrim

function TkwNodeIndexInTree.IndexInTree(const aCtx: TtfwContext;
 const aNode: Il3Node): Integer;
 {* Реализация слова скрипта Node:IndexInTree }
//#UC START# *B48811A42410_1B9E11EA21FB_var*
var
 l_Index: Integer;
 l_P: Il3Node;
//#UC END# *B48811A42410_1B9E11EA21FB_var*
begin
//#UC START# *B48811A42410_1B9E11EA21FB_impl*
 l_Index := aNode.GetNumInParent;
 l_P := aNode.ParentNode;
 try
  while Assigned(l_P) do
  begin
   l_Index := l_Index + l_P.GetNumInParent;
   l_P := l_P.ParentNode;
  end;//while Assigned(l_P)
 finally
  l_P := nil;
 end;//try..finally
//#UC END# *B48811A42410_1B9E11EA21FB_impl*
end;//TkwNodeIndexInTree.IndexInTree

procedure TkwNodeIndexInTree.DoDoIt(const aCtx: TtfwContext);
var l_aNode: Il3Node;
begin
 try
  l_aNode := Il3Node(aCtx.rEngine.PopIntf(Il3Node));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNode: Il3Node : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(IndexInTree(aCtx, l_aNode));
end;//TkwNodeIndexInTree.DoDoIt

class function TkwNodeIndexInTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'Node:IndexInTree';
end;//TkwNodeIndexInTree.GetWordNameForRegister

function TkwNodeIndexInTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwNodeIndexInTree.GetResultTypeInfo

function TkwNodeIndexInTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNodeIndexInTree.GetAllParamsCount

function TkwNodeIndexInTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Il3Node)]);
end;//TkwNodeIndexInTree.ParamsTypes

procedure TkwNodeIndexInTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству IndexInTree', aCtx);
end;//TkwNodeIndexInTree.SetValuePrim

class function TInterfacedNodeWordsResNameGetter.ResName: AnsiString;
begin
 Result := 'InterfacedNodeWords';
end;//TInterfacedNodeWordsResNameGetter.ResName

 {$R InterfacedNodeWords.res}

initialization
 TkwNodeCaption.RegisterInEngine;
 {* Регистрация Node_Caption }
 TkwNodeIndex.RegisterInEngine;
 {* Регистрация Node_Index }
 TkwNodeIndexInTree.RegisterInEngine;
 {* Регистрация Node_IndexInTree }
 TInterfacedNodeWordsResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3Node));
 {* Регистрация типа Il3Node }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Tl3WString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoScripts)

end.
