unit arResultDeliveryInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Processing"
// Модуль: "w:/archi/source/projects/Archi/Processing/arResultDeliveryInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi::Processing::ExportDelivery::arResultDeliveryInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
type
 IarResultDelivererListner = interface(IUnknown)
   ['{E71B8A5D-E73D-4FA6-B569-41304F6F79EE}']
   procedure CheckTaskExistance(const aTaskID: AnsiString);
   procedure RequestSendMessage(const aMessage: AnsiString);
   function RequestNewFolder(var aFolder: AnsiString): Boolean;
   procedure ChangeResultFolder(const aTaskID: AnsiString;
    const aNewFolder: AnsiString);
 end;//IarResultDelivererListner
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
{$IfEnd} //AppClientSide
end.