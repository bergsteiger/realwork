unit evCustomPrintDataSaver;

// Модуль: "w:\common\components\gui\Garant\Everest\evCustomPrintDataSaver.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(InsiderTest)}
uses
 l3IntfUses
 , l3ProtoObject
 , afwInterfaces
;

type
 TevCustomPrintDataSaver = class(Tl3ProtoObject)
  public
   function GetPanel: IafwPreviewPanel; virtual; abstract;
   procedure CheckResult; virtual; abstract;
   function IsWaitingPrint: Boolean; virtual; abstract;
   class procedure SetPrintDataSaver(const aSaver: TevCustomPrintDataSaver);
 end;//TevCustomPrintDataSaver

var g_PrintDataSaver: TevCustomPrintDataSaver;
{$IfEnd} // Defined(InsiderTest)

implementation

{$If Defined(InsiderTest)}
uses
 l3ImplUses
;

class procedure TevCustomPrintDataSaver.SetPrintDataSaver(const aSaver: TevCustomPrintDataSaver);
//#UC START# *4F7972A6004D_4F72F0A30036_var*
//#UC END# *4F7972A6004D_4F72F0A30036_var*
begin
//#UC START# *4F7972A6004D_4F72F0A30036_impl*
  g_PrintDataSaver := aSaver;
//#UC END# *4F7972A6004D_4F72F0A30036_impl*
end;//TevCustomPrintDataSaver.SetPrintDataSaver
{$IfEnd} // Defined(InsiderTest)

end.
