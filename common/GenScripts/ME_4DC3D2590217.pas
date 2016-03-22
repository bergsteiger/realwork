unit CustomInsiderScripter;

// Модуль: "w:\common\components\rtl\Garant\ScriptTestLibrary\CustomInsiderScripter.pas"
// Стереотип: "TestCase"
// Элемент модели: "TCustomInsiderScripter" MUID: (4DC3D2590217)

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , vcmInsiderTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TCustomInsiderScripter = {abstract} class(TvcmInsiderTest)
  protected
   procedure Run; virtual; abstract;
   procedure Prepare; virtual; abstract;
    {* Вызывается в начале DoIt }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$If NOT Defined(NotTunedDUnit)}
   function GetScriptName: AnsiString; override;
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   {$If NOT Defined(NotTunedDUnit)}
   function FileNameForOutput: AnsiString; override;
   {$IfEnd} // NOT Defined(NotTunedDUnit)
  published
   procedure DoIt;
 end;//TCustomInsiderScripter
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3DispatcherHelper
 , l3MessagesService
 , l3DocumentsCacheService
 , TestFrameWork
 , tfwScriptEngine
;

{$If NOT Defined(NotTunedDUnit)}
procedure TCustomInsiderScripter.DoIt;
//#UC START# *4DC3D3150155_4DC3D2590217_var*
var
 l_WasException : Boolean;
//#UC END# *4DC3D3150155_4DC3D2590217_var*
begin
//#UC START# *4DC3D3150155_4DC3D2590217_impl*
 l_WasException := false;
 try
  try
   if not CompileOnly then
   begin
    Prepare;
    Tl3DispatcherHelper.Instance.ClearHistory;
    Tl3DocumentsCacheService.Instance.Clear;
   end;//not CompileOnly
   Tl3MessagesService.Instance.ProcessMessages;
   StartTimer;
   try
    Run;
   finally
    StopTimer;
   end;//try..finally
  except
   l_WasException := true;
   raise;
  end;//try..except
 finally
  CheckOutputFiler(l_WasException);
 end;//try..finally
//#UC END# *4DC3D3150155_4DC3D2590217_impl*
end;//TCustomInsiderScripter.DoIt

function TCustomInsiderScripter.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ScriptTestUnit';
end;//TCustomInsiderScripter.GetFolder

function TCustomInsiderScripter.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DC3D2590217';
end;//TCustomInsiderScripter.GetModelElementGUID

function TCustomInsiderScripter.GetScriptName: AnsiString;
//#UC START# *4DC263E8038F_4DC3D2590217_var*
//#UC END# *4DC263E8038F_4DC3D2590217_var*
begin
//#UC START# *4DC263E8038F_4DC3D2590217_impl*
 if IsScript then
  Result := FTestName
 else
  Result := inherited GetScriptName;
//#UC END# *4DC263E8038F_4DC3D2590217_impl*
end;//TCustomInsiderScripter.GetScriptName

function TCustomInsiderScripter.FileNameForOutput: AnsiString;
//#UC START# *4DCA41A20364_4DC3D2590217_var*
//#UC END# *4DCA41A20364_4DC3D2590217_var*
begin
//#UC START# *4DCA41A20364_4DC3D2590217_impl*
 if IsScript then
  Result := GetScriptName
 else
  Result := inherited FileNameForOutput;
//#UC END# *4DCA41A20364_4DC3D2590217_impl*
end;//TCustomInsiderScripter.FileNameForOutput
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
