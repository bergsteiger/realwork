unit msmOperationsSeparator;

// Модуль: "w:\common\components\gui\Garant\msm\msmOperationsSeparator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmOperationsSeparator" MUID: (57D25DA703D8)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmOperation
 , msmOperations
;

type
 TmsmOperationsSeparator = class(TmsmOperation)
  protected
   procedure DoDoIt; override;
   function GetEnabled: Boolean; override;
  public
   constructor Create; reintroduce;
   class function Make: ImsmOperation; reintroduce;
 end;//TmsmOperationsSeparator

implementation

uses
 l3ImplUses
 //#UC START# *57D25DA703D8impl_uses*
 //#UC END# *57D25DA703D8impl_uses*
;

constructor TmsmOperationsSeparator.Create;
//#UC START# *57D25DD20388_57D25DA703D8_var*
//#UC END# *57D25DD20388_57D25DA703D8_var*
begin
//#UC START# *57D25DD20388_57D25DA703D8_impl*
 inherited Create('-', nil);
//#UC END# *57D25DD20388_57D25DA703D8_impl*
end;//TmsmOperationsSeparator.Create

class function TmsmOperationsSeparator.Make: ImsmOperation;
var
 l_Inst : TmsmOperationsSeparator;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmOperationsSeparator.Make

procedure TmsmOperationsSeparator.DoDoIt;
//#UC START# *57CEB1F602D1_57D25DA703D8_var*
//#UC END# *57CEB1F602D1_57D25DA703D8_var*
begin
//#UC START# *57CEB1F602D1_57D25DA703D8_impl*
 // - ничего не делаем
//#UC END# *57CEB1F602D1_57D25DA703D8_impl*
end;//TmsmOperationsSeparator.DoDoIt

function TmsmOperationsSeparator.GetEnabled: Boolean;
//#UC START# *57EB6D020381_57D25DA703D8_var*
//#UC END# *57EB6D020381_57D25DA703D8_var*
begin
//#UC START# *57EB6D020381_57D25DA703D8_impl*
 Result := true;
//#UC END# *57EB6D020381_57D25DA703D8_impl*
end;//TmsmOperationsSeparator.GetEnabled

end.
