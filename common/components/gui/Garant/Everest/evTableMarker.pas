unit evTableMarker;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evTableMarker.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Cursors::TevTableMarker
//
// маркер отступа таблиц
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  evMarker,
  nevBase
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 TevTableMarker = class(TevMarker)
  {* маркер отступа таблиц }
 protected
 // overridden protected methods
   function DoGetValue: Integer; override;
   procedure DoSetValue(aValue: Integer;
     const Context: InevOp); override;
 end;//TevTableMarker
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  k2Except,
  l3Units
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}

// start class TevTableMarker

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

{$IfEnd} //evUseVisibleCursors

end.