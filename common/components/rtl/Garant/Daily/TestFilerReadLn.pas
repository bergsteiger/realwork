unit TestFilerReadLn;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/TestFilerReadLn.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::Core::TTestFilerReadLn
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
 TTestFilerReadLn = class(TBaseTest)
 private
 // private methods
   function ReadViaDelphiPrim(const aName: AnsiString): Longword;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure ReadViaDelphi;
   procedure DoIt;
   procedure ReadLnBadText;
     {* Тест для [RequestLink:175540286]. }
   procedure ReadLnBadUnicodeText;
     {* Тест для [RequestLink:175540286]. }
 end;//TTestFilerReadLn
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3Filer,
  SysUtils,
  l3Types,
  TestGlobals,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TTestFilerReadLn

function TTestFilerReadLn.ReadViaDelphiPrim(const aName: AnsiString): Longword;
//#UC START# *4B2A57F40332_4B2A51EA00EB_var*
var
 l_TF : TextFile;
 l_S  : AnsiString;
//#UC END# *4B2A57F40332_4B2A51EA00EB_var*
begin
//#UC START# *4B2A57F40332_4B2A51EA00EB_impl*
 AssignFile(l_TF, FileFromCurrent(cNSRCFileIn));
 Reset(l_TF);
 try
  StartTimer;
  while not EOF(l_TF) do
   ReadLn(l_TF, l_S);
  if (aName = '') then
   Result := StopTimer('Read via Delphi')
  else
   Result := StopTimer(aName, 'Etalon');
 finally
  CloseFile(l_TF);
 end;//try..finally
//#UC END# *4B2A57F40332_4B2A51EA00EB_impl*
end;//TTestFilerReadLn.ReadViaDelphiPrim

procedure TTestFilerReadLn.ReadViaDelphi;
//#UC START# *4B2A52480392_4B2A51EA00EB_var*
//#UC END# *4B2A52480392_4B2A51EA00EB_var*
begin
//#UC START# *4B2A52480392_4B2A51EA00EB_impl*
 ReadViaDelphiPrim('');
//#UC END# *4B2A52480392_4B2A51EA00EB_impl*
end;//TTestFilerReadLn.ReadViaDelphi

procedure TTestFilerReadLn.DoIt;
//#UC START# *4B2A5250025B_4B2A51EA00EB_var*
var
 l_F : Tl3CustomFiler;
 l_T : Cardinal;
 l_Mul : Integer;
//#UC END# *4B2A5250025B_4B2A51EA00EB_var*
begin
//#UC START# *4B2A5250025B_4B2A51EA00EB_impl*
 l_F := FilerForInput(cNSRCFileIn);
 try
  l_F.Open;
  try
   if IsGK then
    l_Mul := 2
   else
    l_Mul := 1;
   StartTimer;
   try
    while not l_F.EOF do
     l_F.ReadLn;
   finally
    l_T := StopTimer('Read');
   end;//try..finally
   //Check(false);
   Check(l_T <= ReadViaDelphiPrim('Read') * l_Mul);
  finally
   l_F.Close;
  end;//try..finally 
 finally
  FreeAndNil(l_F);
 end;//try..finally
//#UC END# *4B2A5250025B_4B2A51EA00EB_impl*
end;//TTestFilerReadLn.DoIt

procedure TTestFilerReadLn.ReadLnBadText;
//#UC START# *4B336B0B0247_4B2A51EA00EB_var*
var
 l_F : Tl3CustomFiler;
//#UC END# *4B336B0B0247_4B2A51EA00EB_var*
begin
//#UC START# *4B336B0B0247_4B2A51EA00EB_impl*
 l_F := FilerForInput('badtext.txt');
 try
  l_F.Open;
  try
   while not l_F.EOF do
    l_F.ReadLn;
  finally
   l_F.Close;
  end;//try..finally 
 finally
  FreeAndNil(l_F);
 end;//try..finally
//#UC END# *4B336B0B0247_4B2A51EA00EB_impl*
end;//TTestFilerReadLn.ReadLnBadText

procedure TTestFilerReadLn.ReadLnBadUnicodeText;
//#UC START# *4B336DFB0051_4B2A51EA00EB_var*
var
 l_F : Tl3CustomFiler;
//#UC END# *4B336DFB0051_4B2A51EA00EB_var*
begin
//#UC START# *4B336DFB0051_4B2A51EA00EB_impl*
 l_F := FilerForInput(cBadTextUnicode);
 try
  l_F.CodePage := CP_Unicode;
  l_F.Open;
  try
   while not l_F.EOF do
    l_F.ReadLn;
  finally
   l_F.Close;
  end;//try..finaly 
 finally
  FreeAndNil(l_F);
 end;//try..finally
//#UC END# *4B336DFB0051_4B2A51EA00EB_impl*
end;//TTestFilerReadLn.ReadLnBadUnicodeText

function TTestFilerReadLn.GetFolder: AnsiString;
 {-}
begin
 Result := 'Core';
end;//TTestFilerReadLn.GetFolder

function TTestFilerReadLn.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4B2A51EA00EB';
end;//TTestFilerReadLn.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TTestFilerReadLn.Suite);

end.