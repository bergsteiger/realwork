unit PDAnnotIntf;

interface
{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }


uses
  PDElementIntf, gtObjectIntf, PDBaseObjectIntf;

type

  IgtPDAnnot = Class(IgtPDElement)
//    function MakeAnnot(AParentDoc: IgtObject; AParentElement: IgtPDElement;
//      ABaseObject: IgtPDBaseObject): IgtPDAnnot;     class functiom
    procedure Update;virtual;abstract;
    procedure RemoveOCMD;virtual;abstract;

//    function IsCurrentlyVisible(OCContext: TgtPDOCContext): Boolean;
    function IsValid: WordBool;virtual;abstract;
  end;

implementation

end.
