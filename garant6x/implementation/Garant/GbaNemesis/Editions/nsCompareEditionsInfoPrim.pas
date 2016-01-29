unit nsCompareEditionsInfoPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editions"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Editions/nsCompareEditionsInfoPrim.pas"
// Начат: 10.08.2009 19:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Пользовательские сервисы::CompareEditions::Editions::CommonObjects::TnsCompareEditionsInfoPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  eeInterfaces,
  EditionsInterfaces,
  nsRedactionCurrentPara
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _MnsDocument_Parent_ = TnsRedactionCurrentPara;
 {$Include ..\Editions\MnsDocument.imp.pas}
 TnsCompareEditionsInfoPrim = class(_MnsDocument_)
 public
 // public methods
   constructor Create(const aDoc: IDocument;
     const aPara: IeeLeafPara;
     const aDocumentForReturn: TnsDocumentForReturnInfo); reintroduce;
 end;//TnsCompareEditionsInfoPrim
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include ..\Editions\MnsDocument.imp.pas}

// start class TnsCompareEditionsInfoPrim

constructor TnsCompareEditionsInfoPrim.Create(const aDoc: IDocument;
  const aPara: IeeLeafPara;
  const aDocumentForReturn: TnsDocumentForReturnInfo);
//#UC START# *4B585365015A_4A8039EF0325_var*
//#UC END# *4B585365015A_4A8039EF0325_var*
begin
//#UC START# *4B585365015A_4A8039EF0325_impl*
 Assert(aDoc <> nil);
 Assert(aDocumentForReturn.rDoc <> nil);
 inherited Create(aPara);
 Init(aDoc, aDocumentForReturn);
//#UC END# *4B585365015A_4A8039EF0325_impl*
end;//TnsCompareEditionsInfoPrim.Create

{$IfEnd} //not Admin AND not Monitorings

end.