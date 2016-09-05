unit seModalWorker;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\seModalWorker.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "seModalWorker" MUID: (4FC75F0F0061)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
;

type
 TseModalWorker = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rWord: TtfwWord;
   rContext: PtfwContext;
  public
   procedure Free;
 end;//TseModalWorker

function TseModalWorker_C(aWord: TtfwWord;
 const aContext: TtfwContext): TseModalWorker;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *4FC75F0F0061impl_uses*
 //#UC END# *4FC75F0F0061impl_uses*
;

function TseModalWorker_C(aWord: TtfwWord;
 const aContext: TtfwContext): TseModalWorker;
//#UC START# *4FC755E000C9_4FC7557C0082_var*
//#UC END# *4FC755E000C9_4FC7557C0082_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4FC755E000C9_4FC7557C0082_impl*
 Result.rWord := aWord;
 Result.rContext := @aContext;
//#UC END# *4FC755E000C9_4FC7557C0082_impl*
end;//TseModalWorker_C

procedure TseModalWorker.Free;
//#UC START# *4FC755BA022E_4FC7557C0082_var*
//#UC END# *4FC755BA022E_4FC7557C0082_var*
begin
//#UC START# *4FC755BA022E_4FC7557C0082_impl*
 // - ничего не делаем пока
//#UC END# *4FC755BA022E_4FC7557C0082_impl*
end;//TseModalWorker.Free
{$IfEnd} // NOT Defined(NoScripts)

end.
