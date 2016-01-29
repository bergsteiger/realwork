unit CogtObject;

interface

uses

  gtObjectIntf, gtObject;

type

  TgtCoObject = class(IgtObject)
  private
    FgtObject: TgtObject;
  protected
    property gtObject: TgtObject read FgtObject write FgtObject;
  end;

implementation

end.
