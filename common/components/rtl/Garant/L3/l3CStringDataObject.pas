unit l3CStringDataObject;

// Модуль: "w:\common\components\rtl\Garant\L3\l3CStringDataObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3CStringDataObject" MUID: (55E5CAA801A1)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3StorableDataObject
 , l3Interfaces
;

type
 Tl3CStringDataObject = class(Tl3StorableDataObject, Il3DataObjectInfo)
  private
   f_String: Il3CString;
  protected
   function pm_GetIsQuestionNeedBeforeFlush: Boolean;
   function Store(aFormat: Tl3ClipboardFormat;
    const aPool: IStream): Boolean; override;
   procedure ClearFields; override;
  public
   constructor Create(const aString: Il3CString); reintroduce;
   class function Make(const aString: Il3CString): IDataObject; reintroduce;
 end;//Tl3CStringDataObject

implementation

uses
 l3ImplUses
 , SysUtils
 , l3_String
 , l3Chars
 , l3String
 , Windows
 //#UC START# *55E5CAA801A1impl_uses*
 //#UC END# *55E5CAA801A1impl_uses*
;

constructor Tl3CStringDataObject.Create(const aString: Il3CString);
//#UC START# *55E5CB0A0231_55E5CAA801A1_var*
var
 l_F : Tl3ClipboardFormats;
//#UC END# *55E5CB0A0231_55E5CAA801A1_var*
begin
//#UC START# *55E5CB0A0231_55E5CAA801A1_impl*
 SetLength(l_F, 3);
 l_F[0] := CF_UNICODETEXT;
 l_F[1] := CF_TEXT;
 l_F[2] := CF_OEMTEXT;
 inherited Create(l_F);
 f_String := aString;
//#UC END# *55E5CB0A0231_55E5CAA801A1_impl*
end;//Tl3CStringDataObject.Create

class function Tl3CStringDataObject.Make(const aString: Il3CString): IDataObject;
var
 l_Inst : Tl3CStringDataObject;
begin
 l_Inst := Create(aString);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tl3CStringDataObject.Make

function Tl3CStringDataObject.pm_GetIsQuestionNeedBeforeFlush: Boolean;
//#UC START# *4680FC190114_55E5CAA801A1get_var*
//#UC END# *4680FC190114_55E5CAA801A1get_var*
begin
//#UC START# *4680FC190114_55E5CAA801A1get_impl*
 Result := false;
//#UC END# *4680FC190114_55E5CAA801A1get_impl*
end;//Tl3CStringDataObject.pm_GetIsQuestionNeedBeforeFlush

function Tl3CStringDataObject.Store(aFormat: Tl3ClipboardFormat;
 const aPool: IStream): Boolean;
//#UC START# *48F37AC50290_55E5CAA801A1_var*

 function DoStore(aCodePage : Integer; const aStr: Tl3WString): Boolean;
 var
  l_S : Tl3_String;
  l_SizeToWrite : Integer;
  l_Written : Integer;
 begin//DoStore
  if (aStr.SCodePage <> aCodePage) then
  begin
   l_S := Tl3_String.Make(aStr);
   try
    l_S.CodePage := aCodePage;
    Assert(l_S.CodePage = aCodePage);
    Result := DoStore(aCodePage, l_S.AsWStr);
    Exit;
   finally
    FreeAndNil(l_S);
   end;//try..finally
  end;//aStr.SCodePage <> aCodePage

  l_SizeToWrite := (aStr.SLen + 1);
  // +1 - чтобы терминирующий ноль записать

  if (aCodePage = CP_Unicode) then
   l_SizeToWrite := l_SizeToWrite * SizeOf(WideChar);
  
  if SUCCEEDED(aPool.Write(aStr.S, l_SizeToWrite, @l_Written)) then
   Result := (l_SizeToWrite = l_Written)
  else
   Result := false;
 end;//DoStore

var
 l_S : Tl3WString;
//#UC END# *48F37AC50290_55E5CAA801A1_var*
begin
//#UC START# *48F37AC50290_55E5CAA801A1_impl*
 if (aPool = nil) then
  Result := false
 else
 begin
  l_S := f_String.AsWStr;
  Case aFormat of
   CF_TEXT:
    if l3IsANSI(l_S.SCodePage) then
     Result := DoStore(l_S.SCodePage, l_S)
    else
     Result := DoStore(CP_ANSI, l_S);
   CF_OEMTEXT:
    if l3IsOEM(l_S.SCodePage) then
     Result := DoStore(l_S.SCodePage, l_S)
    else
     Result := DoStore(CP_OEM, l_S);
   CF_UNICODETEXT:
    Result := DoStore(CP_UNICODE, l_S);
   else
    Result := false;
  end;//Case aFormat
 end;//aPool = nil
//#UC END# *48F37AC50290_55E5CAA801A1_impl*
end;//Tl3CStringDataObject.Store

procedure Tl3CStringDataObject.ClearFields;
begin
 f_String := nil;
 inherited;
end;//Tl3CStringDataObject.ClearFields

end.
