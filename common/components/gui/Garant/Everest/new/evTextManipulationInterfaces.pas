unit evTextManipulationInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/new/evTextManipulationInterfaces.pas"
// �����: 02.06.2009 19:43
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::nevUtils::evTextManipulationInterfaces
//
// ���������� ��� ��������� ������ � ������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  l3Types,
  l3CustomString
  ;

type
 IevTextOpProcessor = interface(IUnknown)
  {* ��������� ��������� �������� }
   ['{27DFA0BA-9D4F-45EE-A9DF-C99CE1840716}']
   procedure CheckTextOp(Text: Tl3CustomString;
    Op: Tl3Operation);
     {* ��������� �������� � ������� }
   procedure TextOp(Text: Tl3CustomString;
    Op: Tl3Operation);
     {* ��������� �������� � ������� }
 end;//IevTextOpProcessor

implementation

end.