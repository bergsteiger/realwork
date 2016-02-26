unit NOT_FINISHED_VMailWin;
 {* Почтовое окно. }

// Модуль: "w:\archi\source\projects\Archi\Dlg\NOT_FINISHED_VMailWin.pas"
// Стереотип: "UtilityPack"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , vtForm
;

type
 TViewMailWin = class(TvtForm)
  {* Почтовое окно. }
  public
   procedure SetMessage(Value: LongInt;
    Mode: Byte = 0);
    {* 0 - This, 1 - Prev, 2 - Next }
 end;//TViewMailWin
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , evExtFormat
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TViewMailWin.SetMessage(Value: LongInt;
 Mode: Byte = 0);
 {* 0 - This, 1 - Prev, 2 - Next }
//#UC START# *4F0C225A02DD_4F0C222F0080_var*
//#UC END# *4F0C225A02DD_4F0C222F0080_var*
begin
//#UC START# *4F0C225A02DD_4F0C222F0080_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F0C225A02DD_4F0C222F0080_impl*
end;//TViewMailWin.SetMessage

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TViewMailWin);
 {* Регистрация TViewMailWin }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(AppClientSide)

end.
