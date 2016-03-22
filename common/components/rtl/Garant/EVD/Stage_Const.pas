unit Stage_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/Stage_Const.pas"
// �����: 07.06.2008 19:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::Stage
//
// ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� Stage - "����".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idStage = 80;

function k2_attrFinish: Integer;

function k2_typStage: StageTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Stage : StageTag = nil;

// start class StageTag

function k2_typStage: StageTag;
begin
 if (g_Stage = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Stage := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Stage;
 end;//g_Stage = nil
 Result := g_Stage;
end;
var
 g_k2_attrFinish: Integer = -1;

function k2_attrFinish: Integer;
begin
 if (g_k2_attrFinish = -1) then
  g_k2_attrFinish :=  Tk2Attributes.Instance.CheckIDByName('Finish');
 Result := g_k2_attrFinish;
end;


end.