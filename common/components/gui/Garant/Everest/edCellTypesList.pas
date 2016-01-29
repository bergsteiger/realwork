unit edCellTypesList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/edCellTypesList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::CellUtils::TedCellTypesList
//
// Список для хранения типов содержимого ячеек.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3SimpleDataContainer,
  evEditorInterfaces,
  l3Memory,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Except,
  Classes
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
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TedCellTypesList;

{$Include w:\common\components\rtl\Garant\L3\l3EnumList.imp.pas}

end.