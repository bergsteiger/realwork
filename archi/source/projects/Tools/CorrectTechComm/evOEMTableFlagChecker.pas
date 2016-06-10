unit evOEMTableFlagChecker;
 {* Фильтр выставления флага выливать в псевдографику таблицам. }

// Модуль: "w:\common\components\gui\Garant\EverestCommon\evOEMTableFlagFilter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevOEMTableFlagFilter" MUID: (4C3FED3103B2)

{$Include w:\common\components\gui\Garant\EverestCommon\evDefine.inc}

interface

uses
 l3IntfUses,
 l3Filer,
 evInfoFilter
 , k2TagFilter
 , k2Base
 , l3Variant
;

type
 TevOEMTableFlagChecker = class(TevInfoFilterEx)
  {* Фильтр выставления флага выливать в псевдографику таблицам. }
  protected
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
    {-}
 end;//TevOEMTableFlagChecker

implementation

uses
 l3ImplUses,
 l3Types,
 SysUtils,
  Table_Const
 , k2Tags
;

procedure TevOEMTableFlagChecker.AddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4A2D1634025B_4C3FED3103B2_var*
//#UC END# *4A2D1634025B_4C3FED3103B2_var*
begin
//#UC START# *4A2D1634025B_4C3FED3103B2_impl*
 if CurrentType.IsKindOf(k2_typTable) and (AtomIndex = k2_tiOldNSRC) then
  if VariantAsInteger(AtomIndex, Value) = Ord(True) then
   if not f_WasOut then
    ReportDocID;
 inherited;
//#UC END# *4A2D1634025B_4C3FED3103B2_impl*
end;//TevOEMTableFlagChecker.DoAddAtomEx

end.
