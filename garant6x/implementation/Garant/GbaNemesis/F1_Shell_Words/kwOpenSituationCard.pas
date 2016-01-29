unit kwOpenSituationCard;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Shell Words"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwOpenSituationCard.pas"
// �����: 31.01.2012 17:23
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Shell Words::F1 Shell Words::TkwOpenSituationCard
//
// ������� ��� 6.� (�����������)
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
 TkwOpenSituationCard = {scriptword} class(TtfwRegisterableWord)
  {* ������� ��� 6.� (�����������) }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwOpenSituationCard
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwOpenSituationCard

procedure TkwOpenSituationCard.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F27EAF200E5_var*
//#UC END# *4DAEEDE10285_4F27EAF200E5_var*
begin
//#UC START# *4DAEEDE10285_4F27EAF200E5_impl*
 TdmStdRes.OpenSituationCard(nil);
//#UC END# *4DAEEDE10285_4F27EAF200E5_impl*
end;//TkwOpenSituationCard.DoDoIt

class function TkwOpenSituationCard.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����������_Prim';
end;//TkwOpenSituationCard.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwOpenSituationCard
 TkwOpenSituationCard.RegisterInEngine;
{$IfEnd} //not NoScripts

end.