unit evdCustomNativeWriter;

interface

uses
 l3IntfUses
 , k2CustomFileGenerator
;

type
 TevdCustomNativeWriter = class(Tk2CustomFileGenerator)
  {* Писатель тегов в формате evd. }
 end;//TevdCustomNativeWriter
 
implementation

uses
 l3ImplUses
 , evdCustomNativeWriterServices
;

end.
