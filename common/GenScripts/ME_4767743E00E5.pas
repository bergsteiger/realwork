unit TypInfo;
 {* ������ ��� ������ � RTTI. }

// ������: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Rtl\Common\TypInfo.pas"
// ���������: "Interfaces"
// ������� ������: "TypInfo" MUID: (4767743E00E5)

interface

uses
 l3IntfUses
;

type
 PTypeInfo = ^TTypeInfo;
  {* ���������� � ����. }

 PTypeData = ^TTypeData;

 PPropInfo = ^;

 TTypeInfo = record
  {* ���������� � ����. }
 end;//TTypeInfo

 TTypeData = record
 end;//TTypeData

 GetObjectProp = procedure;

implementation

uses
 l3ImplUses
;

end.
