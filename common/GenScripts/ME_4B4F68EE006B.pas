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
   {* ������ NSRCReader }
  procedure NSRCtoMemory(const aFileName: AnsiString);
   {* ������ NSRC � ������ }
  procedure NSRCtoEVD(const aFileName: AnsiString);
  function PainterCodePage: Integer;
  function NSRCCodePage: Integer;
   {* ��������� ��� ������� � NSRC }
  procedure ExtractFileEvent(const aFileName: AnsiString);
   {* ������� ������� �������� �����. }
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
