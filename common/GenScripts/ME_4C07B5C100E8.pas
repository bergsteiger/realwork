unit EVDWriterTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDWriterTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , WriterTest
 , evdNativeReader
;

type
 TEVDWriterTest = {abstract} class(TWriterTest)
  protected
   procedure EVDtoEVD(const aFileName: AnsiString);
   function UseFullEVDReader: Boolean; virtual;
    {* Использовать ли ПОЛНЫЙ evdReader (с чтением текста тоже) }
   function DisableParserLog: Boolean; virtual;
    {* Запретить парсеру выводить в лог }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TEVDWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , SysUtils
 , evEvdRd
 , l3Parser
;

procedure TEVDWriterTest.EVDtoEVD(const aFileName: AnsiString);
var l_Reader: TevdNativeReader;
//#UC START# *4C07B67A02C1_4C07B5C100E8_var*
var
 l_DisableParserLog : Boolean;
//#UC END# *4C07B67A02C1_4C07B5C100E8_var*
begin
//#UC START# *4C07B67A02C1_4C07B5C100E8_impl*
 if UseFullEVDReader then
  l_Reader := TevCustomEvdReader.Make(FileFromCurrent(aFileName))
 else
  l_Reader := TevdNativeReader.Make(FileFromCurrent(aFileName));
 try
  l_DisableParserLog := DisableParserLog;
  if l_DisableParserLog then
   Inc(g_DisableParserLog);
  try
   SomeFormatToEVD(l_Reader);
  finally
   if l_DisableParserLog then
    Dec(g_DisableParserLog);
  end;//try..finally
 finally
  FreeAndNil(l_Reader);
 end;//try..finally
//#UC END# *4C07B67A02C1_4C07B5C100E8_impl*
end;//TEVDWriterTest.EVDtoEVD

function TEVDWriterTest.UseFullEVDReader: Boolean;
 {* Использовать ли ПОЛНЫЙ evdReader (с чтением текста тоже) }
//#UC START# *4C1B2B0203A2_4C07B5C100E8_var*
//#UC END# *4C1B2B0203A2_4C07B5C100E8_var*
begin
//#UC START# *4C1B2B0203A2_4C07B5C100E8_impl*
 Result := false;
//#UC END# *4C1B2B0203A2_4C07B5C100E8_impl*
end;//TEVDWriterTest.UseFullEVDReader

function TEVDWriterTest.DisableParserLog: Boolean;
 {* Запретить парсеру выводить в лог }
//#UC START# *4C1B47BA03AC_4C07B5C100E8_var*
//#UC END# *4C1B47BA03AC_4C07B5C100E8_var*
begin
//#UC START# *4C1B47BA03AC_4C07B5C100E8_impl*
 Result := false;
//#UC END# *4C1B47BA03AC_4C07B5C100E8_impl*
end;//TEVDWriterTest.DisableParserLog

function TEVDWriterTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EVD';
end;//TEVDWriterTest.GetFolder

function TEVDWriterTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C07B5C100E8';
end;//TEVDWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
