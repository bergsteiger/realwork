unit m4WordIDStr;
 {* Элемент словаря. Список идентификаторов слов }

// Модуль: "w:\common\components\rtl\Garant\m4\m4WordIDStr.pas"
// Стереотип: "SimpleClass"

{$Include m4Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , m4DictTypes
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tm4WordID;
 _l3AtomicList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3AtomicList.imp.pas}
 Tm4WordIDStr = class(_l3AtomicList_)
  {* Элемент словаря. Список идентификаторов слов }
  private
   f_ID: Tm4DictItemAddr;
    {* Поле для свойства ID }
  protected
   procedure ClearFields; override;
  public
   function Compare(anOther: Tm4WordIDStr): Integer;
   constructor Create(const anID: Tm4DictItemAddr); reintroduce;
  public
   property ID: Tm4DictItemAddr
    read f_ID;
 end;//Tm4WordIDStr

implementation

uses
 l3ImplUses
 , m2MemLib
 , l3MinMax
 , l3Base
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = Tm4WordIDStr;

{$Include l3AtomicList.imp.pas}

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
begin
 Finalize(f_ID);
 inherited;
end;//Tm4WordIDStr.ClearFields

end.
