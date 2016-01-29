unit CustomInsiderScripter;

interface

uses
 l3IntfUses
 , vcmInsiderTest
;

type
 TCustomInsiderScripter = class(TvcmInsiderTest)
  procedure Run;
  procedure DoIt;
  procedure Prepare;
   {* Âûחûגאועסÿ ג םאקאכו DoIt }
 end;//TCustomInsiderScripter
 
implementation

uses
 l3ImplUses
 , l3DispatcherHelper
 , l3MessagesService
 , l3DocumentsCacheService
 , TestFrameWork
;

end.
