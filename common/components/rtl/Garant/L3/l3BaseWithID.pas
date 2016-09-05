unit l3BaseWithID;

// ������: "w:\common\components\rtl\Garant\L3\l3BaseWithID.pas"
// ���������: "SimpleClass"
// ������� ������: "Tl3BaseWithID" MUID: (47BD85FA015F)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 Tl3BaseWithID = class(Tl3ProtoObject)
  private
   f_ID: Integer;
  public
   constructor Create(aHandle: Integer); reintroduce; virtual;
  public
   property ID: Integer
    read f_ID;
 end;//Tl3BaseWithID

implementation

uses
 l3ImplUses
 //#UC START# *47BD85FA015Fimpl_uses*
 //#UC END# *47BD85FA015Fimpl_uses*
;

constructor Tl3BaseWithID.Create(aHandle: Integer);
//#UC START# *47BD8AF20271_47BD85FA015F_var*
//#UC END# *47BD8AF20271_47BD85FA015F_var*
begin
//#UC START# *47BD8AF20271_47BD85FA015F_impl*
 inherited Create;
 f_ID := aHandle;
//#UC END# *47BD8AF20271_47BD85FA015F_impl*
end;//Tl3BaseWithID.Create

end.
