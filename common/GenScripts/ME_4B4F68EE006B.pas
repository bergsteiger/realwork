unit NSRCWriterTest;

interface

uses
 l3IntfUses
 , WriterTest
 , tstNSRCGenerator
 , l3Filer
 , evCustomTextFormatter
 , k2TagGen
 , k2CustomFileReader
 , evdNativeReader
 , evdNSRCReader
 , k2DocumentBuffer
;

type
 TNSRCWriterTest = class(TWriterTest, ItstNSRCListener)
  procedure SomeFormatToNSRC(aReader: Tk2CustomFileReader;
   aPlus: Boolean);
  procedure EVDtoNSRC(const aFileName: AnsiString;
   aPlus: Boolean);
  procedure NSRCtoNSRC(const aFileName: AnsiString;
   aPlus: Boolean);
  function CreateNSRCReader(const aFileName: AnsiString): TevdNSRCReader;
   {* Создаёт NSRCReader }
  procedure NSRCtoMemory(const aFileName: AnsiString);
   {* Читает NSRC в память }
  procedure NSRCtoEVD(const aFileName: AnsiString);
  function PainterCodePage: Integer;
  function NSRCCodePage: Integer;
   {* Кодировка для выливки в NSRC }
  procedure ExtractFileEvent(const aFileName: AnsiString);
   {* Событие выливки внешнего файла. }
 end;//TNSRCWriterTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , SysUtils
 , l3Chars
 , evTextFormatter
 , evSimpleTextPainter
 , evNSRCPlusWriter
 , evEmptyTableEliminator
;

end.
