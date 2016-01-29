unit vcmOperationsCollectionItemList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Components/vcmOperationsCollectionItemList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Components::TvcmOperationsCollectionItemList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3ProtoDataContainer,
  vcmOperationsCollectionItem,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 _ItemType_ = TvcmOperationsCollectionItem;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 TvcmOperationsCollectionItemList = class(_l3ObjectPtrList_)
 end;//TvcmOperationsCollectionItemList
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

type _Instance_R_ = TvcmOperationsCollectionItemList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}


{$IfEnd} //not NoVCM
end.