unit PDOCConfig;

interface

uses
  PDElement;

type
  TgtPDOCConfig = class;

  (**
    * An Event used for enumerating optional-content configurations. Enumeration
    * stops when all configurations have been enumerated, or when the parameter
    * Cancel is set true by user.
    *
    * @param OCConfig The optional-content configuration object.
    * @param Cancel Determines when to stop the Enumeration, by default True
    *)
  TgtPDEnumOCConfigEvent = procedure(OCConfig: TgtPDOCConfig; var Cancel:
    Boolean) of object;

  TgtPDOCConfig = class(TgtPDElement)
  private
  public
  end;

implementation

end.
