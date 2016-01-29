unit evGeneratorsInterfaces;

interface

uses
 l3IntfUses
 , l3Base
 , l3Variant
 , nevBase
;

type
 IevTextPainter = interface
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
   aValidateText: Tl3String);
   {* Проверяет строку на наличие одинаковых сегментов "утратил силу" и "Не вступил в силу" и если возможно объединяет их (пририсовывая ко всему тексту). Если aValidateText <> nil проверяем по этой строке, а aText только изменяем. }
  function IsStyleEqual(aParaStyle: Integer;
   aSegmentStyle: Integer): Boolean;
   {* Сравнивает два стиля с точки зрения выливки в NSRC. }
 end;//IevTextPainter
 
 IevJoinGenerator = interface
  {* Объект определяющий надо ли объединять параграфы при вставке }
 end;//IevJoinGenerator
 
 IevNSRCExport = interface
  procedure SetExportDirectory(const aDirName: AnsiString);
  procedure SetExternalDocHandle(anID: Integer);
 end;//IevNSRCExport
 
implementation

uses
 l3ImplUses
;

end.
