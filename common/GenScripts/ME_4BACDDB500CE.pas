unit WriterTest;
 {* ������� ���� ������ }

// ������: "w:\common\components\rtl\Garant\Daily\WriterTest.pas"
// ���������: "TestCase"
// ������� ������: "WriterTest" MUID: (4BACDDB500CE)
// ��� ����: "TWriterTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , evdNativeWriter
 , l3Variant
 , k2CustomFileReader
 , l3Filer
;

type
 TWriterTest = {abstract} class({$If NOT Defined(NotTunedDUnit)}
 TBaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
  {* ������� ���� ������ }
  protected
   procedure DoWrite(aReader: Tk2CustomFileReader;
    const anExt: AnsiString;
    aHeaderBegin: AnsiChar = #0);
   function CreateEVDWriter: TevdNativeWriter;
   procedure SomeFormatToEVD(aReader: Tk2CustomFileReader);
   function AcceptBadPictureFormat: Boolean; virtual;
   function TreatExceptionAsSuccess: Boolean; virtual;
   procedure SetFilters(var theGenerator: Ik2TagGenerator); virtual;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Except
 , TestFrameWork
;

{$If NOT Defined(NotTunedDUnit)}
procedure TWriterTest.DoWrite(aReader: Tk2CustomFileReader;
 const anExt: AnsiString;
 aHeaderBegin: AnsiChar = #0);
var l_G: Ik2TagGenerator;
//#UC START# *4BACDE3B02E9_4BACDDB500CE_var*
var
 l_Raise : Boolean;
//#UC END# *4BACDE3B02E9_4BACDDB500CE_var*
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
var l_Filer: Tl3CustomFiler;
//#UC START# *4C07B2F8016F_4BACDDB500CE_var*
//#UC END# *4C07B2F8016F_4BACDDB500CE_var*
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
var l_Writer: TevdNativeWriter;
//#UC START# *4C07B63D0078_4BACDDB500CE_var*
//#UC END# *4C07B63D0078_4BACDDB500CE_var*
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
 // - ������ �� ������
//#UC END# *4C07BCBE01F2_4BACDDB500CE_impl*
end;//TWriterTest.SetFilters

function TWriterTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Write';
end;//TWriterTest.GetFolder

function TWriterTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BACDDB500CE';
end;//TWriterTest.GetModelElementGUID
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
