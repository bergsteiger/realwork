unit m4Word;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m4"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/m4/m4Word.pas"
// Начат: 18.09.2009 12:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m4::Dict::Tm4Word
//
// Слово словаря
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
  l3_String,
  m4DictTypes
  ;

type
 Tm4Word = class(Tl3_String)
  {* Слово словаря }
 private
 // private fields
   f_ID : Tm4WordID;
   f_FirstWordIDStrID : Integer;
    {* Поле для свойства FirstWordIDStrID}
 protected
 // overridden property methods
   function pm_GetStringID: Integer; override;
   procedure pm_SetStringID(aValue: Integer); override;
 public
 // public methods
   constructor Create(const aStr: Tl3WString;
    anID: Tm4WordID); reintroduce;
 public
 // public properties
   property FirstWordIDStrID: Integer
     read f_FirstWordIDStrID
     write f_FirstWordIDStrID;
     {* Первый элемент словаря который начинается с данного слова }
 end;//Tm4Word

implementation

// start class Tm4Word

constructor Tm4Word.Create(const aStr: Tl3WString;
  anID: Tm4WordID);
//#UC START# *4AB37FB103D8_4AB37F0D0301_var*
//#UC END# *4AB37FB103D8_4AB37F0D0301_var*
begin
//#UC START# *4AB37FB103D8_4AB37F0D0301_impl*
 Make(aStr);
 f_ID := anID;
 f_FirstWordIDStrID := -1;
//#UC END# *4AB37FB103D8_4AB37F0D0301_impl*
end;//Tm4Word.Create

function Tm4Word.pm_GetStringID: Integer;
//#UC START# *47BC3BFD017F_4AB37F0D0301get_var*
//#UC END# *47BC3BFD017F_4AB37F0D0301get_var*
begin
//#UC START# *47BC3BFD017F_4AB37F0D0301get_impl*
 Result := f_ID;
//#UC END# *47BC3BFD017F_4AB37F0D0301get_impl*
end;//Tm4Word.pm_GetStringID

procedure Tm4Word.pm_SetStringID(aValue: Integer);
//#UC START# *47BC3BFD017F_4AB37F0D0301set_var*
//#UC END# *47BC3BFD017F_4AB37F0D0301set_var*
begin
//#UC START# *47BC3BFD017F_4AB37F0D0301set_impl*
 f_ID := aValue;
//#UC END# *47BC3BFD017F_4AB37F0D0301set_impl*
end;//Tm4Word.pm_SetStringID

end.