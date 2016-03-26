unit TestFilerCopyViaReadLn;

// Модуль: "w:\common\components\rtl\Garant\Daily\TestFilerCopyViaReadLn.pas"
// Стереотип: "TestCase"
// Элемент модели: "TTestFilerCopyViaReadLn" MUID: (4B2A52070264)

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
 TTestFilerCopyViaReadLn = class(TBaseTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
    {* Тест правильности копирования файлов с помощью ReadLn }
   procedure CopyUnicode;
    {* Тест для [RequestLink:175540286]. }
 end;//TTestFilerCopyViaReadLn
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestGlobals
 , l3Filer
 , l3Stream
 , l3Types
 , SysUtils
 , TestFrameWork
;

{$If NOT Defined(NotTunedDUnit)}
procedure TTestFilerCopyViaReadLn.DoIt;
 {* Тест правильности копирования файлов с помощью ReadLn }
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
 {* Тест для [RequestLink:175540286]. }
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
 {* Папка в которую входит тест }
begin
 Result := 'Core';
end;//TTestFilerCopyViaReadLn.GetFolder

function TTestFilerCopyViaReadLn.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4B2A52070264';
end;//TTestFilerCopyViaReadLn.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TTestFilerCopyViaReadLn.Suite);
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
