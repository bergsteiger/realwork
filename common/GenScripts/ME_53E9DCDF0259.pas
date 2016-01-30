unit vcmMenuItemClickListenerList;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenuItemClickListenerList.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3SimpleDataContainer
 , vcmMenuManagerTypes
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IvcmMenuItemClickListener;
 _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfacePtrList.imp.pas}
 TvcmMenuItemClickListenerList = class(_l3InterfacePtrList_)
 end;//TvcmMenuItemClickListenerList
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

type _Instance_R_ = TvcmMenuItemClickListenerList;

{$Include l3InterfacePtrList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
