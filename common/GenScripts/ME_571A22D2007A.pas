unit DiffFormWordsPack;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\DiffFormWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "DiffFormWordsPack" MUID: (571A22D2007A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 //#UC START# *571A22D2007Aintf_uses*
 //#UC END# *571A22D2007Aintf_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , kwFormFromControlWord
 {$IfEnd} // NOT Defined(NoVCL)
 , Diff_Form
 , tfwScriptingInterfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , DocumentUnit
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
 //#UC START# *571A22D2007Aimpl_uses*
 //#UC END# *571A22D2007Aimpl_uses*
;

type
 TkwDiffFormWord = {abstract} class({$If NOT Defined(NoVCL)}
 TkwFormFromControlWord
 {$IfEnd} // NOT Defined(NoVCL)
 )
  protected
   procedure DoDiffForm(aForm: TDiffForm;
    const aCtx: TtfwContext); virtual; abstract;
   {$If NOT Defined(NoVCL)}
   procedure DoForm(aForm: TForm;
    const aCtx: TtfwContext); override;
   {$IfEnd} // NOT Defined(NoVCL)
 end;//TkwDiffFormWord

 TDiffFormHack = {abstract} class(TDiffForm)
 end;//TDiffFormHack

 TkwDiffIteratorWord = {abstract} class(TkwDiffFormWord)
  protected
   procedure DoIterator(const anIterator: IDiffIterator;
    const aCtx: TtfwContext); virtual; abstract;
   procedure DoDiffForm(aForm: TDiffForm;
    const aCtx: TtfwContext); override;
 end;//TkwDiffIteratorWord

 TkwDiffIteratorHasNext = class(TkwDiffIteratorWord)
  protected
   procedure DoIterator(const anIterator: IDiffIterator;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDiffIteratorHasNext

 TkwDiffIteratorPrev = class(TkwDiffIteratorWord)
  protected
   procedure DoIterator(const anIterator: IDiffIterator;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDiffIteratorPrev

 TkwDiffIteratorHasPrev = class(TkwDiffIteratorWord)
  protected
   procedure DoIterator(const anIterator: IDiffIterator;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDiffIteratorHasPrev

 TkwDiffIteratorNext = class(TkwDiffIteratorWord)
  protected
   procedure DoIterator(const anIterator: IDiffIterator;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDiffIteratorNext

{$If NOT Defined(NoVCL)}
procedure TkwDiffFormWord.DoForm(aForm: TForm;
 const aCtx: TtfwContext);
//#UC START# *4EB25DE00396_4EB25E1501E1_var*
//#UC END# *4EB25DE00396_4EB25E1501E1_var*
begin
//#UC START# *4EB25DE00396_4EB25E1501E1_impl*
 Assert(aForm Is TDiffForm, Format('Форма %s не совместима с %s',
                                   [aForm.ClassName, TDiffForm.ClassName]));
 DoDiffForm(aForm As TDiffForm, aCtx);
//#UC END# *4EB25DE00396_4EB25E1501E1_impl*
end;//TkwDiffFormWord.DoForm
{$IfEnd} // NOT Defined(NoVCL)

procedure TkwDiffIteratorWord.DoDiffForm(aForm: TDiffForm;
 const aCtx: TtfwContext);
//#UC START# *4EB25F0701B5_4EB2632A02DD_var*
//#UC END# *4EB25F0701B5_4EB2632A02DD_var*
begin
//#UC START# *4EB25F0701B5_4EB2632A02DD_impl*
 DoIterator(TDiffFormHack(aForm).CompareEditions.ChangedParas, aCtx);
//#UC END# *4EB25F0701B5_4EB2632A02DD_impl*
end;//TkwDiffIteratorWord.DoDiffForm

procedure TkwDiffIteratorHasNext.DoIterator(const anIterator: IDiffIterator;
 const aCtx: TtfwContext);
//#UC START# *4EB2634D0118_4EB25F2501B3_var*
//#UC END# *4EB2634D0118_4EB25F2501B3_var*
begin
//#UC START# *4EB2634D0118_4EB25F2501B3_impl*
 aCtx.rEngine.PushBool(anIterator.HasNext);
//#UC END# *4EB2634D0118_4EB25F2501B3_impl*
end;//TkwDiffIteratorHasNext.DoIterator

class function TkwDiffIteratorHasNext.GetWordNameForRegister: AnsiString;
begin
 Result := 'DiffIterator:HasNext';
end;//TkwDiffIteratorHasNext.GetWordNameForRegister

procedure TkwDiffIteratorPrev.DoIterator(const anIterator: IDiffIterator;
 const aCtx: TtfwContext);
//#UC START# *4EB2634D0118_4EB263BB0204_var*
//#UC END# *4EB2634D0118_4EB263BB0204_var*
begin
//#UC START# *4EB2634D0118_4EB263BB0204_impl*
 aCtx.rEngine.PushInt(anIterator.Prev);
//#UC END# *4EB2634D0118_4EB263BB0204_impl*
end;//TkwDiffIteratorPrev.DoIterator

class function TkwDiffIteratorPrev.GetWordNameForRegister: AnsiString;
begin
 Result := 'DiffIterator:Prev';
end;//TkwDiffIteratorPrev.GetWordNameForRegister

procedure TkwDiffIteratorHasPrev.DoIterator(const anIterator: IDiffIterator;
 const aCtx: TtfwContext);
//#UC START# *4EB2634D0118_4EB263890066_var*
//#UC END# *4EB2634D0118_4EB263890066_var*
begin
//#UC START# *4EB2634D0118_4EB263890066_impl*
 aCtx.rEngine.PushBool(anIterator.HasPrev);
//#UC END# *4EB2634D0118_4EB263890066_impl*
end;//TkwDiffIteratorHasPrev.DoIterator

class function TkwDiffIteratorHasPrev.GetWordNameForRegister: AnsiString;
begin
 Result := 'DiffIterator:HasPrev';
end;//TkwDiffIteratorHasPrev.GetWordNameForRegister

procedure TkwDiffIteratorNext.DoIterator(const anIterator: IDiffIterator;
 const aCtx: TtfwContext);
//#UC START# *4EB2634D0118_4EB25F5F0340_var*
//#UC END# *4EB2634D0118_4EB25F5F0340_var*
begin
//#UC START# *4EB2634D0118_4EB25F5F0340_impl*
 aCtx.rEngine.PushInt(anIterator.Next);
//#UC END# *4EB2634D0118_4EB25F5F0340_impl*
end;//TkwDiffIteratorNext.DoIterator

class function TkwDiffIteratorNext.GetWordNameForRegister: AnsiString;
begin
 Result := 'DiffIterator:Next';
end;//TkwDiffIteratorNext.GetWordNameForRegister

initialization
 TkwDiffFormWord.RegisterClass;
 {* Регистрация TkwDiffFormWord }
 TkwDiffIteratorWord.RegisterClass;
 {* Регистрация TkwDiffIteratorWord }
 TkwDiffIteratorHasNext.RegisterInEngine;
 {* Регистрация TkwDiffIteratorHasNext }
 TkwDiffIteratorPrev.RegisterInEngine;
 {* Регистрация TkwDiffIteratorPrev }
 TkwDiffIteratorHasPrev.RegisterInEngine;
 {* Регистрация TkwDiffIteratorHasPrev }
 TkwDiffIteratorNext.RegisterInEngine;
 {* Регистрация TkwDiffIteratorNext }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
