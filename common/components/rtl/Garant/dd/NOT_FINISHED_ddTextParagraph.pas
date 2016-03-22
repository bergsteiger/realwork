unit NOT_FINISHED_ddTextParagraph;

// Модуль: "w:\common\components\rtl\Garant\dd\NOT_FINISHED_ddTextParagraph.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddTextParagraph" MUID: (51E8DBEC0212)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddDocumentAtom
 , ddCharacterProperty
 , ddParagraphProperty
 , ddTextSegmentsList
 , ddSubsList
 , l3Base
 , ddTextSegment
 , k2Interfaces
 , rtfListTable
 , ddTypes
 , ddCustomDestination
 , l3ProtoObject
;

type
 TddTextParagraph = class(TddDocumentAtom)
  private
   f_ItemText: Tl3String;
   f_Offset: Integer;
   f_CHP: TddCharacterProperty;
    {* Поле для свойства CHP }
   f_CharacterStyle: LongInt;
    {* Поле для свойства CharacterStyle }
   f_ID: LongInt;
    {* Поле для свойства ID }
   f_PAP: TddParagraphProperty;
    {* Поле для свойства PAP }
   f_SegmentList: TddTextSegmentsList;
    {* Поле для свойства SegmentList }
   f_SubList: TddSubsList;
    {* Поле для свойства SubList }
   f_Text: Tl3String;
    {* Поле для свойства Text }
   f_Width: Integer;
    {* Поле для свойства Width }
   f_Unicode: Boolean;
    {* Поле для свойства Unicode }
  private
   procedure Process;
   procedure CheckListItem;
   function CheckInTable(const Generator: Ik2TagGenerator;
    const LiteVersion: Boolean = False): Boolean;
   procedure WriteHyperlinks(const Generator: Ik2TagGenerator);
   function WritePAP(const Generator: Ik2TagGenerator;
    LiteVersion: Boolean;
    aStyled: Boolean): Boolean;
   procedure WriteSegments(const Generator: Ik2TagGenerator);
   procedure WriteTabStops(const Generator: Ik2TagGenerator);
  protected
   procedure pm_SetCHP(aValue: TddCharacterProperty);
   procedure pm_SetPAP(aValue: TddParagraphProperty);
   function pm_GetSegmentCount: LongInt;
   function pm_GetSegmentList: TddTextSegmentsList;
   function pm_GetText: Tl3String;
   procedure pm_SetText(aValue: Tl3String);
   function pm_Getf_Inc: Integer;
   procedure pm_Setf_Inc(aValue: Integer);
   function pm_GetSegments(anIndex: Integer): TddTextSegment;
   procedure CheckSegments;
   procedure WriteSubs(const aGenerator: Ik2TagGenerator);
   procedure AddOldListItem;
   procedure ClearOldListItem;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetEmpty: Boolean; override;
  public
   procedure AddItemText(const aItemText: AnsiString);
    {* Добавить текст пункта, как в Word 6/95. }
   procedure AddHyperlink(const aText: AnsiString;
    aDocID: Integer;
    aSubID: Integer);
   procedure AddListIndex(aList: TrtfList;
    aLite: Boolean);
   procedure AddPicture(aPicture: TddDocumentAtom);
   procedure AddSegment(aCHP: TddCharacterProperty;
    const RelativeToText: Boolean = False); overload;
   procedure AddSegment(aSegment: TddTextSegment); overload;
   procedure AddSub(aSubID: Integer;
    const aName: AnsiString;
    aIsRealName: Boolean = True);
   procedure ApplyCHP(aCHP: TddCharacterProperty);
   procedure ApplyPAP(aPAP: TddParagraphProperty);
   procedure CorrectSegments(aPrevPara: TddTextParagraph);
   function DeleteLastSegment: Boolean;
   function HaveHyperlinks: Boolean;
   function HaveObjects: Boolean;
   function HaveSegments: Boolean;
   function HyperlinkByCharIndex(Index: LongInt;
    const EndSegment: Boolean = False): TddTextSegment;
   function ObjectByCharIndex(Index: LongInt;
    const EndSegment: Boolean = False): TddTextSegment;
   function LastSegment: TddTextSegment;
   procedure PackSegments;
   function PrevCHP(aCurSegment: TddTextSegment): TddCharacterProperty;
   function SegmentByCharIndex(Index: LongInt;
    const EndSegment: Boolean = False;
    const StartIndex: Integer = -1): TddTextSegment;
   procedure Write2Generator(const Generator: Ik2TagGenerator;
    aNeedProcessRow: Boolean;
    LiteVersion: TddLiteVersion); override;
   function JoinWith(P: TObject;
    aCorrectSegment: Boolean = False): Integer; override;
   constructor Create(aDetination: TddCustomDestination); override;
   function HasSoftEnter: Boolean; override;
   function IsTextPara: Boolean; override;
   function GetLastPara: TddDocumentAtom; override;
   procedure Assign(const aDocAtomObj: Tl3ProtoObject); override;
  private
   property f_Inc: Integer
    read pm_Getf_Inc
    write pm_Setf_Inc;
  public
   property CHP: TddCharacterProperty
    read f_CHP
    write pm_SetCHP;
   property CharacterStyle: LongInt
    read f_CharacterStyle
    write f_CharacterStyle;
   property ID: LongInt
    read f_ID
    write f_ID;
   property PAP: TddParagraphProperty
    read f_PAP
    write pm_SetPAP;
   property SegmentCount: LongInt
    read pm_GetSegmentCount;
   property SegmentList: TddTextSegmentsList
    read pm_GetSegmentList;
   property SubList: TddSubsList
    read f_SubList
    write f_SubList;
   property Text: Tl3String
    read pm_GetText
    write pm_SetText;
   property Width: Integer
    read f_Width
    write f_Width;
   property Unicode: Boolean
    read f_Unicode
    write f_Unicode;
   property Segments[anIndex: Integer]: TddTextSegment
    read pm_GetSegments;
 end;//TddTextParagraph

implementation

uses
 l3ImplUses
 , ddTextParaString
;

procedure TddTextParagraph.pm_SetCHP(aValue: TddCharacterProperty);
//#UC START# *534F94C90349_4FACE14F0231set_var*
//#UC END# *534F94C90349_4FACE14F0231set_var*
begin
//#UC START# *534F94C90349_4FACE14F0231set_impl*
 !!! Needs to be implemented !!!
//#UC END# *534F94C90349_4FACE14F0231set_impl*
end;//TddTextParagraph.pm_SetCHP

procedure TddTextParagraph.pm_SetPAP(aValue: TddParagraphProperty);
//#UC START# *534FAB090274_4FACE14F0231set_var*
//#UC END# *534FAB090274_4FACE14F0231set_var*
begin
//#UC START# *534FAB090274_4FACE14F0231set_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FAB090274_4FACE14F0231set_impl*
end;//TddTextParagraph.pm_SetPAP

function TddTextParagraph.pm_GetSegmentCount: LongInt;
//#UC START# *534FAB2A025A_4FACE14F0231get_var*
//#UC END# *534FAB2A025A_4FACE14F0231get_var*
begin
//#UC START# *534FAB2A025A_4FACE14F0231get_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FAB2A025A_4FACE14F0231get_impl*
end;//TddTextParagraph.pm_GetSegmentCount

function TddTextParagraph.pm_GetSegmentList: TddTextSegmentsList;
//#UC START# *534FAD0D0319_4FACE14F0231get_var*
//#UC END# *534FAD0D0319_4FACE14F0231get_var*
begin
//#UC START# *534FAD0D0319_4FACE14F0231get_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FAD0D0319_4FACE14F0231get_impl*
end;//TddTextParagraph.pm_GetSegmentList

function TddTextParagraph.pm_GetText: Tl3String;
//#UC START# *534FAE7C0182_4FACE14F0231get_var*
//#UC END# *534FAE7C0182_4FACE14F0231get_var*
begin
//#UC START# *534FAE7C0182_4FACE14F0231get_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FAE7C0182_4FACE14F0231get_impl*
end;//TddTextParagraph.pm_GetText

procedure TddTextParagraph.pm_SetText(aValue: Tl3String);
//#UC START# *534FAE7C0182_4FACE14F0231set_var*
//#UC END# *534FAE7C0182_4FACE14F0231set_var*
begin
//#UC START# *534FAE7C0182_4FACE14F0231set_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FAE7C0182_4FACE14F0231set_impl*
end;//TddTextParagraph.pm_SetText

function TddTextParagraph.pm_Getf_Inc: Integer;
//#UC START# *534FB22101FE_4FACE14F0231get_var*
//#UC END# *534FB22101FE_4FACE14F0231get_var*
begin
//#UC START# *534FB22101FE_4FACE14F0231get_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB22101FE_4FACE14F0231get_impl*
end;//TddTextParagraph.pm_Getf_Inc

procedure TddTextParagraph.pm_Setf_Inc(aValue: Integer);
//#UC START# *534FB22101FE_4FACE14F0231set_var*
//#UC END# *534FB22101FE_4FACE14F0231set_var*
begin
//#UC START# *534FB22101FE_4FACE14F0231set_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB22101FE_4FACE14F0231set_impl*
end;//TddTextParagraph.pm_Setf_Inc

function TddTextParagraph.pm_GetSegments(anIndex: Integer): TddTextSegment;
//#UC START# *534FB2940195_4FACE14F0231get_var*
//#UC END# *534FB2940195_4FACE14F0231get_var*
begin
//#UC START# *534FB2940195_4FACE14F0231get_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB2940195_4FACE14F0231get_impl*
end;//TddTextParagraph.pm_GetSegments

procedure TddTextParagraph.Process;
//#UC START# *534FB2F6005C_4FACE14F0231_var*
//#UC END# *534FB2F6005C_4FACE14F0231_var*
begin
//#UC START# *534FB2F6005C_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB2F6005C_4FACE14F0231_impl*
end;//TddTextParagraph.Process

procedure TddTextParagraph.CheckListItem;
//#UC START# *534FB31400D8_4FACE14F0231_var*
//#UC END# *534FB31400D8_4FACE14F0231_var*
begin
//#UC START# *534FB31400D8_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB31400D8_4FACE14F0231_impl*
end;//TddTextParagraph.CheckListItem

function TddTextParagraph.CheckInTable(const Generator: Ik2TagGenerator;
 const LiteVersion: Boolean = False): Boolean;
//#UC START# *534FB35501E0_4FACE14F0231_var*
//#UC END# *534FB35501E0_4FACE14F0231_var*
begin
//#UC START# *534FB35501E0_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB35501E0_4FACE14F0231_impl*
end;//TddTextParagraph.CheckInTable

procedure TddTextParagraph.WriteHyperlinks(const Generator: Ik2TagGenerator);
//#UC START# *534FB38B0225_4FACE14F0231_var*
//#UC END# *534FB38B0225_4FACE14F0231_var*
begin
//#UC START# *534FB38B0225_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB38B0225_4FACE14F0231_impl*
end;//TddTextParagraph.WriteHyperlinks

function TddTextParagraph.WritePAP(const Generator: Ik2TagGenerator;
 LiteVersion: Boolean;
 aStyled: Boolean): Boolean;
//#UC START# *534FB3BA00C5_4FACE14F0231_var*
//#UC END# *534FB3BA00C5_4FACE14F0231_var*
begin
//#UC START# *534FB3BA00C5_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB3BA00C5_4FACE14F0231_impl*
end;//TddTextParagraph.WritePAP

procedure TddTextParagraph.WriteSegments(const Generator: Ik2TagGenerator);
//#UC START# *534FB3F001B8_4FACE14F0231_var*
//#UC END# *534FB3F001B8_4FACE14F0231_var*
begin
//#UC START# *534FB3F001B8_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB3F001B8_4FACE14F0231_impl*
end;//TddTextParagraph.WriteSegments

procedure TddTextParagraph.WriteTabStops(const Generator: Ik2TagGenerator);
//#UC START# *534FB41A02CC_4FACE14F0231_var*
//#UC END# *534FB41A02CC_4FACE14F0231_var*
begin
//#UC START# *534FB41A02CC_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB41A02CC_4FACE14F0231_impl*
end;//TddTextParagraph.WriteTabStops

procedure TddTextParagraph.CheckSegments;
//#UC START# *534FB45703D6_4FACE14F0231_var*
//#UC END# *534FB45703D6_4FACE14F0231_var*
begin
//#UC START# *534FB45703D6_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB45703D6_4FACE14F0231_impl*
end;//TddTextParagraph.CheckSegments

procedure TddTextParagraph.WriteSubs(const aGenerator: Ik2TagGenerator);
//#UC START# *534FB48603A8_4FACE14F0231_var*
//#UC END# *534FB48603A8_4FACE14F0231_var*
begin
//#UC START# *534FB48603A8_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB48603A8_4FACE14F0231_impl*
end;//TddTextParagraph.WriteSubs

procedure TddTextParagraph.AddOldListItem;
//#UC START# *534FB4AB013F_4FACE14F0231_var*
//#UC END# *534FB4AB013F_4FACE14F0231_var*
begin
//#UC START# *534FB4AB013F_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB4AB013F_4FACE14F0231_impl*
end;//TddTextParagraph.AddOldListItem

procedure TddTextParagraph.ClearOldListItem;
//#UC START# *534FB4C5005B_4FACE14F0231_var*
//#UC END# *534FB4C5005B_4FACE14F0231_var*
begin
//#UC START# *534FB4C5005B_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB4C5005B_4FACE14F0231_impl*
end;//TddTextParagraph.ClearOldListItem

procedure TddTextParagraph.AddItemText(const aItemText: AnsiString);
 {* Добавить текст пункта, как в Word 6/95. }
//#UC START# *534FB4E801F5_4FACE14F0231_var*
//#UC END# *534FB4E801F5_4FACE14F0231_var*
begin
//#UC START# *534FB4E801F5_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB4E801F5_4FACE14F0231_impl*
end;//TddTextParagraph.AddItemText

procedure TddTextParagraph.AddHyperlink(const aText: AnsiString;
 aDocID: Integer;
 aSubID: Integer);
//#UC START# *534FB516039F_4FACE14F0231_var*
//#UC END# *534FB516039F_4FACE14F0231_var*
begin
//#UC START# *534FB516039F_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB516039F_4FACE14F0231_impl*
end;//TddTextParagraph.AddHyperlink

procedure TddTextParagraph.AddListIndex(aList: TrtfList;
 aLite: Boolean);
//#UC START# *534FB54003B5_4FACE14F0231_var*
//#UC END# *534FB54003B5_4FACE14F0231_var*
begin
//#UC START# *534FB54003B5_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB54003B5_4FACE14F0231_impl*
end;//TddTextParagraph.AddListIndex

procedure TddTextParagraph.AddPicture(aPicture: TddDocumentAtom);
//#UC START# *534FB563027E_4FACE14F0231_var*
//#UC END# *534FB563027E_4FACE14F0231_var*
begin
//#UC START# *534FB563027E_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB563027E_4FACE14F0231_impl*
end;//TddTextParagraph.AddPicture

procedure TddTextParagraph.AddSegment(aCHP: TddCharacterProperty;
 const RelativeToText: Boolean = False);
//#UC START# *534FB5B00167_4FACE14F0231_var*
//#UC END# *534FB5B00167_4FACE14F0231_var*
begin
//#UC START# *534FB5B00167_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB5B00167_4FACE14F0231_impl*
end;//TddTextParagraph.AddSegment

procedure TddTextParagraph.AddSegment(aSegment: TddTextSegment);
//#UC START# *534FB5DE0045_4FACE14F0231_var*
//#UC END# *534FB5DE0045_4FACE14F0231_var*
begin
//#UC START# *534FB5DE0045_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FB5DE0045_4FACE14F0231_impl*
end;//TddTextParagraph.AddSegment

procedure TddTextParagraph.AddSub(aSubID: Integer;
 const aName: AnsiString;
 aIsRealName: Boolean = True);
//#UC START# *534FC3A90391_4FACE14F0231_var*
//#UC END# *534FC3A90391_4FACE14F0231_var*
begin
//#UC START# *534FC3A90391_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FC3A90391_4FACE14F0231_impl*
end;//TddTextParagraph.AddSub

procedure TddTextParagraph.ApplyCHP(aCHP: TddCharacterProperty);
//#UC START# *534FC3F9001C_4FACE14F0231_var*
//#UC END# *534FC3F9001C_4FACE14F0231_var*
begin
//#UC START# *534FC3F9001C_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FC3F9001C_4FACE14F0231_impl*
end;//TddTextParagraph.ApplyCHP

procedure TddTextParagraph.ApplyPAP(aPAP: TddParagraphProperty);
//#UC START# *534FC4190249_4FACE14F0231_var*
//#UC END# *534FC4190249_4FACE14F0231_var*
begin
//#UC START# *534FC4190249_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FC4190249_4FACE14F0231_impl*
end;//TddTextParagraph.ApplyPAP

procedure TddTextParagraph.CorrectSegments(aPrevPara: TddTextParagraph);
//#UC START# *534FC43F03A0_4FACE14F0231_var*
//#UC END# *534FC43F03A0_4FACE14F0231_var*
begin
//#UC START# *534FC43F03A0_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FC43F03A0_4FACE14F0231_impl*
end;//TddTextParagraph.CorrectSegments

function TddTextParagraph.DeleteLastSegment: Boolean;
//#UC START# *534FC46A03D2_4FACE14F0231_var*
//#UC END# *534FC46A03D2_4FACE14F0231_var*
begin
//#UC START# *534FC46A03D2_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FC46A03D2_4FACE14F0231_impl*
end;//TddTextParagraph.DeleteLastSegment

function TddTextParagraph.HaveHyperlinks: Boolean;
//#UC START# *534FC48A0324_4FACE14F0231_var*
//#UC END# *534FC48A0324_4FACE14F0231_var*
begin
//#UC START# *534FC48A0324_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FC48A0324_4FACE14F0231_impl*
end;//TddTextParagraph.HaveHyperlinks

function TddTextParagraph.HaveObjects: Boolean;
//#UC START# *534FC4C10046_4FACE14F0231_var*
//#UC END# *534FC4C10046_4FACE14F0231_var*
begin
//#UC START# *534FC4C10046_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FC4C10046_4FACE14F0231_impl*
end;//TddTextParagraph.HaveObjects

function TddTextParagraph.HaveSegments: Boolean;
//#UC START# *534FC4DE03A0_4FACE14F0231_var*
//#UC END# *534FC4DE03A0_4FACE14F0231_var*
begin
//#UC START# *534FC4DE03A0_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FC4DE03A0_4FACE14F0231_impl*
end;//TddTextParagraph.HaveSegments

function TddTextParagraph.HyperlinkByCharIndex(Index: LongInt;
 const EndSegment: Boolean = False): TddTextSegment;
//#UC START# *534FC50503DE_4FACE14F0231_var*
//#UC END# *534FC50503DE_4FACE14F0231_var*
begin
//#UC START# *534FC50503DE_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FC50503DE_4FACE14F0231_impl*
end;//TddTextParagraph.HyperlinkByCharIndex

function TddTextParagraph.ObjectByCharIndex(Index: LongInt;
 const EndSegment: Boolean = False): TddTextSegment;
//#UC START# *534FC52F0030_4FACE14F0231_var*
//#UC END# *534FC52F0030_4FACE14F0231_var*
begin
//#UC START# *534FC52F0030_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FC52F0030_4FACE14F0231_impl*
end;//TddTextParagraph.ObjectByCharIndex

function TddTextParagraph.LastSegment: TddTextSegment;
//#UC START# *534FC553015D_4FACE14F0231_var*
//#UC END# *534FC553015D_4FACE14F0231_var*
begin
//#UC START# *534FC553015D_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FC553015D_4FACE14F0231_impl*
end;//TddTextParagraph.LastSegment

procedure TddTextParagraph.PackSegments;
//#UC START# *534FC57001F5_4FACE14F0231_var*
//#UC END# *534FC57001F5_4FACE14F0231_var*
begin
//#UC START# *534FC57001F5_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FC57001F5_4FACE14F0231_impl*
end;//TddTextParagraph.PackSegments

function TddTextParagraph.PrevCHP(aCurSegment: TddTextSegment): TddCharacterProperty;
//#UC START# *534FC58D0282_4FACE14F0231_var*
//#UC END# *534FC58D0282_4FACE14F0231_var*
begin
//#UC START# *534FC58D0282_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FC58D0282_4FACE14F0231_impl*
end;//TddTextParagraph.PrevCHP

function TddTextParagraph.SegmentByCharIndex(Index: LongInt;
 const EndSegment: Boolean = False;
 const StartIndex: Integer = -1): TddTextSegment;
//#UC START# *534FC5AF022B_4FACE14F0231_var*
//#UC END# *534FC5AF022B_4FACE14F0231_var*
begin
//#UC START# *534FC5AF022B_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *534FC5AF022B_4FACE14F0231_impl*
end;//TddTextParagraph.SegmentByCharIndex

procedure TddTextParagraph.Write2Generator(const Generator: Ik2TagGenerator;
 aNeedProcessRow: Boolean;
 LiteVersion: TddLiteVersion);
//#UC START# *518A504F00F5_4FACE14F0231_var*
//#UC END# *518A504F00F5_4FACE14F0231_var*
begin
//#UC START# *518A504F00F5_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *518A504F00F5_4FACE14F0231_impl*
end;//TddTextParagraph.Write2Generator

procedure TddTextParagraph.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4FACE14F0231_var*
//#UC END# *479731C50290_4FACE14F0231_var*
begin
//#UC START# *479731C50290_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_4FACE14F0231_impl*
end;//TddTextParagraph.Cleanup

function TddTextParagraph.GetEmpty: Boolean;
//#UC START# *4A54E03B009A_4FACE14F0231_var*
//#UC END# *4A54E03B009A_4FACE14F0231_var*
begin
//#UC START# *4A54E03B009A_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A54E03B009A_4FACE14F0231_impl*
end;//TddTextParagraph.GetEmpty

function TddTextParagraph.JoinWith(P: TObject;
 aCorrectSegment: Boolean = False): Integer;
//#UC START# *51921142034B_4FACE14F0231_var*
//#UC END# *51921142034B_4FACE14F0231_var*
begin
//#UC START# *51921142034B_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *51921142034B_4FACE14F0231_impl*
end;//TddTextParagraph.JoinWith

constructor TddTextParagraph.Create(aDetination: TddCustomDestination);
//#UC START# *51E91BA80051_4FACE14F0231_var*
//#UC END# *51E91BA80051_4FACE14F0231_var*
begin
//#UC START# *51E91BA80051_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *51E91BA80051_4FACE14F0231_impl*
end;//TddTextParagraph.Create

function TddTextParagraph.HasSoftEnter: Boolean;
//#UC START# *52662EA90016_4FACE14F0231_var*
//#UC END# *52662EA90016_4FACE14F0231_var*
begin
//#UC START# *52662EA90016_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *52662EA90016_4FACE14F0231_impl*
end;//TddTextParagraph.HasSoftEnter

function TddTextParagraph.IsTextPara: Boolean;
//#UC START# *5268D5950076_4FACE14F0231_var*
//#UC END# *5268D5950076_4FACE14F0231_var*
begin
//#UC START# *5268D5950076_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *5268D5950076_4FACE14F0231_impl*
end;//TddTextParagraph.IsTextPara

function TddTextParagraph.GetLastPara: TddDocumentAtom;
//#UC START# *5268DBC503E2_4FACE14F0231_var*
//#UC END# *5268DBC503E2_4FACE14F0231_var*
begin
//#UC START# *5268DBC503E2_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *5268DBC503E2_4FACE14F0231_impl*
end;//TddTextParagraph.GetLastPara

procedure TddTextParagraph.Assign(const aDocAtomObj: Tl3ProtoObject);
//#UC START# *528C8C2F02D9_4FACE14F0231_var*
//#UC END# *528C8C2F02D9_4FACE14F0231_var*
begin
//#UC START# *528C8C2F02D9_4FACE14F0231_impl*
 !!! Needs to be implemented !!!
//#UC END# *528C8C2F02D9_4FACE14F0231_impl*
end;//TddTextParagraph.Assign

end.
