unit kwConfigRestore;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Shell Words"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwConfigRestore.pas"
// �����: 08.09.2011 17:54
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Shell Words::F1 Shell Words::TkwConfigRestore
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
 TkwConfigRestore = {scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigRestore
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  nsConfigurationList
  {$IfEnd} //not Admin AND not Monitorings
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwConfigRestore

procedure TkwConfigRestore.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E68C9020275_var*
//#UC END# *4DAEEDE10285_4E68C9020275_var*
begin
//#UC START# *4DAEEDE10285_4E68C9020275_impl*
 ConfigurationList.ActiveConfig.Load(true);
//#UC END# *4DAEEDE10285_4E68C9020275_impl*
end;//TkwConfigRestore.DoDoIt

class function TkwConfigRestore.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Config:Restore';
end;//TkwConfigRestore.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwConfigRestore
 TkwConfigRestore.RegisterInEngine;
{$IfEnd} //not NoScripts

end.