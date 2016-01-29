unit WriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/WriterTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::Write::WriterTest
//
// Базовый тест записи
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
  l3Filer,
  k2CustomFileReader,
  evdNativeWriter
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  ,
  l3Variant
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TWriterTest = {abstract} class(TBaseTest)
  {* Базовый тест записи }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   procedure DoWrite(aReader: Tk2CustomFileReader;
     const anExt: AnsiString;
     aHeaderBegin: AnsiChar = #0);
   function CreateEVDWriter: TevdNativeWriter;
   procedure SomeFormatToEVD(aReader: Tk2CustomFileReader);
   function AcceptBadPictureFormat: Boolean; virtual;
   function TreatExceptionAsSuccess: Boolean; virtual;
   procedure SetFilters(var theGenerator: Ik2TagGenerator); virtual;
 end;//TWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  l3Except,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TWriterTest

procedure TWriterTest.DoWrite(aReader: Tk2CustomFileReader;
  const anExt: AnsiString;
  aHeaderBegin: AnsiChar = #0);
//#UC START# *4BACDE3B02E9_4BACDDB500CE_var*
var
 l_Raise : Boolean;
//#UC END# *4BACDE3B02E9_4BACDDB500CE_var*
var
 l_G : Ik2TagGenerator;
begin
//#UC START# *4BACDE3B02E9_4BACDDB500CE_impl*
 l_Raise := TreatExceptionAsSuccess;
 try
  try
   StartTimer;
   try
    l_G := aReader.Generator;
    try
     SetFilters(l_G);
     aReader.Generator := l_G;
    finally
     l_G := nil;
    end;//try..finally
    aReader.Execute;
   finally
    StopTimer;
   end;//try..finally
  except
   on E : El3BadPictureFormat do
    if not AcceptBadPictureFormat then
     raise;
  end;//try..except
 except
  if l_Raise then
   Exit
  else
   raise;
 end;
 if (anExt <> '') then
  CheckOutputWithInput(ChangeFileExt(aReader.Filer.Identifier, anExt), aHeaderBegin);
//#UC END# *4BACDE3B02E9_4BACDDB500CE_impl*
end;//TWriterTest.DoWrite

function TWriterTest.CreateEVDWriter: TevdNativeWriter;
//#UC START# *4C07B2F8016F_4BACDDB500CE_var*
//#UC END# *4C07B2F8016F_4BACDDB500CE_var*
var
 l_Filer : Tl3CustomFiler;
begin
//#UC START# *4C07B2F8016F_4BACDDB500CE_impl*
 Result := TevdNativeWriter.Create;
 try
  l_Filer := FilerForOutput;
  try
   Result.Filer := l_Filer;
  finally
   FreeAndNil(l_Filer);
  end;//try..finally
  Result.Binary := false;
 except
  FreeAndNil(Result);
  raise;
 end;//try..except
//#UC END# *4C07B2F8016F_4BACDDB500CE_impl*
end;//TWriterTest.CreateEVDWriter

procedure TWriterTest.SomeFormatToEVD(aReader: Tk2CustomFileReader);
//#UC START# *4C07B63D0078_4BACDDB500CE_var*
//#UC END# *4C07B63D0078_4BACDDB500CE_var*
var
 l_Writer : TevdNativeWriter;
begin
//#UC START# *4C07B63D0078_4BACDDB500CE_impl*
 l_Writer := CreateEVDWriter;
 try
  aReader.Generator := l_Writer;
 finally
  FreeAndNil(l_Writer);
 end;//try..finally
 DoWrite(aReader, EtalonSuffix + '.evd', '%');
//#UC END# *4C07B63D0078_4BACDDB500CE_impl*
end;//TWriterTest.SomeFormatToEVD

function TWriterTest.AcceptBadPictureFormat: Boolean;
//#UC START# *4E8317EF02C7_4BACDDB500CE_var*
//#UC END# *4E8317EF02C7_4BACDDB500CE_var*
begin
//#UC START# *4E8317EF02C7_4BACDDB500CE_impl*
 Result := false;
//#UC END# *4E8317EF02C7_4BACDDB500CE_impl*
end;//TWriterTest.AcceptBadPictureFormat

function TWriterTest.TreatExceptionAsSuccess: Boolean;
//#UC START# *51406117007F_4BACDDB500CE_var*
//#UC END# *51406117007F_4BACDDB500CE_var*
begin
//#UC START# *51406117007F_4BACDDB500CE_impl*
 Result := False;
//#UC END# *51406117007F_4BACDDB500CE_impl*
end;//TWriterTest.TreatExceptionAsSuccess

procedure TWriterTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4BACDDB500CE_var*
//#UC END# *4C07BCBE01F2_4BACDDB500CE_var*
begin
//#UC START# *4C07BCBE01F2_4BACDDB500CE_impl*
 // - ничего не делаем
//#UC END# *4C07BCBE01F2_4BACDDB500CE_impl*
end;//TWriterTest.SetFilters

function TWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Write';
end;//TWriterTest.GetFolder

function TWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BACDDB500CE';
end;//TWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.