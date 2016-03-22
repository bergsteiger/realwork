unit csMessageWithReply_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/csMessageWithReply_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csMessageWithReply
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� csMessageWithReply .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsMessageWithReply: csMessageWithReplyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csMessageWithReply : csMessageWithReplyTag = nil;

// start class csMessageWithReplyTag

function k2_typcsMessageWithReply: csMessageWithReplyTag;
begin
 if (g_csMessageWithReply = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMessageWithReply := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMessageWithReply;
 end;//g_csMessageWithReply = nil
 Result := g_csMessageWithReply;
end;

end.