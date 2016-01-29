unit l3MemorySizeUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3$Basic Concepts"
// Модуль: "l3MemorySizeUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: UtilityPack::Class Shared Delphi Требования к низкоуровневым библиотекам::L3$Basic Concepts::MemoryUtils::l3MemorySizeUtils
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\L3\l3Define.inc}

interface

uses
  l3MemorySizeUtilsPrim
  ;

type
 PMem = System.PANSIChar;

{$If not defined(XE)}
var l3MemorySize : Tl3MemorySizeFunc = L3MemorySizeDelphi7;
 {* функция для получения размера куска памяти}
{$IfEnd} //not XE

{$If defined(XE)}
var l3MemorySize : Tl3MemorySizeFunc = L3MemorySizeXE;
 {* функция для получения размера куска памяти}
{$IfEnd} //XE

implementation

end.