unit m4DictTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m4"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/m4/m4DictTypes.pas"
// Начат: 18.09.2009 17:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::m4::Dict::m4DictTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m4\m4Define.inc}

interface

type
 Tm4DictItemID = System.Integer;
  {* Идентификатор элемента словаря }

 Tm4WordID = System.Integer;
  {* Буква в строке }

 Tm4DictItemAddr = record
   rID : Tm4DictItemID;
   rDictionaryID : Integer;
 end;//Tm4DictItemAddr

function Tm4DictItemAddr_C(anID: Tm4DictItemID;
    aDictionaryID: Integer): Tm4DictItemAddr;

implementation

function Tm4DictItemAddr_C(anID: Tm4DictItemID;
       aDictionaryID: Integer): Tm4DictItemAddr;
//#UC START# *4ABA24E701F2_4ABA246700B4_var*
//#UC END# *4ABA24E701F2_4ABA246700B4_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4ABA24E701F2_4ABA246700B4_impl*
 Result.rID := anID;
 Result.rDictionaryID := aDictionaryID;
//#UC END# *4ABA24E701F2_4ABA246700B4_impl*
end;//Tm4DictItemAddr.C

end.