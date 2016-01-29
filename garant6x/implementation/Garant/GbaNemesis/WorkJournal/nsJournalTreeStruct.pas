unit nsJournalTreeStruct;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "WorkJournal"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/WorkJournal/nsJournalTreeStruct.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 �������� ����������::WorkJournal::WorkJournal::WorkJournalImpl::TnsJournalTreeStruct
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsDataResetTreeStruct,
  DynamicTreeUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsJournalTreeStruct = class(TnsDataResetTreeStruct)
 protected
 // realized methods
   function ReAqurieUnfilteredRoot: INodeBase; override;
 end;//TnsJournalTreeStruct
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsJournalTreeStruct

function TnsJournalTreeStruct.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_4A8260EC0099_var*
//#UC END# *48FF64F60078_4A8260EC0099_var*
begin
//#UC START# *48FF64F60078_4A8260EC0099_impl*
 defDataAdapter.NativeAdapter.MakeUserJournal.GetUserJornalTree(Result);
//#UC END# *48FF64F60078_4A8260EC0099_impl*
end;//TnsJournalTreeStruct.ReAqurieUnfilteredRoot

{$IfEnd} //not Admin AND not Monitorings

end.