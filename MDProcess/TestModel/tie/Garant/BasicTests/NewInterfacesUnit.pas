unit NewInterfacesUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "BasicTests"
// Модуль: "w:/MDProcess/TestModel/tie/Garant/BasicTests/NewInterfacesUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::NewInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

type
 INewFacet = interface(IUnknown)
   ['{2CFA8895-40F1-4601-B8E9-52147ADB59DC}']
 end;//INewFacet

 TNewStruct = record
   new_attribute : Integer; // 
 end;//TNewStruct

 IBaseInterface = interface(IUnknown)
   ['{268B0A46-3C2C-4279-9154-EE5F93F50CD1}']
   function GetLnkLongP: Integer; stdcall;
   procedure SetLnkLongP(aValue: Integer); stdcall;
   function GetAgrLongP: Integer; stdcall;
   procedure SetAgrLongP(aValue: Integer); stdcall;
   function GetLnkStructP: TNewStruct; stdcall;
   procedure SetLnkStructP(const aValue: TNewStruct); stdcall;
   function GetAgrStructP: TNewStruct; stdcall;
   procedure SetAgrStructP(const aValue: TNewStruct); stdcall;
   property lnk_long_p: Integer
     read GetLnkLongP
     write SetLnkLongP;
   property agr_long_p: Integer
     read GetAgrLongP
     write SetAgrLongP;
   property lnk_struct_p: TNewStruct
     read GetLnkStructP
     write SetLnkStructP;
   property agr_struct_p: TNewStruct
     read GetAgrStructP
     write SetAgrStructP;
 end;//IBaseInterface

 IMySyperData = array of long long;

 IDerivedInterface = interface(BaseInterface)
   ['{19342E98-DAAF-4338-806F-19FA17807BD7}']
   procedure MyFunc(const aA: IMySyperData); stdcall;
 end;//IDerivedInterface

implementation

end.