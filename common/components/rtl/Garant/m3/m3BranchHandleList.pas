unit m3BranchHandleList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3BranchHandleList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::m3CoreObjects::Tm3BranchHandleList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3BranchHandle,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 Tm3WideString = record
   rValue : PWideChar;
   rLength : Integer;
 end;//Tm3WideString

 _ItemType_ = Tm3BranchHandle;
 _KeyType_ = Tm3WideString;
 {$Include ..\m3\m3ListWithFind.imp.pas}
 Tm3BranchHandleList = class(_m3ListWithFind_)
 protected
 // realized methods
   function CompareKeyByItem(const aKey: _KeyType_;
     const anItem: _ItemType_): Integer; override;
 end;//Tm3BranchHandleList

function Tm3WideString_C(const aValue: WideString): Tm3WideString; overload;
function Tm3WideString_C(aValue: PWideChar;
     aLength: Integer): Tm3WideString; overload;

implementation

uses
  m3BranchHandlePrim,
  m3WideStringManager,
  m2MemLib,
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tm3BranchHandleList;

{$Include ..\m3\m3ListWithFind.imp.pas}


function Tm3WideString_C(const aValue: WideString): Tm3WideString;
//#UC START# *545B853F0209_545B84B70269_var*
//#UC END# *545B853F0209_545B84B70269_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *545B853F0209_545B84B70269_impl*
 Result := Tm3WideString_C(PWideChar(aValue), Length(aValue));
//#UC END# *545B853F0209_545B84B70269_impl*
end;//Tm3WideString.C



function Tm3WideString_C(aValue: PWideChar;
        aLength: Integer): Tm3WideString;
//#UC START# *545B855D01A3_545B84B70269_var*
//#UC END# *545B855D01A3_545B84B70269_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *545B855D01A3_545B84B70269_impl*
 Result.rValue := aValue;
 Result.rLength := aLength;
//#UC END# *545B855D01A3_545B84B70269_impl*
end;//Tm3WideString.C

// start class Tm3BranchHandleList

function Tm3BranchHandleList.CompareKeyByItem(const aKey: _KeyType_;
  const anItem: _ItemType_): Integer;
//#UC START# *5421A06902CD_5453BC4F0348_var*
//#UC END# *5421A06902CD_5453BC4F0348_var*
begin
//#UC START# *5421A06902CD_5453BC4F0348_impl*
 Result := m2MEMCompare(Pointer(aKey.rValue),
                        aKey.rLength * SizeOf(WideChar),
                        Pointer(anItem.Data.Value),
                        Tm3WideStringManager.ItemLength(anItem.Data.Value) * SizeOf(WideChar));
//#UC END# *5421A06902CD_5453BC4F0348_impl*
end;//Tm3BranchHandleList.CompareKeyByItem

end.