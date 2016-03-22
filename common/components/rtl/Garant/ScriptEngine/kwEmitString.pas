unit kwEmitString;
 {* Позволяет ввести строку.
Пример:
[code]
: "Ввести строку" STRING IN aString
 aString emitstring
;
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwEmitString.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "EmitString" MUID: (4DB19F7802E3)
// Имя типа: "TkwEmitString"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwEmitString = class(TtfwRegisterableWord)
  {* Позволяет ввести строку.
Пример:
[code]
: "Ввести строку" STRING IN aString
 aString emitstring
;
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEmitString
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , Windows
 , Messages
 , l3Chars
 , l3Interfaces
;

procedure TkwEmitString.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB19F7802E3_var*
var
 l_Index : Integer;
(* l_Scan  : Integer;*)
 l_C     : Integer;
 l_H     : THandle;
 l_S     : Il3CString;
//#UC END# *4DAEEDE10285_4DB19F7802E3_var*
begin
//#UC START# *4DAEEDE10285_4DB19F7802E3_impl*
 l_S := aCtx.rEngine.PopString;
 try
  with l3PCharLen(l_S) do
  begin
   if not l3IsANSI(SCodePage) then
    RunnerError('Странная кодировка строки', aCtx);
   l_H := GetFocus;
   for l_Index := 0 to Pred(SLen) do
   begin
    l_C := ORD(S[l_Index]);
    if (GetFocus <> l_H) then
     SetFocus(l_H);
    SendMessage(l_H, WM_CHAR, l_C, 0);
 (*   l_Scan := MapVirtualKey(l_C, 0);
    keybd_event(l_C, l_Scan, 0, 0); { Key down }
    keybd_event(l_C, l_Scan, KEYEVENTF_KEYUP, 0);*)
   end;//for l_Index
  end;//with l3PCharLen(aCtx.rEngine.PopString)
 finally
  l_S := nil;
 end;//try..finally
//#UC END# *4DAEEDE10285_4DB19F7802E3_impl*
end;//TkwEmitString.DoDoIt

class function TkwEmitString.GetWordNameForRegister: AnsiString;
begin
 Result := 'emitstring';
end;//TkwEmitString.GetWordNameForRegister

initialization
 TkwEmitString.RegisterInEngine;
 {* Регистрация EmitString }
{$IfEnd} // NOT Defined(NoScripts)

end.
