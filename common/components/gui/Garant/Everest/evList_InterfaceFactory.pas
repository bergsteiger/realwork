unit evList_InterfaceFactory;
 {* ������� ����������� ��� ������ ����� }

// ���������� "Everest"
// �����: ����� �.�.
// ������: evList_InterfaceFactory
// �����: 18.06.2008 15:13

{$Include evDefine.inc}

interface

{$IfDef Archi}
uses
  evListBlock
  ;

type
 TevListInterfaceFactory = evListBlock.TevListInterfaceFactory;
  {* ������� ����������� ��� ������ ����� }
{$EndIf Archi}

implementation

end.