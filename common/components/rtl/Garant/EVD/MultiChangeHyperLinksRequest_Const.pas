unit MultiChangeHyperLinksRequest_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/MultiChangeHyperLinksRequest_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::MultiChangeHyperLinksRequest
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� MultiChangeHyperLinksRequest .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typMultiChangeHyperLinksRequest: MultiChangeHyperLinksRequestTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_MultiChangeHyperLinksRequest : MultiChangeHyperLinksRequestTag = nil;

// start class MultiChangeHyperLinksRequestTag

function k2_typMultiChangeHyperLinksRequest: MultiChangeHyperLinksRequestTag;
begin
 if (g_MultiChangeHyperLinksRequest = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_MultiChangeHyperLinksRequest := TevdTasksSchema(Tk2TypeTable.GetInstance).t_MultiChangeHyperLinksRequest;
 end;//g_MultiChangeHyperLinksRequest = nil
 Result := g_MultiChangeHyperLinksRequest;
end;

end.