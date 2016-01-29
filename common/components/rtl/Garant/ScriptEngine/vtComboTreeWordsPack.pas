unit vtComboTreeWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Everest"
// ������: "vtComboTreeWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$Everest::EditorFromStackKeyWords::vtComboTreeWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3TreeInterfaces,
  tfwScriptingInterfaces,
  vtComboTree,
  tfwClassLike
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
 TkwPopComboTreeCurrentNode = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:ComboTree:CurrentNode
*��� ����������:* Il3SimpleNode
*������:*
[code]
INTERFACE VAR l_Il3SimpleNode
 aComboTree pop:ComboTree:CurrentNode >>> l_Il3SimpleNode
[code]  }
 private
 // private methods
   function CurrentNode(const aCtx: TtfwContext;
    aComboTree: TvtComboTree): Il3SimpleNode;
     {* ���������� ����� ������� pop:ComboTree:CurrentNode }
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
 end;//TkwPopComboTreeCurrentNode

// start class TkwPopComboTreeCurrentNode

function TkwPopComboTreeCurrentNode.CurrentNode(const aCtx: TtfwContext;
  aComboTree: TvtComboTree): Il3SimpleNode;
//#UC START# *E52B39199FD5_9F9FF0616B3E_var*
//#UC END# *E52B39199FD5_9F9FF0616B3E_var*
begin
//#UC START# *E52B39199FD5_9F9FF0616B3E_impl*
 Result := aComboTree.Tree.GetCurrentNode;
//#UC END# *E52B39199FD5_9F9FF0616B3E_impl*
end;//TkwPopComboTreeCurrentNode.CurrentNode

procedure TkwPopComboTreeCurrentNode.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aComboTree : TvtComboTree;
begin
 try
  l_aComboTree := TvtComboTree(aCtx.rEngine.PopObjAs(TvtComboTree));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aComboTree: TvtComboTree : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf((CurrentNode(aCtx, l_aComboTree)), TypeInfo(Il3SimpleNode));
end;//TkwPopComboTreeCurrentNode.DoDoIt

class function TkwPopComboTreeCurrentNode.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:ComboTree:CurrentNode';
end;//TkwPopComboTreeCurrentNode.GetWordNameForRegister

function TkwPopComboTreeCurrentNode.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Il3SimpleNode);
end;//TkwPopComboTreeCurrentNode.GetResultTypeInfo

function TkwPopComboTreeCurrentNode.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopComboTreeCurrentNode.GetAllParamsCount

function TkwPopComboTreeCurrentNode.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvtComboTree)]);
end;//TkwPopComboTreeCurrentNode.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_ComboTree_CurrentNode
 TkwPopComboTreeCurrentNode.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TvtComboTree
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtComboTree));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Il3SimpleNode
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3SimpleNode));
{$IfEnd} //not NoScripts

end.