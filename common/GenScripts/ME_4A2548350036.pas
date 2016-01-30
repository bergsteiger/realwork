unit evTextManipulationInterfaces;
 {* Интерфейсы для поддержки работы с текстом документа }

// Модуль: "w:\common\components\gui\Garant\Everest\new\evTextManipulationInterfaces.pas"
// Стереотип: "UtilityPack"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3CustomString
 , l3Types
;

type
 IevTextOpProcessor = interface
  {* Процессор текстовых операций }
  ['{27DFA0BA-9D4F-45EE-A9DF-C99CE1840716}']
  procedure CheckTextOp(Text: Tl3CustomString;
   Op: Tl3Operation);
   {* Проверить операцию с текстом }
  procedure TextOp(Text: Tl3CustomString;
   Op: Tl3Operation);
   {* Завершить операцию с текстом }
 end;//IevTextOpProcessor

implementation

uses
 l3ImplUses
;

end.
