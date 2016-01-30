unit arHyperLinkProcessor;
 {* Открытие ссылки со скриптом. }

// Модуль: "w:\archi\source\projects\Archi\Editor\arHyperLinkProcessor.pas"
// Стереотип: "UtilityPack"

{$Include arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , nevNavigation
 , l3ProtoObject
 , l3Interfaces
;

function arOpenHyperLink(const aHyperLink: IevHyperlink): Boolean;
 {* Открыть ссылку }
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , l3String
 , l3Base
 , SysUtils
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngine
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , tfwArchiHyperlinkScriptCaller
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TarHyperLinkProcessor = class(Tl3ProtoObject)
  {* Обработка ссылок со скриптами }
  protected
   function OpenURL(const anURL: Tl3WString): Boolean; virtual;
   procedure ExecuteScript(const aScript: AnsiString); virtual;
 end;//TarHyperLinkProcessor

function arOpenHyperLink(const aHyperLink: IevHyperlink): Boolean;
 {* Открыть ссылку }
//#UC START# *4E5C7FB10117_4E5C7F4402E8_var*
var
 l_Processor: TarHyperLinkProcessor;
//#UC END# *4E5C7FB10117_4E5C7F4402E8_var*
begin
//#UC START# *4E5C7FB10117_4E5C7F4402E8_impl*
 l_Processor := TarHyperLinkProcessor.Create;
 try
  Result := l_Processor.OpenURL(aHyperLink.URL);
 finally
  l3Free(l_Processor);
 end;
//#UC END# *4E5C7FB10117_4E5C7F4402E8_impl*
end;//arOpenHyperLink

function TarHyperLinkProcessor.OpenURL(const anURL: Tl3WString): Boolean;
//#UC START# *4E5C805800FC_4E5C7EA10197_var*
var
 l_P, l_S : Il3CString;
//#UC END# *4E5C805800FC_4E5C7EA10197_var*
begin
//#UC START# *4E5C805800FC_4E5C7EA10197_impl*
 if l3IsNil(anURL) then
  Result := false
 else
 begin
  l3Split(l3CStr(anURL), ':', l_P, l_S);
  Result := l3Same(l_P, 'script') AND not l3IsNil(l_S);
  if Result then
   ExecuteScript(l3Str(l_S));
 end;//l3IsNil(anURL)
//#UC END# *4E5C805800FC_4E5C7EA10197_impl*
end;//TarHyperLinkProcessor.OpenURL

procedure TarHyperLinkProcessor.ExecuteScript(const aScript: AnsiString);
//#UC START# *4E5C806F0361_4E5C7EA10197_var*
//#UC END# *4E5C806F0361_4E5C7EA10197_var*
begin
//#UC START# *4E5C806F0361_4E5C7EA10197_impl*
 TtfwScriptEngine.Script(aScript, TtfwArchiHyperlinkScriptCaller.Make);
//#UC END# *4E5C806F0361_4E5C7EA10197_impl*
end;//TarHyperLinkProcessor.ExecuteScript
{$IfEnd} // Defined(AppClientSide)

end.
