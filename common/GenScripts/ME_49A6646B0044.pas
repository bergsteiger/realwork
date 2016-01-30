unit k2BaseTypes;
 {* ������� ���� ����������. �� ��� ��������� �������� ����������� }

// ������: "w:\common\components\rtl\Garant\L3\k2BaseTypes.pas"
// ���������: "Interfaces"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
;

type
 Tk2StorePropertyFlag = (
  {* ����� ���������� ����� �����. }
  l3_spfScalars
  , l3_spfObjects
  , l3_spfChildren
  , l3_spfRawData
 );//Tk2StorePropertyFlag

 Tk2StorePropertyFlags = set of Tk2StorePropertyFlag;
  {* ������ ���������� ����� �����. }

 // l3_spfAll

 // l3_spfInner

 Tk2AssignMode = (
  {* ����� ����������� ������������ �����. }
  k2_amNull
  , k2_amTransparent
 );//Tk2AssignMode

 Tk2AssignModes = set of Tk2AssignMode;
  {* ������ ����������� ������������ �����. }

 // k2_amAll

implementation

uses
 l3ImplUses
;

end.
