unit l3StringMapPrim;

// ������: "w:\common\components\gui\Garant\VCM\Implementation\l3StringMapPrim.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Variant
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 {$Define l3Items_NeedsBeforeFreeItem}

 {$Undef l3Items_NoSort}

type
 _l3StringList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3StringList.imp.pas}
 Tl3StringMapPrim = class(_l3StringList_)
 end;//Tl3StringMapPrim
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3String
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = Tl3StringMapPrim;

{$Include w:\common\components\rtl\Garant\L3\l3StringList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
