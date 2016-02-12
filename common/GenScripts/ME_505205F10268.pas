{$IfNDef atEntityWithName_imp}

// Модуль: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atEntityWithName.imp.pas"
// Стереотип: "Impurity"

{$Define atEntityWithName_imp}

 {$Include w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atEntity.imp.pas}
 _atEntityWithName_ = class(_atEntity_)
  protected
   function pm_GetName: AnsiString; virtual;
  public
   property Name: AnsiString
    read pm_GetName;
 end;//_atEntityWithName_

{$Else atEntityWithName_imp}

{$IfNDef atEntityWithName_imp_impl}

{$Define atEntityWithName_imp_impl}

{$Include w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atEntity.imp.pas}

function _atEntityWithName_.pm_GetName: AnsiString;
//#UC START# *4FD249FB01FC_505205F10268get_var*
  var
    l_Str : IString;
//#UC END# *4FD249FB01FC_505205F10268get_var*
begin
//#UC START# *4FD249FB01FC_505205F10268get_impl*
  f_Entity.GetName(l_Str);
  if Assigned(l_Str) then
    SetString(Result, l_Str.GetData, l_Str.GetLength)
  else
    Result := ''; 
//#UC END# *4FD249FB01FC_505205F10268get_impl*
end;//_atEntityWithName_.pm_GetName

{$EndIf atEntityWithName_imp_impl}

{$EndIf atEntityWithName_imp}

