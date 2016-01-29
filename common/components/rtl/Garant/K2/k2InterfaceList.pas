unit k2InterfaceList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2InterfaceList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::K2::k2PrimObjects::k2InterfaceList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3Types,
  l3Base,
  l3IID,
  l3SimpleObject,
  l3ProtoObject
  ;

type
 Tk2InterfaceList = packed object
 private
   f_I : Tl3ObjectHash;
 public
    procedure Clear;
    function SetItem(const ID: Tl3IID;
    Item: Tl3ProtoObject): PObject;
    function GetItemP(const ID: Tl3IID): PObject;
    function GetItem(const ID: Tl3IID): Tl3SimpleObject;
 end;//Tk2InterfaceList

implementation

// start class Tk2InterfaceList

procedure Tk2InterfaceList.Clear;
//#UC START# *531EF6EA02E5_531EF6900385_var*
//#UC END# *531EF6EA02E5_531EF6900385_var*
begin
//#UC START# *531EF6EA02E5_531EF6900385_impl*
 f_I.Clear;
//#UC END# *531EF6EA02E5_531EF6900385_impl*
end;//Tk2InterfaceList.Clear

function Tk2InterfaceList.SetItem(const ID: Tl3IID;
  Item: Tl3ProtoObject): PObject;
//#UC START# *531EF6B6000A_531EF6900385_var*
//#UC END# *531EF6B6000A_531EF6900385_var*
begin
//#UC START# *531EF6B6000A_531EF6900385_impl*
 Result := f_I.SetItem(ID.IID, Item);
//#UC END# *531EF6B6000A_531EF6900385_impl*
end;//Tk2InterfaceList.SetItem

function Tk2InterfaceList.GetItemP(const ID: Tl3IID): PObject;
//#UC START# *531EF6C7030B_531EF6900385_var*
//#UC END# *531EF6C7030B_531EF6900385_var*
begin
//#UC START# *531EF6C7030B_531EF6900385_impl*
 Result := f_I.GetItemP(ID.IID);
//#UC END# *531EF6C7030B_531EF6900385_impl*
end;//Tk2InterfaceList.GetItemP

function Tk2InterfaceList.GetItem(const ID: Tl3IID): Tl3SimpleObject;
//#UC START# *531EF6D10264_531EF6900385_var*
//#UC END# *531EF6D10264_531EF6900385_var*
begin
//#UC START# *531EF6D10264_531EF6900385_impl*
 PObject(Result) := GetItemP(ID);
 if (Result <> nil) then
  Result := Tl3SimpleObject(PObject(Result)^);
//#UC END# *531EF6D10264_531EF6900385_impl*
end;//Tk2InterfaceList.GetItem

end.