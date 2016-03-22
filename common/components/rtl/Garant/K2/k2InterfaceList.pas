unit k2InterfaceList;

// ������: "w:\common\components\rtl\Garant\K2\k2InterfaceList.pas"
// ���������: "UtilityPack"
// ������� ������: "k2InterfaceList" MUID: (531EF67F0065)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3Base
 , l3Types
 , l3SimpleObject
 , l3IID
 , l3ProtoObject
;

type
 Tk2InterfaceList = packed object
  private
   f_I: Tl3ObjectHash;
  public
   procedure Clear;
   function SetItem(const ID: Tl3IID;
    Item: Tl3ProtoObject): PObject;
   function GetItemP(const ID: Tl3IID): PObject;
   function GetItem(const ID: Tl3IID): Tl3SimpleObject;
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
