unit vtColorBox;

interface

uses
 l3IntfUses
 , vtComboTree
 , Graphics
 , l3Interfaces
 , Classes
 , ctTypes
 , l3VCLStrings
 , l3InternalInterfaces
 , nevTools
;

type
 TvtColorBoxStyles = (
  cbStandardColors
   {* first sixteen RGBI colors }
  , cbExtendedColors
   {* four additional reserved colors }
  , cbSystemColors
   {* system managed/defined colors }
  , cbIncludeNone
   {* include clNone color, must be used with cbSystemColors }
  , cbIncludeDefault
   {* include clDefault color, must be used with cbSystemColors }
  , cbCustomColor
   {* first color is customizable }
  , cbPrettyNames
   {* instead of 'clColorNames' you get 'Color Names' }
  , cbNoName
   {* show only color rect }
 );//TvtColorBoxStyles
 
 TvtColorBoxStyle = set of TvtColorBoxStyles;
 
 TvtCustomColorBox = class(TvtComboTree)
  procedure ColorCallBack(const aName: AnsiString);
  function IndexOfColor(aColor: TColor): Integer;
  function PickCustomColor: Boolean;
  procedure PopulateList;
  function DrawNames: Boolean;
 end;//TvtCustomColorBox
 
 TvtColorBox = class(TvtCustomColorBox)
 end;//TvtColorBox
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Base
 , Dialogs
 , Consts
 , vtColorBoxStrings
 , TtfwClassRef_Proxy
;

end.
