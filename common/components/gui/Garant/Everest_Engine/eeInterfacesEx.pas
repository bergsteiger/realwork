unit eeInterfacesEx;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeInterfacesEx.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi For F1::Everest Engine::eeInterfacesEx
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  l3Interfaces,
  nevBase,
  nevTools,
  eeInterfaces,
  l3Variant
  ;

type
 IeeDocumentEx = interface(IeeDocument)
   ['{1AAE9C95-4200-43F5-A5A8-6028C2B8C93F}']
   function Get_DocumentPart(anID: Integer): IevDocumentPart;
   function Get_DocumentPartEx(anID: Integer; aLayerID: Integer): IevDocumentPart;
   function Get_Sub(anID: Integer): IevSub;
   function Get_SubEx(anID: Integer; aLayerID: Integer): IevSub;
   function Get_Selection: InevSelection;
   function Get_EntryPoint: Tl3Tag;
   function Get_Processor: InevProcessor;
   function Get_NewSub: IevSub;
   function Get_NewSubEx(aLayerID: Integer): IevSub;
   property DocumentPart[anID: Integer]: IevDocumentPart
     read Get_DocumentPart;
   property DocumentPartEx[anID: Integer; aLayerID: Integer]: IevDocumentPart
     read Get_DocumentPartEx;
   property Sub[anID: Integer]: IevSub
     read Get_Sub;
   property SubEx[anID: Integer; aLayerID: Integer]: IevSub
     read Get_SubEx;
   property Selection: InevSelection
     read Get_Selection;
   property EntryPoint: Tl3Tag
     read Get_EntryPoint;
   property Processor: InevProcessor
     read Get_Processor;
   property NewSub: IevSub
     read Get_NewSub;
   property NewSubEx[aLayerID: Integer]: IevSub
     read Get_NewSubEx;
 end;//IeeDocumentEx

 IeeTool = l3Interfaces.Il3Tool;

 IeeToolOwner = l3Interfaces.Il3ToolOwner;

implementation

end.