unit tfwCOMStreamFactory;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwCOMStreamFactory.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

uses
 l3IntfUses
 , tfwStreamFactory
 , l3Interfaces
 , l3BaseStream
;

type
 TtfwCOMStreamFactory = class(TtfwStreamFactory)
  private
   f_COMStream: IStream;
  protected
   procedure ClearFields; override;
  public
   constructor Create(const aStream: IStream); reintroduce;
   function Stream: Tl3Stream; override;
   function FileDateTime: TDateTime; override;
 end;//TtfwCOMStreamFactory

implementation

uses
 l3ImplUses
 , l3Stream
 , Classes
 , SysUtils
;

constructor TtfwCOMStreamFactory.Create(const aStream: IStream);
//#UC START# *52F4F21D036E_52F4F1AA01E1_var*
//#UC END# *52F4F21D036E_52F4F1AA01E1_var*
begin
//#UC START# *52F4F21D036E_52F4F1AA01E1_impl*
 inherited Create('');
 f_COMStream := aStream
//#UC END# *52F4F21D036E_52F4F1AA01E1_impl*
end;//TtfwCOMStreamFactory.Create

function TtfwCOMStreamFactory.Stream: Tl3Stream;
//#UC START# *52F4E6E90067_52F4F1AA01E1_var*
//#UC END# *52F4E6E90067_52F4F1AA01E1_var*
begin
//#UC START# *52F4E6E90067_52F4F1AA01E1_impl*
 if (f_Stream = nil) then
  l3IStream2Stream(f_COMStream, TStream(f_Stream));
 Result := f_Stream;
//#UC END# *52F4E6E90067_52F4F1AA01E1_impl*
end;//TtfwCOMStreamFactory.Stream

function TtfwCOMStreamFactory.FileDateTime: TDateTime;
//#UC START# *55A649CC0040_52F4F1AA01E1_var*
//#UC END# *55A649CC0040_52F4F1AA01E1_var*
begin
//#UC START# *55A649CC0040_52F4F1AA01E1_impl*
 Result := Now;
//#UC END# *55A649CC0040_52F4F1AA01E1_impl*
end;//TtfwCOMStreamFactory.FileDateTime

procedure TtfwCOMStreamFactory.ClearFields;
begin
 f_COMStream := nil;
 inherited;
end;//TtfwCOMStreamFactory.ClearFields

end.
