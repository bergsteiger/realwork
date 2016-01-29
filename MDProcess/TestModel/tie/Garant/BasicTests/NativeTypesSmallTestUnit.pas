unit NativeTypesSmallTestUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "BasicTests"
// Модуль: "w:/MDProcess/TestModel/tie/Garant/BasicTests/NativeTypesSmallTestUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::NativeTypesSmallTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

const
  { NewConstants }
 LONG : Integer = 1;
  {  }
 STRING : PChar = this is string;
  {  }
 ASTRING : String = this is a-string;
  {  }

type
 TNewEnum = (
   A // 
 , B // 
 , C // 
 );//TNewEnum

 NewException = class
 private
 // private fields
   attr : String;
 private
 // property fields
   f_property : String;
   f_ro_property : String;
   f_wo_property : String;
 protected
 // property methods
   function pm_GetProperty: String;
   procedure pm_SetProperty(const aValue: String);
   function pm_GetRoProperty: String;
   procedure pm_SetWoProperty(const aValue: String);
 public
 // public methods
   constructor VoidCtor; virtual;
 public
 // public properties
   property property: String
     read pm_GetProperty
     write pm_SetProperty;
   property ro_property: String
     read pm_GetRoProperty;
   property wo_property: String
     write pm_SetWoProperty;
 end;//NewException

 TFullCharStruct = record
  {* CONSTRAINT ERROR: "Cant use this type of attributes (FullCharStruct::char,ref-const,ref)" CONSTRAINT ERROR: "Cant use this type of attributes (FullCharStruct::char,ref-ref)" }
   char_agr : char; // 
   const_char_agr : char; // 
   ref_char_agr : char; // 
   constref_char_agr : char; // 
   char_ref : char; // 
   const_char_ref : char; // 
   char_lnk : char; // 
   const_char_lnk : char; // 
   ref_char_lnk : char; // 
   constref_char_lnk : char; // 
 end;//TFullCharStruct

function TFullCharStruct_void_ctor: TFullCharStruct;

type
 TNewEnumT = TNewEnum;

 NewUnion = record
  Case : TNewEnum of
   A: (a_long: Integer);
   B: (b_new_enum_t: TNewEnumT);
   C: (c_astring: String);
 end;//NewUnion

implementation

// start class NewException

function NewException.pm_GetProperty: String;
//#UC START# *49B9229C0112_49AEDAED01F3get_var*
//#UC END# *49B9229C0112_49AEDAED01F3get_var*
begin
//#UC START# *49B9229C0112_49AEDAED01F3get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49B9229C0112_49AEDAED01F3get_impl*
end;

procedure NewException.pm_SetProperty(const aValue: String);
//#UC START# *49B9229C0112_49AEDAED01F3set_var*
//#UC END# *49B9229C0112_49AEDAED01F3set_var*
begin
//#UC START# *49B9229C0112_49AEDAED01F3set_impl*
 !!! Needs to be implemented !!!
//#UC END# *49B9229C0112_49AEDAED01F3set_impl*
end;

function NewException.pm_GetRoProperty: String;
//#UC START# *49B922B002CD_49AEDAED01F3get_var*
//#UC END# *49B922B002CD_49AEDAED01F3get_var*
begin
//#UC START# *49B922B002CD_49AEDAED01F3get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49B922B002CD_49AEDAED01F3get_impl*
end;

procedure NewException.pm_SetWoProperty(const aValue: String);
//#UC START# *49B922CA037D_49AEDAED01F3set_var*
//#UC END# *49B922CA037D_49AEDAED01F3set_var*
begin
//#UC START# *49B922CA037D_49AEDAED01F3set_impl*
 !!! Needs to be implemented !!!
//#UC END# *49B922CA037D_49AEDAED01F3set_impl*
end;

constructor NewException.VoidCtor;
//#UC START# *49B9227C0055_49AEDAED01F3_var*
//#UC END# *49B9227C0055_49AEDAED01F3_var*
begin
//#UC START# *49B9227C0055_49AEDAED01F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *49B9227C0055_49AEDAED01F3_impl*
end;
function TFullCharStruct_void_ctor: TFullCharStruct;
//#UC START# *49B9226E014C_49AEDB5301AD_var*
//#UC END# *49B9226E014C_49AEDB5301AD_var*
begin
 System.FillChar(Result, 0, SizeOf(Result));
//#UC START# *49B9226E014C_49AEDB5301AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *49B9226E014C_49AEDB5301AD_impl*
end;

end.