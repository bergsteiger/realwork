unit nsDocumentContextHistory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ContextHistory"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/rtl/Garant/ContextHistory/nsDocumentContextHistory.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::ContextHistory::ContextHistory::TnsDocumentContextHistory
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  nsDocumentContextHistoryPrim,
  ContextHistoryInterfaces
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TnsDocumentContextHistory = class(TnsDocumentContextHistoryPrim)
 public
 // public methods
   class function Make: InsContextSearchHistory; reintroduce;
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TnsDocumentContextHistory
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class TnsDocumentContextHistory

var g_TnsDocumentContextHistory : Pointer = nil;

procedure TnsDocumentContextHistoryFree;
begin
 IUnknown(g_TnsDocumentContextHistory) := nil;
end;


class function TnsDocumentContextHistory.Make: InsContextSearchHistory;
begin
 if (g_TnsDocumentContextHistory = nil) then
 begin
  l3System.AddExitProc(TnsDocumentContextHistoryFree);
  InsContextSearchHistory(g_TnsDocumentContextHistory) := inherited Make;
 end;
 Result := InsContextSearchHistory(g_TnsDocumentContextHistory);
end;

class function TnsDocumentContextHistory.Exists: Boolean;
 {-}
begin
 Result := g_TnsDocumentContextHistory <> nil;
end;//TnsDocumentContextHistory.Exists

{$IfEnd} //not Admin

end.