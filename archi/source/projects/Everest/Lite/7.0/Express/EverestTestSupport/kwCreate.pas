unit kwCreate;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestTestSupport"
// Модуль: "w:/archi/source/projects/Everest/Lite/7.0/Express/EverestTestSupport/kwCreate.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$EverestLite$TestSupport::EverestTestSupport::EverestLiteKeyWords::Create
//
// *Формат:*  Create
// *Описание:* Создает новый документ в редакторе.
// *Пример:*
// {code}
// Create
// {code}
// *Результат:* Будет создан новый документ.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  tfwRegisterableWord
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}
type
 TkwCreate = {final scriptword} class(TtfwRegisterableWord)
  {* *Формат:*  Create
*Описание:* Создает новый документ в редакторе.
 *Пример:*
 [code]
Create
 [code]
 *Результат:* Будет создан новый документ. }
 protected
 // realized methods
    {$If not defined(NoScripts)}
   procedure DoDoIt(const aCtx: TtfwContext); override;
    {$IfEnd} //not NoScripts
 protected
 // overridden protected methods
   {$If not defined(NoScripts)}
   class function GetWordNameForRegister: AnsiString; override;
   {$IfEnd} //not NoScripts
 end;//TkwCreate
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  EverestLiteAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TkwCreate

{$If not defined(NoScripts)}
procedure TkwCreate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_512D9C2D013F_var*
//#UC END# *4DAEEDE10285_512D9C2D013F_var*
begin
//#UC START# *4DAEEDE10285_512D9C2D013F_impl*
 CreateNewDocument;
//#UC END# *4DAEEDE10285_512D9C2D013F_impl*
end;//TkwCreate.DoDoIt
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
class function TkwCreate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Create';
end;//TkwCreate.GetWordNameForRegister
{$IfEnd} //not NoScripts

{$IfEnd} //InsiderTest AND nsTest

initialization
{$If defined(InsiderTest) AND defined(nsTest)}
// Регистрация Create
 TkwCreate.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest

end.