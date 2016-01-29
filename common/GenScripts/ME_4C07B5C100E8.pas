unit EVDWriterTest;

interface

uses
 l3IntfUses
 , WriterTest
 , evdNativeReader
;

type
 TEVDWriterTest = class(TWriterTest)
  procedure EVDtoEVD(const aFileName: AnsiString);
  function UseFullEVDReader: Boolean;
   {* Использовать ли ПОЛНЫЙ evdReader (с чтением текста тоже) }
  function DisableParserLog: Boolean;
   {* Запретить парсеру выводить в лог }
 end;//TEVDWriterTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , SysUtils
 , evEvdRd
 , l3Parser
;

end.
