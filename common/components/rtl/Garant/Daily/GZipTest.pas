unit GZipTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/GZipTest.pas"
// Начат: 25.08.2010 14:17
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::GZip::GZipTest
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
 TGZipTest = {abstract} class(TBaseTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TGZipTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3Stream,
  l3GZipStream,
  SysUtils,
  l3Types,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TGZipTest

procedure TGZipTest.DoIt;
//#UC START# *4C74EDE00008_4C74EDA4008B_var*
const
 cIExt = '.gz';
 cOExt = '.xml';
var
 l_FS  : Tl3FileStream;
 l_FS2 : Tl3FileStream;
 l_GZ  : Tl3GZipStream;
 l_In  : String;
//#UC END# *4C74EDE00008_4C74EDA4008B_var*
begin
//#UC START# *4C74EDE00008_4C74EDA4008B_impl*
 l_In := FileFromCurrent(KPage + cIExt);
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
//#UC END# *4C74EDE00008_4C74EDA4008B_impl*
end;//TGZipTest.DoIt

function TGZipTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'GZip';
end;//TGZipTest.GetFolder

function TGZipTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C74EDA4008B';
end;//TGZipTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.