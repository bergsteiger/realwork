unit TestFilerReadLn;

// Модуль: "w:\common\components\rtl\Garant\Daily\TestFilerReadLn.pas"
// Стереотип: "TestCase"
// Элемент модели: "TTestFilerReadLn" MUID: (4B2A51EA00EB)

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
 TTestFilerReadLn = class({$If NOT Defined(NotTunedDUnit)}
 TBaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
  private
   function ReadViaDelphiPrim(const aName: AnsiString): Longword;
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure ReadViaDelphi;
   procedure DoIt;
   procedure ReadLnBadText;
    {* Тест для [RequestLink:175540286]. }
   procedure ReadLnBadUnicodeText;
    {* Тест для [RequestLink:175540286]. }
 end;//TTestFilerReadLn
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestGlobals
 , l3Filer
 , SysUtils
 , l3Types
 , TestFrameWork
;

{$If NOT Defined(NotTunedDUnit)}
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

procedure TTestFilerReadLn.ReadLnBadText;
 {* Тест для [RequestLink:175540286]. }
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
 {* Тест для [RequestLink:175540286]. }
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
 {* Папка в которую входит тест }
begin
 Result := 'Core';
end;//TTestFilerReadLn.GetFolder

function TTestFilerReadLn.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4B2A51EA00EB';
end;//TTestFilerReadLn.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TTestFilerReadLn.Suite);
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
