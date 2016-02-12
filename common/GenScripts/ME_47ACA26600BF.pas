unit l3InterfacePtrList;
 {* Список УКАЗАТЕЛЕЙ на интерфейсы. Не владеет ими. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3InterfacePtrList.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IUnknown;
 _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 Tl3InterfacePtrList = class(_l3InterfacePtrList_)
  {* Список УКАЗАТЕЛЕЙ на интерфейсы. Не владеет ими. }
 end;//Tl3InterfacePtrList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = Tl3InterfacePtrList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.
