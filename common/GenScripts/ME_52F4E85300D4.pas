unit tfwFileStreamFactory;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwFileStreamFactory.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

uses
 l3IntfUses
 , tfwStreamFactory
 , l3BaseStream
;

type
 TtfwFileStreamFactory = class(TtfwStreamFactory)
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   function Stream: Tl3Stream; override;
   function FileDateTime: TDateTime; override;
 end;//TtfwFileStreamFactory

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Stream
 , l3Types
 , l3FileUtils
;

function TtfwFileStreamFactory.Stream: Tl3Stream;
//#UC START# *52F4E6E90067_52F4E85300D4_var*
//#UC END# *52F4E6E90067_52F4E85300D4_var*
begin
//#UC START# *52F4E6E90067_52F4E85300D4_impl*
 if (f_Stream = nil) then
  f_Stream := Tl3NamedTextStream.Create(FileName, l3_fmRead, 1000);
 Result := f_Stream;
//#UC END# *52F4E6E90067_52F4E85300D4_impl*
end;//TtfwFileStreamFactory.Stream

function TtfwFileStreamFactory.FileDateTime: TDateTime;
//#UC START# *55A649CC0040_52F4E85300D4_var*
//#UC END# *55A649CC0040_52F4E85300D4_var*
begin
//#UC START# *55A649CC0040_52F4E85300D4_impl*
 Result := l3FileUtils.FileDateTime(FileName);
//#UC END# *55A649CC0040_52F4E85300D4_impl*
end;//TtfwFileStreamFactory.FileDateTime

procedure TtfwFileStreamFactory.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52F4E85300D4_var*
//#UC END# *479731C50290_52F4E85300D4_var*
begin
//#UC START# *479731C50290_52F4E85300D4_impl*
 inherited;
//#UC END# *479731C50290_52F4E85300D4_impl*
end;//TtfwFileStreamFactory.Cleanup

end.
