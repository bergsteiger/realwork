unit csDIsconnectReply_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/csDIsconnectReply_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csDIsconnectReply
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� csDIsconnectReply .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsDIsconnectReply: csDIsconnectReplyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csDIsconnectReply : csDIsconnectReplyTag = nil;

// start class csDIsconnectReplyTag

function k2_typcsDIsconnectReply: csDIsconnectReplyTag;
begin
 if (g_csDIsconnectReply = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csDIsconnectReply := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csDIsconnectReply;
 end;//g_csDIsconnectReply = nil
 Result := g_csDIsconnectReply;
end;

end.