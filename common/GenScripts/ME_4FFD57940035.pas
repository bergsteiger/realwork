unit GZipUnzipTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\GZipUnzipTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TGZipUnzipTest = class(TBaseTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//TGZipUnzipTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , SysUtils
 , l3Stream
 , l3GZipStream
 , l3Types
;

{$If NOT Defined(NotTunedDUnit)}
procedure TGZipUnzipTest.DoIt;
//#UC START# *4FFD57F600FA_4FFD57940035_var*
const
 cIExt = '.gz';
 cOExt = '.xml';
var
 l_FS  : Tl3FileStream;
 l_FS2 : Tl3FileStream;
 l_GZ  : Tl3GZipStream;
 l_In  : String;
//#UC END# *4FFD57F600FA_4FFD57940035_var*
begin
//#UC START# *4FFD57F600FA_4FFD57940035_impl*
 l_In := FileFromCurrent(ClassName + cIExt);
 l_FS := Tl3FileStream.Create(l_In, l3_fmRead);
 try
  l_GZ := Tl3GZipStream.Create(l_FS);
  try
   l_FS2 := Tl3FileStream.Create(FileForOutput, l3_fmWrite);
   try
    l_FS2.CopyFrom(l_GZ, l_GZ.Size);
   finally
    FreeAndNil(l_FS2);
   end;//try..finally
  finally
   FreeAndNil(l_GZ);
  end;//try..finally
 finally
  FreeAndNil(l_FS);
 end;//try..finally
 CheckOutputWithInput(ChangeFileExt(l_In, EtalonSuffix + cOExt));
//#UC END# *4FFD57F600FA_4FFD57940035_impl*
end;//TGZipUnzipTest.DoIt

function TGZipUnzipTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'GZip';
end;//TGZipUnzipTest.GetFolder

function TGZipUnzipTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FFD57940035';
end;//TGZipUnzipTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TGZipUnzipTest.Suite);
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
