unit evMultiSelectionText;

// ћодуль: "w:\common\components\gui\Garant\Everest\evMultiSelectionText.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TevMultiSelectionText" MUID: (48ECDF6602FD)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evMultiSelectionDataFormatting
 , nevTools
 , l3Variant
 , l3Interfaces
 , nevBase
;

type
 TevMultiSelectionText = class(TevMultiSelectionDataFormatting, InevTextModify, InevText)
  protected
   function CanBeDeleted: Boolean;
   function Modify: InevTextModify;
   function InsertString(const aView: InevView;
    const aString: Il3CString;
    const anOp: InevOp = nil;
    InsertMode: Boolean = True;
    aFlags: TnevInsertStringFlags = []): Boolean;
    {* вставл€ет строку. }
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
    {* удал€ет строку. }
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
   function GetText: InevText; override;
 end;//TevMultiSelectionText

implementation

uses
 l3ImplUses
 , k2Base
 //#UC START# *48ECDF6602FDimpl_uses*
 //#UC END# *48ECDF6602FDimpl_uses*
;

function TevMultiSelectionText.CanBeDeleted: Boolean;
//#UC START# *47C5B23101DE_48ECDF6602FD_var*
//#UC END# *47C5B23101DE_48ECDF6602FD_var*
begin
//#UC START# *47C5B23101DE_48ECDF6602FD_impl*
 Result := False;
//#UC END# *47C5B23101DE_48ECDF6602FD_impl*
end;//TevMultiSelectionText.CanBeDeleted

function TevMultiSelectionText.Modify: InevTextModify;
//#UC START# *47C5B23D0301_48ECDF6602FD_var*
//#UC END# *47C5B23D0301_48ECDF6602FD_var*
begin
//#UC START# *47C5B23D0301_48ECDF6602FD_impl*
 Result := Self;
//#UC END# *47C5B23D0301_48ECDF6602FD_impl*
end;//TevMultiSelectionText.Modify

function TevMultiSelectionText.InsertString(const aView: InevView;
 const aString: Il3CString;
 const anOp: InevOp = nil;
 InsertMode: Boolean = True;
 aFlags: TnevInsertStringFlags = []): Boolean;
 {* вставл€ет строку. }
//#UC START# *47C5B31203AD_48ECDF6602FD_var*
//#UC END# *47C5B31203AD_48ECDF6602FD_var*
begin
//#UC START# *47C5B31203AD_48ECDF6602FD_impl*
 Result := false;
//#UC END# *47C5B31203AD_48ECDF6602FD_impl*
end;//TevMultiSelectionText.InsertString

function TevMultiSelectionText.InsertStream(const aView: InevView;
 const aStream: IStream;
 aFormat: TnevFormat;
 const anOp: InevOp = nil;
 aFlags: TevLoadFlags = nevBase.evDefaultLoadFlags;
 aCodePage: Integer = CP_DefaultValue): Boolean;
//#UC START# *47C5B3410044_48ECDF6602FD_var*
//#UC END# *47C5B3410044_48ECDF6602FD_var*
begin
//#UC START# *47C5B3410044_48ECDF6602FD_impl*
 Result := false;
//#UC END# *47C5B3410044_48ECDF6602FD_impl*
end;//TevMultiSelectionText.InsertStream

function TevMultiSelectionText.DeleteString(const aView: InevView;
 Count: Integer;
 const anOp: InevOp = nil;
 aFlags: TnevInsertStringFlags = []): Boolean;
 {* удал€ет строку. }
//#UC START# *47C5B48E01CF_48ECDF6602FD_var*
//#UC END# *47C5B48E01CF_48ECDF6602FD_var*
begin
//#UC START# *47C5B48E01CF_48ECDF6602FD_impl*
 Result := false;
//#UC END# *47C5B48E01CF_48ECDF6602FD_impl*
end;//TevMultiSelectionText.DeleteString

function TevMultiSelectionText.DeleteChar(const aView: InevView;
 aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *47C5B4A30392_48ECDF6602FD_var*
//#UC END# *47C5B4A30392_48ECDF6602FD_var*
begin
//#UC START# *47C5B4A30392_48ECDF6602FD_impl*
 Result := false;
//#UC END# *47C5B4A30392_48ECDF6602FD_impl*
end;//TevMultiSelectionText.DeleteChar

function TevMultiSelectionText.InsertBreak(const aView: InevView;
 aDrawLines: Boolean = False;
 const anOp: InevOp = nil): Boolean;
//#UC START# *47C5B4B10123_48ECDF6602FD_var*
//#UC END# *47C5B4B10123_48ECDF6602FD_var*
begin
//#UC START# *47C5B4B10123_48ECDF6602FD_impl*
 Result := false;
//#UC END# *47C5B4B10123_48ECDF6602FD_impl*
end;//TevMultiSelectionText.InsertBreak

function TevMultiSelectionText.DeleteCharToLeft(const aView: InevView;
 aDrawLines: Boolean = False;
 const anOp: InevOp = nil): Boolean;
//#UC START# *47C5B4BF021F_48ECDF6602FD_var*
//#UC END# *47C5B4BF021F_48ECDF6602FD_var*
begin
//#UC START# *47C5B4BF021F_48ECDF6602FD_impl*
 Result := false;
//#UC END# *47C5B4BF021F_48ECDF6602FD_impl*
end;//TevMultiSelectionText.DeleteCharToLeft

function TevMultiSelectionText.Split(const aView: InevView;
 aFlags: TnevInsertStringFlags;
 const anOp: InevOp): Il3TagRef;
//#UC START# *47C5B4CF00D0_48ECDF6602FD_var*
//#UC END# *47C5B4CF00D0_48ECDF6602FD_var*
begin
//#UC START# *47C5B4CF00D0_48ECDF6602FD_impl*
 Result := Tl3NullTag.Instance;
//#UC END# *47C5B4CF00D0_48ECDF6602FD_impl*
end;//TevMultiSelectionText.Split

function TevMultiSelectionText.JoinWith(const aView: InevView;
 aSecondPara: Tl3Variant;
 const anOp: InevOp = nil;
 MoveSubs: Boolean = True): Integer;
//#UC START# *47C5B4E001F9_48ECDF6602FD_var*
//#UC END# *47C5B4E001F9_48ECDF6602FD_var*
begin
//#UC START# *47C5B4E001F9_48ECDF6602FD_impl*
 Result := 1;
//#UC END# *47C5B4E001F9_48ECDF6602FD_impl*
end;//TevMultiSelectionText.JoinWith

function TevMultiSelectionText.JoinWithNext(const aView: InevView;
 const anOp: InevOp = nil): Boolean;
//#UC START# *47C5B4FA0219_48ECDF6602FD_var*
//#UC END# *47C5B4FA0219_48ECDF6602FD_var*
begin
//#UC START# *47C5B4FA0219_48ECDF6602FD_impl*
 Result := false;
//#UC END# *47C5B4FA0219_48ECDF6602FD_impl*
end;//TevMultiSelectionText.JoinWithNext

function TevMultiSelectionText.GetText: InevText;
//#UC START# *48ECD288024B_48ECDF6602FD_var*
//#UC END# *48ECD288024B_48ECDF6602FD_var*
begin
//#UC START# *48ECD288024B_48ECDF6602FD_impl*
 Result := Self;
//#UC END# *48ECD288024B_48ECDF6602FD_impl*
end;//TevMultiSelectionText.GetText

end.
