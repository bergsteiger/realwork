unit l3ProtoDataContainer;
 {* ����� ����������� ��������� ������ }

// ������: "w:\common\components\rtl\Garant\L3\l3ProtoDataContainer.pas"
// ���������: "SimpleClass"
// ������� ������: "Tl3ProtoDataContainer" MUID: (4A54DD4E036F)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 _l3DataContainer_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3DataContainer.imp.pas}
 Tl3ProtoDataContainer = {abstract} class(_l3DataContainer_)
  {* ����� ����������� ��������� ������ }
 end;//Tl3ProtoDataContainer

implementation

uses
 l3ImplUses
;

{$Include w:\common\components\rtl\Garant\L3\l3DataContainer.imp.pas}

end.
