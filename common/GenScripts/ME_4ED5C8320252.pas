{$IfNDef SBSColumnMarker_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\SBSColumnMarker.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "SBSColumnMarker" MUID: (4ED5C8320252)
// Имя типа: "_SBSColumnMarker_"

{$Define SBSColumnMarker_imp}

{$If Defined(evUseVisibleCursors)}
 _SBSColumnMarker_ = class(_SBSColumnMarker_Parent_)
  protected
   procedure SetClientValue(aValue: Integer;
    const aContext: InevOp); override;
   function DoGetClientValue: Integer; override;
   function DoGetValue: Integer; override;
 end;//_SBSColumnMarker_

{$Else Defined(evUseVisibleCursors)}

_SBSColumnMarker_ = _SBSColumnMarker_Parent_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else SBSColumnMarker_imp}

{$IfNDef SBSColumnMarker_imp_impl}

{$Define SBSColumnMarker_imp_impl}

{$If Defined(evUseVisibleCursors)}
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
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf SBSColumnMarker_imp_impl}

{$EndIf SBSColumnMarker_imp}

