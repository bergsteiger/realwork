unit arHyperLinkProcessor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editor"
// Модуль: "w:/archi/source/projects/Archi/Editor/arHyperLinkProcessor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi::Editor::Scripting Support::arHyperLinkProcessor
//
// Открытие ссылки со скриптом.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
uses
  l3Interfaces,
  l3ProtoObject,
  nevNavigation
  ;

function ArOpenHyperLink(const aHyperLink: IevHyperlink): Boolean;
   {* Открыть ссылку }
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  l3String,
  l3Base,
  SysUtils
  {$If not defined(NoScripts)}
  ,
  tfwScriptEngine
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  tfwArchiHyperlinkScriptCaller
  {$IfEnd} //not NoScripts
  
  ;

type
 TarHyperLinkProcessor = class(Tl3ProtoObject)
  {* Обработка ссылок со скриптами }
 protected
 // protected methods
   function OpenURL(const anURL: Tl3WString): Boolean; virtual;
   procedure ExecuteScript(const aScript: AnsiString); virtual;
 end;//TarHyperLinkProcessor

// start class TarHyperLinkProcessor

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

function ArOpenHyperLink(const aHyperLink: IevHyperlink): Boolean;
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
end;//ArOpenHyperLink
{$IfEnd} //AppClientSide

end.