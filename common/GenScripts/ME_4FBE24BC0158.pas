unit k2ParentedTypedHugeListTag;
 {* ������ ���������� � ������ ��������� ������ 32 }

// ������: "w:\common\components\rtl\Garant\K2\k2ParentedTypedHugeListTag.pas"
// ���������: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2TypedHugeListTag
 , l3Variant
;

type
 _k2ParentedTagObject_Parent_ = Tk2TypedHugeListTag;
 {$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}
 Tk2ParentedTypedHugeListTag = class(_k2ParentedTagObject_)
  {* ������ ���������� � ������ ��������� ������ 32 }
 end;//Tk2ParentedTypedHugeListTag

implementation

uses
 l3ImplUses
 , k2Base
 , k2NullTagImpl
;

{$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}

end.
