unit PrefixTreeUnit;
 {* ������ ��� ��� �������� ���������� }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\PrefixTreeUnit.pas"
// ���������: "Interfaces"
// ������� ������: "PrefixTree" MUID: (45F1207C0197)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
 , DynamicTreeUnit
 , SearchDefinesUnit
 , IOUnit
 , DynamicTreeDefinesUnit
;

type
 IPrefixNode = interface(INodeBase)
  {* ���� �������� ��� �������� ���������� }
  ['{9EC9825A-DC26-4939-8C4B-D8473E03E283}']
 end;//IPrefixNode

implementation

uses
 l3ImplUses
;

end.
