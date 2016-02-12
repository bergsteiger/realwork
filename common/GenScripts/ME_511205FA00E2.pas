unit edCellTypesList;
 {* Список для хранения типов содержимого ячеек. }

// Модуль: "w:\common\components\gui\Garant\Everest\edCellTypesList.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , evEditorInterfaces
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
  {* Список для хранения типов содержимого ячеек. }
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
