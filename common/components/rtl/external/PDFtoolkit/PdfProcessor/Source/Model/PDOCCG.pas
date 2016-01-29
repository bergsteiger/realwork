unit PDOCCG;

interface

uses
  PDElement;

type
  TgtPDOCG = class;

  (**
    * An event used for enumerating optional-content groups (OCGs). Enumeration
    * stops when all OCSs have been enumerated, or when the parameter Cancel is
    * set true by user.
    *
    * @param OCG The optional-content group object.
    * @param Cancel Determines when to stop the Enumeration, by default True
    *)
  TgtPDEnumOCGEvent = procedure (OCG: TgtPDOCG; var Cancel: Boolean) of object;

  TgtPDOCG = class(TgtPDElement)
  private
  public
  end;

implementation

end.
