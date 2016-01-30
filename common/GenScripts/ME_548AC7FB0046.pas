unit ncsProfile;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsProfile.pas"
// Стереотип: "UtilityPack"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3StopWatch
;

var g_SaveMessage: Tl3StopWatch;
var g_LoadMessage: Tl3StopWatch;
var g_SendMessage: Tl3StopWatch;
var g_ReveiveMessage: Tl3StopWatch;
var g_WaitFile: Tl3StopWatch;
var g_ReceivePartFile: Tl3StopWatch;
var g_SaveControl: Tl3StopWatch;
var g_WriteFile: Tl3StopWatch;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
