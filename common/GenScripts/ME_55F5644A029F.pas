unit vcmZoneTypeList;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmZoneTypeList.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmBaseTypes
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TvcmZoneType;
 _l3EnumList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3EnumList.imp.pas}
 TvcmZoneTypeList = class(_l3EnumList_)
 end;//TvcmZoneTypeList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TvcmZoneTypeList;

{$Include l3EnumList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
