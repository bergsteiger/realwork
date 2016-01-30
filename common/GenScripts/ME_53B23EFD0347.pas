unit OvcKeyDataListenerList;

// Модуль: "w:\common\components\rtl\external\Orpheus\OvcKeyDataListenerList.pas"
// Стереотип: "SimpleClass"

{$Include OVC.INC}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3InternalInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Il3KeyDataListener;
 _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfacePtrList.imp.pas}
 TOvcKeyDataListenerList = class(_l3InterfacePtrList_)
 end;//TOvcKeyDataListenerList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TOvcKeyDataListenerList;

{$Include l3InterfacePtrList.imp.pas}

end.
