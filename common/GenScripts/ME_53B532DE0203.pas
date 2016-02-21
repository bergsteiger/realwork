unit InterfacedNodeWords;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\InterfacedNodeWords.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Tree_TLB
 , l3Interfaces
 , l3TreeInterfaces
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwAxiomaticsResNameGetter
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
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
  {* ����������� ������������ ����������� }
  public
   class function ResName: AnsiString; override;
 //#UC START# *609BA308C8F6publ*
 //#UC END# *609BA308C8F6publ*
 end;//TInterfacedNodeWordsResNameGetter

 TkwNodeCaption = {final} class(TtfwPropertyLike)
  {* ����� ������� Node:Caption
*��� ����������:* Tl3WString
*������:*
[code]
STRING VAR l_Tl3WString
 aNode Node:Caption >>> l_Tl3WString
[code]  }
  private
   function Caption(const aCtx: TtfwContext;
    const aNode: Il3Node): Tl3WString;
    {* ���������� ����� ������� Node:Caption }
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
  {* ����� ������� Node:Index
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aNode Node:Index >>> l_Integer
[code]  }
  private
   function Index(const aCtx: TtfwContext;
    const aNode: Il3Node): Integer;
    {* ���������� ����� ������� Node:Index }
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
  {* ����� ������� Node:IndexInTree
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aNode Node:IndexInTree >>> l_Integer
[code]  }
  private
   function IndexInTree(const aCtx: TtfwContext;
    const aNode: Il3Node): Integer;
    {* ���������� ����� ������� Node:IndexInTree }
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
 {* ���������� ����� ������� Node:Caption }
//#UC START# *EB2FE05C3FD8_925538F9D93F_var*
//#UC END# *EB2FE05C3FD8_925538F9D93F_var*
begin
//#UC START# *EB2FE05C3FD8_925538F9D93F_impl*
 Result := aNode.Text;
//#UC END# *EB2FE05C3FD8_925538F9D93F_impl*
end;//TkwNodeCaption.Caption

procedure TkwNodeCaption.DoDoIt(const aCtx: TtfwContext);
var l_aNode: Il3Node;
begin
 try
  l_aNode := Il3Node(aCtx.rEngine.PopIntf(Il3Node));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNode: Il3Node : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Caption(aCtx, l_aNode));
end;//TkwNodeCaption.DoDoIt

class function TkwNodeCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'Node:Caption';
end;//TkwNodeCaption.GetWordNameForRegister

procedure TkwNodeCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Caption', aCtx);
end;//TkwNodeCaption.SetValuePrim

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

function TkwNodeIndex.Index(const aCtx: TtfwContext;
 const aNode: Il3Node): Integer;
 {* ���������� ����� ������� Node:Index }
//#UC START# *5069AAF05422_34FBBF0F2ACD_var*
//#UC END# *5069AAF05422_34FBBF0F2ACD_var*
begin
//#UC START# *5069AAF05422_34FBBF0F2ACD_impl*
 Result := aNode.GetNumInParent;
//#UC END# *5069AAF05422_34FBBF0F2ACD_impl*
end;//TkwNodeIndex.Index

procedure TkwNodeIndex.DoDoIt(const aCtx: TtfwContext);
var l_aNode: Il3Node;
begin
 try
  l_aNode := Il3Node(aCtx.rEngine.PopIntf(Il3Node));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNode: Il3Node : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Index(aCtx, l_aNode));
end;//TkwNodeIndex.DoDoIt

class function TkwNodeIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'Node:Index';
end;//TkwNodeIndex.GetWordNameForRegister

procedure TkwNodeIndex.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Index', aCtx);
end;//TkwNodeIndex.SetValuePrim

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

function TkwNodeIndexInTree.IndexInTree(const aCtx: TtfwContext;
 const aNode: Il3Node): Integer;
 {* ���������� ����� ������� Node:IndexInTree }
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
var l_aNode: Il3Node;
begin
 try
  l_aNode := Il3Node(aCtx.rEngine.PopIntf(Il3Node));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNode: Il3Node : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(IndexInTree(aCtx, l_aNode));
end;//TkwNodeIndexInTree.DoDoIt

class function TkwNodeIndexInTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'Node:IndexInTree';
end;//TkwNodeIndexInTree.GetWordNameForRegister

procedure TkwNodeIndexInTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� IndexInTree', aCtx);
end;//TkwNodeIndexInTree.SetValuePrim

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

initialization
 TInterfacedNodeWordsResNameGetter.Register;
 {* ����������� ������������ ����������� }
 TkwNodeCaption.RegisterInEngine;
 {* ����������� Node_Caption }
 TkwNodeIndex.RegisterInEngine;
 {* ����������� Node_Index }
 TkwNodeIndexInTree.RegisterInEngine;
 {* ����������� Node_IndexInTree }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3Node));
 {* ����������� ���� Il3Node }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� Tl3WString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* ����������� ���� Integer }
{$IfEnd} // NOT Defined(NoScripts)

end.
