unit CoPDDocInfo;

interface
  uses
    PDDocInfoIntf, PDDocInfo, PDDocumentIntf;

type
  TgtCoPDDocInfo = class(IgtPDDocInfo)
  private
    FPDDocInfo: TgtPDDocInfo;
  public
    //constructor Create(AParentDoc: IgtPDDocument; ACatalog: IgtPDCatalog);
    //destructor Destroy;
    constructor Create(APDDocInfo: TgtPDDocInfo);override;
    procedure GetInfo(const InfoKey: WideString; var Value: WideString);override;
    procedure SetDocInfo(const InfoKey: WideString; const Value: WideString);override;
    function CountXMPMetadataArrayItems(const Namespace: WideString;
      const Path: WideString): Integer;override;
    function GetXMPMetadataArrayItem(const NameSpaceName: WideString;
      const Path: WideString; Index: Integer): WideString;override;
    procedure SetXMPMetadataArrayItem(const NameSpace: WideString;
      const NamespacePrefix: WideString; const Path: WideString; Index: Integer;
        const NewValue: WideString);override;

    function GetAuthor: WideString;override;
    function GetCreateDate: WideString;override;
    function GetCreator: WideString;override;
    function GetModDate: WideString;override;
    function GetProducer: WideString;override;
    function GetSubject: WideString;override;
    function GetTitle: WideString;override;
    function GetKeyword: WideString;override;

    procedure SetAuthor(Value: WideString);override;
    procedure SetCreateDate(Value: WideString);override;
    procedure SetCreator(Value: WideString);override;
    procedure SetModDate(Value: WideString);override;
    procedure SetProducer(Value: WideString);override;
    procedure SetSubject(Value: WideString);override;
    procedure SetTitle(Value: WideString);override;
    procedure SetKeyword(Value: WideString);override;
  end;

implementation

{ TgtCoPDDocInfo }

function TgtCoPDDocInfo.CountXMPMetadataArrayItems(const Namespace,
  Path: WideString): Integer;
begin
  FPDDocInfo.CountXMPMetadataArrayItems(Namespace, Path);
end;
{*
constructor TgtCoPDDocInfo.Create(AParentDoc: IgtPDDocument;
  ACatalog: IgtPDCatalog);
begin

end;

destructor TgtCoPDDocInfo.Destroy;
begin
  if Assigned(FPDDocInfo) then
    FPDDocInfo.Free;
end;
*}

constructor TgtCoPDDocInfo.Create(APDDocInfo: TgtPDDocInfo);
begin
  FPDDocInfo := APDDocInfo;
end;

function TgtCoPDDocInfo.GetAuthor: WideString;
begin
  Result := FPDDocInfo.Author;
end;

function TgtCoPDDocInfo.GetCreateDate: WideString;
begin
  Result := FPDDocInfo.CreateDate;
end;

function TgtCoPDDocInfo.GetCreator: WideString;
begin
  Result := FPDDocInfo.Creator;
end;

procedure TgtCoPDDocInfo.GetInfo(const InfoKey: WideString;
  var Value: WideString);
var
  LValue: String;
begin
  LValue := Value;
  FPDDocInfo.GetInfo(InfoKey, LValue);
  Value := LValue;
end;

function TgtCoPDDocInfo.GetKeyword: WideString;
begin
  Result := FPDDocInfo.Keyword;
end;

function TgtCoPDDocInfo.GetModDate: WideString;
begin
  Result := FPDDocInfo.ModeDate;
end;

function TgtCoPDDocInfo.GetProducer: WideString;
begin
  Result := FPDDocInfo.Producer;
end;

function TgtCoPDDocInfo.GetSubject: WideString;
begin
  Result := FPDDocInfo.Subject;
end;

function TgtCoPDDocInfo.GetTitle: WideString;
begin
  Result := FPDDocInfo.Title;
end;

function TgtCoPDDocInfo.GetXMPMetadataArrayItem(const NameSpaceName,
  Path: WideString; Index: Integer): WideString;
begin
  FPDDocInfo.GetXMPMetadataArrayItem(NameSpaceName, Path, Index);
end;

procedure TgtCoPDDocInfo.SetAuthor(Value: WideString);
begin
  FPDDocInfo.Author := Value;
end;

procedure TgtCoPDDocInfo.SetCreateDate(Value: WideString);
begin
  FPDDocInfo.CreateDate := Value;
end;

procedure TgtCoPDDocInfo.SetCreator(Value: WideString);
begin
  FPDDocInfo.Creator := Value;
end;

procedure TgtCoPDDocInfo.SetDocInfo(const InfoKey, Value: WideString);
begin
  FPDDocInfo.SetDocInfo(InfoKey, Value);
end;

procedure TgtCoPDDocInfo.SetKeyword(Value: WideString);
begin
  FPDDocInfo.Keyword := Value;
end;

procedure TgtCoPDDocInfo.SetModDate(Value: WideString);
begin
  FPDDocInfo.ModeDate := Value;
end;

procedure TgtCoPDDocInfo.SetProducer(Value: WideString);
begin
  FPDDocInfo.Producer := Value;
end;

procedure TgtCoPDDocInfo.SetSubject(Value: WideString);
begin
  FPDDocInfo.Subject := Value;
end;

procedure TgtCoPDDocInfo.SetTitle(Value: WideString);
begin
  FPDDocInfo.Title := Value;
end;

procedure TgtCoPDDocInfo.SetXMPMetadataArrayItem(const NameSpace,
  NamespacePrefix, Path: WideString; Index: Integer;
  const NewValue: WideString);
begin
  FPDDocInfo.SetXMPMetadataArrayItem(NameSpace, NamespacePrefix, Path,
    Index, NewValue);
end;

end.
