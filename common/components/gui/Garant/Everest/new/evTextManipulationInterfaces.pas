unit evTextManipulationInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/evTextManipulationInterfaces.pas"
// Начат: 02.06.2009 19:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::nevUtils::evTextManipulationInterfaces
//
// Интерфейсы для поддержки работы с текстом документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  l3Types,
  l3CustomString
  ;

type
 IevTextOpProcessor = interface(IUnknown)
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

end.