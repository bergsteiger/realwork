unit ddTable;

// Модуль: "w:\common\components\rtl\Garant\dd\ddTable.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddTablePrim
 , ddCustomDestination
;

type
 TddTable = class(TddTablePrim)
  private
   f_StartRow: Integer;
    {* Поле для свойства StartRow }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure ClearRows;
   procedure Clear; override;
   constructor Create(aDetination: TddCustomDestination); override;
  public
   property StartRow: Integer
    read f_StartRow
    write f_StartRow;
 end;//TddTable

implementation

uses
 l3ImplUses
;

procedure TddTable.ClearRows;
//#UC START# *54EC750000EB_519B719F0019_var*
//#UC END# *54EC750000EB_519B719F0019_var*
begin
//#UC START# *54EC750000EB_519B719F0019_impl*
 RowList.Clear;
//#UC END# *54EC750000EB_519B719F0019_impl*
end;//TddTable.ClearRows

procedure TddTable.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_519B719F0019_var*
//#UC END# *479731C50290_519B719F0019_var*
begin
//#UC START# *479731C50290_519B719F0019_impl*
 f_StartRow := 0;
 inherited;
//#UC END# *479731C50290_519B719F0019_impl*
end;//TddTable.Cleanup

procedure TddTable.Clear;
//#UC START# *518A48F500CF_519B719F0019_var*
//#UC END# *518A48F500CF_519B719F0019_var*
begin
//#UC START# *518A48F500CF_519B719F0019_impl*
 f_StartRow := 0;
 inherited;
//#UC END# *518A48F500CF_519B719F0019_impl*
end;//TddTable.Clear

constructor TddTable.Create(aDetination: TddCustomDestination);
//#UC START# *51E91BA80051_519B719F0019_var*
//#UC END# *51E91BA80051_519B719F0019_var*
begin
//#UC START# *51E91BA80051_519B719F0019_impl*
 inherited Create(aDetination);
 f_StartRow := 0;
//#UC END# *51E91BA80051_519B719F0019_impl*
end;//TddTable.Create

end.
