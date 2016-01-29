unit CoPDAction;

interface

uses
  PDActionIntf, CoPDElement, PDAction;

type

  TgtCoPDAction = class(TgtPDCoPDElement, IgtPDAction)
  private
    FPDAction: TgtPDAction;
  public
    function Create(APDAction: TgtPDAction): TgtCoPDAction;override;
  protected
    property PDAction: TgtPDAction read FPDAction write FPDAction;
  end;

implementation

{ TgtCoPDAction }

constructor TgtCoPDAction.Create(APDAction: TgtPDAction);
begin
  FPDAction := APDAction;
end;

end.
