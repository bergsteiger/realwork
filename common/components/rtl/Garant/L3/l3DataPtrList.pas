unit l3DataPtrList;
 {* Список указателей на куски памяти. Ничего не освобождает. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3DataPtrList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3DataPtrList" MUID: (4773DD2700DA)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

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
 _ItemType_ = Pointer;
 _l3DataPtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3DataPtrList.imp.pas}
 Tl3DataPtrList = class(_l3DataPtrList_)
  {* Список указателей на куски памяти. Ничего не освобождает. }
 end;//Tl3DataPtrList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4773DD2700DAimpl_uses*
 //#UC END# *4773DD2700DAimpl_uses*
;

type _Instance_R_ = Tl3DataPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3DataPtrList.imp.pas}

end.
