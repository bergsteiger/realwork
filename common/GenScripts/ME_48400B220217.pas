unit atBaseEvdHelper;

// Модуль: "w:\quality\test\garant6x\AdapterTest\EvdHelpers\atBaseEvdHelper.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , l3Memory
 , evdNativeWriter
;

type
 TatBaseEvdHelper = class(Tl3MemoryStream)
  protected
   procedure Generate; virtual;
   procedure DoGenerate(anEVDNativeWriter: TevdNativeWriter); virtual; abstract;
 end;//TatBaseEvdHelper

implementation

uses
 l3ImplUses
 , Classes
 , k2TagGen
 , ActiveX
 , SysUtils
;

procedure TatBaseEvdHelper.Generate;
//#UC START# *4B6AE78F01CF_48400B220217_var*
  var
    l_K2Gen : Tk2TagGenerator;
    l_EVDNativeWriter : TevdNativeWriter;
//#UC END# *4B6AE78F01CF_48400B220217_var*
begin
//#UC START# *4B6AE78F01CF_48400B220217_impl*
  l_K2Gen := nil;
  l_EVDNativeWriter := TevdNativeWriter.SetTo(l_K2Gen, Self as IStream);
  Assert(l_EVDNativeWriter <> nil, 'f_EVDNativeWriter <> nil');
  try
    DoGenerate(l_EVDNativeWriter);
  finally
    FreeAndNil(l_EVDNativeWriter);
  end;
//#UC END# *4B6AE78F01CF_48400B220217_impl*
end;//TatBaseEvdHelper.Generate

end.
