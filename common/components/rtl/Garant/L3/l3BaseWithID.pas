unit l3BaseWithID;

// ������: "w:\common\components\rtl\Garant\L3\l3BaseWithID.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 Tl3BaseWithID = class(Tl3ProtoObject)
  private
   f_ID: Integer;
    {* ���� ��� �������� ID }
  public
   constructor Create(aHandle: Integer); reintroduce; virtual;
  public
   property ID: Integer
    read f_ID;
 end;//Tl3BaseWithID

implementation

uses
 l3ImplUses
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
