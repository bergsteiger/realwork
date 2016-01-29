unit Segment_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/Segment_Const.pas"
// �����: 07.06.2008 19:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::Segment
//
// ������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� Segment - "������� ����������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_attrStart: Integer;

function k2_attrFinish: Integer;

function k2_attrApply2Para: Integer;

function k2_attrStyle: Integer;

function k2_typSegment: SegmentTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Segment : SegmentTag = nil;

// start class SegmentTag

function k2_typSegment: SegmentTag;
begin
 if (g_Segment = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Segment := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Segment;
 end;//g_Segment = nil
 Result := g_Segment;
end;
var
 g_k2_attrStart: Integer = -1;

function k2_attrStart: Integer;
begin
 if (g_k2_attrStart = -1) then
  g_k2_attrStart :=  Tk2Attributes.Instance.CheckIDByName('Start');
 Result := g_k2_attrStart;
end;

var
 g_k2_attrFinish: Integer = -1;

function k2_attrFinish: Integer;
begin
 if (g_k2_attrFinish = -1) then
  g_k2_attrFinish :=  Tk2Attributes.Instance.CheckIDByName('Finish');
 Result := g_k2_attrFinish;
end;

var
 g_k2_attrApply2Para: Integer = -1;

function k2_attrApply2Para: Integer;
begin
 if (g_k2_attrApply2Para = -1) then
  g_k2_attrApply2Para :=  Tk2Attributes.Instance.CheckIDByName('Apply2Para');
 Result := g_k2_attrApply2Para;
end;

var
 g_k2_attrStyle: Integer = -1;

function k2_attrStyle: Integer;
begin
 if (g_k2_attrStyle = -1) then
  g_k2_attrStyle :=  Tk2Attributes.Instance.CheckIDByName('Style');
 Result := g_k2_attrStyle;
end;


end.