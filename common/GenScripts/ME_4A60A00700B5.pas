unit l3DataContainerWithoutIUnknown;
 {* ��������� ������ ��� ���������� IUnknown, �� �� ���� ������������ ���������� }

// ������: "w:\common\components\rtl\Garant\L3\l3DataContainerWithoutIUnknown.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3DataContainerWithoutIUnknownPrim
 , l3PureMixIns
;

type
 _l3Changing_Parent_ = Tl3DataContainerWithoutIUnknownPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}
 Tl3DataContainerWithoutIUnknown = {abstract} class(_l3Changing_)
  {* ��������� ������ ��� ���������� IUnknown, �� �� ���� ������������ ���������� }
 end;//Tl3DataContainerWithoutIUnknown

implementation

uses
 l3ImplUses
 , l3IID
 , l3InterfacesMisc
;

{$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}

end.
