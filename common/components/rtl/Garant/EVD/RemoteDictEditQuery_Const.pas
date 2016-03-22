unit RemoteDictEditQuery_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/RemoteDictEditQuery_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::RemoteDictEditQuery
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� RemoteDictEditQuery .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typRemoteDictEditQuery: RemoteDictEditQueryTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_RemoteDictEditQuery : RemoteDictEditQueryTag = nil;

// start class RemoteDictEditQueryTag

function k2_typRemoteDictEditQuery: RemoteDictEditQueryTag;
begin
 if (g_RemoteDictEditQuery = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_RemoteDictEditQuery := TevdTasksSchema(Tk2TypeTable.GetInstance).t_RemoteDictEditQuery;
 end;//g_RemoteDictEditQuery = nil
 Result := g_RemoteDictEditQuery;
end;

end.