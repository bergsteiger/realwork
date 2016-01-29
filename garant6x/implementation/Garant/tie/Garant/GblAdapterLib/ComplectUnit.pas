unit ComplectUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/ComplectUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Complect
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit,
  DynamicTreeUnit,
  SearchDefinesUnit
  ;

type
 TComplectType = (
   CT_INTERNAL
 , CT_LOCAL
 , CT_NET_ONE_USER
 , CT_NET_MANY_USERS
 );//TComplectType

 IComplectInfoNode = interface(INodeBase)
  {* Нода информации о комплекте }
   ['{3D963480-C844-4A4A-AE68-6B68A125864D}']
   function GetInfo: IString; stdcall;
   property info: IString
     read GetInfo;
 end;//IComplectInfoNode

 TVisualRepresentation = record
   name : IString;
   percent : AnsiChar;
 end;//TVisualRepresentation

 IVisualRepresentationList = array of TVisualRepresentation;

 IComplectInfo = interface(IUnknown)
  {* Интерфейс получение информации о текущем комплекте баз. }
   ['{0B0F9913-DE64-41E4-A884-68D60D6829AE}']
   function GetType: TComplectType; stdcall;
   function GetOwner : IString; stdcall;
   function GetDealerInfo: IString; stdcall;
   function GetOldBaseWarning: IString; stdcall;
   function GetInfo : INodeBase; stdcall;
   function GetUnexistDocMessage: IString; stdcall;
   procedure GetVisualRepresentationData(out aRet {: IVisualRepresentationList}); stdcall;
   property type: TComplectType
     read GetType;
   property owner : IString
     read GetOwner ;
   property dealer_info: IString
     read GetDealerInfo;
   property old_base_warning: IString
     read GetOldBaseWarning;
   property info : INodeBase
     read GetInfo ;
   property unexist_doc_message: IString
     read GetUnexistDocMessage;
 end;//IComplectInfo

implementation

end.