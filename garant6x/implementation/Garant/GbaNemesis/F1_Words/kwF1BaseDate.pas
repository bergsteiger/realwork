unit kwF1BaseDate;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Words"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwF1BaseDate.pas"
// �����: 14.11.2011 19:32
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Words::Words::f1_BaseDate
//
// ����� �� ���� ���� ���� � ��������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwF1BaseDate = {scriptword} class(TtfwRegisterableWord)
  {* ����� �� ���� ���� ���� � ��������� ������� }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwF1BaseDate
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  bsUtils
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwF1BaseDate

procedure TkwF1BaseDate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EC134690154_var*
//#UC END# *4DAEEDE10285_4EC134690154_var*
begin
//#UC START# *4DAEEDE10285_4EC134690154_impl*
 aCtx.rEngine.PushString(bsBaseDateStr);
//#UC END# *4DAEEDE10285_4EC134690154_impl*
end;//TkwF1BaseDate.DoDoIt

class function TkwF1BaseDate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'f1:BaseDate';
end;//TkwF1BaseDate.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� f1_BaseDate
 TkwF1BaseDate.RegisterInEngine;
{$IfEnd} //not NoScripts

end.