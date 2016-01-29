unit InterfacedNodeWords;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$L3"
// ������: "InterfacedNodeWords.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$L3::l3NodeWords::InterfacedNodeWords
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  l3Tree_TLB,
  tfwScriptingInterfaces,
  tfwAxiomaticsResNameGetter,
  tfwPropertyLike,
  l3TreeInterfaces
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
//#UC START# *609BA308C8F6ci*
//#UC END# *609BA308C8F6ci*
//#UC START# *609BA308C8F6cit*
//#UC END# *609BA308C8F6cit*
 TInterfacedNodeWordsResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *609BA308C8F6publ*
//#UC END# *609BA308C8F6publ*
 end;//TInterfacedNodeWordsResNameGetter

// start class TInterfacedNodeWordsResNameGetter

class function TInterfacedNodeWordsResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'InterfacedNodeWords';
end;//TInterfacedNodeWordsResNameGetter.ResName

 {$R InterfacedNodeWords.res}

type
 TkwNodeCaption = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� Node:Caption
*��� ����������:* Tl3WString
*������:*
[code]
STRING VAR l_Tl3WString
 aNode Node:Caption >>> l_Tl3WString
[code]  }
 private
 // private methods
   function Caption(const aCtx: TtfwContext;
    const aNode: Il3Node): Tl3WString;
     {* ���������� ����� ������� Node:Caption }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNodeCaption

// start class TkwNodeCaption

function TkwNodeCaption.Caption(const aCtx: TtfwContext;
  const aNode: Il3Node): Tl3WString;
//#UC START# *EB2FE05C3FD8_925538F9D93F_var*
//#UC END# *EB2FE05C3FD8_925538F9D93F_var*
begin
//#UC START# *EB2FE05C3FD8_925538F9D93F_impl*
 Result := aNode.Text;
//#UC END# *EB2FE05C3FD8_925538F9D93F_impl*
end;//TkwNodeCaption.Caption

procedure TkwNodeCaption.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aNode : Il3Node;
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
 aCtx.rEngine.PushString((Caption(aCtx, l_aNode)));
end;//TkwNodeCaption.DoDoIt

class function TkwNodeCaption.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Node:Caption';
end;//TkwNodeCaption.GetWordNameForRegister

procedure TkwNodeCaption.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Caption', aCtx);
end;//TkwNodeCaption.SetValuePrim

function TkwNodeCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwNodeCaption.GetResultTypeInfo

function TkwNodeCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwNodeCaption.GetAllParamsCount

function TkwNodeCaption.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Il3Node)]);
end;//TkwNodeCaption.ParamsTypes

type
 TkwNodeIndex = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� Node:Index
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aNode Node:Index >>> l_Integer
[code]  }
 private
 // private methods
   function Index(const aCtx: TtfwContext;
    const aNode: Il3Node): Integer;
     {* ���������� ����� ������� Node:Index }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNodeIndex

// start class TkwNodeIndex

function TkwNodeIndex.Index(const aCtx: TtfwContext;
  const aNode: Il3Node): Integer;
//#UC START# *5069AAF05422_34FBBF0F2ACD_var*
//#UC END# *5069AAF05422_34FBBF0F2ACD_var*
begin
//#UC START# *5069AAF05422_34FBBF0F2ACD_impl*
 Result := aNode.GetNumInParent;
//#UC END# *5069AAF05422_34FBBF0F2ACD_impl*
end;//TkwNodeIndex.Index

procedure TkwNodeIndex.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aNode : Il3Node;
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
 aCtx.rEngine.PushInt((Index(aCtx, l_aNode)));
end;//TkwNodeIndex.DoDoIt

class function TkwNodeIndex.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Node:Index';
end;//TkwNodeIndex.GetWordNameForRegister

procedure TkwNodeIndex.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Index', aCtx);
end;//TkwNodeIndex.SetValuePrim

function TkwNodeIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwNodeIndex.GetResultTypeInfo

function TkwNodeIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwNodeIndex.GetAllParamsCount

function TkwNodeIndex.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Il3Node)]);
end;//TkwNodeIndex.ParamsTypes

type
 TkwNodeIndexInTree = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� Node:IndexInTree
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aNode Node:IndexInTree >>> l_Integer
[code]  }
 private
 // private methods
   function IndexInTree(const aCtx: TtfwContext;
    const aNode: Il3Node): Integer;
     {* ���������� ����� ������� Node:IndexInTree }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNodeIndexInTree

// start class TkwNodeIndexInTree

function TkwNodeIndexInTree.IndexInTree(const aCtx: TtfwContext;
  const aNode: Il3Node): Integer;
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
 {-}
var
 l_aNode : Il3Node;
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
 aCtx.rEngine.PushInt((IndexInTree(aCtx, l_aNode)));
end;//TkwNodeIndexInTree.DoDoIt

class function TkwNodeIndexInTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Node:IndexInTree';
end;//TkwNodeIndexInTree.GetWordNameForRegister

procedure TkwNodeIndexInTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� IndexInTree', aCtx);
end;//TkwNodeIndexInTree.SetValuePrim

function TkwNodeIndexInTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwNodeIndexInTree.GetResultTypeInfo

function TkwNodeIndexInTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwNodeIndexInTree.GetAllParamsCount

function TkwNodeIndexInTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Il3Node)]);
end;//TkwNodeIndexInTree.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� ������������ �����������
 TInterfacedNodeWordsResNameGetter.Register;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Node_Caption
 TkwNodeCaption.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Node_Index
 TkwNodeIndex.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Node_IndexInTree
 TkwNodeIndexInTree.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Il3Node
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3Node));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Tl3WString
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts

end.