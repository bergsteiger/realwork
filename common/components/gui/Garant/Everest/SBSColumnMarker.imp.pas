{$IfNDef SBSColumnMarker_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/SBSColumnMarker.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Cursors::SBSColumnMarker
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define SBSColumnMarker_imp}
{$If defined(evUseVisibleCursors)}
 _SBSColumnMarker_ = {mixin} class(_SBSColumnMarker_Parent_)
 protected
 // overridden protected methods
   procedure SetClientValue(aValue: Integer;
     const aContext: InevOp); override;
   function DoGetClientValue: Integer; override;
   function DoGetValue: Integer; override;
 end;//_SBSColumnMarker_
{$Else}

 _SBSColumnMarker_ = _SBSColumnMarker_Parent_;

{$IfEnd} //evUseVisibleCursors

{$Else SBSColumnMarker_imp}

{$If defined(evUseVisibleCursors)}

// start class _SBSColumnMarker_

procedure _SBSColumnMarker_.SetClientValue(aValue: Integer;
  const aContext: InevOp);
//#UC START# *4E3A3F0D0388_4ED5C8320252_var*
var
 l_FI : TnevFormatInfoPrim;
//#UC END# *4E3A3F0D0388_4ED5C8320252_var*
begin
//#UC START# *4E3A3F0D0388_4ED5C8320252_impl*
 l_FI := View.FormatInfoByPara(ParaInst);
 if l_FI = nil then
  Exit
 else
  l_FI.ResizeColumn(ColumnID, aValue, aContext);
//#UC END# *4E3A3F0D0388_4ED5C8320252_impl*
end;//_SBSColumnMarker_.SetClientValue

function _SBSColumnMarker_.DoGetClientValue: Integer;
//#UC START# *4E3A4C4B03A0_4ED5C8320252_var*
var
 l_FI: TnevFormatInfoPrim;
//#UC END# *4E3A4C4B03A0_4ED5C8320252_var*
begin
//#UC START# *4E3A4C4B03A0_4ED5C8320252_impl*
 try
  l_FI := View.FormatInfoByPara(ParaInst);
  if l_FI = nil then
   Result := 0
  else
   Result := l_FI.CalcClientValue4Column(ColumnID);
 except
  on Ek2ConversionError do
   Result := 0;
 end;//try..except
//#UC END# *4E3A4C4B03A0_4ED5C8320252_impl*
end;//_SBSColumnMarker_.DoGetClientValue

function _SBSColumnMarker_.DoGetValue: Integer;
//#UC START# *4ECF8E2C007D_4ED5C8320252_var*
var
 l_FI: TnevFormatInfoPrim;
//#UC END# *4ECF8E2C007D_4ED5C8320252_var*
begin
//#UC START# *4ECF8E2C007D_4ED5C8320252_impl*
 try
  l_FI := View.FormatInfoByPara(ParaInst);
  if l_FI = nil then
   Result := ClientValue
  else
   Result := l_FI.ClientToParent(l_FI.CalcClientValue4Column(ColumnID));
 except
  on Ek2ConversionError do
   Result := 0;
 end;//try..except
//#UC END# *4ECF8E2C007D_4ED5C8320252_impl*
end;//_SBSColumnMarker_.DoGetValue

{$IfEnd} //evUseVisibleCursors

{$EndIf SBSColumnMarker_imp}
