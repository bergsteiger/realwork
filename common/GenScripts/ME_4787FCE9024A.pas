unit NOT_FINISHED_l3AsincMessageWindow;
 {* Вывод ассинхронного окна с сообщением в отдельной триаде }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3AsincMessageWindow.pas"
// Стереотип: "UtilityPack"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , Classes
;

type
 Tl3AsincMessageWindow = class(TThread)
  protected
   procedure Execute; override;
 end;//Tl3AsincMessageWindow

implementation

uses
 l3ImplUses
 , l3AsincMessageWindowRes
;

procedure Tl3AsincMessageWindow.Execute;
//#UC START# *499D3BE0004D_4787FD4002B4_var*
//#UC END# *499D3BE0004D_4787FD4002B4_var*
begin
//#UC START# *499D3BE0004D_4787FD4002B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *499D3BE0004D_4787FD4002B4_impl*
end;//Tl3AsincMessageWindow.Execute

end.
