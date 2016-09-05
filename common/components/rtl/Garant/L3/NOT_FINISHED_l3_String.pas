unit NOT_FINISHED_l3_String;
 {* Класс реализующий строки с собственным методом хранения данных. }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3_String.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3_String" MUID: (4773DED9004C)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3CustomString
 , l3Interfaces
;

type
 Tl3_String = class(Tl3CustomString)
  {* Класс реализующий строки с собственным методом хранения данных. }
  private
   f_String: Tl3WStrCast;
  public
   procedure NotifyDeletion(aPos: Integer;
    aLen: Integer); virtual;
 end;//Tl3_String

implementation

uses
 l3ImplUses
 //#UC START# *4773DED9004Cimpl_uses*
 //#UC END# *4773DED9004Cimpl_uses*
;

procedure Tl3_String.NotifyDeletion(aPos: Integer;
 aLen: Integer);
//#UC START# *4FB10B1D016B_4773DED9004C_var*
//#UC END# *4FB10B1D016B_4773DED9004C_var*
begin
//#UC START# *4FB10B1D016B_4773DED9004C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FB10B1D016B_4773DED9004C_impl*
end;//Tl3_String.NotifyDeletion

end.
