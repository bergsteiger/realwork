unit tfwOutToFileScriptCaller;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwOutToFileScriptCaller.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwOutToFileScriptCaller" MUID: (56456E3E01E4)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwConsoleScriptCaller
 , l3Filer
 , tfwScriptingInterfaces
 , l3Interfaces
;

type
 TtfwOutToFileScriptCaller = class(TtfwConsoleScriptCaller)
  private
   f_OutFiler: Tl3DOSFiler;
   f_FileName: AnsiString;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aFileName: AnsiString); reintroduce;
   class function Make(const aFileName: AnsiString): ItfwScriptCaller; reintroduce;
   procedure DoPrint(const aStr: Tl3WString); override;
 end;//TtfwOutToFileScriptCaller
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Types
 , l3String
 , l3Chars
;

constructor TtfwOutToFileScriptCaller.Create(const aFileName: AnsiString);
//#UC START# *5645710E0083_56456E3E01E4_var*
//#UC END# *5645710E0083_56456E3E01E4_var*
begin
//#UC START# *5645710E0083_56456E3E01E4_impl*
 inherited Create;
 f_FileName := aFileName;
//#UC END# *5645710E0083_56456E3E01E4_impl*
end;//TtfwOutToFileScriptCaller.Create

class function TtfwOutToFileScriptCaller.Make(const aFileName: AnsiString): ItfwScriptCaller;
var
 l_Inst : TtfwOutToFileScriptCaller;
begin
 l_Inst := Create(aFileName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwOutToFileScriptCaller.Make

procedure TtfwOutToFileScriptCaller.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56456E3E01E4_var*
//#UC END# *479731C50290_56456E3E01E4_var*
begin
//#UC START# *479731C50290_56456E3E01E4_impl*
 if (f_OutFiler <> nil) then
  f_OutFiler.Close;
 FreeAndNil(f_OutFiler);
 inherited;
//#UC END# *479731C50290_56456E3E01E4_impl*
end;//TtfwOutToFileScriptCaller.Cleanup

procedure TtfwOutToFileScriptCaller.DoPrint(const aStr: Tl3WString);
//#UC START# *55C491FC025C_56456E3E01E4_var*
//#UC END# *55C491FC025C_56456E3E01E4_var*
begin
//#UC START# *55C491FC025C_56456E3E01E4_impl*
 if (f_OutFiler = nil) then
 begin
  f_OutFiler := Tl3DOSFiler.Make(f_FileName, l3_fmWrite, false);
  f_OutFiler.CodePage := CP_ANSI;
  f_OutFiler.Open;
 end;//f_OutFiler = nil
 f_OutFiler.WriteLn(aStr);
//#UC END# *55C491FC025C_56456E3E01E4_impl*
end;//TtfwOutToFileScriptCaller.DoPrint
{$IfEnd} // NOT Defined(NoScripts)

end.
