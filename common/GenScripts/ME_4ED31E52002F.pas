unit evTableMarker;
 {* маркер отступа таблиц }

// Модуль: "w:\common\components\gui\Garant\Everest\evTableMarker.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evMarker
 , nevBase
;

type
 TevTableMarker = class(TevMarker)
  {* маркер отступа таблиц }
  protected
   function DoGetValue: Integer; override;
   procedure DoSetValue(aValue: Integer;
    const Context: InevOp); override;
 end;//TevTableMarker
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , k2Except
 , l3Units
;

function TevTableMarker.DoGetValue: Integer;
//#UC START# *4ECF8E2C007D_4ED31E52002F_var*
var
 l_FI: TnevFormatInfoPrim;
//#UC END# *4ECF8E2C007D_4ED31E52002F_var*
begin
//#UC START# *4ECF8E2C007D_4ED31E52002F_impl*
 try
  l_FI := View.FormatInfoByPara(ParaInst.OwnerPara);
  if l_FI = nil then
   Result := 0
  else
   Result := l_FI.ClientToParent(ClientValue);
 except
  on Ek2ConversionError do
   Result := 0;
 end;//try..except
//#UC END# *4ECF8E2C007D_4ED31E52002F_impl*
end;//TevTableMarker.DoGetValue

procedure TevTableMarker.DoSetValue(aValue: Integer;
 const Context: InevOp);
//#UC START# *4ED31DEA0077_4ED31E52002F_var*
var
 l_FI: TnevFormatInfoPrim;
//#UC END# *4ED31DEA0077_4ED31E52002F_var*
begin
//#UC START# *4ED31DEA0077_4ED31E52002F_impl*
 if (Self.Value <> aValue) then
 begin
  l_FI := View.FormatInfoByPara(ParaInst.OwnerPara);
  if l_FI <> nil then
  begin
   SetClientValue(l_FI.ParentToClient(l3PointX(aValue)).X, Context);
   ParaInst.Invalidate([nev_spExtent]);
  end; // if l_FI <> nil then
 end;//Self.Value <> Value
//#UC END# *4ED31DEA0077_4ED31E52002F_impl*
end;//TevTableMarker.DoSetValue
{$IfEnd} // Defined(evUseVisibleCursors)

end.
