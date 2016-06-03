unit caPriorityCalculator;

// Модуль: "w:\common\components\rtl\Garant\ComboAccess\caPriorityCalculator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcaPriorityCalculator" MUID: (5751293D00A9)

{$Include w:\common\components\rtl\Garant\ComboAccess\caDefine.inc}

interface

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 TcaPriorityCalculator = class(Tl3ProtoObject, IdaPriorityCalculator)
  private
   f_HTCalculator: IdaPriorityCalculator;
   f_PGCalculator: IdaPriorityCalculator;
  protected
   function Calc(aUserId: TdaUserID;
    out aImportPriority: TdaPriority;
    out aExportPriority: TdaPriority): Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aHTCalculator: IdaPriorityCalculator;
    const aPGCalculator: IdaPriorityCalculator); reintroduce;
   class function Make(const aHTCalculator: IdaPriorityCalculator;
    const aPGCalculator: IdaPriorityCalculator): IdaPriorityCalculator; reintroduce;
 end;//TcaPriorityCalculator
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
;

constructor TcaPriorityCalculator.Create(const aHTCalculator: IdaPriorityCalculator;
 const aPGCalculator: IdaPriorityCalculator);
//#UC START# *5751296703D0_5751293D00A9_var*
//#UC END# *5751296703D0_5751293D00A9_var*
begin
//#UC START# *5751296703D0_5751293D00A9_impl*
 inherited Create;
 f_HTCalculator := aHTCalculator;
 f_PGCalculator := aPGCalculator;
//#UC END# *5751296703D0_5751293D00A9_impl*
end;//TcaPriorityCalculator.Create

class function TcaPriorityCalculator.Make(const aHTCalculator: IdaPriorityCalculator;
 const aPGCalculator: IdaPriorityCalculator): IdaPriorityCalculator;
var
 l_Inst : TcaPriorityCalculator;
begin
 l_Inst := Create(aHTCalculator, aPGCalculator);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TcaPriorityCalculator.Make

function TcaPriorityCalculator.Calc(aUserId: TdaUserID;
 out aImportPriority: TdaPriority;
 out aExportPriority: TdaPriority): Boolean;
//#UC START# *575000000164_5751293D00A9_var*
var
 l_ImportPriority: TdaPriority;
 l_ExportPriority: TdaPriority;
//#UC END# *575000000164_5751293D00A9_var*
begin
//#UC START# *575000000164_5751293D00A9_impl*
 Result := f_HTCalculator.Calc(aUserID, aImportPriority, aExportPriority);
 Assert(Result = f_PGCalculator.Calc(aUserID, l_ImportPriority, l_ExportPriority));
 if Result then
  Assert((aImportPriority = l_ImportPriority) and (aExportPriority = l_ExportPriority));
//#UC END# *575000000164_5751293D00A9_impl*
end;//TcaPriorityCalculator.Calc

procedure TcaPriorityCalculator.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5751293D00A9_var*
//#UC END# *479731C50290_5751293D00A9_var*
begin
//#UC START# *479731C50290_5751293D00A9_impl*
 f_HTCalculator := nil;
 f_PGCalculator := nil;
 inherited;
//#UC END# *479731C50290_5751293D00A9_impl*
end;//TcaPriorityCalculator.Cleanup
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
