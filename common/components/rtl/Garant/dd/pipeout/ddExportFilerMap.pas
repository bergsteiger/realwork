unit ddExportFilerMap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/PipeOut/ddExportFilerMap.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::PipeOut::TddExportFilerMap
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
  ddPipeOutInterfaces,
  l3ProtoDataContainer,
  l3Memory,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Except,
  Classes
  ;

type
 _KeyType_ = TddFilerDispatcherMapKeyRecord;
 _ValueType_ = IddExportFilerDispatcherElem;
 {$Include w:\common\components\rtl\Garant\L3\l3Map.imp.pas}
 TddExportFilerMap = class(_l3Map_)
 end;//TddExportFilerMap

implementation

uses
  l3String,
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TddExportFilerMap

function CompareKeys(const aA: _KeyType_;
  const aB: _KeyType_): Integer;
//#UC START# *5609091B00C0_560A38A50349_var*
//#UC END# *5609091B00C0_560A38A50349_var*
begin
//#UC START# *5609091B00C0_560A38A50349_impl*
 if aA.rPart > aB.rPart then
  Result := 1
 else
 if aA.rPart < aB.rPart then
  Result := -1
 else
 Result := l3Compare(aA.rAccGroup.AsWStr, aB.rAccGroup.AsWStr);
//#UC END# *5609091B00C0_560A38A50349_impl*
end;//CompareKeys

type _Instance_R_ = TddExportFilerMap;

{$Include w:\common\components\rtl\Garant\L3\l3Map.imp.pas}

end.