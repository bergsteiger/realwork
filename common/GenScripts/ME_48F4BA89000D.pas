unit ddRTFWriter;

interface

uses
 l3IntfUses
 , ddRTFExpandedTextWriter
 , ddRTFProperties
 , ddCharacterProperty
 , ddParagraphProperty
;

type
 TCustomRTFObjectGenerator = class(TddRTFExpandedTextWriter)
  function Style2RTF(aStyle: TddStyleEntry;
   aBlockIndent: Integer;
   anIgnoreLeftIndent: Boolean): AnsiString;
  function CHP2RTF(aCHP: TddCharacterProperty;
   aParent: TddCharacterProperty;
   const WithStyle: Boolean): AnsiString;
  function DIffCHP2RTF(aCHP1: TddCharacterProperty;
   aCHP2: TddCharacterProperty): AnsiString;
  function PAP2RTF(aPAP: TddParagraphProperty;
   aBlockIndent: Integer;
   anIgnoreLeftIndent: Boolean;
   WithStyle: Boolean): AnsiString;
 end;//TCustomRTFObjectGenerator
 
 TevRTFObjectGenerator = class(TCustomRTFObjectGenerator)
 end;//TevRTFObjectGenerator
 
implementation

uses
 l3ImplUses
 , ddDocument
;

end.
