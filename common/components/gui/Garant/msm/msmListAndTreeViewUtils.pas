unit msmListAndTreeViewUtils;

// Модуль: "w:\common\components\gui\Garant\msm\msmListAndTreeViewUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "msmListAndTreeViewUtils" MUID: (57B45AC9019C)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
;

type
 TmsmTreeViewInitContext = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rMultiStrokeItem: Boolean;
   rImageNameProp: AnsiString;
 end;//TmsmTreeViewInitContext

 TmsmListViewtInitContext = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rMultiStrokeItem: Boolean;
   rImageNameProp: AnsiString;
 end;//TmsmListViewtInitContext

function TmsmTreeViewInitContext_C: TmsmTreeViewInitContext;
function TmsmListViewtInitContext_C: TmsmListViewtInitContext;

implementation

uses
 l3ImplUses
 //#UC START# *57B45AC9019Cimpl_uses*
 //#UC END# *57B45AC9019Cimpl_uses*
;

function TmsmTreeViewInitContext_C: TmsmTreeViewInitContext;
//#UC START# *57B45C9100C2_57B45B2201A5_var*
//#UC END# *57B45C9100C2_57B45B2201A5_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *57B45C9100C2_57B45B2201A5_impl*
//#UC END# *57B45C9100C2_57B45B2201A5_impl*
end;//TmsmTreeViewInitContext_C

function TmsmListViewtInitContext_C: TmsmListViewtInitContext;
//#UC START# *57B45CA701A8_57B45B380244_var*
//#UC END# *57B45CA701A8_57B45B380244_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *57B45CA701A8_57B45B380244_impl*
//#UC END# *57B45CA701A8_57B45B380244_impl*
end;//TmsmListViewtInitContext_C

end.
