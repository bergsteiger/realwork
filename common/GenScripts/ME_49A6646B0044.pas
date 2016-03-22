unit k2BaseTypes;
 {* ������� ���� ����������. �� ��� ��������� �������� ����������� }

// ������: "w:\common\components\rtl\Garant\L3\k2BaseTypes.pas"
// ���������: "Interfaces"
// ������� ������: "k2BaseTypes" MUID: (49A6646B0044)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

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

 Tk2AssignMode = (
  {* ����� ����������� ������������ �����. }
  k2_amNull
  , k2_amTransparent
 );//Tk2AssignMode

 Tk2AssignModes = set of Tk2AssignMode;
  {* ������ ����������� ������������ �����. }

const
 {* ����� ���������� ���� ����� �����. }
 l3_spfAll = [Low(Tk2StorePropertyFlag) .. High(Tk2StorePropertyFlag)];
 {* ����� ���������� ���� ��������� ����� �������. }
 l3_spfInner = l3_spfAll;
 {* ����� ����������� ���� �������� �����. }
 k2_amAll = [Low(Tk2AssignMode) .. High(Tk2AssignMode)];

implementation

uses
 l3ImplUses
;

end.
