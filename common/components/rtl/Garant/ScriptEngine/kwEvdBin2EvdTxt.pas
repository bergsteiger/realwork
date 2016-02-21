unit kwEvdBin2EvdTxt;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwEvdBin2EvdTxt.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwSysUtilsWord
 , tfwScriptingInterfaces
;

type
 TkwEvdBin2EvdTxt = {final} class(TtfwSysUtilsWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEvdBin2EvdTxt
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Filer
 , l3Interfaces
 , l3Memory
 , evEvdRd
 , evdNativeWriter
 , SysUtils
 , l3String
 , l3Base
;

procedure TkwEvdBin2EvdTxt.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52DEAB2F00A1_var*
var
 l_InFiler, l_OutFiler : Tl3CustomFiler;
 l_InData: Tl3WString;
 l_InStream: Tl3ConstMemoryStream;
 l_OutStream: Tl3StringStream;
 l_EverestReader : TevEvdReader;
 l_EverestWriter : TevdNativeWriter;
//#UC END# *4DAEEDE10285_52DEAB2F00A1_var*
begin
//#UC START# *4DAEEDE10285_52DEAB2F00A1_impl*
 {$IFDEF EverestLite}
 RunnerError(Format('Функция %s не поддерживается в EverestLite!', [GetWordNameForRegister]), aCtx);
 {$ELSE}
 RunnerAssert(aCtx.rEngine.IsTopString, 'Нужна строка', aCtx);
 l_InData := aCtx.rEngine.PopString.AsWStr;
 l_InStream := Tl3ConstMemoryStream.Create(l_InData.S, l_InData.SLen);
 try
  l_OutStream := Tl3StringStream.Create;
  try
   l_InFiler := Tl3CustomFiler.Create;
   try
    l_InFiler.Stream := l_InStream;
    l_OutFiler := Tl3CustomFiler.Create;
    try
     l_OutFiler.Stream := l_OutStream;
     l_EverestReader := TevEvdReader.Create;
     try
      l_EverestWriter := TevdNativeWriter.Create;
      try
       l_EverestReader.Filer := l_InFiler;
       l_EverestWriter.Filer := l_OutFiler;
       l_EverestReader.Generator := l_EverestWriter;
       l_EverestWriter.Binary := False;
       l_EverestReader.Execute;
       aCtx.rEngine.PushString(l_OutStream as Il3CString);
      finally
       l3Free(l_EverestWriter);
      end;
     finally
      l3Free(l_EverestReader);
     end;
    finally
     l3Free(l_OutFiler);
    end;
   finally
    l3Free(l_InFiler);
   end;
  finally
   l3Free(l_OutStream);
  end;
 finally
  l3Free(l_InStream);
 end;
 {$ENDIF EverestLite}
//#UC END# *4DAEEDE10285_52DEAB2F00A1_impl*
end;//TkwEvdBin2EvdTxt.DoDoIt

class function TkwEvdBin2EvdTxt.GetWordNameForRegister: AnsiString;
begin
 Result := 'EvdBin2EvdTxt';
end;//TkwEvdBin2EvdTxt.GetWordNameForRegister

initialization
 TkwEvdBin2EvdTxt.RegisterInEngine;
 {* Регистрация EvdBin2EvdTxt }
{$IfEnd} // NOT Defined(NoScripts)

end.
