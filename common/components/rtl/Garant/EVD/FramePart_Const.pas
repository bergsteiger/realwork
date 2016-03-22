unit FramePart_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/FramePart_Const.pas"
// �����: 07.06.2008 19:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::FramePart
//
// ����� ����� ������ �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� FramePart - "����� ����� ������ �������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idFramePart = 40;

function k2_attrForeColor: Integer;

function k2_attrWidth: Integer;

function k2_attrLineType: Integer;

function k2_attrSpaceBefore: Integer;

function k2_attrSpaceAfter: Integer;

function k2_typFramePart: FramePartTag;

//#UC START# *484D27FD005Dconst_intf*
//#UC END# *484D27FD005Dconst_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_FramePart : FramePartTag = nil;

// start class FramePartTag

function k2_typFramePart: FramePartTag;
begin
 if (g_FramePart = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_FramePart := TevdNativeSchema(Tk2TypeTable.GetInstance).t_FramePart;
 end;//g_FramePart = nil
 Result := g_FramePart;
end;
var
 g_k2_attrForeColor: Integer = -1;

function k2_attrForeColor: Integer;
begin
 if (g_k2_attrForeColor = -1) then
  g_k2_attrForeColor :=  Tk2Attributes.Instance.CheckIDByName('ForeColor');
 Result := g_k2_attrForeColor;
end;

var
 g_k2_attrWidth: Integer = -1;

function k2_attrWidth: Integer;
begin
 if (g_k2_attrWidth = -1) then
  g_k2_attrWidth :=  Tk2Attributes.Instance.CheckIDByName('Width');
 Result := g_k2_attrWidth;
end;

var
 g_k2_attrLineType: Integer = -1;

function k2_attrLineType: Integer;
begin
 if (g_k2_attrLineType = -1) then
  g_k2_attrLineType :=  Tk2Attributes.Instance.CheckIDByName('LineType');
 Result := g_k2_attrLineType;
end;

var
 g_k2_attrSpaceBefore: Integer = -1;

function k2_attrSpaceBefore: Integer;
begin
 if (g_k2_attrSpaceBefore = -1) then
  g_k2_attrSpaceBefore :=  Tk2Attributes.Instance.CheckIDByName('SpaceBefore');
 Result := g_k2_attrSpaceBefore;
end;

var
 g_k2_attrSpaceAfter: Integer = -1;

function k2_attrSpaceAfter: Integer;
begin
 if (g_k2_attrSpaceAfter = -1) then
  g_k2_attrSpaceAfter :=  Tk2Attributes.Instance.CheckIDByName('SpaceAfter');
 Result := g_k2_attrSpaceAfter;
end;


end.