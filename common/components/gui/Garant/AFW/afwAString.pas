unit afwAString;

// Модуль: "w:\common\components\gui\Garant\AFW\afwAString.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TafwAString" MUID: (4F6C79B10165)

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
;

type
 TafwAString = class(Tl3ProtoObject, Il3AString)
  private
   f_String: Il3CString;
   f_Tmp: AnsiString;
  protected
   function S: PAnsiChar;
    {* Собственно строка. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure ClearFields; override;
  public
   constructor Create(const aString: Il3CString); reintroduce;
   class function Make(const aString: Il3CString): Il3AString; reintroduce;
 end;//TafwAString

implementation

uses
 l3ImplUses
 , l3String
 , l3Chars
;

constructor TafwAString.Create(const aString: Il3CString);
//#UC START# *4F6C7A060311_4F6C79B10165_var*
//#UC END# *4F6C7A060311_4F6C79B10165_var*
begin
//#UC START# *4F6C7A060311_4F6C79B10165_impl*
 inherited Create;
 f_String := aString;
//#UC END# *4F6C7A060311_4F6C79B10165_impl*
end;//TafwAString.Create

class function TafwAString.Make(const aString: Il3CString): Il3AString;
var
 l_Inst : TafwAString;
begin
 l_Inst := Create(aString);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TafwAString.Make

function TafwAString.S: PAnsiChar;
 {* Собственно строка. }
//#UC START# *46A45D0A02A1_4F6C79B10165_var*
var
 l_S : Tl3WString;
//#UC END# *46A45D0A02A1_4F6C79B10165_var*
begin
//#UC START# *46A45D0A02A1_4F6C79B10165_impl*
 if (f_String = nil) then
  Result := ''
 else
 begin
  l_S := f_String.AsWStr;
  if (l_S.SCodePage = CP_ANSI) then
  begin
   Result := l_S.S;
   if (Result <> nil) AND (Result[l_S.SLen] <> #0) then
   begin
    f_Tmp := l3Str(l_S);
    Result := PAnsiChar(f_Tmp);
   end;//l_S.SLen >= l3StrLen(Result)
  end//f_String.SCodePage = CP_ANSI
  else
  begin
   f_Tmp := l3Str(l_S);
   Result := PAnsiChar(f_Tmp);
  end;//f_String.SCodePage = CP_ANSI
 end;//f_String = nil
//#UC END# *46A45D0A02A1_4F6C79B10165_impl*
end;//TafwAString.S

{$If NOT Defined(DesignTimeLibrary)}
class function TafwAString.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4F6C79B10165_var*
//#UC END# *47A6FEE600FC_4F6C79B10165_var*
begin
//#UC START# *47A6FEE600FC_4F6C79B10165_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4F6C79B10165_impl*
end;//TafwAString.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TafwAString.ClearFields;
begin
 f_String := nil;
 inherited;
end;//TafwAString.ClearFields

end.
