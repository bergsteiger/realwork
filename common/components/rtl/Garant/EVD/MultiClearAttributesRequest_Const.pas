unit MultiClearAttributesRequest_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/MultiClearAttributesRequest_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::MultiClearAttributesRequest
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� MultiClearAttributesRequest .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typMultiClearAttributesRequest: MultiClearAttributesRequestTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_MultiClearAttributesRequest : MultiClearAttributesRequestTag = nil;

// start class MultiClearAttributesRequestTag

function k2_typMultiClearAttributesRequest: MultiClearAttributesRequestTag;
begin
 if (g_MultiClearAttributesRequest = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_MultiClearAttributesRequest := TevdTasksSchema(Tk2TypeTable.GetInstance).t_MultiClearAttributesRequest;
 end;//g_MultiClearAttributesRequest = nil
 Result := g_MultiClearAttributesRequest;
end;

end.