unit csLoginReply_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/csLoginReply_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::csLoginReply
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� csLoginReply .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsLoginReply: csLoginReplyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csLoginReply : csLoginReplyTag = nil;

// start class csLoginReplyTag

function k2_typcsLoginReply: csLoginReplyTag;
begin
 if (g_csLoginReply = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csLoginReply := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csLoginReply;
 end;//g_csLoginReply = nil
 Result := g_csLoginReply;
end;

end.