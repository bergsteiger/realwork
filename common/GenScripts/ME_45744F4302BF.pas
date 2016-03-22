unit ComplectUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ComplectUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "Complect" MUID: (45744F4302BF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , DynamicTreeUnit
 , IOUnit
 , BaseTypesUnit
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
  function Get_info: IString;
  property info: IString
   read Get_info;
 end;//IComplectInfoNode

 TVisualRepresentation = record
  name: IString;
  percent: AnsiChar;
 end;//TVisualRepresentation

 IVisualRepresentationList = array of TVisualRepresentation;

 IComplectInfo = interface
  {* Интерфейс получение информации о текущем комплекте баз. }
  ['{0B0F9913-DE64-41E4-A884-68D60D6829AE}']
  function Get_type: TComplectType;
  function Get_owner : IString;
  function Get_dealer_info: IString;
  function Get_old_base_warning: IString;
  function Get_info : INodeBase; { can raise CanNotFindData }
  function Get_unexist_doc_message: IString;
  function get_visual_representation_data: IVisualRepresentationList;
  property type: TComplectType
   read Get_type;
  property owner : IString
   read Get_owner ;
  property dealer_info: IString
   read Get_dealer_info;
  property old_base_warning: IString
   read Get_old_base_warning;
  property info : INodeBase
   read Get_info ;
  property unexist_doc_message: IString
   read Get_unexist_doc_message;
 end;//IComplectInfo

class function make(var owner_tree: IFakeFacetForFactory;
 const snode): BadFactoryType;
class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make(var owner_tree: IFakeFacetForFactory;
 const snode): BadFactoryType;
var
 l_Inst : IComplectInfoNode;
begin
 l_Inst := Create(owner_tree, snode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IComplectInfo;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
