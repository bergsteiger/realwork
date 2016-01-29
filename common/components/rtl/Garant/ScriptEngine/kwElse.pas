unit kwElse;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// ������: "kwElse.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine::CodeBranchingWords::else
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
 TkwElse = {final scriptword} class(TtfwWordWorker)
 protected
 // realized methods
   function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function AfterWordMaxCount(const aCtx: TtfwContext): Integer; override;
   procedure DoCompiledWord(aWord: TtfwWord;
     const aContext: TtfwContext); override;
   function MakeCompiledWordWorker(const aContext: TtfwContext;
     aRightParams: TkwCompiledWordPrim): TtfwWord; override;
 end;//TkwElse
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  kwCompiledWord,
  kwCompiledIfElse
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwElse

function TkwElse.CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
//#UC START# *4DCBD67C0362_5284F739012F_var*
//#UC END# *4DCBD67C0362_5284F739012F_var*
begin
//#UC START# *4DCBD67C0362_5284F739012F_impl*
 RunnerError('�� ������ ���� ��������', aCtx);
 Result := nil;
//#UC END# *4DCBD67C0362_5284F739012F_impl*
end;//TkwElse.CompiledWorkerClass

class function TkwElse.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'else';
end;//TkwElse.GetWordNameForRegister

function TkwElse.AfterWordMaxCount(const aCtx: TtfwContext): Integer;
//#UC START# *4DB9B446039A_5284F739012F_var*
//#UC END# *4DB9B446039A_5284F739012F_var*
begin
//#UC START# *4DB9B446039A_5284F739012F_impl*
 Result := 1;
//#UC END# *4DB9B446039A_5284F739012F_impl*
end;//TkwElse.AfterWordMaxCount

procedure TkwElse.DoCompiledWord(aWord: TtfwWord;
  const aContext: TtfwContext);
//#UC START# *4DB9BBD6024F_5284F739012F_var*
//#UC END# *4DB9BBD6024F_5284F739012F_var*
begin
//#UC START# *4DB9BBD6024F_5284F739012F_impl*
 CompilerAssert(not aWord.IsForwardDeclaration, '����������', aContext);
 CompilerAssert(aContext.rWordCompilingNow Is TkwCompiledWordPrim, '����� ������������� �����', aContext);
 CompilerAssert(TkwCompiledWordPrim(aContext.rWordCompilingNow).GetCode(aContext).Last Is TkwCompiledIfElse, '����� if ����� else', aContext);
 TkwCompiledIfElse(TkwCompiledWordPrim(aContext.rWordCompilingNow).GetCode(aContext).Last).SetElse(aWord);
 //inherited;
//#UC END# *4DB9BBD6024F_5284F739012F_impl*
end;//TkwElse.DoCompiledWord

function TkwElse.MakeCompiledWordWorker(const aContext: TtfwContext;
  aRightParams: TkwCompiledWordPrim): TtfwWord;
//#UC START# *5284D8180211_5284F739012F_var*
//#UC END# *5284D8180211_5284F739012F_var*
begin
//#UC START# *5284D8180211_5284F739012F_impl*
 CompilerAssert((aRightParams.CodeCount = 1),
                '�������� ������ ���� �������� ����� �����',
                aContext);
 Result := aRightParams.GetCode(aContext)[0].Use;
//#UC END# *5284D8180211_5284F739012F_impl*
end;//TkwElse.MakeCompiledWordWorker

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� else
 TkwElse.RegisterInEngine;
{$IfEnd} //not NoScripts

end.