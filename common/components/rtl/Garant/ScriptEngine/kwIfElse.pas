unit kwIfElse;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// ������: "kwIfElse.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine::CodeBranchingWords::if_else
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwWordWorker,
  tfwScriptingInterfaces,
  kwCompiledWordPrim,
  kwCompiledWordWorker
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwIfElse = {final scriptword} class(TtfwWordWorker)
 protected
 // realized methods
   function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function AfterWordMaxCount(const aCtx: TtfwContext): Integer; override;
   function CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim; override;
   function MakeCompiledWordWorker(const aContext: TtfwContext;
     aRightParams: TkwCompiledWordPrim): TtfwWord; override;
 end;//TkwIfElse
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  kwCompiledIfElse,
  kwTemporaryCompiledCode
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwIfElse

function TkwIfElse.CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
//#UC START# *4DCBD67C0362_5284E9670258_var*
//#UC END# *4DCBD67C0362_5284E9670258_var*
begin
//#UC START# *4DCBD67C0362_5284E9670258_impl*
 RunnerError('�� ������ ���� ��������', aCtx);
 Result := nil;
//#UC END# *4DCBD67C0362_5284E9670258_impl*
end;//TkwIfElse.CompiledWorkerClass

class function TkwIfElse.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'if';
end;//TkwIfElse.GetWordNameForRegister

function TkwIfElse.AfterWordMaxCount(const aCtx: TtfwContext): Integer;
//#UC START# *4DB9B446039A_5284E9670258_var*
//#UC END# *4DB9B446039A_5284E9670258_var*
begin
//#UC START# *4DB9B446039A_5284E9670258_impl*
 Result := 2;
//#UC END# *4DB9B446039A_5284E9670258_impl*
end;//TkwIfElse.AfterWordMaxCount

function TkwIfElse.CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim;
//#UC START# *4DBAEE0D028D_5284E9670258_var*
//#UC END# *4DBAEE0D028D_5284E9670258_var*
begin
//#UC START# *4DBAEE0D028D_5284E9670258_impl*
 Result := TkwTemporaryCompiledCode;
//#UC END# *4DBAEE0D028D_5284E9670258_impl*
end;//TkwIfElse.CompiledWordClass

function TkwIfElse.MakeCompiledWordWorker(const aContext: TtfwContext;
  aRightParams: TkwCompiledWordPrim): TtfwWord;
//#UC START# *5284D8180211_5284E9670258_var*
//#UC END# *5284D8180211_5284E9670258_var*
begin
//#UC START# *5284D8180211_5284E9670258_impl*
 CompilerAssert((aRightParams.CodeCount = 2),
                '��������� ������ ��� ��������� ����� �����',
                aContext);
 Result := TkwCompiledIfElse.Create(aRightParams.GetCode(aContext)[0], aRightParams.GetCode(aContext)[1], nil, aContext);
//#UC END# *5284D8180211_5284E9670258_impl*
end;//TkwIfElse.MakeCompiledWordWorker

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� if_else
 TkwIfElse.RegisterInEngine;
{$IfEnd} //not NoScripts

end.