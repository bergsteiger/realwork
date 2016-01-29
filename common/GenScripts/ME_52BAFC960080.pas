unit EVDtoRTFRender;

interface

uses
 l3IntfUses
 , BaseTest
;

type
 THiddenStylesArray = array of LongInt;
 
 TEVDtoRTFRender = class(TBaseTest)
  procedure DoIt;
  function NeedEliminateCommentDecorations: Boolean;
  function TreatExceptionAsSuccess: Boolean;
  function GetHiddenStylesLength: Integer;
  function GetHiddenStyles: THiddenStylesArray;
 end;//TEVDtoRTFRender
 
implementation

uses
 l3ImplUses
 , eeEVDtoRTF
 , l3Filer
 , SysUtils
 , l3Interfaces
 , evStyleInterfaceEx
 , l3Memory
 , l3Stream
 , l3BaseStream
 , TestFrameWork
;

end.
