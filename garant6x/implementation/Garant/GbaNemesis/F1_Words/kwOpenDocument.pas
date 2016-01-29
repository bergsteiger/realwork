unit kwOpenDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwOpenDocument.pas"
// Начат: 21.04.2011 14:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::OpenDocument
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 _F1Test_Parent_ = TtfwRegisterableWord;
 {$Include ..\F1_Words\F1Test.imp.pas}
 TkwOpenDocument = {scriptword} class(_F1Test_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwOpenDocument
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(Admin)}
  ,
  nsQueryInterfaces
  {$IfEnd} //not Admin
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  nsUtils,
  nsConst,
  bsTypesNew
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

{$Include ..\F1_Words\F1Test.imp.pas}

// start class TkwOpenDocument

procedure TkwOpenDocument.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB00AF302F0_var*
var
 sDoc: string;
 iDoc: Integer;
 l_Result: Boolean;
//#UC END# *4DAEEDE10285_4DB00AF302F0_var*
begin
//#UC START# *4DAEEDE10285_4DB00AF302F0_impl*
 if aCtx.rEngine.IsTopString then
 begin
  sDoc := aCtx.rEngine.PopDelphiString;
  l_Result := nsOpenDocumentByNumber(sDoc, true, false);
 end else
 begin
  if aCtx.rEngine.IsTopBool then
  begin                             
   if not aCtx.rEngine.PopBool then
   begin
    iDoc := aCtx.rEngine.PopInt;
    sDoc := IntToStr(iDoc);
    iDoc := iDoc + c_InternalDocShift;
   end else
   begin
    iDoc := aCtx.rEngine.PopInt;
    sDoc := IntToStr(iDoc);
   end;
  end else
  begin
   iDoc := aCtx.rEngine.PopInt;
   sDoc := IntToStr(iDoc);
   iDoc := iDoc + c_InternalDocShift;
  end;
  l_Result := nsOpenDocumentByNumber(iDoc, 0, dptSub, false);
 end;
 RunnerAssert(l_Result, 'Документ ' + sDoc + ' в базе не найден.', aCtx);
//#UC END# *4DAEEDE10285_4DB00AF302F0_impl*
end;//TkwOpenDocument.DoDoIt

class function TkwOpenDocument.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Открыть';
end;//TkwOpenDocument.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация OpenDocument
 TkwOpenDocument.RegisterInEngine;
{$IfEnd} //not NoScripts

end.