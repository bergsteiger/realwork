unit nevPersistentDocumentContainer;

interface

uses
 l3IntfUses
 , evDocumentContainerWithProcessor
 , nevBase
 , k2TagGen
 , nevInternalInterfaces
 , l3Interfaces
 , k2CustomReader
;

type
 TevGetWriterProc = procedure(Sender: TObject;
  aFormat: TnevFormat;
  var Writer: Tk2TagGenerator);
  {* процедура для получения объекта для записи текста в формате aFormat. }
 
 TevGetReaderProc = procedure(Sender: TObject;
  aFormat: TnevFormat;
  var Reader: Tk2CustomReader;
  const aFileName: AnsiString);
  {* процедура для получения объекта для чтения текста в формате aFormat. }
 
 TnevPersistentDocumentContainer = class(TevDocumentContainerWithProcessor)
  {* Контейнер документа с поддержкой записи/чтения в различных форматах. }
  function UseWikiMarkup: Boolean;
  procedure DoGetWriter(aFormat: TnevFormat;
   anInternal: Boolean;
   var theWriter: Tk2TagGenerator;
   aCodePage: Integer);
 end;//TnevPersistentDocumentContainer
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evCustomTxtReader
 , evTypes
 , evdNativeReader
 , k2CustomFileGenerator
 , evTextFormatter
 , evdPlainTextWriter
 , nevInterfaces
 , l3Chars
 , SysUtils
 , l3Base
 , evdNativeWriter
 , Document_Const
 , evMergedCellFilter
 , ShellAPI
 , evCustomWikiReader
 , evdTextStyle_Const
 , evStyleHeaderAdder
 , evdNativeUnpackedWriter
;

end.
