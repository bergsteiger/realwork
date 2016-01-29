unit kwWordPtrWorker;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// �����: ����� �.�.
// ������: "kwWordPtrWorker.pas"
// �����: 12.02.2012 16:18
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::CompiledWords::TkwWordPtrWorker
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwWordPtrWorker = {abstract} class(TtfwWord)
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 protected
 // protected fields
   f_Word : TtfwWord;
 public
 // public methods
   constructor Create(aWord: TtfwWord); reintroduce;
 end;//TkwWordPtrWorker
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TkwWordPtrWorker

constructor TkwWordPtrWorker.Create(aWord: TtfwWord);
//#UC START# *4F37AE8B03CE_4F37ADFF0150_var*
//#UC END# *4F37AE8B03CE_4F37ADFF0150_var*
begin
//#UC START# *4F37AE8B03CE_4F37ADFF0150_impl*
 inherited Create;
 f_Word := aWord;
//#UC END# *4F37AE8B03CE_4F37ADFF0150_impl*
end;//TkwWordPtrWorker.Create

procedure TkwWordPtrWorker.Cleanup;
//#UC START# *479731C50290_4F37ADFF0150_var*
//#UC END# *479731C50290_4F37ADFF0150_var*
begin
//#UC START# *479731C50290_4F37ADFF0150_impl*
 f_Word := nil;
 inherited;
//#UC END# *479731C50290_4F37ADFF0150_impl*
end;//TkwWordPtrWorker.Cleanup

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwWordPtrWorker
 TkwWordPtrWorker.RegisterClass;
{$IfEnd} //not NoScripts

end.