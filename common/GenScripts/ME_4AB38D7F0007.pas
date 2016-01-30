unit m4DictTypes;

// Модуль: "w:\common\components\rtl\Garant\m4\m4DictTypes.pas"
// Стереотип: "UtilityPack"

{$Include m4Define.inc}

interface

uses
 l3IntfUses
;

type
 Tm4DictItemID = Integer;
  {* Идентификатор элемента словаря }

 Tm4WordID = Integer;
  {* Буква в строке }

 Tm4DictItemAddr = record
  rID: Tm4DictItemID;
  rDictionaryID: Integer;
 end;//Tm4DictItemAddr

function Tm4DictItemAddr_C: Tm4DictItemAddr;

implementation

uses
 l3ImplUses
;

function Tm4DictItemAddr_C: Tm4DictItemAddr;
//#UC START# *4ABA24E701F2_4ABA246700B4_var*
//#UC END# *4ABA24E701F2_4ABA246700B4_var*
begin
//#UC START# *4ABA24E701F2_4ABA246700B4_impl*
 Result.rID := anID;
 Result.rDictionaryID := aDictionaryID;
//#UC END# *4ABA24E701F2_4ABA246700B4_impl*
end;//Tm4DictItemAddr_C

end.
