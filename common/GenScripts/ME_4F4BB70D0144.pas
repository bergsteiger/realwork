unit kwForwardDeclaration;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwForwardDeclaration.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwForwardDeclaration" MUID: (4F4BB70D0144)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwDictionaryPrim
 , l3Interfaces
 , l3Variant
;

type
 TkwForwardDeclaration = class(TtfwWord)
  private
   f_RealWord: TtfwWord;
  protected
   procedure pm_SetRealWord(aValue: TtfwWord);
   procedure DoDoIt(const aCtx: TtfwContext); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetWordProducer: TtfwWord; override;
   procedure pm_SetWordProducer(aValue: TtfwWord); override;
   function pm_GetInnerDictionary: TtfwDictionaryPrim; override;
   function pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo; override;
  public
   function IsForwardDeclaration: Boolean; override;
   function GetKeywordFinder(const aCtx: TtfwContext): TtfwWord; override;
   function DoCheckWord(const aName: Il3CString): TtfwKeyWord; override;
   function GetKeywordByName(const aName: Il3CString): Tl3PrimString; override;
   function GetParentFinder: TtfwWord; override;
   function WordName: Il3CString; override;
   function MakeRefForCompile(const aCtx: TtfwContext;
    aSNI: TtfwSuppressNextImmediate): TtfwWord; override;
  public
   property RealWord: TtfwWord
    read f_RealWord
    write pm_SetRealWord;
 end;//TkwForwardDeclaration
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , tfwClassRef
 , kwForwardDeclarationHolder
;

procedure TkwForwardDeclaration.pm_SetRealWord(aValue: TtfwWord);
//#UC START# *4F4BB75C021E_4F4BB70D0144set_var*
//#UC END# *4F4BB75C021E_4F4BB70D0144set_var*
begin
//#UC START# *4F4BB75C021E_4F4BB70D0144set_impl*
 aValue.SetRefTo(f_RealWord);
 if (f_RealWord <> nil) then
  f_RealWord.Key := Self.Key;
//#UC END# *4F4BB75C021E_4F4BB70D0144set_impl*
end;//TkwForwardDeclaration.pm_SetRealWord

procedure TkwForwardDeclaration.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F4BB70D0144_var*
//#UC END# *4DAEEDE10285_4F4BB70D0144_var*
begin
//#UC START# *4DAEEDE10285_4F4BB70D0144_impl*
 RunnerAssert(f_RealWord <> nil,
              'Предварительное определение слова не было завершено',
              aCtx);
 f_RealWord.DoIt(aCtx);
//#UC END# *4DAEEDE10285_4F4BB70D0144_impl*
end;//TkwForwardDeclaration.DoDoIt

procedure TkwForwardDeclaration.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F4BB70D0144_var*
//#UC END# *479731C50290_4F4BB70D0144_var*
begin
//#UC START# *479731C50290_4F4BB70D0144_impl*
 FreeAndNil(f_RealWord);
 inherited;
//#UC END# *479731C50290_4F4BB70D0144_impl*
end;//TkwForwardDeclaration.Cleanup

function TkwForwardDeclaration.pm_GetWordProducer: TtfwWord;
//#UC START# *4F43C9A10139_4F4BB70D0144get_var*
//#UC END# *4F43C9A10139_4F4BB70D0144get_var*
begin
//#UC START# *4F43C9A10139_4F4BB70D0144get_impl*
 if (f_RealWord = nil) then
  Result := nil
 else
  Result := f_RealWord.WordProducer;
//#UC END# *4F43C9A10139_4F4BB70D0144get_impl*
end;//TkwForwardDeclaration.pm_GetWordProducer

procedure TkwForwardDeclaration.pm_SetWordProducer(aValue: TtfwWord);
//#UC START# *4F43C9A10139_4F4BB70D0144set_var*
//#UC END# *4F43C9A10139_4F4BB70D0144set_var*
begin
//#UC START# *4F43C9A10139_4F4BB70D0144set_impl*
 f_RealWord.WordProducer := aValue;
//#UC END# *4F43C9A10139_4F4BB70D0144set_impl*
end;//TkwForwardDeclaration.pm_SetWordProducer

function TkwForwardDeclaration.IsForwardDeclaration: Boolean;
//#UC START# *4F4BB6CD0359_4F4BB70D0144_var*
//#UC END# *4F4BB6CD0359_4F4BB70D0144_var*
begin
//#UC START# *4F4BB6CD0359_4F4BB70D0144_impl*
 Result := true;
//#UC END# *4F4BB6CD0359_4F4BB70D0144_impl*
end;//TkwForwardDeclaration.IsForwardDeclaration

function TkwForwardDeclaration.pm_GetInnerDictionary: TtfwDictionaryPrim;
//#UC START# *52B43311021D_4F4BB70D0144get_var*
//#UC END# *52B43311021D_4F4BB70D0144get_var*
begin
//#UC START# *52B43311021D_4F4BB70D0144get_impl*
 if (f_RealWord = nil) then
  Result := nil
 else
  Result := f_RealWord.InnerDictionary;
//#UC END# *52B43311021D_4F4BB70D0144get_impl*
end;//TkwForwardDeclaration.pm_GetInnerDictionary

function TkwForwardDeclaration.pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo;
//#UC START# *52CFC11603C8_4F4BB70D0144get_var*
//#UC END# *52CFC11603C8_4F4BB70D0144get_var*
begin
//#UC START# *52CFC11603C8_4F4BB70D0144get_impl*
 if (f_RealWord = nil) then
  Result := inherited pm_GetResultTypeInfo(aCtx)
 else
  Result := f_RealWord.ResultTypeInfo[aCtx];
//#UC END# *52CFC11603C8_4F4BB70D0144get_impl*
end;//TkwForwardDeclaration.pm_GetResultTypeInfo

function TkwForwardDeclaration.GetKeywordFinder(const aCtx: TtfwContext): TtfwWord;
//#UC START# *52D5637A031E_4F4BB70D0144_var*
//#UC END# *52D5637A031E_4F4BB70D0144_var*
begin
//#UC START# *52D5637A031E_4F4BB70D0144_impl*
 Result := f_RealWord.GetKeywordFinder(aCtx);
//#UC END# *52D5637A031E_4F4BB70D0144_impl*
end;//TkwForwardDeclaration.GetKeywordFinder

function TkwForwardDeclaration.DoCheckWord(const aName: Il3CString): TtfwKeyWord;
//#UC START# *55A7D34102A0_4F4BB70D0144_var*
//#UC END# *55A7D34102A0_4F4BB70D0144_var*
begin
//#UC START# *55A7D34102A0_4F4BB70D0144_impl*
 Result := f_RealWord.DoCheckWord(aName);
//#UC END# *55A7D34102A0_4F4BB70D0144_impl*
end;//TkwForwardDeclaration.DoCheckWord

function TkwForwardDeclaration.GetKeywordByName(const aName: Il3CString): Tl3PrimString;
//#UC START# *55ACE5210310_4F4BB70D0144_var*
//#UC END# *55ACE5210310_4F4BB70D0144_var*
begin
//#UC START# *55ACE5210310_4F4BB70D0144_impl*
 Result := f_RealWord.GetKeywordByName(aName);
//#UC END# *55ACE5210310_4F4BB70D0144_impl*
end;//TkwForwardDeclaration.GetKeywordByName

function TkwForwardDeclaration.GetParentFinder: TtfwWord;
//#UC START# *55ACF0F5025D_4F4BB70D0144_var*
//#UC END# *55ACF0F5025D_4F4BB70D0144_var*
begin
//#UC START# *55ACF0F5025D_4F4BB70D0144_impl*
 Result := f_RealWord.GetParentFinder;
//#UC END# *55ACF0F5025D_4F4BB70D0144_impl*
end;//TkwForwardDeclaration.GetParentFinder

function TkwForwardDeclaration.WordName: Il3CString;
//#UC START# *55AFD7DA0258_4F4BB70D0144_var*
//#UC END# *55AFD7DA0258_4F4BB70D0144_var*
begin
//#UC START# *55AFD7DA0258_4F4BB70D0144_impl*
 Result := f_RealWord.WordName;
//#UC END# *55AFD7DA0258_4F4BB70D0144_impl*
end;//TkwForwardDeclaration.WordName

function TkwForwardDeclaration.MakeRefForCompile(const aCtx: TtfwContext;
 aSNI: TtfwSuppressNextImmediate): TtfwWord;
//#UC START# *55CB5B8C004E_4F4BB70D0144_var*
//#UC END# *55CB5B8C004E_4F4BB70D0144_var*
begin
//#UC START# *55CB5B8C004E_4F4BB70D0144_impl*
 Result := TkwForwardDeclarationHolder.Create(Self);
//#UC END# *55CB5B8C004E_4F4BB70D0144_impl*
end;//TkwForwardDeclaration.MakeRefForCompile

initialization
 TkwForwardDeclaration.RegisterClass;
 {* Регистрация TkwForwardDeclaration }
{$IfEnd} // NOT Defined(NoScripts)

end.
