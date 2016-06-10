unit htPriorityCalculator;

// Модуль: "w:\common\components\rtl\Garant\HT\htPriorityCalculator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "ThtPriorityCalculator" MUID: (575008E903D1)

{$Include w:\common\components\rtl\Garant\HT\htDefineDA.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 ThtPriorityCalculator = class(Tl3ProtoObject, IdaPriorityCalculator)
  protected
   function Calc(aUserId: TdaUserID;
    out aImportPriority: TdaPriority;
    out aExportPriority: TdaPriority): Boolean;
  public
   constructor Create; reintroduce;
   class function Make: IdaPriorityCalculator; reintroduce;
 end;//ThtPriorityCalculator

implementation

uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , dt_User
 {$IfEnd} // NOT Defined(Nemesis)
;

constructor ThtPriorityCalculator.Create;
//#UC START# *5750180302CA_575008E903D1_var*
//#UC END# *5750180302CA_575008E903D1_var*
begin
//#UC START# *5750180302CA_575008E903D1_impl*
 inherited;
//#UC END# *5750180302CA_575008E903D1_impl*
end;//ThtPriorityCalculator.Create

class function ThtPriorityCalculator.Make: IdaPriorityCalculator;
var
 l_Inst : ThtPriorityCalculator;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//ThtPriorityCalculator.Make

function ThtPriorityCalculator.Calc(aUserId: TdaUserID;
 out aImportPriority: TdaPriority;
 out aExportPriority: TdaPriority): Boolean;
//#UC START# *575000000164_575008E903D1_var*
//#UC END# *575000000164_575008E903D1_var*
begin
//#UC START# *575000000164_575008E903D1_impl*
 Result := dt_User.UserManager.xxxCalcUserPriorities(aUserID, aImportPriority, aExportPriority);
//#UC END# *575000000164_575008E903D1_impl*
end;//ThtPriorityCalculator.Calc

end.
