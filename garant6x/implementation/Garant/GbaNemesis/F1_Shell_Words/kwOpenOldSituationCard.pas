unit kwOpenOldSituationCard;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Shell Words"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwOpenOldSituationCard.pas"
// �����: 31.01.2012 17:24
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Shell Words::F1 Shell Words::TkwOpenOldSituationCard
//
// ������� ��� 5.� (�������������)
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
 TkwOpenOldSituationCard = {scriptword} class(TtfwRegisterableWord)
  {* ������� ��� 5.� (�������������) }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwOpenOldSituationCard
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

// start class TkwOpenOldSituationCard

procedure TkwOpenOldSituationCard.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F27EB56012C_var*
//#UC END# *4DAEEDE10285_4F27EB56012C_var*
begin
//#UC START# *4DAEEDE10285_4F27EB56012C_impl*
 TdmStdRes.OpenOldSituationCard(nil, nil);
//#UC END# *4DAEEDE10285_4F27EB56012C_impl*
end;//TkwOpenOldSituationCard.DoDoIt

class function TkwOpenOldSituationCard.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�������������_Prim';
end;//TkwOpenOldSituationCard.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwOpenOldSituationCard
 TkwOpenOldSituationCard.RegisterInEngine;
{$IfEnd} //not NoScripts

end.