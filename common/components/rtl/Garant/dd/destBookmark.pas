unit destBookmark;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "dd"
// ������: "w:/common/components/rtl/Garant/dd/destBookmark.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::RTFSupport::TdestBookmark
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3Base,
  ddRTFdestination,
  ddRTFState,
  ddCustomRTFReader,
  RTFtypes
  ;

type
 TdestBookmark = class(TddRTFDestination)
 private
 // private fields
   f_Text : Tl3String;
 protected
 // realized methods
   procedure Close(aState: TddRTFState;
     aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
     aText: Tl3String;
     aState: TddRTFState); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 public
 // overridden public methods
   procedure Clear; override;
   procedure AddAnsiChar(aText: AnsiChar;
     aState: TddRTFState); override;
   procedure AddString(aText: Tl3String;
     aState: TddRTFState); override;
   constructor Create(aRTFReader: TddCustomRTFReader); override;
 end;//TdestBookmark

implementation

uses
  destNorm,
  SysUtils
  ;

// start class TdestBookmark

procedure TdestBookmark.Close(aState: TddRTFState;
  aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_56A9F17B003C_var*
//#UC END# *5461BEC2017D_56A9F17B003C_var*
begin
//#UC START# *5461BEC2017D_56A9F17B003C_impl*
 if (aNewDest.RDS <> RDS) and (aNewDest is TdestNorm) then
 begin
  TdestNorm(aNewDest).AddSub(aState, f_Text);
  Clear;
 end; // if (aNewDest.RDS <> RDS) and (aNewDest is TdestNorm) then
//#UC END# *5461BEC2017D_56A9F17B003C_impl*
end;//TdestBookmark.Close

procedure TdestBookmark.WriteText(aRDS: TRDS;
  aText: Tl3String;
  aState: TddRTFState);
//#UC START# *54E1F08400F9_56A9F17B003C_var*
//#UC END# *54E1F08400F9_56A9F17B003C_var*
begin
//#UC START# *54E1F08400F9_56A9F17B003C_impl*
//#UC END# *54E1F08400F9_56A9F17B003C_impl*
end;//TdestBookmark.WriteText

procedure TdestBookmark.Cleanup;
//#UC START# *479731C50290_56A9F17B003C_var*
//#UC END# *479731C50290_56A9F17B003C_var*
begin
//#UC START# *479731C50290_56A9F17B003C_impl*
 FreeAndNil(f_Text);
 inherited;
//#UC END# *479731C50290_56A9F17B003C_impl*
end;//TdestBookmark.Cleanup

procedure TdestBookmark.Clear;
//#UC START# *51D27A48038E_56A9F17B003C_var*
//#UC END# *51D27A48038E_56A9F17B003C_var*
begin
//#UC START# *51D27A48038E_56A9F17B003C_impl*
 inherited;
 f_Text.Clear;
//#UC END# *51D27A48038E_56A9F17B003C_impl*
end;//TdestBookmark.Clear

procedure TdestBookmark.AddAnsiChar(aText: AnsiChar;
  aState: TddRTFState);
//#UC START# *51D27C0402E9_56A9F17B003C_var*
//#UC END# *51D27C0402E9_56A9F17B003C_var*
begin
//#UC START# *51D27C0402E9_56A9F17B003C_impl*
 f_Text.Append(aText);
//#UC END# *51D27C0402E9_56A9F17B003C_impl*
end;//TdestBookmark.AddAnsiChar

procedure TdestBookmark.AddString(aText: Tl3String;
  aState: TddRTFState);
//#UC START# *51D27C3302EC_56A9F17B003C_var*
//#UC END# *51D27C3302EC_56A9F17B003C_var*
begin
//#UC START# *51D27C3302EC_56A9F17B003C_impl*
 f_Text.JoinWith(aText);
//#UC END# *51D27C3302EC_56A9F17B003C_impl*
end;//TdestBookmark.AddString

constructor TdestBookmark.Create(aRTFReader: TddCustomRTFReader);
//#UC START# *51E7C9DB0213_56A9F17B003C_var*
//#UC END# *51E7C9DB0213_56A9F17B003C_var*
begin
//#UC START# *51E7C9DB0213_56A9F17B003C_impl*
 inherited;
 f_Text := Tl3String.Create;
//#UC END# *51E7C9DB0213_56A9F17B003C_impl*
end;//TdestBookmark.Create

end.