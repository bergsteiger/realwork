unit evSCSubAttr;

// Модуль: "w:\common\components\gui\Garant\Everest\evSCSubAttr.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , evSubCompareInterfaces
;

type
 TevSCSubAttr = class(Tl3ProtoObject, IevSCAttrElement)
  private
   f_AttrType: TevSCAttrType;
   f_ID: Integer;
   f_SubID: Integer;
  protected
   function Get_AttrType: TevSCAttrType;
   function Get_ID: Integer;
   function Get_SubID: Integer;
  public
   constructor Create(aType: TevSCAttrType;
    aID: Integer;
    aSubID: Integer = 0); reintroduce;
   class function Make(aType: TevSCAttrType;
    aID: Integer;
    aSubID: Integer = 0): IevSCAttrElement; reintroduce;
 end;//TevSCSubAttr

implementation

uses
 l3ImplUses
;

constructor TevSCSubAttr.Create(aType: TevSCAttrType;
 aID: Integer;
 aSubID: Integer = 0);
//#UC START# *56559CFC005F_56559282021D_var*
//#UC END# *56559CFC005F_56559282021D_var*
begin
//#UC START# *56559CFC005F_56559282021D_impl*
 inherited Create;
 f_AttrType := aType;
 f_ID := aID;
 f_SubID := aSubID;
//#UC END# *56559CFC005F_56559282021D_impl*
end;//TevSCSubAttr.Create

class function TevSCSubAttr.Make(aType: TevSCAttrType;
 aID: Integer;
 aSubID: Integer = 0): IevSCAttrElement;
var
 l_Inst : TevSCSubAttr;
begin
 l_Inst := Create(aType, aID, aSubID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevSCSubAttr.Make

function TevSCSubAttr.Get_AttrType: TevSCAttrType;
//#UC START# *5655780E0080_56559282021Dget_var*
//#UC END# *5655780E0080_56559282021Dget_var*
begin
//#UC START# *5655780E0080_56559282021Dget_impl*
 Result := f_AttrType;
//#UC END# *5655780E0080_56559282021Dget_impl*
end;//TevSCSubAttr.Get_AttrType

function TevSCSubAttr.Get_ID: Integer;
//#UC START# *5655789501D8_56559282021Dget_var*
//#UC END# *5655789501D8_56559282021Dget_var*
begin
//#UC START# *5655789501D8_56559282021Dget_impl*
 Result := f_ID;
//#UC END# *5655789501D8_56559282021Dget_impl*
end;//TevSCSubAttr.Get_ID

function TevSCSubAttr.Get_SubID: Integer;
//#UC START# *565578A702AE_56559282021Dget_var*
//#UC END# *565578A702AE_56559282021Dget_var*
begin
//#UC START# *565578A702AE_56559282021Dget_impl*
 Result := f_SubID;
//#UC END# *565578A702AE_56559282021Dget_impl*
end;//TevSCSubAttr.Get_SubID

end.
