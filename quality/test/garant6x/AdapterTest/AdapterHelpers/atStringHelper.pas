unit atStringHelper;

// Модуль: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atStringHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatStringHelper" MUID: (48B5671301C7)

interface

uses
 l3IntfUses
 , IOUnit
;

type
 TatStringHelper = class
  public
   class function AStr2DStr(const aString: IString): AnsiString; virtual;
   class function DStr2AStr(const aString: AnsiString): IString; virtual;
 end;//TatStringHelper

implementation

uses
 l3ImplUses
 , atGblAdapterWorker
 //#UC START# *48B5671301C7impl_uses*
 //#UC END# *48B5671301C7impl_uses*
;

class function TatStringHelper.AStr2DStr(const aString: IString): AnsiString;
//#UC START# *48B567460292_48B5671301C7_var*
//#UC END# *48B567460292_48B5671301C7_var*
begin
//#UC START# *48B567460292_48B5671301C7_impl*
  SetString(Result, aString.GetData, aString.GetLength);
//#UC END# *48B567460292_48B5671301C7_impl*
end;//TatStringHelper.AStr2DStr

class function TatStringHelper.DStr2AStr(const aString: AnsiString): IString;
//#UC START# *48B5679F0206_48B5671301C7_var*
//#UC END# *48B5679F0206_48B5671301C7_var*
begin
//#UC START# *48B5679F0206_48B5671301C7_impl*
  Result := TatGblAdapterWorker.Instance.GblAdapterDll.MakeString(PAnsiChar(aString));
//#UC END# *48B5679F0206_48B5671301C7_impl*
end;//TatStringHelper.DStr2AStr

end.
