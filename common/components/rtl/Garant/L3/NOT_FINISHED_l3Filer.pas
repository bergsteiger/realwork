unit NOT_FINISHED_l3Filer;
 {* Реализация компонента-обертки вокруг потока. }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Filer.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "l3Filer" MUID: (47A0686803A5)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProgressComponent
;

type
 Tl3CustomFiler = class(Tl3ProgressComponent)
  {* Реализация компонента-обертки вокруг потока. }
  protected
   function DoOpen: Boolean; virtual;
   procedure DoClose; virtual;
 end;//Tl3CustomFiler

 Tl3CustomDosFiler = class(Tl3CustomFiler)
 end;//Tl3CustomDosFiler

 Tl3NextTokenFlag = (
 );//Tl3NextTokenFlag

 Tl3DOSFiler = class(Tl3CustomDosFiler)
 end;//Tl3DOSFiler

 Il3FilerSource = interface
  ['{B20273DF-48CC-4A83-ADA7-E2CC912A6F62}']
 end;//Il3FilerSource

implementation

uses
 l3ImplUses
 , l3FilerRes
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *47A0686803A5impl_uses*
 //#UC END# *47A0686803A5impl_uses*
;

function Tl3CustomFiler.DoOpen: Boolean;
//#UC START# *555C888301B0_47A0679D00E4_var*
//#UC END# *555C888301B0_47A0679D00E4_var*
begin
//#UC START# *555C888301B0_47A0679D00E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *555C888301B0_47A0679D00E4_impl*
end;//Tl3CustomFiler.DoOpen

procedure Tl3CustomFiler.DoClose;
//#UC START# *555C88B703E7_47A0679D00E4_var*
//#UC END# *555C88B703E7_47A0679D00E4_var*
begin
//#UC START# *555C88B703E7_47A0679D00E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *555C88B703E7_47A0679D00E4_impl*
end;//Tl3CustomFiler.DoClose

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Tl3CustomFiler);
 {* Регистрация Tl3CustomFiler }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Tl3CustomDosFiler);
 {* Регистрация Tl3CustomDosFiler }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Tl3DOSFiler);
 {* Регистрация Tl3DOSFiler }
{$IfEnd} // NOT Defined(NoScripts)

end.
