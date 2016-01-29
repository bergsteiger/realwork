unit atBaseEvdHelper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/EvdHelpers/atBaseEvdHelper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::EvdHelpers::TatBaseEvdHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  l3Memory,
  evdNativeWriter
  ;

type
 TatBaseEvdHelper = class(Tl3MemoryStream)
 protected
 // protected methods
   procedure Generate; virtual;
   procedure DoGenerate(anEVDNativeWriter: TevdNativeWriter); virtual; abstract;
 end;//TatBaseEvdHelper

implementation

uses
  Classes,
  k2TagGen,
  ActiveX,
  SysUtils
  ;

// start class TatBaseEvdHelper

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