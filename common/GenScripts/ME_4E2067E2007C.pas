unit bsHyperLinkProcessorPrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\bsHyperLinkProcessorPrim.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3CProtoObject
 , l3Interfaces
 , ExternalObjectUnit
;

type
 TbsHyperLinkProcessorPrim = class(Tl3CProtoObject)
  protected
   function OpenURL(const anURL: Tl3WString): Boolean; overload;
   procedure ExecuteScript(const aScript: AnsiString);
  public
   procedure OpenURL(const anURL: IExternalLink); overload;
   class procedure RunScript(const aScript: AnsiString);
 end;//TbsHyperLinkProcessorPrim
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngine
 {$IfEnd} // NOT Defined(NoScripts)
 , l3String
 , l3Base
 , DataAdapter
 , nsExternalObjectPrim
 , SysUtils
 , ComObj
 , ActiveX
 {$If NOT Defined(NoScripts)}
 , tfwF1HyperlinkScriptCaller
 {$IfEnd} // NOT Defined(NoScripts)
 , IOUnit
 , nsTypes
;

function TbsHyperLinkProcessorPrim.OpenURL(const anURL: Tl3WString): Boolean;
//#UC START# *4E2068B30386_4E2067E2007C_var*
var
 l_P, l_S : Il3CString;
//#UC END# *4E2068B30386_4E2067E2007C_var*
begin
//#UC START# *4E2068B30386_4E2067E2007C_impl*
 if l3IsNil(anURL) then
  Result := false
 else
 begin
  l3Split(l3CStr(anURL), ':', l_P, l_S);
  Result := l3Same(l_P, 'script') AND not l3IsNil(l_S);
  if Result then
   ExecuteScript(l3Str(l_S))
  else
   nsDoShellExecute(l3CStr(anURL));
 end;//l3IsNil(anURL)
//#UC END# *4E2068B30386_4E2067E2007C_impl*
end;//TbsHyperLinkProcessorPrim.OpenURL

procedure TbsHyperLinkProcessorPrim.ExecuteScript(const aScript: AnsiString);
//#UC START# *4E2068D800E0_4E2067E2007C_var*
//#UC END# *4E2068D800E0_4E2067E2007C_var*
begin
//#UC START# *4E2068D800E0_4E2067E2007C_impl*
 TtfwScriptEngine.Script(aScript, TtfwF1HyperlinkScriptCaller.Make);
//#UC END# *4E2068D800E0_4E2067E2007C_impl*
end;//TbsHyperLinkProcessorPrim.ExecuteScript

procedure TbsHyperLinkProcessorPrim.OpenURL(const anURL: IExternalLink);
//#UC START# *4E20711A0022_4E2067E2007C_var*
var
 l_S : IString;
 l_WS : Tl3WString;
//#UC END# *4E20711A0022_4E2067E2007C_var*
begin
//#UC START# *4E20711A0022_4E2067E2007C_impl*
 anURL.GetURL(l_S);
 try
  l_WS := nsWStr(l_S);
  if l3Starts('script:', l_WS) OR
     l3Starts('http:', l_WS) OR
     l3Starts('mailto:', l_WS) then
   OpenURL(l_WS)
  else
   ExecuteScript(l3Str(nsCStr(l_S)));
 finally
  l_S := nil;
 end;//try..fianlly
//#UC END# *4E20711A0022_4E2067E2007C_impl*
end;//TbsHyperLinkProcessorPrim.OpenURL

class procedure TbsHyperLinkProcessorPrim.RunScript(const aScript: AnsiString);
//#UC START# *502B7892000D_4E2067E2007C_var*
//#UC END# *502B7892000D_4E2067E2007C_var*
begin
//#UC START# *502B7892000D_4E2067E2007C_impl*
 TtfwScriptEngine.Script(aScript, TtfwF1HyperlinkScriptCaller.Make);
//#UC END# *502B7892000D_4E2067E2007C_impl*
end;//TbsHyperLinkProcessorPrim.RunScript
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
