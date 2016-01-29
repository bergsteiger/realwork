unit TestFilerCopyViaReadLn;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/TestFilerCopyViaReadLn.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::Core::TTestFilerCopyViaReadLn
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
 TTestFilerCopyViaReadLn = class(TBaseTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
     {* Тест правильности копирования файлов с помощью ReadLn }
   procedure CopyUnicode;
     {* Тест для [RequestLink:175540286]. }
 end;//TTestFilerCopyViaReadLn
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3Filer,
  l3Stream,
  l3Types,
  SysUtils,
  TestGlobals,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TTestFilerCopyViaReadLn

procedure TTestFilerCopyViaReadLn.DoIt;
//#UC START# *4B2A528E03BB_4B2A52070264_var*
var
 l_F : Tl3CustomFiler;
 l_O : Tl3CustomFiler;
//#UC END# *4B2A528E03BB_4B2A52070264_var*
begin
//#UC START# *4B2A528E03BB_4B2A52070264_impl*
 l_F := FilerForInput(cNSRCFileIn);
 try
  l_F.CodePage := CP_ANSI;
  l_O := FilerForOutput;
  try
   l_F.Open;
   try
    l_O.Open;
    try
     StartTimer;
     try
      while not l_F.EOF do
      begin
       with l_F.ReadLn do
        l_O.Write(S, SLen);
       if not l_F.EOF then
        l_O.OutEOL;
      end;//while not l_F.EOF
     finally
      StopTimer('Copy');
     end;//try..finally
    finally
     l_O.Close;
    end;//try..finally
   finally
    l_F.Close;
   end;//try..finally
  finally
   FreeAndNil(l_O);
  end;//try..finally
 finally
  FreeAndNil(l_F);
 end;//try..finally

 CheckOutputWithInput(cNSRCFileIn);
//#UC END# *4B2A528E03BB_4B2A52070264_impl*
end;//TTestFilerCopyViaReadLn.DoIt

procedure TTestFilerCopyViaReadLn.CopyUnicode;
//#UC START# *4B337B58013E_4B2A52070264_var*
var
 l_F : Tl3CustomFiler;
 l_O : Tl3CustomFiler;
//#UC END# *4B337B58013E_4B2A52070264_var*
begin
//#UC START# *4B337B58013E_4B2A52070264_impl*
 l_F := FilerForInput(cBadTextUnicode);
 try
  l_F.CodePage := CP_Unicode;
  l_O := FilerForOutput;
  try
   l_O.CodePage := CP_Unicode;
   l_F.Open;
   try
    l_O.Open;
    try
     StartTimer;
     try
      while not l_F.EOF do
      begin
       with l_F.ReadLn do
        l_O.Write(S, SLen * 2);
       if not l_F.EOF then
        l_O.OutEOL;
      end;//while not l_F.EOF
     finally
      StopTimer('Copy');
     end;//try..finally
    finally
     l_O.Close;
    end;//try..finally
   finally
    l_F.Close;
  end;//try..finally
  finally
   FreeAndNil(l_O);
  end;//try..finally
 finally
  FreeAndNil(l_F);
 end;//try..finally

 CheckOutputWithInput(cBadTextUnicode);
//#UC END# *4B337B58013E_4B2A52070264_impl*
end;//TTestFilerCopyViaReadLn.CopyUnicode

function TTestFilerCopyViaReadLn.GetFolder: AnsiString;
 {-}
begin
 Result := 'Core';
end;//TTestFilerCopyViaReadLn.GetFolder

function TTestFilerCopyViaReadLn.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4B2A52070264';
end;//TTestFilerCopyViaReadLn.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TTestFilerCopyViaReadLn.Suite);

end.