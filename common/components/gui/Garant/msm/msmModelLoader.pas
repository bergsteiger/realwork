unit msmModelLoader;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelLoader.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelLoader" MUID: (57A9D6D90249)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmModelElements
;

type
 TmsmModelLoader = class
  public
   class function LoadFromFile(const aFileName: AnsiString): ImsmModelElement;
 end;//TmsmModelLoader

implementation

uses
 l3ImplUses
 , msmModelElementFactory
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngine
 {$IfEnd} // NOT Defined(NoScripts)
 , msmModelElementMethodCaller
 //#UC START# *57A9D6D90249impl_uses*
 , l3Chars
 , tfwScriptingInterfaces
 , tfwScriptEngineEx
 // - чтобы аксиоматика подтянулась
 , SysUtils
 //#UC END# *57A9D6D90249impl_uses*
;

class function TmsmModelLoader.LoadFromFile(const aFileName: AnsiString): ImsmModelElement;
//#UC START# *57A9D6F8022B_57A9D6D90249_var*
//#UC END# *57A9D6F8022B_57A9D6D90249_var*
begin
//#UC START# *57A9D6F8022B_57A9D6D90249_impl*
 Result := TmsmModelElementFactory.Make(
  TmsmModelElementMethodCaller.Call(
   [TtfwStackValue_C(TtfwCStringFactory.C(aFileName))],
   'WordByDictionaryPath').AsObject As TtfwWord
  );
//#UC END# *57A9D6F8022B_57A9D6D90249_impl*
end;//TmsmModelLoader.LoadFromFile

end.
