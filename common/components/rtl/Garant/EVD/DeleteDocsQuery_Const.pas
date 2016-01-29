unit DeleteDocsQuery_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/DeleteDocsQuery_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::DeleteDocsQuery
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� DeleteDocsQuery .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typDeleteDocsQuery: DeleteDocsQueryTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DeleteDocsQuery : DeleteDocsQueryTag = nil;

// start class DeleteDocsQueryTag

function k2_typDeleteDocsQuery: DeleteDocsQueryTag;
begin
 if (g_DeleteDocsQuery = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_DeleteDocsQuery := TevdTasksSchema(Tk2TypeTable.GetInstance).t_DeleteDocsQuery;
 end;//g_DeleteDocsQuery = nil
 Result := g_DeleteDocsQuery;
end;

end.