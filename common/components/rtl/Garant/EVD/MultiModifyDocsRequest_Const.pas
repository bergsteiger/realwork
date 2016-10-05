unit MultiModifyDocsRequest_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/MultiModifyDocsRequest_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::MultiModifyDocsRequest
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� MultiModifyDocsRequest .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typMultiModifyDocsRequest: MultiModifyDocsRequestTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_MultiModifyDocsRequest : MultiModifyDocsRequestTag = nil;

// start class MultiModifyDocsRequestTag

function k2_typMultiModifyDocsRequest: MultiModifyDocsRequestTag;
begin
 if (g_MultiModifyDocsRequest = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_MultiModifyDocsRequest := TevdTasksSchema(Tk2TypeTable.GetInstance).t_MultiModifyDocsRequest;
 end;//g_MultiModifyDocsRequest = nil
 Result := g_MultiModifyDocsRequest;
end;

end.