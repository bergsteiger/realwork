{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{***************************************************************************}
{                                                                           }
{                             XML Data Binding                              }
{                                                                           }
{         Generated on: 6/11/2002 12:51:22 PM                               }
{       Generated from: http://schemas.xmlsoap.org/ws/2001/10/inspection/   }
{                                                                           }
{***************************************************************************}

unit Soap.WSILIntf;

interface

uses
  System.Types, Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward Decls }

  IXMLItemWithAbstracts = interface;
  IXMLServiceType = interface;
  IXMLServiceTypeList = interface;
  IXMLNameType = interface;
  IXMLNameTypeList = interface;
  IXMLReferenceType = interface;
  IXMLLinkType = interface;
  IXMLLinkTypeList = interface;
  IXMLTypeOfAbstract = interface;
  IXMLInspection = interface;
  IXMLDescriptionType = interface;
  IXMLDescriptionTypeList = interface;

{ IXMLItemWithAbstracts }

  IXMLItemWithAbstracts = interface(IXMLNodeCollection)
    ['{33E53FE0-14E5-4D18-A0AE-19FEE8CF6403}']
    { Property Accessors }
    function Get_Abstract(Index: Integer): IXMLTypeOfAbstract;
    { Methods & Properties }
    function Add: IXMLTypeOfAbstract;
    function Insert(const Index: Integer): IXMLTypeOfAbstract;
    property Abstract[Index: Integer]: IXMLTypeOfAbstract read Get_Abstract; default;
  end;

{ IXMLServiceType }

  IXMLServiceType = interface(IXMLItemWithAbstracts)
    ['{EC832C01-CF74-4207-9884-4027134D80F2}']
    { Property Accessors }
    function Get_Name: IXMLNameTypeList;
    function Get_Description: IXMLDescriptionTypeList;
    { Methods & Properties }
    property Name: IXMLNameTypeList read Get_Name;
    property Description: IXMLDescriptionTypeList read Get_Description;
  end;

{ IXMLServiceTypeList }

  IXMLServiceTypeList = interface(IXMLNodeCollection)
    ['{3E5EC7EF-3355-4D9A-8987-7067A9CAFBC7}']
    { Methods & Properties }
    function Add: IXMLServiceType;
    function Insert(const Index: Integer): IXMLServiceType;
    function Get_Item(Index: Integer): IXMLServiceType;
    property Items[Index: Integer]: IXMLServiceType read Get_Item; default;
  end;

{ IXMLNameType }

  IXMLNameType = interface(IXMLNode)
    ['{60F42F94-6754-40EB-8889-00D7BD607240}']
    { Property Accessors }
    function Get_Lang: OleStr;
    procedure Set_Lang(Value: OleStr);
    { Methods & Properties }
    property Lang: OleStr read Get_Lang write Set_Lang;
  end;

{ IXMLNameTypeList }

  IXMLNameTypeList = interface(IXMLNodeCollection)
    ['{5DAA8A82-A27D-49DF-A154-52351CBB8A7F}']
    { Methods & Properties }
    function Add: IXMLNameType;
    function Insert(const Index: Integer): IXMLNameType;
    function Get_Item(Index: Integer): IXMLNameType;
    property Items[Index: Integer]: IXMLNameType read Get_Item; default;
  end;

{ IXMLReferenceType }

  IXMLReferenceType = interface(IXMLItemWithAbstracts)
    ['{94130F0C-0F07-4FDE-9A59-C5079D7952A0}']
    { Property Accessors }
    function Get_ReferencedNamespace: OleStr;
    function Get_Location: OleStr;
    procedure Set_ReferencedNamespace(Value: OleStr);
    procedure Set_Location(Value: OleStr);
    { Methods & Properties }
    property ReferencedNamespace: OleStr read Get_ReferencedNamespace write Set_ReferencedNamespace;
    property Location: OleStr read Get_Location write Set_Location;
  end;

{ IXMLLinkType }

  IXMLLinkType = interface(IXMLReferenceType)
    ['{84A1F2BC-E4CA-4187-8B62-DEBB01F8BE8F}']
  end;

{ IXMLLinkTypeList }

  IXMLLinkTypeList = interface(IXMLNodeCollection)
    ['{64415871-3494-4B46-A34C-A47BF53AABEE}']
    { Methods & Properties }
    function Add: IXMLLinkType;
    function Insert(const Index: Integer): IXMLLinkType;
    function Get_Item(Index: Integer): IXMLLinkType;
    property Items[Index: Integer]: IXMLLinkType read Get_Item; default;
  end;

{ IXMLTypeOfAbstract }

  IXMLTypeOfAbstract = interface(IXMLNode)
    ['{49BD4FF9-04D5-41C4-B08C-66A17F7DCB18}']
    { Property Accessors }
    function Get_Lang: OleStr;
    procedure Set_Lang(Value: OleStr);
    { Methods & Properties }
    property Lang: OleStr read Get_Lang write Set_Lang;
  end;

{ IXMLInspection }

  IXMLInspection = interface(IXMLItemWithAbstracts)
    ['{9188C201-D00D-44B9-80A6-6C55D820879F}']
    { Property Accessors }
    function Get_Service: IXMLServiceTypeList;
    function Get_Link: IXMLLinkTypeList;
    { Methods & Properties }
    property Service: IXMLServiceTypeList read Get_Service;
    property Link: IXMLLinkTypeList read Get_Link;
  end;

{ IXMLDescriptionType }

  IXMLDescriptionType = interface(IXMLReferenceType)
    ['{620E7125-E033-4B8B-B5AE-A18F26864411}']
  end;

{ IXMLDescriptionTypeList }

  IXMLDescriptionTypeList = interface(IXMLNodeCollection)
    ['{9A62AF8B-F404-4655-8175-1E899C78F668}']
    { Methods & Properties }
    function Add: IXMLDescriptionType;
    function Insert(const Index: Integer): IXMLDescriptionType;
    function Get_Item(Index: Integer): IXMLDescriptionType;
    property Items[Index: Integer]: IXMLDescriptionType read Get_Item; default;
  end;

{ Forward Decls }

  TXMLItemWithAbstracts = class;
  TXMLServiceType = class;
  TXMLServiceTypeList = class;
  TXMLNameType = class;
  TXMLNameTypeList = class;
  TXMLReferenceType = class;
  TXMLLinkType = class;
  TXMLLinkTypeList = class;
  TXMLTypeOfAbstract = class;
  TXMLInspection = class;
  TXMLDescriptionType = class;
  TXMLDescriptionTypeList = class;

{ TXMLItemWithAbstracts }

  TXMLItemWithAbstracts = class(TXMLNodeCollection, IXMLItemWithAbstracts)
  protected
    { IXMLItemWithAbstracts }
    function Get_Abstract(Index: Integer): IXMLTypeOfAbstract;
    function Add: IXMLTypeOfAbstract;
    function Insert(const Index: Integer): IXMLTypeOfAbstract;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLServiceType }

  TXMLServiceType = class(TXMLItemWithAbstracts, IXMLServiceType)
  private
    FName: IXMLNameTypeList;
    FDescription: IXMLDescriptionTypeList;
  protected
    { IXMLServiceType }
    function Get_Name: IXMLNameTypeList;
    function Get_Description: IXMLDescriptionTypeList;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLServiceTypeList }

  TXMLServiceTypeList = class(TXMLNodeCollection, IXMLServiceTypeList)
  protected
    { IXMLServiceTypeList }
    function Add: IXMLServiceType;
    function Insert(const Index: Integer): IXMLServiceType;
    function Get_Item(Index: Integer): IXMLServiceType;
  end;

{ TXMLNameType }

  TXMLNameType = class(TXMLNode, IXMLNameType)
  protected
    { IXMLNameType }
    function Get_Lang: OleStr;
    procedure Set_Lang(Value: OleStr);
  end;

{ TXMLNameTypeList }

  TXMLNameTypeList = class(TXMLNodeCollection, IXMLNameTypeList)
  protected
    { IXMLNameTypeList }
    function Add: IXMLNameType;
    function Insert(const Index: Integer): IXMLNameType;
    function Get_Item(Index: Integer): IXMLNameType;
  end;

{ TXMLReferenceType }

  TXMLReferenceType = class(TXMLItemWithAbstracts, IXMLReferenceType)
  protected
    { IXMLReferenceType }
    function Get_ReferencedNamespace: OleStr;
    function Get_Location: OleStr;
    procedure Set_ReferencedNamespace(Value: OleStr);
    procedure Set_Location(Value: OleStr);
  end;

{ TXMLLinkType }

  TXMLLinkType = class(TXMLReferenceType, IXMLLinkType)
  protected
    { IXMLLinkType }
  end;

{ TXMLLinkTypeList }

  TXMLLinkTypeList = class(TXMLNodeCollection, IXMLLinkTypeList)
  protected
    { IXMLLinkTypeList }
    function Add: IXMLLinkType;
    function Insert(const Index: Integer): IXMLLinkType;
    function Get_Item(Index: Integer): IXMLLinkType;
  end;

{ TXMLTypeOfAbstract }

  TXMLTypeOfAbstract = class(TXMLNode, IXMLTypeOfAbstract)
  protected
    { IXMLTypeOfAbstract }
    function Get_Lang: OleStr;
    procedure Set_Lang(Value: OleStr);
  end;

{ TXMLInspection }

  TXMLInspection = class(TXMLItemWithAbstracts, IXMLInspection)
  private
    FService: IXMLServiceTypeList;
    FLink: IXMLLinkTypeList;
  protected
    { IXMLInspection }
    function Get_Service: IXMLServiceTypeList;
    function Get_Link: IXMLLinkTypeList;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDescriptionType }

  TXMLDescriptionType = class(TXMLReferenceType, IXMLDescriptionType)
  protected
    { IXMLDescriptionType }
  end;

{ TXMLDescriptionTypeList }

  TXMLDescriptionTypeList = class(TXMLReferenceType, IXMLDescriptionTypeList)
  protected
    { IXMLDescriptionTypeList }
    function Add: IXMLDescriptionType;
    function Insert(const Index: Integer): IXMLDescriptionType;
    function Get_Item(Index: Integer): IXMLDescriptionType;
  end;

{ Global Functions }

function Getinspection(Doc: IXMLDocument): IXMLInspection;
function Loadinspection(const FileName: OleStr): IXMLInspection;
function Newinspection: IXMLInspection;

const
  SInspectionNS = 'http://schemas.xmlsoap.org/ws/2001/10/inspection/';

implementation

{ Global Functions }

function Getinspection(Doc: IXMLDocument): IXMLInspection;
begin
  Result := Doc.GetDocBinding('inspection', TXMLInspection, SInspectionNS) as IXMLInspection;
end;

function Loadinspection(const FileName: OleStr): IXMLInspection;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('inspection', TXMLInspection, SInspectionNS) as IXMLInspection;
end;

function Newinspection: IXMLInspection;
begin
  Result := NewXMLDocument.GetDocBinding('inspection', TXMLInspection, SInspectionNS) as IXMLInspection;
end;

{ TXMLItemWithAbstracts }

procedure TXMLItemWithAbstracts.AfterConstruction;
begin
  RegisterChildNode('abstract', TXMLTypeOfAbstract);
  ItemTag := 'abstract';
  ItemNS := SInspectionNS;
  ItemInterface := IXMLTypeOfAbstract;
  inherited;
end;

function TXMLItemWithAbstracts.Get_Abstract(Index: Integer): IXMLTypeOfAbstract;
begin
  Result := List[Index] as IXMLTypeOfAbstract;
end;

function TXMLItemWithAbstracts.Add: IXMLTypeOfAbstract;
begin
  Result := AddItem(-1) as IXMLTypeOfAbstract;
end;

function TXMLItemWithAbstracts.Insert(const Index: Integer): IXMLTypeOfAbstract;
begin
  Result := AddItem(Index) as IXMLTypeOfAbstract;
end;


{ TXMLServiceType }

procedure TXMLServiceType.AfterConstruction;
begin
  RegisterChildNode('name', TXMLNameType);
  RegisterChildNode('description', TXMLDescriptionType);
  FName := CreateCollection(TXMLNameTypeList, IXMLNameType, 'name') as IXMLNameTypeList;
  FDescription := CreateCollection(TXMLDescriptionTypeList, IXMLDescriptionType, 'description') as IXMLDescriptionTypeList;
  inherited;
end;

function TXMLServiceType.Get_Name: IXMLNameTypeList;
begin
  Result := FName;
end;

function TXMLServiceType.Get_Description: IXMLDescriptionTypeList;
begin
  Result := FDescription;
end;

{ TXMLServiceTypeList }

function TXMLServiceTypeList.Add: IXMLServiceType;
begin
  Result := AddItem(-1) as IXMLServiceType;
end;

function TXMLServiceTypeList.Insert(const Index: Integer): IXMLServiceType;
begin
  Result := AddItem(Index) as IXMLServiceType;
end;

function TXMLServiceTypeList.Get_Item(Index: Integer): IXMLServiceType;
begin
  Result := List[Index] as IXMLServiceType;
end;

{ TXMLNameType }

function TXMLNameType.Get_Lang: OleStr;
begin
  Result := AttributeNodes['xml:lang'].Text;
end;

procedure TXMLNameType.Set_Lang(Value: OleStr);
begin
  SetAttribute('xml:lang', Value);
end;

{ TXMLNameTypeList }

function TXMLNameTypeList.Add: IXMLNameType;
begin
  Result := AddItem(-1) as IXMLNameType;
end;

function TXMLNameTypeList.Insert(const Index: Integer): IXMLNameType;
begin
  Result := AddItem(Index) as IXMLNameType;
end;

function TXMLNameTypeList.Get_Item(Index: Integer): IXMLNameType;
begin
  Result := List[Index] as IXMLNameType;
end;

{ TXMLReferenceType }

function TXMLReferenceType.Get_ReferencedNamespace: OleStr;
begin
  Result := AttributeNodes['referencedNamespace'].Text;
end;

procedure TXMLReferenceType.Set_ReferencedNamespace(Value: OleStr);
begin
  SetAttribute('referencedNamespace', Value);
end;

function TXMLReferenceType.Get_Location: OleStr;
begin
  Result := AttributeNodes['location'].Text;
end;

procedure TXMLReferenceType.Set_Location(Value: OleStr);
begin
  SetAttribute('location', Value);
end;

{ TXMLLinkType }

{ TXMLLinkTypeList }

function TXMLLinkTypeList.Add: IXMLLinkType;
begin
  Result := AddItem(-1) as IXMLLinkType;
end;

function TXMLLinkTypeList.Insert(const Index: Integer): IXMLLinkType;
begin
  Result := AddItem(Index) as IXMLLinkType;
end;

function TXMLLinkTypeList.Get_Item(Index: Integer): IXMLLinkType;
begin
  Result := List[Index] as IXMLLinkType;
end;

{ TXMLTypeOfAbstract }

function TXMLTypeOfAbstract.Get_Lang: OleStr;
begin
  Result := AttributeNodes['xml:lang'].Text;
end;

procedure TXMLTypeOfAbstract.Set_Lang(Value: OleStr);
begin
  SetAttribute('xml:lang', Value);
end;

{ TXMLInspection }

procedure TXMLInspection.AfterConstruction;
begin
  RegisterChildNode('service', TXMLServiceType);
  RegisterChildNode('link', TXMLLinkType);
  FService := CreateCollection(TXMLServiceTypeList, IXMLServiceType, 'service') as IXMLServiceTypeList;
  FLink := CreateCollection(TXMLLinkTypeList, IXMLLinkType, 'link') as IXMLLinkTypeList;
  inherited;
end;

function TXMLInspection.Get_Service: IXMLServiceTypeList;
begin
  Result := FService;
end;

function TXMLInspection.Get_Link: IXMLLinkTypeList;
begin
  Result := FLink;
end;

{ TXMLDescriptionType }

{ TXMLDescriptionTypeList }

function TXMLDescriptionTypeList.Add: IXMLDescriptionType;
begin
  Result := AddItem(-1) as IXMLDescriptionType;
end;

function TXMLDescriptionTypeList.Insert(const Index: Integer): IXMLDescriptionType;
begin
  Result := AddItem(Index) as IXMLDescriptionType;
end;

function TXMLDescriptionTypeList.Get_Item(Index: Integer): IXMLDescriptionType;
begin
  Result := List[Index] as IXMLDescriptionType;
end;

end.
