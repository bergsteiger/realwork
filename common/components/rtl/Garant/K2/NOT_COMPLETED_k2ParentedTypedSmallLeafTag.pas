unit NOT_COMPLETED_k2ParentedTypedSmallLeafTag;
 {* ��������� ��� � ������� ����������� �����, ������� ������ �� �������� � ������� ����� �� ����� 32 (������������) ��������� }

// ������: "w:\common\components\rtl\Garant\K2\NOT_COMPLETED_k2ParentedTypedSmallLeafTag.pas"
// ���������: "SimpleClass"
// ������� ������: "Tk2ParentedTypedSmallLeafTag" MUID: (4A64874301F2)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2TypedSmallLeafTag
 , l3Variant
 //#UC START# *4A64874301F2intf_uses*
 //#UC END# *4A64874301F2intf_uses*
;

type
 //#UC START# *4A64874301F2ci*
 {$Define k2Tag_No_f_TagType}
 //#UC END# *4A64874301F2ci*
 _k2ParentedTagObject_Parent_ = Tk2TypedSmallLeafTag;
 {$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}
 //#UC START# *4A64874301F2cit*
 //#UC END# *4A64874301F2cit*
 Tk2ParentedTypedSmallLeafTag = class(_k2ParentedTagObject_)
  {* ��������� ��� � ������� ����������� �����, ������� ������ �� �������� � ������� ����� �� ����� 32 (������������) ��������� }
 //#UC START# *4A64874301F2publ*
 //#UC END# *4A64874301F2publ*
 end;//Tk2ParentedTypedSmallLeafTag

implementation

uses
 l3ImplUses
 , k2Base
 , k2NullTagImpl
 , l3BitArr
 //#UC START# *4A64874301F2impl_uses*
 //#UC END# *4A64874301F2impl_uses*
;

{$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}

//#UC START# *4A64874301F2impl*
//#UC END# *4A64874301F2impl*

end.
