unit tfwMainDictionary;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionary.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDictionaryEx
 , tfwScriptingInterfaces
 , tfwDictionary
 , l3Interfaces
;

type
 TtfwMainDictionary = class(TtfwDictionaryEx)
  private
   f_CompiledCode: TtfwWord;
    {* Поле для свойства CompiledCode }
  protected
   procedure pm_SetCompiledCode(aValue: TtfwWord);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function FindInUsedDictionary(anOther: TtfwDictionary;
    const aName: Il3CString): TtfwKeyWord; override;
  public
   function IsMain: Boolean; override;
  public
   property CompiledCode: TtfwWord
    read f_CompiledCode
    write pm_SetCompiledCode;
 end;//TtfwMainDictionary
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwMainDictionaryWordsPack
;

procedure TtfwMainDictionary.pm_SetCompiledCode(aValue: TtfwWord);
//#UC START# *55A4E85101BA_55A0005D02CCset_var*
//#UC END# *55A4E85101BA_55A0005D02CCset_var*
begin
//#UC START# *55A4E85101BA_55A0005D02CCset_impl*
 aValue.SetRefTo(f_CompiledCode);
//#UC END# *55A4E85101BA_55A0005D02CCset_impl*
end;//TtfwMainDictionary.pm_SetCompiledCode

procedure TtfwMainDictionary.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55A0005D02CC_var*
//#UC END# *479731C50290_55A0005D02CC_var*
begin
//#UC START# *479731C50290_55A0005D02CC_impl*
 CompiledCode := nil;
 inherited;
//#UC END# *479731C50290_55A0005D02CC_impl*
end;//TtfwMainDictionary.Cleanup

function TtfwMainDictionary.FindInUsedDictionary(anOther: TtfwDictionary;
 const aName: Il3CString): TtfwKeyWord;
//#UC START# *55A3A1E7038F_55A0005D02CC_var*
//#UC END# *55A3A1E7038F_55A0005D02CC_var*
begin
//#UC START# *55A3A1E7038F_55A0005D02CC_impl*
(* if (anOther Is TtfwHLTCLikeDictionary) then
  Result := anOther.DRbyCName[aName]
 else*)
  Result := inherited FindInUsedDictionary(anOther, aName);
//#UC END# *55A3A1E7038F_55A0005D02CC_impl*
end;//TtfwMainDictionary.FindInUsedDictionary

function TtfwMainDictionary.IsMain: Boolean;
//#UC START# *55A531FA016A_55A0005D02CC_var*
//#UC END# *55A531FA016A_55A0005D02CC_var*
begin
//#UC START# *55A531FA016A_55A0005D02CC_impl*
 Result := true;
//#UC END# *55A531FA016A_55A0005D02CC_impl*
end;//TtfwMainDictionary.IsMain
{$IfEnd} // NOT Defined(NoScripts)

end.
