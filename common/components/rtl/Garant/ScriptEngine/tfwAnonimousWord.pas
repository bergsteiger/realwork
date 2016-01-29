unit tfwAnonimousWord;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// �����: ����� �.�.
// ������: "tfwAnonimousWord.pas"
// �����: 28.04.2011 23:09
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::CompiledWords::TtfwAnonimousWord
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  tfwCompilingWord
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TtfwAnonimousWord = {abstract} class(TtfwCompilingWord)
 public
 // overridden public methods
   function IsAnonimous(const aCtx: TtfwContext): Boolean; override;
 protected
 // protected methods
   procedure DoCompiledWord(aWord: TtfwWord;
     const aContext: TtfwContext); virtual;
 public
 // public methods
   procedure DoRun(const aCtx: TtfwContext); virtual;
 end;//TtfwAnonimousWord
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TtfwAnonimousWord

procedure TtfwAnonimousWord.DoCompiledWord(aWord: TtfwWord;
  const aContext: TtfwContext);
//#UC START# *4DB9BBD6024F_4DB9BB43017B_var*
//#UC END# *4DB9BBD6024F_4DB9BB43017B_var*
begin
//#UC START# *4DB9BBD6024F_4DB9BB43017B_impl*
 if aWord.IsImmediate(aContext) then
 //if aWord.IsRunner(aContext) then
 begin
  CompilerAssert((aWord.Key = nil) OR (aWord.Key = Self.Key), '�������� ��� ������������ �����', aContext);
  aWord.Key := Self.Key;
  // - ����� ����� ���� ���������� ����� �� �� Runner'��
  try
   aWord.DoIt(aContext);
  finally
   aWord.Key := nil;
  end;//try..finally
 end//aWord.IsRunner
 else
 begin
  CompilerAssert(aContext.rCompiler <> nil, '��� ���� ��� ����������', aContext);
  aContext.rCompiler.AddCodePart(aWord, aContext, tfw_sniNo);
 end;//aWord.IsRunner
//#UC END# *4DB9BBD6024F_4DB9BB43017B_impl*
end;//TtfwAnonimousWord.DoCompiledWord

procedure TtfwAnonimousWord.DoRun(const aCtx: TtfwContext);
//#UC START# *5512949D0048_4DB9BB43017B_var*
//#UC END# *5512949D0048_4DB9BB43017B_var*
begin
//#UC START# *5512949D0048_4DB9BB43017B_impl*
 RunnerError(ClassName + '.DoRun �� ����������', aCtx);
//#UC END# *5512949D0048_4DB9BB43017B_impl*
end;//TtfwAnonimousWord.DoRun

function TtfwAnonimousWord.IsAnonimous(const aCtx: TtfwContext): Boolean;
//#UC START# *4F3AB3600008_4DB9BB43017B_var*
//#UC END# *4F3AB3600008_4DB9BB43017B_var*
begin
//#UC START# *4F3AB3600008_4DB9BB43017B_impl*
 Result := true;
//#UC END# *4F3AB3600008_4DB9BB43017B_impl*
end;//TtfwAnonimousWord.IsAnonimous

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TtfwAnonimousWord
 TtfwAnonimousWord.RegisterClass;
{$IfEnd} //not NoScripts

end.