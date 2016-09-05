unit csDisconnectReply_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/csDisconnectReply_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csDisconnectReply
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� csDisconnectReply .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsDisconnectReply: csDisconnectReplyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csDisconnectReply : csDisconnectReplyTag = nil;

// start class csDisconnectReplyTag

function k2_typcsDisconnectReply: csDisconnectReplyTag;
begin
 if (g_csDisconnectReply = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csDisconnectReply := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csDisconnectReply;
 end;//g_csDisconnectReply = nil
 Result := g_csDisconnectReply;
end;

end.