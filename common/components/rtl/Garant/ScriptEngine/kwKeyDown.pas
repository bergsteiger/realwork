unit kwKeyDown;
 {* 'Alt' KeyDown // зажать клавишу
1000 SLEEP
'Alt' KeyUp // отпустить клавишу }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwKeyDown.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "KeyDown" MUID: (5220A3ED0104)
// Имя типа: "TkwKeyDown"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwKeyDown = {final} class(TtfwRegisterableWord)
  {* 'Alt' KeyDown // зажать клавишу
1000 SLEEP
'Alt' KeyUp // отпустить клавишу }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwKeyDown
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Windows
 , Menus
 , Classes
 , Messages
 , SysUtils
 , l3MessagesService
;

class function TkwKeyDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'KeyDown';
end;//TkwKeyDown.GetWordNameForRegister

procedure TkwKeyDown.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5220A3ED0104_var*
{$IfNDef XE}
var
 l_Input: array[0..0] of TInput;
 l_String: string;
 l_Key: Word;
{$EndIf  XE}
//#UC END# *4DAEEDE10285_5220A3ED0104_var*
begin
//#UC START# *4DAEEDE10285_5220A3ED0104_impl*
{$IfNDef XE}
 {$IfNDef NoVCL}
 l_String := aCtx.rEngine.PopDelphiString;

 if AnsiCompareText(l_String, MenuKeyCaps[mkcShift]) = 0 then
  l_Key := VK_SHIFT
 else
 if (AnsiCompareText(l_String, '^') = 0) or (AnsiCompareText(l_String, MenuKeyCaps[mkcCtrl]) = 0) then
  l_Key := VK_CONTROL
 else
 if AnsiCompareText(l_String, MenuKeyCaps[mkcAlt]) = 0 then
  l_Key := VK_MENU
 else
 begin
  if Length(l_String) > 0 then
   for l_Key := $08 to $255 do
    if AnsiCompareText(l_String, ShortCutToText(l_Key)) = 0 then
     Break;
 end;

 with l_Input[0] do
 begin
  Itype := INPUT_KEYBOARD;
  ki.wVk := l_Key;
  ki.wScan := MapVirtualKey(ki.wVk, 0);
  ki.dwFlags := KEYEVENTF_EXTENDEDKEY;
  ki.time := 0;
  ki.dwExtraInfo := 0;
 end;

 SendInput(1, l_Input[0], SizeOf(TInput));
 Tl3MessagesService.Instance.ProcessMessages;
 {$Else  NoVCL}
 Assert(false);
 {$EndIf NoVCL}
{$Else  XE}
 Assert(false);
{$EndIf XE}
//#UC END# *4DAEEDE10285_5220A3ED0104_impl*
end;//TkwKeyDown.DoDoIt

initialization
 TkwKeyDown.RegisterInEngine;
 {* Регистрация KeyDown }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
