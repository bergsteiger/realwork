unit evdBadEVDToEmptyDocumentTranslator;

interface

uses
 l3IntfUses
 , k2TagTranslator
 , k2Base
 , l3Variant
 , k2TagGen
;

type
 TevdBadEVDToEmptyDocumentTranslator = class(Tk2TagTranslator)
  procedure Create(aDocType: Tk2Type;
   aDocLanguage: Integer);
  procedure SetTo(var theGenerator: Ik2TagGenerator;
   aDocType: Tk2Type;
   aDocLanguage: Integer); overload;
  procedure SetTo(var theGenerator: Tk2TagGenerator;
   aDocType: Tk2Type;
   aDocLanguage: Integer); overload;
 end;//TevdBadEVDToEmptyDocumentTranslator
 
implementation

uses
 l3ImplUses
 , Para_Const
 , Document_Const
 , k2Tags
 , SysUtils
;

end.
