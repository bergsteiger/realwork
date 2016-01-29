unit kwClearDocumentContextSearchHistory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Words"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwClearDocumentContextSearchHistory.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Words::Words::ClearDocumentContextSearchHistory
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
 TkwClearDocumentContextSearchHistory = {final scriptword} class(TkwClearContextSearchHistory)
 protected
 // realized methods
   function GetContextHistoryKind: TnsContextHistoryKind; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwClearDocumentContextSearchHistory
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TkwClearDocumentContextSearchHistory

function TkwClearDocumentContextSearchHistory.GetContextHistoryKind: TnsContextHistoryKind;
//#UC START# *53B12AEE01A2_53B12B8A03DC_var*
//#UC END# *53B12AEE01A2_53B12B8A03DC_var*
begin
//#UC START# *53B12AEE01A2_53B12B8A03DC_impl*
 Result := ns_chkDocument;
//#UC END# *53B12AEE01A2_53B12B8A03DC_impl*
end;//TkwClearDocumentContextSearchHistory.GetContextHistoryKind

class function TkwClearDocumentContextSearchHistory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ClearDocumentContextSearchHistory';
end;//TkwClearDocumentContextSearchHistory.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� ClearDocumentContextSearchHistory
 TkwClearDocumentContextSearchHistory.RegisterInEngine;
{$IfEnd} //not NoScripts

end.