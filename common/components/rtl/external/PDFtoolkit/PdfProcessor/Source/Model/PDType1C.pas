unit PDType1C;

interface

uses
  Classes, PDFontBase, PDEncoding;

type
  TPDType1C = class(TPDFontBase)
  private
    //function GetEncoding: TgtEncodingArray;
    function GetName: AnsiString;
  public
    constructor Create(Stream: TStream);
    destructor Destroy; override;

    property Name: AnsiString read GetName;
    //property Encoding: TgtEncodingArray read GetEncoding;
  end;

implementation

{ TPDType1C }

constructor TPDType1C.Create(Stream: TStream);
begin

end;

destructor TPDType1C.Destroy;
begin

  inherited;
end;

{function TPDType1C.GetEncoding: TgtEncodingArray;
begin

end;
}
function TPDType1C.GetName: AnsiString;
begin

end;

end.
