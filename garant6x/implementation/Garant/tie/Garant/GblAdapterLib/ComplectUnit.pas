unit ComplectUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ComplectUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "Complect" MUID: (45744F4302BF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , DynamicTreeUnit
 , SearchDefinesUnit
 , DynamicTreeDefinesUnit
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
  procedure GetInfo; stdcall;
  property Info: 
   read GetInfo;
 end;//IComplectInfoNode

 TVisualRepresentation = record
  name: ;
  percent: AnsiChar;
 end;//TVisualRepresentation

 IVisualRepresentationList = array of TVisualRepresentation;

 IComplectInfo = interface
  {* Интерфейс получение информации о текущем комплекте баз. }
  ['{0B0F9913-DE64-41E4-A884-68D60D6829AE}']
  function GetType: TComplectType; stdcall;
  procedure GetOwner ; stdcall;
  procedure GetDealerInfo; stdcall;
  procedure GetOldBaseWarning; stdcall;
  procedure GetInfo ; stdcall; { can raise CanNotFindData }
  procedure GetUnexistDocMessage; stdcall;
  procedure GetVisualRepresentationData(out aRet
   {* IVisualRepresentationList }); stdcall;
  property Type: TComplectType
   read GetType;
  property Owner : 
   read GetOwner ;
  property DealerInfo: 
   read GetDealerInfo;
  property OldBaseWarning: 
   read GetOldBaseWarning;
  property Info : 
   read GetInfo ;
  property UnexistDocMessage: 
   read GetUnexistDocMessage;
 end;//IComplectInfo

implementation

uses
 l3ImplUses
;

end.
