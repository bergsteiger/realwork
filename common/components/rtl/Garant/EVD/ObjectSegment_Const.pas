unit ObjectSegment_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/ObjectSegment_Const.pas"
// �����: 07.06.2008 19:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::ObjectSegment
//
// ��������� ��� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� ObjectSegment - "��������� ��� �������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idObjectSegment = 51;

function k2_attrBaseLine: Integer;

function k2_typObjectSegment: ObjectSegmentTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ObjectSegment : ObjectSegmentTag = nil;

// start class ObjectSegmentTag

function k2_typObjectSegment: ObjectSegmentTag;
begin
 if (g_ObjectSegment = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_ObjectSegment := TevdNativeSchema(Tk2TypeTable.GetInstance).t_ObjectSegment;
 end;//g_ObjectSegment = nil
 Result := g_ObjectSegment;
end;
var
 g_k2_attrBaseLine: Integer = -1;

function k2_attrBaseLine: Integer;
begin
 if (g_k2_attrBaseLine = -1) then
  g_k2_attrBaseLine :=  Tk2Attributes.Instance.CheckIDByName('BaseLine');
 Result := g_k2_attrBaseLine;
end;


end.