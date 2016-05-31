unit k2Types;
 {* ������� ����. }

// ������: "w:\common\components\rtl\Garant\K2\k2Types.pas"
// ���������: "Interfaces"
// ������� ������: "k2Types" MUID: (469F886F010C)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2Interfaces
 , l3Variant
;

const
 {* ������ ��� �������� k2Interfaces.Tk2TypeKind }
 k2_tkInteger = k2Interfaces.k2_tkInteger;
 k2_tkBool = k2Interfaces.k2_tkBool;
 k2_tkObject = k2Interfaces.k2_tkObject;
 k2_tkTransparent = k2Interfaces.k2_tkTransparent;
 k2_tkStream = k2Interfaces.k2_tkStream;
 {* ������ ��� �������� l3Variant.Tk2VarKind }
 k2_vkInteger = l3Variant.k2_vkInteger;
 k2_vkString = l3Variant.k2_vkString;
 k2_vkTransparent = l3Variant.k2_vkTransparent;
 k2_vkStream = l3Variant.k2_vkStream;

type
 Tk2TypeKind = k2Interfaces.Tk2TypeKind;

 Tk2VarKind = l3Variant.Tk2VarKind;

 Tk2Variant = k2Interfaces.Tk2Variant;

implementation

uses
 l3ImplUses
;

end.
