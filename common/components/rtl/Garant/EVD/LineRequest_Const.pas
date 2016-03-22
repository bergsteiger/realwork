unit LineRequest_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/LineRequest_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::LineRequest
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� LineRequest .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typLineRequest: LineRequestTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_LineRequest : LineRequestTag = nil;

// start class LineRequestTag

function k2_typLineRequest: LineRequestTag;
begin
 if (g_LineRequest = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_LineRequest := TevdTasksSchema(Tk2TypeTable.GetInstance).t_LineRequest;
 end;//g_LineRequest = nil
 Result := g_LineRequest;
end;

end.