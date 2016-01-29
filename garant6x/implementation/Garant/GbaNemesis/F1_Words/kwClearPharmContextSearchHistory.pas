unit kwClearPharmContextSearchHistory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Words"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwClearPharmContextSearchHistory.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Words::Words::ClearPharmContextSearchHistory
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
  kwClearContextSearchHistory
  {$If not defined(Admin)}
  ,
  ContextHistoryInterfaces
  {$IfEnd} //not Admin
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwClearPharmContextSearchHistory = {final scriptword} class(TkwClearContextSearchHistory)
 protected
 // realized methods
   function GetContextHistoryKind: TnsContextHistoryKind; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwClearPharmContextSearchHistory
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TkwClearPharmContextSearchHistory

function TkwClearPharmContextSearchHistory.GetContextHistoryKind: TnsContextHistoryKind;
//#UC START# *53B12AEE01A2_53B12BB200FE_var*
//#UC END# *53B12AEE01A2_53B12BB200FE_var*
begin
//#UC START# *53B12AEE01A2_53B12BB200FE_impl*
 Result := ns_chkInpharm;
//#UC END# *53B12AEE01A2_53B12BB200FE_impl*
end;//TkwClearPharmContextSearchHistory.GetContextHistoryKind

class function TkwClearPharmContextSearchHistory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ClearPharmContextSearchHistory';
end;//TkwClearPharmContextSearchHistory.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� ClearPharmContextSearchHistory
 TkwClearPharmContextSearchHistory.RegisterInEngine;
{$IfEnd} //not NoScripts

end.