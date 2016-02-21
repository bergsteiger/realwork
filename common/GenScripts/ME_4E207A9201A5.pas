unit kwSystemIncluded;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwSystemIncluded.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwIncludedPrim
 , tfwStreamFactory
 , tfwScriptingInterfaces
;

type
 TkwSystemIncluded = class(TkwIncludedPrim)
  private
   f_Stream: TtfwStreamFactory;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   constructor Create(aStream: TtfwStreamFactory); reintroduce;
 end;//TkwSystemIncluded
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwCOMStreamFactory
 , SysUtils
;

constructor TkwSystemIncluded.Create(aStream: TtfwStreamFactory);
//#UC START# *4E207B920217_4E207A9201A5_var*
//#UC END# *4E207B920217_4E207A9201A5_var*
begin
//#UC START# *4E207B920217_4E207A9201A5_impl*
 Assert(aStream <> nil);
 inherited Create;
 aStream.SetRefTo(f_Stream);
//#UC END# *4E207B920217_4E207A9201A5_impl*
end;//TkwSystemIncluded.Create

procedure TkwSystemIncluded.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4E207A9201A5_var*
//#UC END# *479731C50290_4E207A9201A5_var*
begin
//#UC START# *479731C50290_4E207A9201A5_impl*
 FreeAndNil(f_Stream);
 inherited;
//#UC END# *479731C50290_4E207A9201A5_impl*
end;//TkwSystemIncluded.Cleanup

procedure TkwSystemIncluded.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E207A9201A5_var*
//#UC END# *4DAEEDE10285_4E207A9201A5_var*
begin
//#UC START# *4DAEEDE10285_4E207A9201A5_impl*
 try
  DoFiler(f_Stream, aCtx);
 finally 
  f_Stream.CloseStream;
 end;//try..finally 
//#UC END# *4DAEEDE10285_4E207A9201A5_impl*
end;//TkwSystemIncluded.DoDoIt

initialization
 TkwSystemIncluded.RegisterInEngine;
 {* Регистрация TkwSystemIncluded }
{$IfEnd} // NOT Defined(NoScripts)

end.
