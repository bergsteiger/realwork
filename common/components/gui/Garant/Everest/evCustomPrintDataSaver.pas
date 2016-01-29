unit evCustomPrintDataSaver;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evCustomPrintDataSaver.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Printing::evCustomPrintDataSaver
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(InsiderTest)}
uses
  afwInterfaces,
  l3ProtoObject
  ;

type
 TevCustomPrintDataSaver = class(Tl3ProtoObject)
 public
 // public methods
   function GetPanel: IafwPreviewPanel; virtual; abstract;
   procedure CheckResult; virtual; abstract;
   function IsWaitingPrint: Boolean; virtual; abstract;
   class procedure SetPrintDataSaver(const aSaver: TevCustomPrintDataSaver);
 end;//TevCustomPrintDataSaver

var g_PrintDataSaver : TevCustomPrintDataSaver;
{$IfEnd} //InsiderTest

implementation

{$If defined(InsiderTest)}
// start class TevCustomPrintDataSaver

class procedure TevCustomPrintDataSaver.SetPrintDataSaver(const aSaver: TevCustomPrintDataSaver);
//#UC START# *4F7972A6004D_4F72F0A30036_var*
//#UC END# *4F7972A6004D_4F72F0A30036_var*
begin
//#UC START# *4F7972A6004D_4F72F0A30036_impl*
  g_PrintDataSaver := aSaver;
//#UC END# *4F7972A6004D_4F72F0A30036_impl*
end;//TevCustomPrintDataSaver.SetPrintDataSaver
{$IfEnd} //InsiderTest

end.