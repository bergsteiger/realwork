unit ddRTFReaderSpec;
 {* ������� �� ������������ ���������. }

// ������: "w:\common\components\rtl\Garant\dd\ddRTFReaderSpec.pas"
// ���������: "SimpleClass"
// ������� ������: "TddRTFReaderSpec" MUID: (56BB14B90213)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddRTFReader
 , destNorm
;

type
 TddRTFReaderSpec = class(TddRTFReader)
  {* ������� �� ������������ ���������. }
  protected
   function GetdestNormClass: RdestNorm; override;
 end;//TddRTFReaderSpec

implementation

uses
 l3ImplUses
 , destNormSpec
 //#UC START# *56BB14B90213impl_uses*
 //#UC END# *56BB14B90213impl_uses*
;

function TddRTFReaderSpec.GetdestNormClass: RdestNorm;
//#UC START# *56BB204702E6_56BB14B90213_var*
//#UC END# *56BB204702E6_56BB14B90213_var*
begin
//#UC START# *56BB204702E6_56BB14B90213_impl*
 Result := TdestNormSpec;
//#UC END# *56BB204702E6_56BB14B90213_impl*
end;//TddRTFReaderSpec.GetdestNormClass

end.
