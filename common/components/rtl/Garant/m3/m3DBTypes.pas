unit m3DBTypes;

// ������: "w:\common\components\rtl\Garant\m3\m3DBTypes.pas"
// ���������: "Interfaces"
// ������� ������: "m3DBTypes" MUID: (578F46AF0276)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
;

type
 Tm3DocPartSelector = (
  m3_dsMain
   {* �������� ����� }
  , m3_dsAnno
   {* ��������� }
  , m3_dsInfo
   {* ���������� � ��������� }
  , m3_dsObject
   {* ������ � ��������� }
 );//Tm3DocPartSelector

const
 m3_AllDocParts = [Low(Tm3DocPartSelector) .. High(Tm3DocPartSelector)];

implementation

uses
 l3ImplUses
;

end.
