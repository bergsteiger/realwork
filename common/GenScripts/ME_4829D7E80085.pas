unit evCustomEdit;

interface

uses
 l3IntfUses
 , evCustomMemo
 , Classes
 , l3InternalInterfaces
 , l3Region
 , evDef
;

type
 TevCustomEdit = class(TevCustomMemo)
  {* Строка ввода. }
  function cnvLo2Up(Sender: TObject;
   aStr: PAnsiChar;
   aLen: Integer;
   aCodePage: Integer): Boolean;
 end;//TevCustomEdit
 
implementation

uses
 l3ImplUses
 , evCustomEditTextSource
 , SysUtils
 , evSearch
 , l3String
 , evTypes
 , evConvertTextTools
 , l3Units
 , Windows
 , TtfwClassRef_Proxy
 , Themes
;

end.
