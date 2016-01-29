{$IfNDef atEntityWithName_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/AdapterHelpers/atEntityWithName.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> garant6x_test::AdapterTest::AdapterHelpers::atEntityWithName
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define atEntityWithName_imp}
 {$Include ..\AdapterHelpers\atEntity.imp.pas}
 _atEntityWithName_ = {mixin} class(_atEntity_)
 protected
 // property methods
   function pm_GetName: AnsiString; virtual;
 public
 // public properties
   property Name: AnsiString
     read pm_GetName;
 end;//_atEntityWithName_

{$Else atEntityWithName_imp}

{$Include ..\AdapterHelpers\atEntity.imp.pas}

// start class _atEntityWithName_

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

{$EndIf atEntityWithName_imp}
