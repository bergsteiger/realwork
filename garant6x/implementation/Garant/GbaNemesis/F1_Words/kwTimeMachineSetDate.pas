unit kwTimeMachineSetDate;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Words"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwTimeMachineSetDate.pas"
// �����: 06.05.2011 15:18
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Words::Words::TkwTimeMachineSetDate
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
 TkwTimeMachineSetDate = {scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwTimeMachineSetDate
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  DataAdapter,
  l3DateSt,
  bsConvert
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwTimeMachineSetDate

procedure TkwTimeMachineSetDate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DC3D8E200AF_var*
//#UC END# *4DAEEDE10285_4DC3D8E200AF_var*
begin
//#UC START# *4DAEEDE10285_4DC3D8E200AF_impl*
 DefDataAdapter.TimeMachine.Date := bsBusinessToAdapter(FlexStr2Date(aCtx.rEngine.PopDelphiString));
//#UC END# *4DAEEDE10285_4DC3D8E200AF_impl*
end;//TkwTimeMachineSetDate.DoDoIt

class function TkwTimeMachineSetDate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'timemachine:SetDate';
end;//TkwTimeMachineSetDate.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwTimeMachineSetDate
 TkwTimeMachineSetDate.RegisterInEngine;
{$IfEnd} //not NoScripts

end.