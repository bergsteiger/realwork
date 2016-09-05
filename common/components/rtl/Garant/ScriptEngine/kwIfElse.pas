unit kwIfElse;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwIfElse.pas"
// ���������: "ScriptKeyword"
// ������� ������: "if_else" MUID: (5284E9670258)
// ��� ����: "TkwIfElse"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwWordWorker
 , kwCompiledWordWorker
 , kwCompiledWordPrim
 , tfwScriptingInterfaces
;

type
 TkwIfElse = {final} class(TtfwWordWorker)
  protected
   function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker; override;
   function AfterWordMaxCount(const aCtx: TtfwContext): Integer; override;
   function CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim; override;
   function MakeCompiledWordWorker(const aContext: TtfwContext;
    aRightParams: TkwCompiledWordPrim): TtfwWord; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIfElse
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwCompiledIfElse
 , kwTemporaryCompiledCode
 //#UC START# *5284E9670258impl_uses*
 //#UC END# *5284E9670258impl_uses*
;

function TkwIfElse.CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
//#UC START# *4DCBD67C0362_5284E9670258_var*
//#UC END# *4DCBD67C0362_5284E9670258_var*
begin
//#UC START# *4DCBD67C0362_5284E9670258_impl*
 RunnerError('�� ������ ���� ��������', aCtx);
 Result := nil;
//#UC END# *4DCBD67C0362_5284E9670258_impl*
end;//TkwIfElse.CompiledWorkerClass

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

class function TkwIfElse.GetWordNameForRegister: AnsiString;
begin
 Result := 'if';
end;//TkwIfElse.GetWordNameForRegister

initialization
 TkwIfElse.RegisterInEngine;
 {* ����������� if_else }
{$IfEnd} // NOT Defined(NoScripts)

end.
