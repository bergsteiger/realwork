unit tfwConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// �����: ����� �.�.
// ������: "tfwConst.pas"
// �����: 03.05.2011 12:57
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::CompiledWords::TtfwConst
//
// ��������� ��������.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwConstLike,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TtfwConst = {abstract} class(TtfwConstLike)
  {* ��������� ��������. }
 protected
 // overridden protected methods
   function AcceptsKeyWordAfter(const aContext: TtfwContext;
     aWordNumber: Integer): Boolean; override;
 end;//TtfwConst
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TtfwConst

function TtfwConst.AcceptsKeyWordAfter(const aContext: TtfwContext;
  aWordNumber: Integer): Boolean;
//#UC START# *4DB9B502013D_4DBFC3520093_var*
//#UC END# *4DB9B502013D_4DBFC3520093_var*
begin
//#UC START# *4DB9B502013D_4DBFC3520093_impl*
 //Result := false;
 Result := true;
 // - ���������� ��� �������, ����� ����� ���� �������� CONST XXX true
//#UC END# *4DB9B502013D_4DBFC3520093_impl*
end;//TtfwConst.AcceptsKeyWordAfter

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TtfwConst
 TtfwConst.RegisterClass;
{$IfEnd} //not NoScripts

end.