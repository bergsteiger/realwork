unit l3OldInterfaceIDs;

// ������: "w:\common\components\rtl\Garant\L3\l3OldInterfaceIDs.pas"
// ���������: "Interfaces"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3IID
;

const
 ev_iidCursor: Tl3IID = (IID: 0);
  {* ������ ������� }
 ev_iidBlock: Tl3IID = (IID: 1);
  {* ��������� ����� ������� }

implementation

uses
 l3ImplUses
;

end.
