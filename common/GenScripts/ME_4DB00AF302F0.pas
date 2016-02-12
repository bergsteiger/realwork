unit kwOpenDocument;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwOpenDocument.pas"
// Стереотип: "ScriptKeyword"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 _F1Test_Parent_ = TtfwRegisterableWord;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\F1Test.imp.pas}
 TkwOpenDocument = class(_F1Test_)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwOpenDocument
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(Admin)}
 , nsQueryInterfaces
 {$IfEnd} // NOT Defined(Admin)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , nsUtils
 , nsConst
 , bsTypesNew
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\F1Test.imp.pas}

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
begin
 Result := 'Открыть';
end;//TkwOpenDocument.GetWordNameForRegister

initialization
 TkwOpenDocument.RegisterInEngine;
 {* Регистрация OpenDocument }
{$IfEnd} // NOT Defined(NoScripts)

end.
