unit Masks;

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Rtl\Common\Masks.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "Masks" MUID: (502549AF030B)

interface

uses
 l3IntfUses
 , SysUtils
;

type
 EMaskException = class(Exception)
 end;//EMaskException

 TMask = class
  {* TMask allows the comparison of strings containing wildcards to a file mask. }
 end;//TMask

function MatchesMask(const Filename: AnsiString;
 const Mask: AnsiString): Boolean;
 {* Indicates whether a file name conforms to the format specified by a filter string. }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *502549AF030Bimpl_uses*
 //#UC END# *502549AF030Bimpl_uses*
;

function MatchesMask(const Filename: AnsiString;
 const Mask: AnsiString): Boolean;
 {* Indicates whether a file name conforms to the format specified by a filter string. }
//#UC START# *50254A2603D3_502549AF030B_var*
//#UC END# *50254A2603D3_502549AF030B_var*
begin
//#UC START# *50254A2603D3_502549AF030B_impl*
 !!! Needs to be implemented !!!
//#UC END# *50254A2603D3_502549AF030B_impl*
end;//MatchesMask

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EMaskException));
 {* Регистрация типа EMaskException }
{$IfEnd} // NOT Defined(NoScripts)

end.
