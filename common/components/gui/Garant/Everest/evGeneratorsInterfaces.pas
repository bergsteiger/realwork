unit evGeneratorsInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evGeneratorsInterfaces.pas"
// Начат: 02.06.2009 18:52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Generators::evGeneratorsInterfaces
//
// Интерфейсы для поддержки работы генераторов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevBase,
  l3Base,
  l3Variant
  ;

type
 IevTextPainter = interface(IUnknown)
   ['{4840242F-084A-4805-9EB0-90C1126C5137}']
   procedure PaintLine(ParaVisible: Boolean;
    ParaStyle: Integer;
    S: Tl3String;
    Ob: Tl3Variant;
    First: Boolean;
    Last: Boolean);
     {* Процедура для "покраски" сегментов текста }
   procedure ValidateLine(aLine: Tl3String;
    aCodePage: Integer);
     {* Процедура для проверки корректности строки }
   procedure ValidateText(aText: Tl3String;
    aValidateText: Tl3String = nil);
     {* Проверяет строку на наличие одинаковых сегментов "утратил силу" и "Не вступил в силу" и если возможно объединяет их (пририсовывая ко всему тексту). Если aValidateText <> nil проверяем по этой строке, а aText только изменяем. }
   function IsStyleEqual(aParaStyle: Integer;
    aSegmentStyle: Integer): Boolean;
     {* Сравнивает два стиля с точки зрения выливки в NSRC. }
 end;//IevTextPainter

 IevJoinGenerator = interface(IUnknown)
  {* Объект определяющий надо ли объединять параграфы при вставке }
   ['{8772A98D-28F8-446E-9879-9B32BE75D08D}']
   procedure pm_SetNeedJoin(aValue: Boolean);
   procedure pm_SetAtEnd(aValue: Boolean);
   procedure pm_SetNeedSkipSubDocuments(aValue: Boolean);
   procedure Set_LoadFlags(aValue: TevLoadFlags);
   property NeedJoin: Boolean
     write pm_SetNeedJoin;
     {* Свойство определяющее надо ли объединять параграфы при вставке }
   property AtEnd: Boolean
     write pm_SetAtEnd;
   property NeedSkipSubDocuments: Boolean
     write pm_SetNeedSkipSubDocuments;
   property LoadFlags: TevLoadFlags
     write Set_LoadFlags;
     {* Флаги загрузки }
 end;//IevJoinGenerator

 IevNSRCExport = interface(IUnknown)
   ['{E627D909-251B-410E-95CF-C8BAD64F222A}']
   procedure SetExportDirectory(const aDirName: AnsiString);
   procedure SetExternalDocHandle(anID: Integer);
 end;//IevNSRCExport

implementation

end.