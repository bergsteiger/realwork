unit evLocationBase;
 {* Базовый объект для диапазонов в документе (курсоров и блоков) }

// Модуль: "w:\common\components\gui\Garant\Everest\evLocationBase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevLocationBase" MUID: (47F4D44C01BF)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , k2TagPointer
 , nevTools
 , l3Variant
 , nevBase
 , l3Core
 , l3Interfaces
;

type
 _nevParaTool_Parent_ = Tk2TagPointer;
 {$Include w:\common\components\gui\Garant\Everest\new\nevParaTool.imp.pas}
 TevLocationBase = class(_nevParaTool_, InevTextModify, InevLocation, InevDataFormatting, InevDataFormattingModify, IevDocumentPoint)
  {* Базовый объект для диапазонов в документе (курсоров и блоков) }
  protected
   function TagWriter: InevTagWriter;
   function DoJoinWith(const aView: InevView;
    aSecondPara: Tl3Variant;
    const anOp: InevOp;
    MoveSubs: Boolean): Integer; virtual;
   function DoSplit(const aView: InevView;
    aFlags: TnevInsertStringFlags;
    const anOp: InevOp): Il3TagRef; virtual;
   function DoJoinWithNext(const aView: InevView;
    const anOp: InevOp): Boolean; virtual;
   function GetRange: InevRange; virtual;
   function GetAsPoint: InevBasePoint; virtual;
   function GetCanBeDeleted: Boolean; virtual;
   function DoGetBlockLength: Integer; virtual;
   function DoDeleteCharToLeft(const aView: InevView;
    aDrawLines: Boolean;
    const anOp: InevOp): Boolean; virtual;
   function DoGetStyle(Stop: PInteger): Tl3Variant; virtual;
   function DoChangeParam(const aView: InevView;
    const aMarker: IevMarker;
    aValue: Integer;
    const anOp: InevOp): Boolean; virtual;
   function DoGetFont(const aView: InevView;
    aMap: TnevFormatInfoPrim;
    Stop: PInteger): InevFontPrim; virtual;
   function DoDeleteHyperlink(const anOpPack: InevOp): Boolean; virtual;
   function DoInsertBreak(const aView: InevView;
    aDrawLines: Boolean;
    const anOp: InevOp): Boolean; virtual;
   function DoAddIndentMarker(const aView: InevView;
    aValue: Integer;
    const anOpPack: InevOp): Boolean; virtual;
   function DoDeleteIndentMarker(const aView: InevView;
    const anOpPack: InevOp): Boolean; virtual;
   function DoInsertString(const aView: InevView;
    const aString: Il3CString;
    const anOp: InevOp;
    InsertMode: Boolean;
    aFlags: TnevInsertStringFlags): Boolean; virtual;
   function DoDeleteString(const aView: InevView;
    aCount: Integer;
    const anOp: InevOp;
    aFlags: TnevInsertStringFlags): Boolean; virtual;
   function DoSetAtom(const aView: InevView;
    anIndex: Cardinal;
    pSource: Tl3Variant;
    const anOp: InevOp): Boolean; virtual;
   function DoDeleteChar(const aView: InevView;
    aDrawLines: Boolean;
    const anOp: InevOp): Boolean; virtual;
   function GetInevDataFormattingModify(const aView: InevView): InevDataFormattingModify; virtual;
   function GetText: InevText; virtual;
   function DoInsertStream(const aView: InevView;
    const aStream: IStream;
    aFormat: TnevFormat;
    const anOp: InevOp;
    aFlags: TevLoadFlags;
    aCodePage: Integer): Boolean; virtual;
   function DoDeleteSegments(const anOpPack: InevOp): Boolean; virtual;
   function InsertString(const aView: InevView;
    const aString: Il3CString;
    const anOp: InevOp = nil;
    InsertMode: Boolean = True;
    aFlags: TnevInsertStringFlags = []): Boolean;
    {* вставляет строку. }
   function InsertStream(const aView: InevView;
    const aStream: IStream;
    aFormat: TnevFormat;
    const anOp: InevOp = nil;
    aFlags: TevLoadFlags = nevBase.evDefaultLoadFlags;
    aCodePage: Integer = CP_DefaultValue): Boolean;
   function DeleteString(const aView: InevView;
    Count: Integer;
    const anOp: InevOp = nil;
    aFlags: TnevInsertStringFlags = []): Boolean;
    {* удаляет строку. }
   function DeleteChar(const aView: InevView;
    aDrawLines: Boolean;
    const anOp: InevOp): Boolean;
   function InsertBreak(const aView: InevView;
    aDrawLines: Boolean = False;
    const anOp: InevOp = nil): Boolean;
   function DeleteCharToLeft(const aView: InevView;
    aDrawLines: Boolean = False;
    const anOp: InevOp = nil): Boolean;
   function Split(const aView: InevView;
    aFlags: TnevInsertStringFlags;
    const anOp: InevOp): Il3TagRef;
   function JoinWith(const aView: InevView;
    aSecondPara: Tl3Variant;
    const anOp: InevOp = nil;
    MoveSubs: Boolean = True): Integer;
   function JoinWithNext(const aView: InevView;
    const anOp: InevOp = nil): Boolean;
   function Range: InevRange;
   function pm_GetFormatting: InevDataFormatting;
   function GetFont(const aView: InevView;
    aMap: TnevFormatInfoPrim;
    Stop: PInteger = nil): InevFontPrim;
   function GetStyle(Stop: PInteger = nil): Tl3Variant;
   function Modify(const aView: InevView): InevDataFormattingModify;
   function SetAtom(const aView: InevView;
    anIndex: Cardinal;
    aValue: Tl3Variant;
    const anOp: InevOp): Boolean;
   function ChangeParam(const aView: InevView;
    const aMarker: IevMarker;
    aValue: Integer;
    const anOp: InevOp = nil): Boolean;
   function DeleteHyperlink(const anOp: InevOp = nil): Boolean;
   function DeleteSegments(const anOp: InevOp = nil): Boolean;
    {* удаляет сегменты. }
   function Select(const Selection: InevSelection): Boolean;
    {* перемещает Selection на данную метку. }
   function AddIndentMarker(const aView: InevView;
    aValue: Integer;
    const anOpPack: InevOp = nil): Boolean;
   function DeleteIndentMarker(const aView: InevView;
    const anOpPack: InevOp = nil): Boolean;
   function Get_Obj: PInevObject;
   function pm_GetText: InevText;
   function AsPoint: InevBasePoint;
 end;//TevLocationBase
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , evExcept
 , SysUtils
 , nevPersistentDocumentContainer
 , k2NullTagImpl
;

type _Instance_R_ = TevLocationBase;

{$Include w:\common\components\gui\Garant\Everest\new\nevParaTool.imp.pas}

function TevLocationBase.TagWriter: InevTagWriter;
//#UC START# *4A3A61840280_47F4D44C01BF_var*
var
 l_Cont : InevDocumentContainer;
//#UC END# *4A3A61840280_47F4D44C01BF_var*
begin
//#UC START# *4A3A61840280_47F4D44C01BF_impl*
 l_Cont := ParaX.DocumentContainer;
 if (l_Cont = nil) then
  l_Cont := TnevPersistentDocumentContainer.Make;
 Assert(l_Cont <> nil); 
 Result := l_Cont.TagWriter;
//#UC END# *4A3A61840280_47F4D44C01BF_impl*
end;//TevLocationBase.TagWriter

function TevLocationBase.DoJoinWith(const aView: InevView;
 aSecondPara: Tl3Variant;
 const anOp: InevOp;
 MoveSubs: Boolean): Integer;
//#UC START# *49DEFB410161_47F4D44C01BF_var*
//#UC END# *49DEFB410161_47F4D44C01BF_var*
begin
//#UC START# *49DEFB410161_47F4D44C01BF_impl*
 Result := -1;
 Assert(false);
//#UC END# *49DEFB410161_47F4D44C01BF_impl*
end;//TevLocationBase.DoJoinWith

function TevLocationBase.DoSplit(const aView: InevView;
 aFlags: TnevInsertStringFlags;
 const anOp: InevOp): Il3TagRef;
//#UC START# *49DEFB770015_47F4D44C01BF_var*
//#UC END# *49DEFB770015_47F4D44C01BF_var*
begin
//#UC START# *49DEFB770015_47F4D44C01BF_impl*
 Result := nil;
 Assert(false);
//#UC END# *49DEFB770015_47F4D44C01BF_impl*
end;//TevLocationBase.DoSplit

function TevLocationBase.DoJoinWithNext(const aView: InevView;
 const anOp: InevOp): Boolean;
//#UC START# *49DF4C6E0101_47F4D44C01BF_var*
//#UC END# *49DF4C6E0101_47F4D44C01BF_var*
begin
//#UC START# *49DF4C6E0101_47F4D44C01BF_impl*
 Result := false;
 Assert(false);
//#UC END# *49DF4C6E0101_47F4D44C01BF_impl*
end;//TevLocationBase.DoJoinWithNext

function TevLocationBase.GetRange: InevRange;
//#UC START# *49DF62920242_47F4D44C01BF_var*
//#UC END# *49DF62920242_47F4D44C01BF_var*
begin
//#UC START# *49DF62920242_47F4D44C01BF_impl*
 Result := nil;
 Assert(false);
//#UC END# *49DF62920242_47F4D44C01BF_impl*
end;//TevLocationBase.GetRange

function TevLocationBase.GetAsPoint: InevBasePoint;
//#UC START# *49DF62A201EB_47F4D44C01BF_var*
//#UC END# *49DF62A201EB_47F4D44C01BF_var*
begin
//#UC START# *49DF62A201EB_47F4D44C01BF_impl*
 Result := nil;
 Assert(false);
//#UC END# *49DF62A201EB_47F4D44C01BF_impl*
end;//TevLocationBase.GetAsPoint

function TevLocationBase.GetCanBeDeleted: Boolean;
//#UC START# *49DF6777033A_47F4D44C01BF_var*
//#UC END# *49DF6777033A_47F4D44C01BF_var*
begin
//#UC START# *49DF6777033A_47F4D44C01BF_impl*
 Result := true; 
//#UC END# *49DF6777033A_47F4D44C01BF_impl*
end;//TevLocationBase.GetCanBeDeleted

function TevLocationBase.DoGetBlockLength: Integer;
//#UC START# *49E3662D028E_47F4D44C01BF_var*
//#UC END# *49E3662D028E_47F4D44C01BF_var*
begin
//#UC START# *49E3662D028E_47F4D44C01BF_impl*
 Result := 0;
//#UC END# *49E3662D028E_47F4D44C01BF_impl*
end;//TevLocationBase.DoGetBlockLength

function TevLocationBase.DoDeleteCharToLeft(const aView: InevView;
 aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *4A29419B0319_47F4D44C01BF_var*
//#UC END# *4A29419B0319_47F4D44C01BF_var*
begin
//#UC START# *4A29419B0319_47F4D44C01BF_impl*
 Result := false;
//#UC END# *4A29419B0319_47F4D44C01BF_impl*
end;//TevLocationBase.DoDeleteCharToLeft

function TevLocationBase.DoGetStyle(Stop: PInteger): Tl3Variant;
//#UC START# *4A2945060101_47F4D44C01BF_var*
//#UC END# *4A2945060101_47F4D44C01BF_var*
begin
//#UC START# *4A2945060101_47F4D44C01BF_impl*
 Result := nil;
 Assert(false);
//#UC END# *4A2945060101_47F4D44C01BF_impl*
end;//TevLocationBase.DoGetStyle

function TevLocationBase.DoChangeParam(const aView: InevView;
 const aMarker: IevMarker;
 aValue: Integer;
 const anOp: InevOp): Boolean;
//#UC START# *4A29465701BC_47F4D44C01BF_var*
//#UC END# *4A29465701BC_47F4D44C01BF_var*
begin
//#UC START# *4A29465701BC_47F4D44C01BF_impl*
 Result := false;
//#UC END# *4A29465701BC_47F4D44C01BF_impl*
end;//TevLocationBase.DoChangeParam

function TevLocationBase.DoGetFont(const aView: InevView;
 aMap: TnevFormatInfoPrim;
 Stop: PInteger): InevFontPrim;
//#UC START# *4A29477801BF_47F4D44C01BF_var*
//#UC END# *4A29477801BF_47F4D44C01BF_var*
begin
//#UC START# *4A29477801BF_47F4D44C01BF_impl*
 Result := nil;
 Assert(false);
//#UC END# *4A29477801BF_47F4D44C01BF_impl*
end;//TevLocationBase.DoGetFont

function TevLocationBase.DoDeleteHyperlink(const anOpPack: InevOp): Boolean;
//#UC START# *4A38F52201BA_47F4D44C01BF_var*
//#UC END# *4A38F52201BA_47F4D44C01BF_var*
begin
//#UC START# *4A38F52201BA_47F4D44C01BF_impl*
 Result := false;
//#UC END# *4A38F52201BA_47F4D44C01BF_impl*
end;//TevLocationBase.DoDeleteHyperlink

function TevLocationBase.DoInsertBreak(const aView: InevView;
 aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *4A38F59B0234_47F4D44C01BF_var*
//#UC END# *4A38F59B0234_47F4D44C01BF_var*
begin
//#UC START# *4A38F59B0234_47F4D44C01BF_impl*
 Result := false;
//#UC END# *4A38F59B0234_47F4D44C01BF_impl*
end;//TevLocationBase.DoInsertBreak

function TevLocationBase.DoAddIndentMarker(const aView: InevView;
 aValue: Integer;
 const anOpPack: InevOp): Boolean;
//#UC START# *4A38F69F0070_47F4D44C01BF_var*
//#UC END# *4A38F69F0070_47F4D44C01BF_var*
begin
//#UC START# *4A38F69F0070_47F4D44C01BF_impl*
 Result := False;
//#UC END# *4A38F69F0070_47F4D44C01BF_impl*
end;//TevLocationBase.DoAddIndentMarker

function TevLocationBase.DoDeleteIndentMarker(const aView: InevView;
 const anOpPack: InevOp): Boolean;
//#UC START# *4A38F6CB003C_47F4D44C01BF_var*
//#UC END# *4A38F6CB003C_47F4D44C01BF_var*
begin
//#UC START# *4A38F6CB003C_47F4D44C01BF_impl*
 Result := False;
//#UC END# *4A38F6CB003C_47F4D44C01BF_impl*
end;//TevLocationBase.DoDeleteIndentMarker

function TevLocationBase.DoInsertString(const aView: InevView;
 const aString: Il3CString;
 const anOp: InevOp;
 InsertMode: Boolean;
 aFlags: TnevInsertStringFlags): Boolean;
//#UC START# *4A38F71601D6_47F4D44C01BF_var*
//#UC END# *4A38F71601D6_47F4D44C01BF_var*
begin
//#UC START# *4A38F71601D6_47F4D44C01BF_impl*
 Result := false;
//#UC END# *4A38F71601D6_47F4D44C01BF_impl*
end;//TevLocationBase.DoInsertString

function TevLocationBase.DoDeleteString(const aView: InevView;
 aCount: Integer;
 const anOp: InevOp;
 aFlags: TnevInsertStringFlags): Boolean;
//#UC START# *4A38F748002D_47F4D44C01BF_var*
//#UC END# *4A38F748002D_47F4D44C01BF_var*
begin
//#UC START# *4A38F748002D_47F4D44C01BF_impl*
 Result := false;
//#UC END# *4A38F748002D_47F4D44C01BF_impl*
end;//TevLocationBase.DoDeleteString

function TevLocationBase.DoSetAtom(const aView: InevView;
 anIndex: Cardinal;
 pSource: Tl3Variant;
 const anOp: InevOp): Boolean;
//#UC START# *4A38F7A40373_47F4D44C01BF_var*
//#UC END# *4A38F7A40373_47F4D44C01BF_var*
begin
//#UC START# *4A38F7A40373_47F4D44C01BF_impl*
 try
  GetRedirect.AttrW[anIndex, anOp] := pSource.AsObject;
  Result := true;
 except
  Result := false;
 end;//try..except
//#UC END# *4A38F7A40373_47F4D44C01BF_impl*
end;//TevLocationBase.DoSetAtom

function TevLocationBase.DoDeleteChar(const aView: InevView;
 aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *4A38F7F5022C_47F4D44C01BF_var*
//#UC END# *4A38F7F5022C_47F4D44C01BF_var*
begin
//#UC START# *4A38F7F5022C_47F4D44C01BF_impl*
 Result := false;
//#UC END# *4A38F7F5022C_47F4D44C01BF_impl*
end;//TevLocationBase.DoDeleteChar

function TevLocationBase.GetInevDataFormattingModify(const aView: InevView): InevDataFormattingModify;
//#UC START# *4A3A61DC00AB_47F4D44C01BF_var*
//#UC END# *4A3A61DC00AB_47F4D44C01BF_var*
begin
//#UC START# *4A3A61DC00AB_47F4D44C01BF_impl*
 Result := Self;
//#UC END# *4A3A61DC00AB_47F4D44C01BF_impl*
end;//TevLocationBase.GetInevDataFormattingModify

function TevLocationBase.GetText: InevText;
//#UC START# *4A3A69AC006F_47F4D44C01BF_var*
//#UC END# *4A3A69AC006F_47F4D44C01BF_var*
begin
//#UC START# *4A3A69AC006F_47F4D44C01BF_impl*
 Result := nil;
//#UC END# *4A3A69AC006F_47F4D44C01BF_impl*
end;//TevLocationBase.GetText

function TevLocationBase.DoInsertStream(const aView: InevView;
 const aStream: IStream;
 aFormat: TnevFormat;
 const anOp: InevOp;
 aFlags: TevLoadFlags;
 aCodePage: Integer): Boolean;
//#UC START# *4A3A8BEE029F_47F4D44C01BF_var*
var
 l_Writer : InevTagWriter;
//#UC END# *4A3A8BEE029F_47F4D44C01BF_var*
begin
//#UC START# *4A3A8BEE029F_47F4D44C01BF_impl*
 l_Writer := TagWriter;
 if (l_Writer = nil) then
  Result := false
 else
  Result := l_Writer.WriteTag(aView, aFormat, aStream, Self, aFlags, aCodePage);
//#UC END# *4A3A8BEE029F_47F4D44C01BF_impl*
end;//TevLocationBase.DoInsertStream

function TevLocationBase.DoDeleteSegments(const anOpPack: InevOp): Boolean;
//#UC START# *4A3A8F8800AD_47F4D44C01BF_var*
//#UC END# *4A3A8F8800AD_47F4D44C01BF_var*
begin
//#UC START# *4A3A8F8800AD_47F4D44C01BF_impl*
 Result := false;
//#UC END# *4A3A8F8800AD_47F4D44C01BF_impl*
end;//TevLocationBase.DoDeleteSegments

function TevLocationBase.InsertString(const aView: InevView;
 const aString: Il3CString;
 const anOp: InevOp = nil;
 InsertMode: Boolean = True;
 aFlags: TnevInsertStringFlags = []): Boolean;
 {* вставляет строку. }
//#UC START# *47C5B31203AD_47F4D44C01BF_var*
//#UC END# *47C5B31203AD_47F4D44C01BF_var*
begin
//#UC START# *47C5B31203AD_47F4D44C01BF_impl*
 try
  Result := DoInsertString(aView, aString, anOp, InsertMode, aFlags);
 except
  on EevReadOnly do Result := false;
 end;//try..excepy
//#UC END# *47C5B31203AD_47F4D44C01BF_impl*
end;//TevLocationBase.InsertString

function TevLocationBase.InsertStream(const aView: InevView;
 const aStream: IStream;
 aFormat: TnevFormat;
 const anOp: InevOp = nil;
 aFlags: TevLoadFlags = nevBase.evDefaultLoadFlags;
 aCodePage: Integer = CP_DefaultValue): Boolean;
//#UC START# *47C5B3410044_47F4D44C01BF_var*
//#UC END# *47C5B3410044_47F4D44C01BF_var*
begin
//#UC START# *47C5B3410044_47F4D44C01BF_impl*
 Result := DoInsertStream(aView, aStream, aFormat, anOp, aFlags, aCodePage);
//#UC END# *47C5B3410044_47F4D44C01BF_impl*
end;//TevLocationBase.InsertStream

function TevLocationBase.DeleteString(const aView: InevView;
 Count: Integer;
 const anOp: InevOp = nil;
 aFlags: TnevInsertStringFlags = []): Boolean;
 {* удаляет строку. }
//#UC START# *47C5B48E01CF_47F4D44C01BF_var*
//#UC END# *47C5B48E01CF_47F4D44C01BF_var*
begin
//#UC START# *47C5B48E01CF_47F4D44C01BF_impl*
 try
  Result := DoDeleteString(aView, Count, anOp, aFlags);
 except
  on EevReadOnly do
   Result := false;
 end;//try..except
//#UC END# *47C5B48E01CF_47F4D44C01BF_impl*
end;//TevLocationBase.DeleteString

function TevLocationBase.DeleteChar(const aView: InevView;
 aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *47C5B4A30392_47F4D44C01BF_var*
//#UC END# *47C5B4A30392_47F4D44C01BF_var*
begin
//#UC START# *47C5B4A30392_47F4D44C01BF_impl*
 if (Self = nil) then
  Result := false
 else
  Result := DoDeleteChar(aView, aDrawLines, anOp);
//#UC END# *47C5B4A30392_47F4D44C01BF_impl*
end;//TevLocationBase.DeleteChar

function TevLocationBase.InsertBreak(const aView: InevView;
 aDrawLines: Boolean = False;
 const anOp: InevOp = nil): Boolean;
//#UC START# *47C5B4B10123_47F4D44C01BF_var*
//#UC END# *47C5B4B10123_47F4D44C01BF_var*
begin
//#UC START# *47C5B4B10123_47F4D44C01BF_impl*
 Result := DoInsertBreak(aView, aDrawLines, anOp);
//#UC END# *47C5B4B10123_47F4D44C01BF_impl*
end;//TevLocationBase.InsertBreak

function TevLocationBase.DeleteCharToLeft(const aView: InevView;
 aDrawLines: Boolean = False;
 const anOp: InevOp = nil): Boolean;
//#UC START# *47C5B4BF021F_47F4D44C01BF_var*
//#UC END# *47C5B4BF021F_47F4D44C01BF_var*
begin
//#UC START# *47C5B4BF021F_47F4D44C01BF_impl*
 Result := DoDeleteCharToLeft(aView, aDrawLines, anOp);
//#UC END# *47C5B4BF021F_47F4D44C01BF_impl*
end;//TevLocationBase.DeleteCharToLeft

function TevLocationBase.Split(const aView: InevView;
 aFlags: TnevInsertStringFlags;
 const anOp: InevOp): Il3TagRef;
//#UC START# *47C5B4CF00D0_47F4D44C01BF_var*
//#UC END# *47C5B4CF00D0_47F4D44C01BF_var*
begin
//#UC START# *47C5B4CF00D0_47F4D44C01BF_impl*
 Result := DoSplit(aView, aFlags, anOp);
//#UC END# *47C5B4CF00D0_47F4D44C01BF_impl*
end;//TevLocationBase.Split

function TevLocationBase.JoinWith(const aView: InevView;
 aSecondPara: Tl3Variant;
 const anOp: InevOp = nil;
 MoveSubs: Boolean = True): Integer;
//#UC START# *47C5B4E001F9_47F4D44C01BF_var*
//#UC END# *47C5B4E001F9_47F4D44C01BF_var*
begin
//#UC START# *47C5B4E001F9_47F4D44C01BF_impl*
 Result := DoJoinWith(aView, aSecondPara, anOp, MoveSubs);
//#UC END# *47C5B4E001F9_47F4D44C01BF_impl*
end;//TevLocationBase.JoinWith

function TevLocationBase.JoinWithNext(const aView: InevView;
 const anOp: InevOp = nil): Boolean;
//#UC START# *47C5B4FA0219_47F4D44C01BF_var*
//#UC END# *47C5B4FA0219_47F4D44C01BF_var*
begin
//#UC START# *47C5B4FA0219_47F4D44C01BF_impl*
 Result := DoJoinWithNext(aView, anOp);
//#UC END# *47C5B4FA0219_47F4D44C01BF_impl*
end;//TevLocationBase.JoinWithNext

function TevLocationBase.Range: InevRange;
//#UC START# *47C5B55D00B4_47F4D44C01BF_var*
//#UC END# *47C5B55D00B4_47F4D44C01BF_var*
begin
//#UC START# *47C5B55D00B4_47F4D44C01BF_impl*
 Result := GetRange;
//#UC END# *47C5B55D00B4_47F4D44C01BF_impl*
end;//TevLocationBase.Range

function TevLocationBase.pm_GetFormatting: InevDataFormatting;
//#UC START# *47C5B603039F_47F4D44C01BFget_var*
//#UC END# *47C5B603039F_47F4D44C01BFget_var*
begin
//#UC START# *47C5B603039F_47F4D44C01BFget_impl*
 Result := Self;
//#UC END# *47C5B603039F_47F4D44C01BFget_impl*
end;//TevLocationBase.pm_GetFormatting

function TevLocationBase.GetFont(const aView: InevView;
 aMap: TnevFormatInfoPrim;
 Stop: PInteger = nil): InevFontPrim;
//#UC START# *47C68E0C02E2_47F4D44C01BF_var*
//#UC END# *47C68E0C02E2_47F4D44C01BF_var*
begin
//#UC START# *47C68E0C02E2_47F4D44C01BF_impl*
 Result := DoGetFont(aView, aMap, Stop);
//#UC END# *47C68E0C02E2_47F4D44C01BF_impl*
end;//TevLocationBase.GetFont

function TevLocationBase.GetStyle(Stop: PInteger = nil): Tl3Variant;
//#UC START# *47C68E3402A5_47F4D44C01BF_var*
//#UC END# *47C68E3402A5_47F4D44C01BF_var*
begin
//#UC START# *47C68E3402A5_47F4D44C01BF_impl*
 Result := DoGetStyle(Stop);
//#UC END# *47C68E3402A5_47F4D44C01BF_impl*
end;//TevLocationBase.GetStyle

function TevLocationBase.Modify(const aView: InevView): InevDataFormattingModify;
//#UC START# *47C68E3D0279_47F4D44C01BF_var*
//#UC END# *47C68E3D0279_47F4D44C01BF_var*
begin
//#UC START# *47C68E3D0279_47F4D44C01BF_impl*
 Result := GetInevDataFormattingModify(aView);
//#UC END# *47C68E3D0279_47F4D44C01BF_impl*
end;//TevLocationBase.Modify

function TevLocationBase.SetAtom(const aView: InevView;
 anIndex: Cardinal;
 aValue: Tl3Variant;
 const anOp: InevOp): Boolean;
//#UC START# *47C690130239_47F4D44C01BF_var*
//#UC END# *47C690130239_47F4D44C01BF_var*
begin
//#UC START# *47C690130239_47F4D44C01BF_impl*
 if (Self = nil) then
  Result := false
 else
  Result := DoSetAtom(aView, anIndex, aValue, anOp);
//#UC END# *47C690130239_47F4D44C01BF_impl*
end;//TevLocationBase.SetAtom

function TevLocationBase.ChangeParam(const aView: InevView;
 const aMarker: IevMarker;
 aValue: Integer;
 const anOp: InevOp = nil): Boolean;
//#UC START# *47C6902A0263_47F4D44C01BF_var*
//#UC END# *47C6902A0263_47F4D44C01BF_var*
begin
//#UC START# *47C6902A0263_47F4D44C01BF_impl*
 if (Self = nil) then
  Result := false
 else
  Result := DoChangeParam(aView, aMarker, aValue, anOp);
//#UC END# *47C6902A0263_47F4D44C01BF_impl*
end;//TevLocationBase.ChangeParam

function TevLocationBase.DeleteHyperlink(const anOp: InevOp = nil): Boolean;
//#UC START# *47C690400067_47F4D44C01BF_var*
//#UC END# *47C690400067_47F4D44C01BF_var*
begin
//#UC START# *47C690400067_47F4D44C01BF_impl*
 Result := DoDeleteHyperlink(anOp);
//#UC END# *47C690400067_47F4D44C01BF_impl*
end;//TevLocationBase.DeleteHyperlink

function TevLocationBase.DeleteSegments(const anOp: InevOp = nil): Boolean;
 {* удаляет сегменты. }
//#UC START# *47C6904C01B8_47F4D44C01BF_var*
//#UC END# *47C6904C01B8_47F4D44C01BF_var*
begin
//#UC START# *47C6904C01B8_47F4D44C01BF_impl*
 Result := DoDeleteSegments(anOp);
//#UC END# *47C6904C01B8_47F4D44C01BF_impl*
end;//TevLocationBase.DeleteSegments

function TevLocationBase.Select(const Selection: InevSelection): Boolean;
 {* перемещает Selection на данную метку. }
//#UC START# *47C7DE650012_47F4D44C01BF_var*
//#UC END# *47C7DE650012_47F4D44C01BF_var*
begin
//#UC START# *47C7DE650012_47F4D44C01BF_impl*
 if (Selection = nil) then
  Result := false
 else
  Result := Selection.SelectPoint(AsPoint, true);
//#UC END# *47C7DE650012_47F4D44C01BF_impl*
end;//TevLocationBase.Select

function TevLocationBase.AddIndentMarker(const aView: InevView;
 aValue: Integer;
 const anOpPack: InevOp = nil): Boolean;
//#UC START# *48DCAFCF0379_47F4D44C01BF_var*
//#UC END# *48DCAFCF0379_47F4D44C01BF_var*
begin
//#UC START# *48DCAFCF0379_47F4D44C01BF_impl*
 if (Self = nil) then
  Result := false
 else
  Result := DoAddIndentMarker(aView, aValue, anOpPack);
//#UC END# *48DCAFCF0379_47F4D44C01BF_impl*
end;//TevLocationBase.AddIndentMarker

function TevLocationBase.DeleteIndentMarker(const aView: InevView;
 const anOpPack: InevOp = nil): Boolean;
//#UC START# *48DCB01401C8_47F4D44C01BF_var*
//#UC END# *48DCB01401C8_47F4D44C01BF_var*
begin
//#UC START# *48DCB01401C8_47F4D44C01BF_impl*
 if (Self = nil) then
  Result := false
 else
  Result := DoDeleteIndentMarker(aView, anOpPack);
//#UC END# *48DCB01401C8_47F4D44C01BF_impl*
end;//TevLocationBase.DeleteIndentMarker

function TevLocationBase.Get_Obj: PInevObject;
//#UC START# *49DDD02D00E3_47F4D44C01BFget_var*
//#UC END# *49DDD02D00E3_47F4D44C01BFget_var*
begin
//#UC START# *49DDD02D00E3_47F4D44C01BFget_impl*
 Result := @f_ParaX;
//#UC END# *49DDD02D00E3_47F4D44C01BFget_impl*
end;//TevLocationBase.Get_Obj

function TevLocationBase.pm_GetText: InevText;
//#UC START# *49E6FB10002A_47F4D44C01BFget_var*
//#UC END# *49E6FB10002A_47F4D44C01BFget_var*
begin
//#UC START# *49E6FB10002A_47F4D44C01BFget_impl*
 Result := GetText;
//#UC END# *49E6FB10002A_47F4D44C01BFget_impl*
end;//TevLocationBase.pm_GetText

function TevLocationBase.AsPoint: InevBasePoint;
//#UC START# *4A5C6DB4014D_47F4D44C01BF_var*
//#UC END# *4A5C6DB4014D_47F4D44C01BF_var*
begin
//#UC START# *4A5C6DB4014D_47F4D44C01BF_impl*
 Result := GetAsPoint;
//#UC END# *4A5C6DB4014D_47F4D44C01BF_impl*
end;//TevLocationBase.AsPoint
{$IfEnd} // Defined(evUseVisibleCursors)

end.
