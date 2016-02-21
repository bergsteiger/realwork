unit GZipTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\GZipTest.pas"
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
 TGZipTest = {abstract} class(TBaseTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   procedure DoIt;
 end;//TGZipTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3Stream
 , l3GZipStream
 , SysUtils
 , l3Types
;

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
 {* Папка в которую входит тест }
begin
 Result := 'GZip';
end;//TGZipTest.GetFolder

function TGZipTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C74EDA4008B';
end;//TGZipTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
