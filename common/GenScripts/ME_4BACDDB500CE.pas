unit WriterTest;

interface

uses
 l3IntfUses
 , BaseTest
 , l3Variant
 , k2CustomFileReader
 , l3Filer
 , evdNativeWriter
;

type
 TWriterTest = class(TBaseTest)
  {* Базовый тест записи }
  procedure DoWrite(aReader: Tk2CustomFileReader;
   const anExt: AnsiString;
   aHeaderBegin: AnsiChar);
  function CreateEVDWriter: TevdNativeWriter;
  procedure SomeFormatToEVD(aReader: Tk2CustomFileReader);
  function AcceptBadPictureFormat: Boolean;
  function TreatExceptionAsSuccess: Boolean;
  procedure SetFilters(var theGenerator: Ik2TagGenerator);
 end;//TWriterTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , SysUtils
 , l3Except
;

end.
