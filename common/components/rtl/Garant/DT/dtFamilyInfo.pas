unit dtFamilyInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DT"
// Модуль: "w:/common/components/rtl/Garant/DT/dtFamilyInfo.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DT::DbInfo::TdtFamilyInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DT\DtDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TdtFamilyInfo = class(Tl3ProtoObject)
 public
 // public fields
   Number : Integer;
   Name : AnsiString;
   Path : AnsiString;
   DocGroup : Integer;
   Attributes : Integer;
 end;//TdtFamilyInfo
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}


{$IfEnd} //not Nemesis
end.