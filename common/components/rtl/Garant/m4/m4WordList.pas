unit m4WordList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m4"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/m4/m4WordList.pas"
// Начат: 18.09.2009 12:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m4::Dict::Tm4WordList
//
// Список слов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m4\m4Define.inc}

interface

uses
  l3Interfaces,
  l3StringList,
  m4Word,
  m4DictTypes
  ;

type
 Tm4WordList = class(Tl3StringList)
  {* Список слов }
 private
 // private fields
   f_NextID : Tm4WordID;
 protected
 // overridden protected methods
   procedure InitFields; override;
 public
 // public methods
   function AddWord(const aStr: Tl3WString): Tm4WordID;
   constructor Create; reintroduce;
 end;//Tm4WordList

implementation

uses
  SysUtils,
  l3Types
  ;

// start class Tm4WordList

function Tm4WordList.AddWord(const aStr: Tl3WString): Tm4WordID;
//#UC START# *4AB38FE40091_4AB37F2003B6_var*
//#UC END# *4AB38FE40091_4AB37F2003B6_var*
var
 l_Item : Tm4Word;
 l_Index : Integer;
begin
//#UC START# *4AB38FE40091_4AB37F2003B6_impl*
 if not FindData(aStr, l_Index, l3_siCaseUnSensitive) then
 begin
  Result := f_NextID;
  l_Item := Tm4Word.Create(aStr, f_NextID);
  try
   Inc(f_NextID);
   DirectInsert(l_Index, l_Item);
  finally
   FreeAndNil(l_Item);
  end;//try..finally
 end//not Find(aStr, l_Index)
 else
  Result := Items[l_Index].StringID;
//#UC END# *4AB38FE40091_4AB37F2003B6_impl*
end;//Tm4WordList.AddWord

constructor Tm4WordList.Create;
//#UC START# *4AB38F9800B8_4AB37F2003B6_var*
//#UC END# *4AB38F9800B8_4AB37F2003B6_var*
begin
//#UC START# *4AB38F9800B8_4AB37F2003B6_impl*
 MakeSorted;
 SortIndex := l3_siCaseUnSensitive;
//#UC END# *4AB38F9800B8_4AB37F2003B6_impl*
end;//Tm4WordList.Create

procedure Tm4WordList.InitFields;
//#UC START# *47A042E100E2_4AB37F2003B6_var*
//#UC END# *47A042E100E2_4AB37F2003B6_var*
begin
//#UC START# *47A042E100E2_4AB37F2003B6_impl*
 inherited;
 f_NextID := 1;
//#UC END# *47A042E100E2_4AB37F2003B6_impl*
end;//Tm4WordList.InitFields

end.