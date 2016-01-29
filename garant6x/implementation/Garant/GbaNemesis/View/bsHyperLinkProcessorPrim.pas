unit bsHyperLinkProcessorPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/bsHyperLinkProcessorPrim.pas"
// Начат: 15.07.2011 20:16
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::Navigation::TbsHyperLinkProcessorPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  ExternalObjectUnit,
  l3Interfaces,
  l3CProtoObject
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TbsHyperLinkProcessorPrim = class(Tl3CProtoObject)
 protected
 // protected methods
   function OpenURL(const anURL: Tl3WString): Boolean; overload; 
   procedure ExecuteScript(const aScript: AnsiString);
 public
 // public methods
   procedure OpenURL(const anURL: IExternalLink); overload; 
   class procedure RunScript(const aScript: AnsiString);
 end;//TbsHyperLinkProcessorPrim
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  IOUnit,
  nsTypes
  {$If not defined(NoScripts)}
  ,
  tfwScriptEngine
  {$IfEnd} //not NoScripts
  ,
  l3String,
  l3Base,
  DataAdapter,
  nsExternalObjectPrim,
  SysUtils,
  ComObj,
  ActiveX
  {$If not defined(NoScripts)}
  ,
  tfwF1HyperlinkScriptCaller
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TbsHyperLinkProcessorPrim

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

{$IfEnd} //not Admin AND not Monitorings

end.