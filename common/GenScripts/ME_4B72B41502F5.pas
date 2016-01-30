unit eeEVDtoRTF;

// Модуль: "w:\common\components\rtl\Garant\RenderEVD\eeEVDtoRTF.pas"
// Стереотип: "UtilityPack"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evdNativeReader
 , k2TagGen
 , ddRTFWriter
 , evdStyles
 , ActiveX
 , l3Types
;

function EVDtoRTFWithoutCommentDecor(const aEVD: IStream;
 const aRTF: IStream;
 Hidden: PLong;
 HiddenCount: Integer;
 aHost: PAnsiChar): Boolean;
function EVDtoRTF(const aEVD: IStream;
 const aRTF: IStream;
 Hidden: PLong;
 HiddenCount: Integer;
 aHost: PAnsiChar): Boolean;
function SetStyleTable(aStyleBuf: PAnsiChar;
 aStyleBufSize: Integer): Boolean;

implementation

uses
 l3ImplUses
 {$If Defined(Nemesis)}
 , F1_Schema
 {$IfEnd} // Defined(Nemesis)
 , evdSchema
 , l3Base
 , ddSectionRepair
 {$If NOT Defined(notDebugStackTrace)}
 , jclDebug
 {$IfEnd} // NOT Defined(notDebugStackTrace)
 , evHiddenFilter
 , evNestedDocumentEliminator
 , SysUtils
 , evdPageParamsFilter
 , evStyleInterfaceEx
 , evCommentDecorator
 , evdBlockNameAdder
 , evStyleHeaderAdder
 , evdScriptHyperlinkEliminator
 , l3Memory
;

function DoEVDtoRTF(const aEVD: IStream;
 const aRTF: IStream;
 Hidden: PLong;
 HiddenCount: Integer;
 aHost: PAnsiChar;
 aNeedEliminateCommentDecor: Boolean): Boolean;
//#UC START# *4B72B44A0392_4B72B41502F5_var*

 {$IfNDef notDebugStackTrace}
 procedure SaveStack(var S: String; AStackList: TJclStackInfoList);
 var
  I : Integer;
 begin
  try
   if (AStackList = nil) or (AStackList.Count <= 0) then
    S := S + '  [Stack is absent]'
   else
    with AStackList do
     for I := 0 to Count - 1 do
      S := S + #13#10 +  Format('  [Stack #%3d] %s',
       [I, GetLocationInfoStr(Pointer(Items[I].StackInfo.CallerAddr))]);
  except
  end;
 end;
 {$EndIf notDebugStackTrace}

var
 l_S       : String;
 l_Written : Longint;
 l_Index   : Integer;
//#UC END# *4B72B44A0392_4B72B41502F5_var*
begin
//#UC START# *4B72B44A0392_4B72B41502F5_impl*
 l3System.EnterGlobalCS;
 try
  Result := true;
  // - будем оптимистами
  try
(*   l_CMS := Tl3ConstMemoryStream.Create(aStyleBuf, aStyleBufSize);
   try
    with TevStyleInterfaceEx.Make do
     try
      Load(l_CMS);
     finally
      Free;
     end;//try..finally
   finally
    FreeAndNil(l_CMS);
   end;//try..finally*)
   l_Writer := TevRTFObjectGenerator.Create;
   try
    l_Writer.Host := aHost;
    l_G := l_Writer;
    l_Writer.Filer.Mode := l3_fmWrite;
    l_Writer.Filer.COMStream := aRTF;
    try
     TevStyleHeaderAdder.SetTo(l_G);
     TevdBlockNameAdder.SetTo(l_G);
     //http://mdp.garant.ru/pages/viewpage.action?pageId=518756624
     if not aNeedEliminateCommentDecor then
      TevCommentDecorator.SetTo(l_G);
     //TddSectionRepairFilter.SetTo(l_G);
     TevdPageParamsFilter.SetToA4(l_G);
     l_Styles := [];
     if (Hidden <> nil) AND (HiddenCount > 0) then
      for l_Index := 0 to Pred(HiddenCount) do
      begin
       if (Hidden^ < 0) then
        Include(l_Styles, -Hidden^);
       Inc(Hidden); 
      end;//for l_Index
     TevHiddenFilter.SetTo(l_Styles, true, l_G);
     TevdScriptHyperlinkEliminator.SetTo(l_G);
     TevNestedDocumentEliminator.SetTo(l_G);
     l_Reader := TevdNativeReader.Create;
     try
      l_Reader.Generator := l_G;
      l_Reader.Filer.Mode := l3_fmRead;
      l_Reader.Filer.COMStream := aEVD;
      try
       l_Reader.Execute;
      finally
       l_Reader.Filer.COMStream := nil;
      end;//try..finally
     finally
      l3Free(l_Reader);
     end;//try..finally
    finally
     l_Writer.Filer.COMStream := nil;
    end;//try..finally
   finally
    l3Free(l_G);
   end;//try..finally
  except
   on E : Exception do
   begin
    Result := false;
    // - все плохо :-(
    l_S := E.ClassName + ': ' + E.Message;
    {$IfNDef notDebugStackTrace}
    SaveStack(l_S, JclLastExceptStackList);
    {$EndIf  notDebugStackTrace}
    aRTF.Write(PAnsiChar(l_S), Length(l_S), @l_Written);
   end;//on E : Exception
   else
   begin
    Result := false;
    // - совсем все плохо :-(
    l_S := 'совсем все плохо';
    {$IfNDef notDebugStackTrace}
    SaveStack(l_S, JclLastExceptStackList);
    {$EndIf  notDebugStackTrace}
    aRTF.Write(PAnsiChar(l_S), Length(l_S), @l_Written);
   end;//else
  end;//try..except
 finally
  l3System.LeaveGlobalCS;
 end;//try..finally
//#UC END# *4B72B44A0392_4B72B41502F5_impl*
end;//DoEVDtoRTF

function EVDtoRTFWithoutCommentDecor(const aEVD: IStream;
 const aRTF: IStream;
 Hidden: PLong;
 HiddenCount: Integer;
 aHost: PAnsiChar): Boolean;
//#UC START# *530C8AA4024F_4B72B41502F5_var*
//#UC END# *530C8AA4024F_4B72B41502F5_var*
begin
//#UC START# *530C8AA4024F_4B72B41502F5_impl*
 Result := DoEVDtoRTF(aEVD, aRTF, Hidden, HiddenCount,
  aHost, True);
//#UC END# *530C8AA4024F_4B72B41502F5_impl*
end;//EVDtoRTFWithoutCommentDecor

function EVDtoRTF(const aEVD: IStream;
 const aRTF: IStream;
 Hidden: PLong;
 HiddenCount: Integer;
 aHost: PAnsiChar): Boolean;
//#UC START# *530C9AB60327_4B72B41502F5_var*
//#UC END# *530C9AB60327_4B72B41502F5_var*
begin
//#UC START# *530C9AB60327_4B72B41502F5_impl*
 Result := DoEVDToRTF(aEVD, aRTF, Hidden, HiddenCount,
  aHost, False);
//#UC END# *530C9AB60327_4B72B41502F5_impl*
end;//EVDtoRTF

function SetStyleTable(aStyleBuf: PAnsiChar;
 aStyleBufSize: Integer): Boolean;
//#UC START# *53CD1F8A0194_4B72B41502F5_var*
var
 l_CMS : Tl3ConstMemoryStream;
//#UC END# *53CD1F8A0194_4B72B41502F5_var*
begin
//#UC START# *53CD1F8A0194_4B72B41502F5_impl*
 Result := false;
 try
  l_CMS := Tl3ConstMemoryStream.Create(aStyleBuf, aStyleBufSize);
  try
   with TevStyleInterfaceEx.Make do
    try
     Load(l_CMS);
    finally
     Free;
    end;//try..finally
  finally
   FreeAndNil(l_CMS);
  end;//try..finally
 except
  Result := false;
  Exit;
 end;//try..except
 Result := true;
//#UC END# *53CD1F8A0194_4B72B41502F5_impl*
end;//SetStyleTable

end.
