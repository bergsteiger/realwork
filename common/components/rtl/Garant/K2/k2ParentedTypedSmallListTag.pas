unit k2ParentedTypedSmallListTag;
 {* ������ ����� �� ������� �� �������� }

// ������: "w:\common\components\rtl\Garant\K2\k2ParentedTypedSmallListTag.pas"
// ���������: "SimpleClass"
// ������� ������: "Tk2ParentedTypedSmallListTag" MUID: (527D053500AA)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2TypedSmallListTag
 , l3Variant
;

type
 _k2ParentedTagObject_Parent_ = Tk2TypedSmallListTag;
 {$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}
 Tk2ParentedTypedSmallListTag = class(_k2ParentedTagObject_)
  {* ������ ����� �� ������� �� �������� }
 end;//Tk2ParentedTypedSmallListTag

implementation

uses
 l3ImplUses
 , k2Base
 , k2NullTagImpl
 , l3BitArr
 , l3Memory
 //#UC START# *527D053500AAimpl_uses*
 //#UC END# *527D053500AAimpl_uses*
;

{$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}

end.
