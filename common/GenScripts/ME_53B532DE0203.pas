unit InterfacedNodeWords;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\InterfacedNodeWords.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Tree_TLB
 , l3Interfaces
 , l3TreeInterfaces
 , tfwAxiomaticsResNameGetter
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *609BA308C8F6ci*
 //#UC END# *609BA308C8F6ci*
 //#UC START# *609BA308C8F6cit*
 //#UC END# *609BA308C8F6cit*
 TInterfacedNodeWordsResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *609BA308C8F6publ*
 //#UC END# *609BA308C8F6publ*
 end;//TInterfacedNodeWordsResNameGetter

 TkwNodeCaption = {final} class(TtfwPropertyLike)
  {* Слово скрипта Node:Caption
*Тип результата:* Tl3WString
*Пример:*
[code]
STRING VAR l_Tl3WString
 aNode Node:Caption >>> l_Tl3WString
[code]  }
  private
   function Caption(const aCtx: TtfwContext;
    const aNode: Il3Node): Tl3WString;
    {* Реализация слова скрипта Node:Caption }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNodeCaption

 TkwNodeIndex = {final} class(TtfwPropertyLike)
  {* Слово скрипта Node:Index
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aNode Node:Index >>> l_Integer
[code]  }
  private
   function Index(const aCtx: TtfwContext;
    const aNode: Il3Node): Integer;
    {* Реализация слова скрипта Node:Index }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNodeIndex

 TkwNodeIndexInTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта Node:IndexInTree
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aNode Node:IndexInTree >>> l_Integer
[code]  }
  private
   function IndexInTree(const aCtx: TtfwContext;
    const aNode: Il3Node): Integer;
    {* Реализация слова скрипта Node:IndexInTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNodeIndexInTree

class function TInterfacedNodeWordsResNameGetter.ResName: AnsiString;
begin
  Result := 'InterfacedNodeWords';
end;//TInterfacedNodeWordsResNameGetter.ResName

 {$R InterfacedNodeWords.res}

function TkwNodeCaption.Caption(const aCtx: TtfwContext;
 const aNode: Il3Node): Tl3WString;
 {* Реализация слова скрипта Node:Caption }
//#UC START# *EB2FE05C3FD8_925538F9D93F_var*
//#UC END# *EB2FE05C3FD8_925538F9D93F_var*
begin
//#UC START# *EB2FE05C3FD8_925538F9D93F_impl*
 Result := aNode.Text;
//#UC END# *EB2FE05C3FD8_925538F9D93F_impl*
end;//TkwNodeCaption.Caption

procedure TkwNodeCaption.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_925538F9D93F_var*
//#UC END# *4DAEEDE10285_925538F9D93F_var*
begin
//#UC START# *4DAEEDE10285_925538F9D93F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_925538F9D93F_impl*
end;//TkwNodeCaption.DoDoIt

class function TkwNodeCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'Node:Caption';
end;//TkwNodeCaption.GetWordNameForRegister

procedure TkwNodeCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_925538F9D93F_var*
//#UC END# *52D00B00031A_925538F9D93F_var*
begin
//#UC START# *52D00B00031A_925538F9D93F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_925538F9D93F_impl*
end;//TkwNodeCaption.SetValuePrim

function TkwNodeCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_925538F9D93F_var*
//#UC END# *551544E2001A_925538F9D93F_var*
begin
//#UC START# *551544E2001A_925538F9D93F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_925538F9D93F_impl*
end;//TkwNodeCaption.GetResultTypeInfo

function TkwNodeCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNodeCaption.GetAllParamsCount

function TkwNodeCaption.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_925538F9D93F_var*
//#UC END# *5617F4D00243_925538F9D93F_var*
begin
//#UC START# *5617F4D00243_925538F9D93F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_925538F9D93F_impl*
end;//TkwNodeCaption.ParamsTypes

function TkwNodeIndex.Index(const aCtx: TtfwContext;
 const aNode: Il3Node): Integer;
 {* Реализация слова скрипта Node:Index }
//#UC START# *5069AAF05422_34FBBF0F2ACD_var*
//#UC END# *5069AAF05422_34FBBF0F2ACD_var*
begin
//#UC START# *5069AAF05422_34FBBF0F2ACD_impl*
 Result := aNode.GetNumInParent;
//#UC END# *5069AAF05422_34FBBF0F2ACD_impl*
end;//TkwNodeIndex.Index

procedure TkwNodeIndex.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_34FBBF0F2ACD_var*
//#UC END# *4DAEEDE10285_34FBBF0F2ACD_var*
begin
//#UC START# *4DAEEDE10285_34FBBF0F2ACD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_34FBBF0F2ACD_impl*
end;//TkwNodeIndex.DoDoIt

class function TkwNodeIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'Node:Index';
end;//TkwNodeIndex.GetWordNameForRegister

procedure TkwNodeIndex.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_34FBBF0F2ACD_var*
//#UC END# *52D00B00031A_34FBBF0F2ACD_var*
begin
//#UC START# *52D00B00031A_34FBBF0F2ACD_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_34FBBF0F2ACD_impl*
end;//TkwNodeIndex.SetValuePrim

function TkwNodeIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_34FBBF0F2ACD_var*
//#UC END# *551544E2001A_34FBBF0F2ACD_var*
begin
//#UC START# *551544E2001A_34FBBF0F2ACD_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_34FBBF0F2ACD_impl*
end;//TkwNodeIndex.GetResultTypeInfo

function TkwNodeIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNodeIndex.GetAllParamsCount

function TkwNodeIndex.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_34FBBF0F2ACD_var*
//#UC END# *5617F4D00243_34FBBF0F2ACD_var*
begin
//#UC START# *5617F4D00243_34FBBF0F2ACD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_34FBBF0F2ACD_impl*
end;//TkwNodeIndex.ParamsTypes

function TkwNodeIndexInTree.IndexInTree(const aCtx: TtfwContext;
 const aNode: Il3Node): Integer;
 {* Реализация слова скрипта Node:IndexInTree }
//#UC START# *376583B5266F_1B9E11EA21FB_var*
var
 l_Index: Integer;
 l_P: Il3Node;
//#UC END# *376583B5266F_1B9E11EA21FB_var*
begin
//#UC START# *376583B5266F_1B9E11EA21FB_impl*
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
 Result := l_Index;
//#UC END# *376583B5266F_1B9E11EA21FB_impl*
end;//TkwNodeIndexInTree.IndexInTree

procedure TkwNodeIndexInTree.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1B9E11EA21FB_var*
//#UC END# *4DAEEDE10285_1B9E11EA21FB_var*
begin
//#UC START# *4DAEEDE10285_1B9E11EA21FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1B9E11EA21FB_impl*
end;//TkwNodeIndexInTree.DoDoIt

class function TkwNodeIndexInTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'Node:IndexInTree';
end;//TkwNodeIndexInTree.GetWordNameForRegister

procedure TkwNodeIndexInTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_1B9E11EA21FB_var*
//#UC END# *52D00B00031A_1B9E11EA21FB_var*
begin
//#UC START# *52D00B00031A_1B9E11EA21FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_1B9E11EA21FB_impl*
end;//TkwNodeIndexInTree.SetValuePrim

function TkwNodeIndexInTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1B9E11EA21FB_var*
//#UC END# *551544E2001A_1B9E11EA21FB_var*
begin
//#UC START# *551544E2001A_1B9E11EA21FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1B9E11EA21FB_impl*
end;//TkwNodeIndexInTree.GetResultTypeInfo

function TkwNodeIndexInTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNodeIndexInTree.GetAllParamsCount

function TkwNodeIndexInTree.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1B9E11EA21FB_var*
//#UC END# *5617F4D00243_1B9E11EA21FB_var*
begin
//#UC START# *5617F4D00243_1B9E11EA21FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1B9E11EA21FB_impl*
end;//TkwNodeIndexInTree.ParamsTypes

initialization
 TInterfacedNodeWordsResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwNodeCaption.RegisterInEngine;
 {* Регистрация Node_Caption }
 TkwNodeIndex.RegisterInEngine;
 {* Регистрация Node_Index }
 TkwNodeIndexInTree.RegisterInEngine;
 {* Регистрация Node_IndexInTree }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3Node));
 {* Регистрация типа Il3Node }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Tl3WString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoScripts)

end.
