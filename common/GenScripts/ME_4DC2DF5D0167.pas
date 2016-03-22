unit kwIncluded;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwIncluded.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwIncluded" MUID: (4DC2DF5D0167)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwIncludedPrim
 , tfwScriptingInterfaces
;

type
 RkwIncluded = class of TkwIncluded;

 TkwIncluded = class(TkwIncludedPrim)
  private
   f_FileName: AnsiString;
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   function EndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; override;
   procedure UnknownWord(var aContext: TtfwContext;
    aWordNumber: Integer); override;
  public
   constructor Create(const aFileName: AnsiString); reintroduce;
 end;//TkwIncluded
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Parser
 , SysUtils
 , l3Filer
 , l3Types
 , l3Chars
 , kwCompiledIncluded
 , l3Base
 , tfwFileStreamFactory
;

constructor TkwIncluded.Create(const aFileName: AnsiString);
//#UC START# *4DC2E00703AA_4DC2DF5D0167_var*
//#UC END# *4DC2E00703AA_4DC2DF5D0167_var*
begin
//#UC START# *4DC2E00703AA_4DC2DF5D0167_impl*
 Assert(aFileName <> '');
 inherited Create;
 f_FileName := aFileName;
//#UC END# *4DC2E00703AA_4DC2DF5D0167_impl*
end;//TkwIncluded.Create

procedure TkwIncluded.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DC2DF5D0167_var*
var
 l_F : TtfwFileStreamFactory;
//#UC END# *4DAEEDE10285_4DC2DF5D0167_var*
begin
//#UC START# *4DAEEDE10285_4DC2DF5D0167_impl*
 l_F := TtfwFileStreamFactory.Create(f_FileName);
 try
  try
   DoFiler(l_F, aCtx);
  finally
   l_F.CloseStream;
  end;//try..finally
 finally
  FreeAndNil(l_F);
 end;//try..finally
//#UC END# *4DAEEDE10285_4DC2DF5D0167_impl*
end;//TkwIncluded.DoDoIt

function TkwIncluded.EndBracket(const aContext: TtfwContext;
 aSilent: Boolean): RtfwWord;
//#UC START# *4DB6C99F026E_4DC2DF5D0167_var*
//#UC END# *4DB6C99F026E_4DC2DF5D0167_var*
begin
//#UC START# *4DB6C99F026E_4DC2DF5D0167_impl*
 Result := nil;
 //Assert(false);
//#UC END# *4DB6C99F026E_4DC2DF5D0167_impl*
end;//TkwIncluded.EndBracket

procedure TkwIncluded.UnknownWord(var aContext: TtfwContext;
 aWordNumber: Integer);
//#UC START# *4DB6F2760023_4DC2DF5D0167_var*
//#UC END# *4DB6F2760023_4DC2DF5D0167_var*
begin
//#UC START# *4DB6F2760023_4DC2DF5D0167_impl*
 try
  inherited;
 except
  on E : Exception do
   l3System.Exception2Log(E);
 end;//try..except
//#UC END# *4DB6F2760023_4DC2DF5D0167_impl*
end;//TkwIncluded.UnknownWord

initialization
 TkwIncluded.RegisterInEngine;
 {* Регистрация TkwIncluded }
{$IfEnd} // NOT Defined(NoScripts)

end.
