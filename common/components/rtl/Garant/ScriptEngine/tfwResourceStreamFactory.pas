unit tfwResourceStreamFactory;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwResourceStreamFactory.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

uses
 l3IntfUses
 , tfwStreamFactory
 , l3BaseStream
;

type
 TtfwResourceStreamFactory = class(TtfwStreamFactory)
  private
   f_ResName: AnsiString;
  public
   constructor Create(const aResName: AnsiString); reintroduce;
   function Stream: Tl3Stream; override;
   function FileDateTime: TDateTime; override;
 end;//TtfwResourceStreamFactory

implementation

uses
 l3ImplUses
 , l3Stream
 , Windows
 , StrUtils
 , SysUtils
 , l3FileUtils
 , l3String
 , l3Interfaces
 , tfwCStringFactory
;

constructor TtfwResourceStreamFactory.Create(const aResName: AnsiString);
//#UC START# *55795E000174_55795DB3008C_var*
var
 l_P : Il3CString;
 l_S : Il3CString;
 l_N : AnsiString;
//#UC END# *55795E000174_55795DB3008C_var*
begin
//#UC START# *55795E000174_55795DB3008C_impl*
 l3Split(TtfwCStringFactory.C(aResName), ':', l_P, l_S);
 if not l3IsNil(l_S) then
 begin
  Assert(l3Same(l_P, l3PCharLen('res'), true));
  l_N := l3Str(l_S);
 end//not l3IsNil(l_S)
 else
  l_N := aResName; 
 inherited Create(aResName + '.script');
 f_ResName := AnsiUpperCase(l_N);
//#UC END# *55795E000174_55795DB3008C_impl*
end;//TtfwResourceStreamFactory.Create

function TtfwResourceStreamFactory.Stream: Tl3Stream;
//#UC START# *52F4E6E90067_55795DB3008C_var*
//#UC END# *52F4E6E90067_55795DB3008C_var*
begin
//#UC START# *52F4E6E90067_55795DB3008C_impl*
 if (f_Stream = nil) then
  f_Stream := Tl3ResourceStream.Create(hInstance, f_ResName);
 Result := f_Stream;
//#UC END# *52F4E6E90067_55795DB3008C_impl*
end;//TtfwResourceStreamFactory.Stream

function TtfwResourceStreamFactory.FileDateTime: TDateTime;
//#UC START# *55A649CC0040_55795DB3008C_var*
//#UC END# *55A649CC0040_55795DB3008C_var*
begin
//#UC START# *55A649CC0040_55795DB3008C_impl*
 Result := l3FileUtils.FileDateTime(ParamStr(0));
//#UC END# *55A649CC0040_55795DB3008C_impl*
end;//TtfwResourceStreamFactory.FileDateTime

end.
