unit csGetFilePartReply_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/csGetFilePartReply_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::csGetFilePartReply
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� csGetFilePartReply .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrIsSuccess: Integer;

function k2_typcsGetFilePartReply: csGetFilePartReplyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csGetFilePartReply : csGetFilePartReplyTag = nil;

// start class csGetFilePartReplyTag

function k2_typcsGetFilePartReply: csGetFilePartReplyTag;
begin
 if (g_csGetFilePartReply = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csGetFilePartReply := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csGetFilePartReply;
 end;//g_csGetFilePartReply = nil
 Result := g_csGetFilePartReply;
end;
var
 g_k2_attrIsSuccess: Integer = -1;

function k2_attrIsSuccess: Integer;
begin
 if (g_k2_attrIsSuccess = -1) then
  g_k2_attrIsSuccess :=  Tk2Attributes.Instance.CheckIDByName('IsSuccess');
 Result := g_k2_attrIsSuccess;
end;


end.