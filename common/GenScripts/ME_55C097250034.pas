unit vcmFormDataSourceList;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormDataSourceList.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IvcmFormDataSource;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfaceRefList.imp.pas}
 TvcmFormDataSourceList = class(_l3InterfaceRefList_)
 end;//TvcmFormDataSourceList
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

type _Instance_R_ = TvcmFormDataSourceList;

{$Include l3InterfaceRefList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
