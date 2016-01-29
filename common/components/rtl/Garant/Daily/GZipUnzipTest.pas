unit GZipUnzipTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/GZipUnzipTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::GZip::GZipUnzipTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TGZipUnzipTest = class(TBaseTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TGZipUnzipTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  l3Stream,
  l3GZipStream,
  l3Types,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TGZipUnzipTest

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
 {-}
begin
 Result := 'GZip';
end;//TGZipUnzipTest.GetFolder

function TGZipUnzipTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4FFD57940035';
end;//TGZipUnzipTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TGZipUnzipTest.Suite);

end.