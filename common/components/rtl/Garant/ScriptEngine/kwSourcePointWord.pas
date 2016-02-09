unit kwSourcePointWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwSourcePointWord.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3Interfaces
;

type
 TkwSourcePointWord = {abstract} class(TtfwWord)
  private
   f_SourceFileName: Il3CString;
   f_SourceLine: Integer;
  protected
   procedure ClearFields; override;
  public
   constructor Create(const aCtx: TtfwContext); reintroduce;
   function SourcePoint: TtfwSourcePoint; override;
 end;//TkwSourcePointWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

constructor TkwSourcePointWord.Create(const aCtx: TtfwContext);
//#UC START# *556427DD0163_556427250160_var*
//#UC END# *556427DD0163_556427250160_var*
begin
//#UC START# *556427DD0163_556427250160_impl*
 if (aCtx.rParser = nil) then
 begin
  f_SourceLine := -1;
  f_SourceFileName := nil;
 end//aCtx.rParser = nil
 else
 begin
  f_SourceLine := aCtx.rParser.SourceLine;
  f_SourceFileName := TtfwCStringFactory.C(aCtx.rParser.FileName);
 end;//aCtx.rParser = nil
 inherited Create;
//#UC END# *556427DD0163_556427250160_impl*
end;//TkwSourcePointWord.Create

procedure TkwSourcePointWord.ClearFields;
begin
 f_SourceFileName := nil;
 inherited;
end;//TkwSourcePointWord.ClearFields

function TkwSourcePointWord.SourcePoint: TtfwSourcePoint;
//#UC START# *556317DE02B5_556427250160_var*
//#UC END# *556317DE02B5_556427250160_var*
begin
//#UC START# *556317DE02B5_556427250160_impl*
 Result := inherited SourcePoint;
 Result.rFileName := f_SourceFileName;
 Result.rLine := f_SourceLine;
//#UC END# *556317DE02B5_556427250160_impl*
end;//TkwSourcePointWord.SourcePoint

initialization
 TkwSourcePointWord.RegisterClass;
 {* Регистрация TkwSourcePointWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
