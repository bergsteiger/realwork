unit m4WordIDStr;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m4"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/m4/m4WordIDStr.pas"
// Начат: 18.09.2009 16:36
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m4::Dict::Tm4WordIDStr
//
// Элемент словаря. Список идентификаторов слов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m4\m4Define.inc}

interface

uses
  l3ProtoDataContainer,
  m4DictTypes,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Tm4WordID;
 _l3AtomicList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3AtomicList.imp.pas}
 Tm4WordIDStr = class(_l3AtomicList_)
  {* Элемент словаря. Список идентификаторов слов }
 private
 // private fields
   f_ID : Tm4DictItemAddr;
    {* Поле для свойства ID}
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   function Compare(anOther: Tm4WordIDStr): Integer;
   constructor Create(const anID: Tm4DictItemAddr); reintroduce;
 public
 // public properties
   property ID: Tm4DictItemAddr
     read f_ID;
 end;//Tm4WordIDStr

implementation

uses
  m2MemLib,
  l3MinMax,
  l3Base,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tm4WordIDStr;

{$Include w:\common\components\rtl\Garant\L3\l3AtomicList.imp.pas}

// start class Tm4WordIDStr

function Tm4WordIDStr.Compare(anOther: Tm4WordIDStr): Integer;
//#UC START# *4AB3856602A8_4AB37C3E00BA_var*
var
 l_Count : Integer;
//#UC END# *4AB3856602A8_4AB37C3E00BA_var*
begin
//#UC START# *4AB3856602A8_4AB37C3E00BA_impl*
 l_Count := Min(Count, anOther.Count);
 if (l_Count = 0) then
  Result := Count - anOther.Count
 else
 begin
  Result := m2MEMCompare(ItemSlot(0),
                         anOther.ItemSlot(0),
                         l_Count * SizeOf(_ItemType_));
  if (Result = 0) then
   Result := Count - anOther.Count
 end;//l_Count = 0
//#UC END# *4AB3856602A8_4AB37C3E00BA_impl*
end;//Tm4WordIDStr.Compare

constructor Tm4WordIDStr.Create(const anID: Tm4DictItemAddr);
//#UC START# *4AB38AF30255_4AB37C3E00BA_var*
//#UC END# *4AB38AF30255_4AB37C3E00BA_var*
begin
//#UC START# *4AB38AF30255_4AB37C3E00BA_impl*
 inherited Create;
 f_ID := anID;
//#UC END# *4AB38AF30255_4AB37C3E00BA_impl*
end;//Tm4WordIDStr.Create

procedure Tm4WordIDStr.ClearFields;
 {-}
begin
 Finalize(f_ID);
 inherited;
end;//Tm4WordIDStr.ClearFields

end.