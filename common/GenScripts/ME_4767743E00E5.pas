unit TypInfo;
 {* ������ ��� ������ � RTTI. }

// ������: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Rtl\Common\TypInfo.pas"
// ���������: "Interfaces"

interface

uses
 l3IntfUses
;

type
 TTypeInfo = record
  {* ���������� � ����. }
 end;//TTypeInfo

 PTypeInfo = ^TTypeInfo;
  {* ���������� � ����. }

 TTypeData = record
 end;//TTypeData

 PTypeData = ^TTypeData;

 GetObjectProp = procedure;

 PPropInfo = ^;

implementation

uses
 l3ImplUses
;

end.
