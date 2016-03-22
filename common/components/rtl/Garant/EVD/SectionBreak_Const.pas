unit SectionBreak_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/SectionBreak_Const.pas"
// �����: 07.06.2008 19:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::SectionBreak
//
// ������ �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� SectionBreak - "������ �������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idSectionBreak = 104;

function k2_attrParas: Integer;

function k2_typSectionBreak: SectionBreakTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_SectionBreak : SectionBreakTag = nil;

// start class SectionBreakTag

function k2_typSectionBreak: SectionBreakTag;
begin
 if (g_SectionBreak = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_SectionBreak := TevdNativeSchema(Tk2TypeTable.GetInstance).t_SectionBreak;
 end;//g_SectionBreak = nil
 Result := g_SectionBreak;
end;
var
 g_k2_attrParas: Integer = -1;

function k2_attrParas: Integer;
begin
 if (g_k2_attrParas = -1) then
  g_k2_attrParas :=  Tk2Attributes.Instance.CheckIDByName('Paras');
 Result := g_k2_attrParas;
end;


end.