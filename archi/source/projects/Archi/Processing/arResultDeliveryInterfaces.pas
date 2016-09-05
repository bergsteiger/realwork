unit arResultDeliveryInterfaces;

// Модуль: "w:\archi\source\projects\Archi\Processing\arResultDeliveryInterfaces.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "arResultDeliveryInterfaces" MUID: (549A9AB80233)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
;

type
 IarResultDelivererListner = interface
  ['{E71B8A5D-E73D-4FA6-B569-41304F6F79EE}']
  procedure CheckTaskExistance(const aTaskID: AnsiString);
  procedure RequestSendMessage(const aMessage: AnsiString);
  function RequestNewFolder(var aFolder: AnsiString): Boolean;
  procedure ChangeResultFolder(const aTaskID: AnsiString;
   const aNewFolder: AnsiString);
 end;//IarResultDelivererListner
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 //#UC START# *549A9AB80233impl_uses*
 //#UC END# *549A9AB80233impl_uses*
;
{$IfEnd} // Defined(AppClientSide)

end.
