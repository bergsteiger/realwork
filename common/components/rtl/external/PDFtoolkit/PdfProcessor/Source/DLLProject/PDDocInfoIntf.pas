unit PDDocInfoIntf;

interface

uses
  gtObjectIntf;
type
  IgtPDDocInfo = class(IgtObject)

    procedure GetInfo(const InfoKey: WideString; var Value: WideString);virtual;abstract;
    procedure SetDocInfo(const InfoKey: WideString; const Value: WideString);virtual;abstract;
    function CountXMPMetadataArrayItems(const Namespace: WideString;
      const Path: WideString): Integer;virtual;abstract;
    function GetXMPMetadataArrayItem(const NameSpaceName: WideString;
      const Path: WideString; Index: Integer): WideString;virtual;abstract;
    procedure SetXMPMetadataArrayItem(const NameSpace: WideString;
      const NamespacePrefix: WideString; const Path: WideString; Index: Integer;
        const NewValue: WideString);virtual;abstract;

    function GetAuthor: WideString;virtual;abstract;
    function GetCreateDate: WideString;virtual;abstract;
    function GetCreator: WideString;virtual;abstract;
    function GetModDate: WideString;virtual;abstract;
    function GetProducer: WideString;virtual;abstract;
    function GetSubject: WideString;virtual;abstract;
    function GetTitle: WideString;virtual;abstract;
    function GetKeyword: WideString;virtual;abstract;

    procedure SetAuthor(Value: WideString);virtual;abstract;
    procedure SetCreateDate(Value: WideString);virtual;abstract;
    procedure SetCreator(Value: WideString);virtual;abstract;
    procedure SetModDate(Value: WideString);virtual;abstract;
    procedure SetProducer(Value: WideString);virtual;abstract;
    procedure SetSubject(Value: WideString);virtual;abstract;
    procedure SetTitle(Value: WideString);virtual;abstract;
    procedure SetKeyword(Value: WideString);virtual;abstract;

  end;

implementation

end.
