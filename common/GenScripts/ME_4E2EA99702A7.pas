{$IfNDef k2Int64Holder_imp}

// Модуль: "w:\common\components\rtl\Garant\K2\k2Int64Holder.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "k2Int64Holder" MUID: (4E2EA99702A7)
// Имя типа: "_k2Int64Holder_"

{$Define k2Int64Holder_imp}

 _k2Int64Holder_ = {abstract} class(_k2Int64Holder_Parent_)
  protected
   function GetInt64A(anIndex: Integer): Int64; override;
   procedure SetInt64A(anIndex: Integer;
    const aContext: Il3OpPack;
    aValue: Int64); override;
 end;//_k2Int64Holder_

{$Else k2Int64Holder_imp}

{$IfNDef k2Int64Holder_imp_impl}

{$Define k2Int64Holder_imp_impl}

function _k2Int64Holder_.GetInt64A(anIndex: Integer): Int64;
//#UC START# *5360CE4B026A_4E2EA99702A7_var*
var
 l_V : Tk2In64Converter absolute Result;
//#UC END# *5360CE4B026A_4E2EA99702A7_var*
begin
//#UC START# *5360CE4B026A_4E2EA99702A7_impl*
 with Self.Attr[anIndex] do
 begin
  l_V.rLo := IntA[k2_tiDocID];
  l_V.rHi := IntA[k2_tiSubID];
 end;//with Self.Attr[anIndex]
//#UC END# *5360CE4B026A_4E2EA99702A7_impl*
end;//_k2Int64Holder_.GetInt64A

procedure _k2Int64Holder_.SetInt64A(anIndex: Integer;
 const aContext: Il3OpPack;
 aValue: Int64);
//#UC START# *5360CE910025_4E2EA99702A7_var*
var
 l_V : Tk2In64Converter absolute aValue;
//#UC END# *5360CE910025_4E2EA99702A7_var*
begin
//#UC START# *5360CE910025_4E2EA99702A7_impl*
 with Self.cAtom(anIndex, aContext) do
 begin
  IntA[k2_tiDocID] := l_V.rLo;
  IntA[k2_tiSubID] := l_V.rHi;
 end;//Self.cAtom(anIndex)
//#UC END# *5360CE910025_4E2EA99702A7_impl*
end;//_k2Int64Holder_.SetInt64A

{$EndIf k2Int64Holder_imp_impl}

{$EndIf k2Int64Holder_imp}

