unit ddRTFReaderSpec;
 {* Читалка со специальынми заточками. }

// Модуль: "w:\common\components\rtl\Garant\dd\ddRTFReaderSpec.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , ddRTFReader
 , destNorm
;

type
 TddRTFReaderSpec = class(TddRTFReader)
  {* Читалка со специальынми заточками. }
  protected
   function GetdestNormClass: RdestNorm; override;
 end;//TddRTFReaderSpec

implementation

uses
 l3ImplUses
 , destNormSpec
;

function TddRTFReaderSpec.GetdestNormClass: RdestNorm;
//#UC START# *56BB204702E6_56BB14B90213_var*
//#UC END# *56BB204702E6_56BB14B90213_var*
begin
//#UC START# *56BB204702E6_56BB14B90213_impl*
 !!! Needs to be implemented !!!
//#UC END# *56BB204702E6_56BB14B90213_impl*
end;//TddRTFReaderSpec.GetdestNormClass

end.
