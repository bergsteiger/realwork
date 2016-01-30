unit vcmFormDispatcherListenerList;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmFormDispatcherListenerList.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmFormDispatcherInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IvcmFormDispatcherListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfacePtrList.imp.pas}
 TvcmFormDispatcherListenerList = class(_l3InterfacePtrList_)
 end;//TvcmFormDispatcherListenerList
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

type _Instance_R_ = TvcmFormDispatcherListenerList;

{$Include l3InterfacePtrList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
