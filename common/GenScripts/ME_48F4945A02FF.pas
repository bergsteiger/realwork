unit evStringStorable;
 {* Объекты реализующие возможность укладки в клипборд константной строки ([CQ 25894|$96482711]) }

// Модуль: "w:\common\components\gui\Garant\Everest\evStringStorable.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevStringStorable" MUID: (48F4945A02FF)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evStorable
 , l3Interfaces
 , afwNavigation
 , nevBase
 , evdInterfaces
;

type
 TevStringStorable = class(TevStorable)
  {* Объекты реализующие возможность укладки в клипборд константной строки ([CQ 25894|$96482711]) }
  protected
   procedure GetAddress(var Addr: TevAddress); virtual;
   function Text: Tl3WString; virtual; abstract;
   function Address: TevAddress;
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); override;
 end;//TevStringStorable

implementation

uses
 l3ImplUses
 , k2Tags
 , evdTypes
 , l3Base
 , Document_Const
 , TextPara_Const
 , HyperLink_Const
 , Address_Const
;

procedure TevStringStorable.GetAddress(var Addr: TevAddress);
//#UC START# *48F494F102DD_48F4945A02FF_var*
//#UC END# *48F494F102DD_48F4945A02FF_var*
begin
//#UC START# *48F494F102DD_48F4945A02FF_impl*
//#UC END# *48F494F102DD_48F4945A02FF_impl*
end;//TevStringStorable.GetAddress

function TevStringStorable.Address: TevAddress;
//#UC START# *48F495100156_48F4945A02FF_var*
//#UC END# *48F495100156_48F4945A02FF_var*
begin
//#UC START# *48F495100156_48F4945A02FF_impl*
 l3FillChar(Result, SizeOf(Result), 0);
 Result{$IfDef XE4}.rTafwAddress{$EndIf}.TypeID := ev_NullAddressType;
 GetAddress(Result);
//#UC END# *48F495100156_48F4945A02FF_impl*
end;//TevStringStorable.Address

procedure TevStringStorable.DoStore(const G: InevTagGenerator;
 aFlags: TevdStoreFlags);
//#UC START# *48F48C6E02F4_48F4945A02FF_var*
var
 l_Text : Tl3WString;
 l_Addr : TevAddress;
//#UC END# *48F48C6E02F4_48F4945A02FF_var*
begin
//#UC START# *48F48C6E02F4_48F4945A02FF_impl*
 G.Start;
 try
  G.StartChild(k2_typDocument);
  try
   G.StartChild(k2_typTextPara);
   try
    l_Text := Text;
    G.AddStringAtom(k2_tiText, l_Text);
    l_Addr := Address;
    if (l_Addr{$IfDef XE4}.rTafwAddress{$EndIf}.TypeID <> ev_NullAddressType) then
    begin
     G.StartChild(k2_typHyperlink);
     try
      G.AddIntegerAtom(k2_tiFinish, l_Text.SLen);
      G.StartChild(k2_typAddress);
      try
       G.AddIntegerAtom(k2_tiDocID, l_Addr{$IfDef XE4}.rTafwAddress{$EndIf}.DocID);
       G.AddIntegerAtom(k2_tiSubID, l_Addr{$IfDef XE4}.rTafwAddress{$EndIf}.SubID);
       G.AddIntegerAtom(k2_tiType, l_Addr{$IfDef XE4}.rTafwAddress{$EndIf}.TypeID);
      finally
       G.Finish;
      end;//try..finally
     finally
      G.Finish;
     end;//try..finally
    end;//l_Addr.TypeID <>  ev_NullAddressType
   finally
    G.Finish;
   end;//try..finally
  finally
   G.Finish;
  end;//try..finally
 finally
  G.Finish;
 end;//try..finally
//#UC END# *48F48C6E02F4_48F4945A02FF_impl*
end;//TevStringStorable.DoStore

end.
