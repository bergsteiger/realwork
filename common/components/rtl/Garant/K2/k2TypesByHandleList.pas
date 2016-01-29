unit k2TypesByHandleList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2TypesByHandleList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2PrimObjects::Tk2TypesByHandleList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

 {$Define l3Items_NoSort}

type
 _ItemType_ = Tk2Type;
 _l3UnrefcountedList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UnrefcountedList.imp.pas}
 _l3OpenArray_Parent_ = _l3UnrefcountedList_;
 {$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}
 Tk2TypesByHandleList = class(_l3OpenArray_)
 end;//Tk2TypesByHandleList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}
{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

// start class Tk2TypesByHandleList

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_5273AB0F00C2_var*
//#UC END# *47B99D4503A2_5273AB0F00C2_var*
begin
//#UC START# *47B99D4503A2_5273AB0F00C2_impl*
 Assert(false);
 Result := -1;
//#UC END# *47B99D4503A2_5273AB0F00C2_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2TypesByHandleList;

{$Include w:\common\components\rtl\Garant\L3\l3UnrefcountedList.imp.pas}


{$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}

end.