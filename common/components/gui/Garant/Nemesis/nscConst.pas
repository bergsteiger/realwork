unit nscConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// ������: "w:/common/components/gui/Garant/Nemesis/nscConst.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For F1::Nemesis::CoreObjects::nscConst
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Graphics
  ;

const
  { nscConst }
 cDefaultContextEmptyColor = Graphics.clGrayText;
 cPlusKeyCode = 188;
 cMinusKeyCode = 189;
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
{$IfEnd} //Nemesis
end.