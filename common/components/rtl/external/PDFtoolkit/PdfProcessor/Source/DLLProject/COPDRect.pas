unit CoPDRect;

interface

uses
  PDRectIntf, PDRect, gtObjectIntf, CogtObject;

type

  TgtCoPDRect = class(TInterfacedObject, IgtPDRect)
  private
    FPDRect: TgtPDRect;
  public
    constructor Create; overload;
//    constructor Create(ArrayObject: TgtPDArray); overload;
    constructor Create(ALeft, ATop, ARight, ABottom: Double); overload;
//    function GetArray: TgtPDArray;
    procedure Assign(Source: IgtObject); override;
    procedure SetValues(ALeft, ATop, ARight, ABottom: Double); override;
    function GetLeft: Double; override;
    procedure SetLeft(ALeft: Double); override;
    function GetTop: Double; override;
    procedure SetTop(ATop: Double); override;
    function GetRight: Double; override;
    procedure SetRight(ARight: Double); override;
    function GetBottom: Double; override;
    procedure SetBottom(ABottom: Double); override;
    Destructor Destroy; override;
  end;

  TgtHackCoObject = class(TgtCoObject)

  end;

  function NewPDRect: IgtPDRect; overload; export; stdcall;
  function NewPDRect(ALeft, ATop, ARight, ABottom: Double): IgtPDRect; overload;
    export; stdcall;

implementation

{ TgtCoPDRect }

procedure TgtCoPDRect.Assign(Source: IgtObject);
begin
  FPDRect.Assign(TgtHackCoObject(Source).gtObject);
end;

constructor TgtCoPDRect.Create;
begin
  FPDRect := TgtPDRect.Create;
end;

constructor TgtCoPDRect.Create(ALeft, ATop, ARight, ABottom: Double);
begin
  FPDRect := TgtPDRect.Create(ALeft, ATop, ARight, ABottom);
end;

destructor TgtCoPDRect.Destroy;
begin
  if Assigned(FPDRect) then  FPDRect.Free;

end;

function TgtCoPDRect.GetBottom: Double;
begin
  Result := FPDRect.Bottom;
end;

function TgtCoPDRect.GetLeft: Double;
begin
  Result := FPDRect.Left;
end;

function TgtCoPDRect.GetRight: Double;
begin
  Result := FPDRect.Right;
end;

function TgtCoPDRect.GetTop: Double;
begin
  Result := FPDRect.Top;
end;

procedure TgtCoPDRect.SetBottom(ABottom: Double);
begin
  FPDRect.Bottom := ABottom;
end;

procedure TgtCoPDRect.SetLeft(ALeft: Double);
begin
  FPDRect.Left := ALeft;
end;

procedure TgtCoPDRect.SetRight(ARight: Double);
begin
  FPDRect.Right := ARight;
end;

procedure TgtCoPDRect.SetTop(ATop: Double);
begin
  FPDRect.Top := ATop;
end;

procedure TgtCoPDRect.SetValues(ALeft, ATop, ARight, ABottom: Double);
begin
  FPDRect.SetValues(ALeft, ATop, ARight, ABottom);
end;

function NewPDRect: IgtPDRect; export; stdcall;
begin
  Result := TgtCoPDRect.Create;
end;

function NewPDRect(ALeft, ATop, ARight, ABottom: Double): IgtPDRect; export; stdcall;
begin
  Result := TgtCoPDRect.Create(ALeft, ATop, ARight, ABottom);
end;

end.
