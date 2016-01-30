unit k2InterfaceList;

// Модуль: "w:\common\components\rtl\Garant\K2\k2InterfaceList.pas"
// Стереотип: "UtilityPack"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , l3Base
 , l3Types
 , l3SimpleObject
;

type
 Tk2InterfaceList = packed object
  private
   f_I: Tl3ObjectHash;
  public
   procedure Clear;
   function SetItem: PObject;
   function GetItemP: PObject;
   function GetItem: Tl3SimpleObject;
 end;//Tk2InterfaceList

implementation

uses
 l3ImplUses
;

procedure Tk2InterfaceList.Clear;
//#UC START# *531EF6EA02E5_531EF6900385_var*
//#UC END# *531EF6EA02E5_531EF6900385_var*
begin
//#UC START# *531EF6EA02E5_531EF6900385_impl*
 f_I.Clear;
//#UC END# *531EF6EA02E5_531EF6900385_impl*
end;//Tk2InterfaceList.Clear

function Tk2InterfaceList.SetItem: PObject;
//#UC START# *531EF6B6000A_531EF6900385_var*
//#UC END# *531EF6B6000A_531EF6900385_var*
begin
//#UC START# *531EF6B6000A_531EF6900385_impl*
 Result := f_I.SetItem(ID.IID, Item);
//#UC END# *531EF6B6000A_531EF6900385_impl*
end;//Tk2InterfaceList.SetItem

function Tk2InterfaceList.GetItemP: PObject;
//#UC START# *531EF6C7030B_531EF6900385_var*
//#UC END# *531EF6C7030B_531EF6900385_var*
begin
//#UC START# *531EF6C7030B_531EF6900385_impl*
 Result := f_I.GetItemP(ID.IID);
//#UC END# *531EF6C7030B_531EF6900385_impl*
end;//Tk2InterfaceList.GetItemP

function Tk2InterfaceList.GetItem: Tl3SimpleObject;
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
