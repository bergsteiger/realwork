unit edCellTypesList;
 {* —писок дл€ хранени€ типов содержимого €чеек. }

// ћодуль: "w:\common\components\gui\Garant\Everest\edCellTypesList.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TedCellTypesList" MUID: (511205FA00E2)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , evEditorInterfacesTypes
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TedCellType;
 _l3EnumList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3EnumList.imp.pas}
 TedCellTypesList = class(_l3EnumList_)
  {* —писок дл€ хранени€ типов содержимого €чеек. }
 end;//TedCellTypesList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TedCellTypesList;

{$Include w:\common\components\rtl\Garant\L3\l3EnumList.imp.pas}

end.
