unit k2MemoryStream;

// Модуль: "w:\common\components\rtl\Garant\K2\k2MemoryStream.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2MemoryStream" MUID: (530B3FE100E2)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3Memory
 , k2Interfaces
;

type
 Tk2MemoryStream = class(Tl3MemoryStream, Ik2RawData)
  protected
   function GetIsModified: Boolean; virtual;
   function pm_GetIsModified: Boolean;
   function Get_OriginalData: Tl3Variant;
   function Get_InternalID: Integer;
   procedure Set_InternalID(aValue: Integer);
   function Get_ExternalID: Integer;
   procedure Set_ExternalID(aValue: Integer);
 end;//Tk2MemoryStream

implementation

uses
 l3ImplUses
 , k2SizedMemoryPool
;

function Tk2MemoryStream.GetIsModified: Boolean;
//#UC START# *5798CBD10051_530B3FE100E2_var*
//#UC END# *5798CBD10051_530B3FE100E2_var*
begin
//#UC START# *5798CBD10051_530B3FE100E2_impl*
// Result := false;
 Result := true;
 // - иначе на стороне Archi считают, что картинки нет, или она не изменилась
//#UC END# *5798CBD10051_530B3FE100E2_impl*
end;//Tk2MemoryStream.GetIsModified

function Tk2MemoryStream.pm_GetIsModified: Boolean;
//#UC START# *49A67D980375_530B3FE100E2get_var*
//#UC END# *49A67D980375_530B3FE100E2get_var*
begin
//#UC START# *49A67D980375_530B3FE100E2get_impl*
// Result := false;
 Result := true;
 // - иначе на стороне Archi считают, что картинки нет, или она не изменилась
//#UC END# *49A67D980375_530B3FE100E2get_impl*
end;//Tk2MemoryStream.pm_GetIsModified

function Tk2MemoryStream.Get_OriginalData: Tl3Variant;
//#UC START# *5798D8C40263_530B3FE100E2get_var*
//#UC END# *5798D8C40263_530B3FE100E2get_var*
begin
//#UC START# *5798D8C40263_530B3FE100E2get_impl*
 Result := Self.MemoryPool As Tk2SizedMemoryPool;
//#UC END# *5798D8C40263_530B3FE100E2get_impl*
end;//Tk2MemoryStream.Get_OriginalData

function Tk2MemoryStream.Get_InternalID: Integer;
//#UC START# *5799B2C50033_530B3FE100E2get_var*
//#UC END# *5799B2C50033_530B3FE100E2get_var*
begin
//#UC START# *5799B2C50033_530B3FE100E2get_impl*
 Result := (Self.MemoryPool As Tk2SizedMemoryPool).InternalID;
//#UC END# *5799B2C50033_530B3FE100E2get_impl*
end;//Tk2MemoryStream.Get_InternalID

procedure Tk2MemoryStream.Set_InternalID(aValue: Integer);
//#UC START# *5799B2C50033_530B3FE100E2set_var*
//#UC END# *5799B2C50033_530B3FE100E2set_var*
begin
//#UC START# *5799B2C50033_530B3FE100E2set_impl*
 (Self.MemoryPool As Tk2SizedMemoryPool).InternalID := aValue;
//#UC END# *5799B2C50033_530B3FE100E2set_impl*
end;//Tk2MemoryStream.Set_InternalID

function Tk2MemoryStream.Get_ExternalID: Integer;
//#UC START# *5799B2D9013E_530B3FE100E2get_var*
//#UC END# *5799B2D9013E_530B3FE100E2get_var*
begin
//#UC START# *5799B2D9013E_530B3FE100E2get_impl*
 Result := (Self.MemoryPool As Tk2SizedMemoryPool).ExternalID;
//#UC END# *5799B2D9013E_530B3FE100E2get_impl*
end;//Tk2MemoryStream.Get_ExternalID

procedure Tk2MemoryStream.Set_ExternalID(aValue: Integer);
//#UC START# *5799B2D9013E_530B3FE100E2set_var*
//#UC END# *5799B2D9013E_530B3FE100E2set_var*
begin
//#UC START# *5799B2D9013E_530B3FE100E2set_impl*
 (Self.MemoryPool As Tk2SizedMemoryPool).ExternalID := aValue;
//#UC END# *5799B2D9013E_530B3FE100E2set_impl*
end;//Tk2MemoryStream.Set_ExternalID

end.
