unit TipsUnit;
 {* ����� ��� }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\TipsUnit.pas"
// ���������: "Interfaces"
// ������� ������: "Tips" MUID: (47B30C7D02F3)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
 , DynamicTreeUnit
;

type
 ITipsManager = interface
  {* �������� ������� ��� }
  ['{E7AFD5DA-77C8-4E4E-95C3-D54CBB8CD5D7}']
  function GetTipsTreeRoot: INodeBase; stdcall; { can raise CanNotFindData }
  function GetCurrentTip: INodeIndexPath; stdcall;
   {* �������� ������� (�� ��������) ����� ��� }
  function IsExist: ByteBool; stdcall;
  property TipsTreeRoot: INodeBase
   read GetTipsTreeRoot;
   {* ��� ������ ����� ��� }
 end;//ITipsManager

implementation

uses
 l3ImplUses
;

end.
