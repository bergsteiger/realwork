unit l3FilerRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3FilerRes.pas"
// �����: 18.10.2010 13:56
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3FilerRes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3StringIDEx
  ;

{$If not defined(Nemesis)}
var
  { ������������ ������ Local }
 str_l3mmFileOp : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmFileOp'; rValue : '�������� ��������');
  { '�������� ��������' }
 str_l3mmFileOpFmt : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmFileOpFmt'; rValue : '�������� �������� [%s]');
  { '�������� �������� [%s]' }
{$IfEnd} //not Nemesis

{$If defined(Nemesis)}
var
  { ������������ ������ LocalNemesis }
 str_l3mmFileOp : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmFileOp'; rValue : '�������� ���������');
  { '�������� ���������' }
 str_l3mmFileOpFmt : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmFileOpFmt'; rValue : '�������� ��������� [%s]');
  { '�������� ��������� [%s]' }
{$IfEnd} //Nemesis

implementation

uses
  l3MessageID
  ;


initialization
{$If not defined(Nemesis)}
// ������������� str_l3mmFileOp
 str_l3mmFileOp.Init;
{$IfEnd} //not Nemesis
{$If not defined(Nemesis)}
// ������������� str_l3mmFileOpFmt
 str_l3mmFileOpFmt.Init;
{$IfEnd} //not Nemesis
{$If defined(Nemesis)}
// ������������� str_l3mmFileOp
 str_l3mmFileOp.Init;
{$IfEnd} //Nemesis
{$If defined(Nemesis)}
// ������������� str_l3mmFileOpFmt
 str_l3mmFileOpFmt.Init;
{$IfEnd} //Nemesis

end.