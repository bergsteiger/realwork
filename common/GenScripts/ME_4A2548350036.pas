unit evTextManipulationInterfaces;
 {* ���������� ��� ��������� ������ � ������� ��������� }

// ������: "w:\common\components\gui\Garant\Everest\new\evTextManipulationInterfaces.pas"
// ���������: "UtilityPack"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3CustomString
 , l3Types
;

type
 IevTextOpProcessor = interface
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

uses
 l3ImplUses
;

end.
