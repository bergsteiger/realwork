unit ddTextSegment;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddTextSegment.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddTextSegment
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  k2Interfaces,
  l3Base,
  l3ProtoDataContainer,
  ddDocumentAtom,
  ddCharacterProperty,
  ddHyperlinkTarget,
  ddHyperlinkTargetList,
  l3ProtoObject
  ;

type
 _ddDocAtomWithAssign_Parent_ = Tl3ProtoDataContainer;
 {$Include ..\dd\ddDocAtomWithAssign.imp.pas}
 TddTextSegment = class(_ddDocAtomWithAssign_)
 private
 // private fields
   f_HLHandle : LongInt;
    {* Поле для свойства HLHandle}
   f_Index : LongInt;
    {* Поле для свойства Index}
   f_Start : LongInt;
    {* Поле для свойства Start}
   f_Stop : LongInt;
    {* Поле для свойства Stop}
   f_Style : LongInt;
    {* Поле для свойства Style}
   f_CHP : TddCharacterProperty;
    {* Поле для свойства CHP}
   f_Data : TddDocumentAtom;
    {* Поле для свойства Data}
   f_URL : Tl3String;
    {* Поле для свойства URL}
   f_TargetList : TddHyperlinkTargetList;
    {* Поле для свойства TargetList}
   f_Opened : Boolean;
    {* Поле для свойства Opened}
 protected
 // property methods
   procedure pm_SetCHP(aValue: TddCharacterProperty);
   procedure pm_SetData(aValue: TddDocumentAtom);
   procedure pm_SetURL(aValue: Tl3String);
   function pm_GetTargets(anIndex: Integer): TddHyperlinkTarget;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   procedure Assign(const aDocAtomObj: Tl3ProtoObject); override;
 protected
 // protected methods
   procedure DoWriteSegmentProps(const Generator: Ik2TagGenerator;
     aCHP: TddCharacterProperty;
     aParentCHP: TddCharacterProperty;
     LiteVersion: Boolean); virtual;
 public
 // public methods
   procedure AddTarget(aDocID: LongInt;
     aSubID: LongInt;
     aTypeID: Integer);
   constructor Create; reintroduce;
     {* Сигнатура метода Create }
   procedure Write2Generator(const Generator: Ik2TagGenerator;
     aCHP: TddCharacterProperty;
     aParentCHP: TddCharacterProperty;
     LiteVersion: Boolean); virtual; abstract;
   function Clone: TddTextSegment; virtual; abstract;
   function SkipSegment(aDiffCHP: TddCharacterProperty;
     LiteVersion: Boolean): Boolean; virtual; abstract;
   function IsHyperlink: Boolean; virtual;
   function IsObjectSegment: Boolean; virtual;
 public
 // public properties
   property HLHandle: LongInt
     read f_HLHandle
     write f_HLHandle;
   property Index: LongInt
     read f_Index
     write f_Index;
   property Start: LongInt
     read f_Start
     write f_Start;
   property Stop: LongInt
     read f_Stop
     write f_Stop;
   property Style: LongInt
     read f_Style
     write f_Style;
   property CHP: TddCharacterProperty
     read f_CHP
     write pm_SetCHP;
   property Data: TddDocumentAtom
     read f_Data
     write pm_SetData;
   property URL: Tl3String
     read f_URL
     write pm_SetURL;
   property Targets[anIndex: Integer]: TddHyperlinkTarget
     read pm_GetTargets;
   property TargetList: TddHyperlinkTargetList
     read f_TargetList;
   property Opened: Boolean
     read f_Opened
     write f_Opened;
 end;//TddTextSegment

implementation

uses
  ddEVDTypesSupport,
  k2Tags,
  ddTypes
  ;

{$Include ..\dd\ddDocAtomWithAssign.imp.pas}

// start class TddTextSegment

procedure TddTextSegment.AddTarget(aDocID: LongInt;
  aSubID: LongInt;
  aTypeID: Integer);
//#UC START# *525D2C2700F3_5111FC5402AA_var*
var
 l_T: TddHyperlinkTarget;
//#UC END# *525D2C2700F3_5111FC5402AA_var*
begin
//#UC START# *525D2C2700F3_5111FC5402AA_impl*
 if aDocID > -1 then
 begin
  l_T:= TddHyperlinkTarget.Create(aTypeID, aDocID, aSubID);
  try
   f_TargetList.Add(l_T);
  finally
   l3Free(l_T);
  end; // l_T
 end;
//#UC END# *525D2C2700F3_5111FC5402AA_impl*
end;//TddTextSegment.AddTarget

constructor TddTextSegment.Create;
//#UC START# *525D2C8D0143_5111FC5402AA_var*
//#UC END# *525D2C8D0143_5111FC5402AA_var*
begin
//#UC START# *525D2C8D0143_5111FC5402AA_impl*
 inherited Create;
 f_CHP := TddCharacterProperty.Create;
 f_TargetList := TddHyperlinkTargetList.Make;
 f_URL := Tl3String.Create;
 f_Start := 0;
 f_Stop := 0;
 f_Style := propUndefined;
 f_HLHandle := -1;
 f_Opened := False;
//#UC END# *525D2C8D0143_5111FC5402AA_impl*
end;//TddTextSegment.Create

procedure TddTextSegment.DoWriteSegmentProps(const Generator: Ik2TagGenerator;
  aCHP: TddCharacterProperty;
  aParentCHP: TddCharacterProperty;
  LiteVersion: Boolean);
//#UC START# *54D9B0300325_5111FC5402AA_var*
//#UC END# *54D9B0300325_5111FC5402AA_var*
begin
//#UC START# *54D9B0300325_5111FC5402AA_impl*
 Generator.AddIntegerAtom(k2_tiStart, Start);
 Generator.AddIntegerAtom(k2_tiFinish, Stop);
 if (CHP.Style <> 0) and (CHP.Style <> propUndefined) then
  Generator.AddIntegerAtom(k2_tiStyle, CHP.Style);
//#UC END# *54D9B0300325_5111FC5402AA_impl*
end;//TddTextSegment.DoWriteSegmentProps

function TddTextSegment.IsHyperlink: Boolean;
//#UC START# *55E004D80069_5111FC5402AA_var*
//#UC END# *55E004D80069_5111FC5402AA_var*
begin
//#UC START# *55E004D80069_5111FC5402AA_impl*
 Result := False;
//#UC END# *55E004D80069_5111FC5402AA_impl*
end;//TddTextSegment.IsHyperlink

function TddTextSegment.IsObjectSegment: Boolean;
//#UC START# *55E013DF03B9_5111FC5402AA_var*
//#UC END# *55E013DF03B9_5111FC5402AA_var*
begin
//#UC START# *55E013DF03B9_5111FC5402AA_impl*
 Result := False;
//#UC END# *55E013DF03B9_5111FC5402AA_impl*
end;//TddTextSegment.IsObjectSegment

procedure TddTextSegment.pm_SetCHP(aValue: TddCharacterProperty);
//#UC START# *525D2DB20127_5111FC5402AAset_var*
//#UC END# *525D2DB20127_5111FC5402AAset_var*
begin
//#UC START# *525D2DB20127_5111FC5402AAset_impl*
 f_CHP.AssignFrom(aValue);
//#UC END# *525D2DB20127_5111FC5402AAset_impl*
end;//TddTextSegment.pm_SetCHP

procedure TddTextSegment.pm_SetData(aValue: TddDocumentAtom);
//#UC START# *525D2DF10141_5111FC5402AAset_var*
//#UC END# *525D2DF10141_5111FC5402AAset_var*
begin
//#UC START# *525D2DF10141_5111FC5402AAset_impl*
 l3Set(f_Data, aValue);
//#UC END# *525D2DF10141_5111FC5402AAset_impl*
end;//TddTextSegment.pm_SetData

procedure TddTextSegment.pm_SetURL(aValue: Tl3String);
//#UC START# *525D30780001_5111FC5402AAset_var*
//#UC END# *525D30780001_5111FC5402AAset_var*
begin
//#UC START# *525D30780001_5111FC5402AAset_impl*
 f_URL.Assign(aValue);
//#UC END# *525D30780001_5111FC5402AAset_impl*
end;//TddTextSegment.pm_SetURL

function TddTextSegment.pm_GetTargets(anIndex: Integer): TddHyperlinkTarget;
//#UC START# *525D30CC02E9_5111FC5402AAget_var*
//#UC END# *525D30CC02E9_5111FC5402AAget_var*
begin
//#UC START# *525D30CC02E9_5111FC5402AAget_impl*
 Result := f_TargetList[anIndex];
//#UC END# *525D30CC02E9_5111FC5402AAget_impl*
end;//TddTextSegment.pm_GetTargets

procedure TddTextSegment.Cleanup;
//#UC START# *479731C50290_5111FC5402AA_var*
//#UC END# *479731C50290_5111FC5402AA_var*
begin
//#UC START# *479731C50290_5111FC5402AA_impl*
 l3Free(f_Data);
 l3Free(f_URL);
 l3Free(f_TargetList);
 l3Free(f_CHP);
 f_Opened := False;
 inherited;
//#UC END# *479731C50290_5111FC5402AA_impl*
end;//TddTextSegment.Cleanup

procedure TddTextSegment.Assign(const aDocAtomObj: Tl3ProtoObject);
//#UC START# *528C8C2F02D9_5111FC5402AA_var*
var
 l_Value: TddTextSegment;
//#UC END# *528C8C2F02D9_5111FC5402AA_var*
begin
//#UC START# *528C8C2F02D9_5111FC5402AA_impl*
 if (aDocAtomObj is TddTextsegment) then
 begin
  l_Value := aDocAtomObj as TddTextsegment;
  f_CHP.AssignFrom(l_Value.CHP);
  f_TargetList.Assign(l_Value.f_TargetList);
  f_Start := l_Value.Start;
  f_Stop := l_Value.Stop;
  f_Style := l_Value.Style;
  l3Set(f_Data, l_Value.Data);
  f_HLHandle := l_Value.HLHandle;
  f_URL.Assign(l_Value.URL);
 end // aSource Is TddTextSegment
 else
  inherited;
//#UC END# *528C8C2F02D9_5111FC5402AA_impl*
end;//TddTextSegment.Assign

end.