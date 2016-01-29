unit NOT_FINISHED_ddTextSegment;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/NOT_FINISHED_ddTextSegment.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddTextSegment
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

interface

uses
  l3Base,
  l3ProtoPersistentOwnedDataContainer,
  ddBase,
  ddDocumentAtom,
  ddCharacterProperty,
  ddHyperlinkTarget,
  ddHyperlinkTargetList,
  Classes
  ;

type
 TddTextSegment = class(Tl3ProtoPersistentOwnedDataContainer)
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
   f_ObjectType : TddSegmentObjectType;
    {* Поле для свойства ObjectType}
   f_SegmentType : TddSegmentType;
    {* Поле для свойства SegmentType}
   f_URL : Tl3String;
    {* Поле для свойства URL}
   f_TargetList : TddHyperlinkTargetList;
    {* Поле для свойства TargetList}
 protected
 // property methods
   procedure pm_SetCHP(aValue: TddCharacterProperty);
   procedure pm_SetData(aValue: TddDocumentAtom);
   function pm_GetIsHyperlink: Boolean;
   procedure pm_SetIsHyperlink(aValue: Boolean);
   procedure pm_SetURL(aValue: Tl3String);
   function pm_GetTargets(anIndex: Integer): TddHyperlinkTarget;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   procedure Assign(Source: TPersistent); override;
 public
 // public methods
   procedure AddTarget(aDocID: LongInt;
     aSubID: LongInt;
     aTypeID: Integer);
   constructor Create; reintroduce;
     {* Сигнатура метода Create }
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
   property ObjectType: TddSegmentObjectType
     read f_ObjectType
     write f_ObjectType;
   property SegmentType: TddSegmentType
     read f_SegmentType
     write f_SegmentType;
   property IsHyperlink: Boolean
     read pm_GetIsHyperlink
     write pm_SetIsHyperlink;
   property URL: Tl3String
     read f_URL
     write pm_SetURL;
   property Targets[anIndex: Integer]: TddHyperlinkTarget
     read pm_GetTargets;
   property TargetList: TddHyperlinkTargetList
     read f_TargetList;
 end;//TddTextSegment

implementation

// start class TddTextSegment

procedure TddTextSegment.AddTarget(aDocID: LongInt;
  aSubID: LongInt;
  aTypeID: Integer);
//#UC START# *525D2C2700F3_5111FC5402AA_var*
//#UC END# *525D2C2700F3_5111FC5402AA_var*
begin
//#UC START# *525D2C2700F3_5111FC5402AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *525D2C2700F3_5111FC5402AA_impl*
end;//TddTextSegment.AddTarget

constructor TddTextSegment.Create;
//#UC START# *525D2C8D0143_5111FC5402AA_var*
//#UC END# *525D2C8D0143_5111FC5402AA_var*
begin
//#UC START# *525D2C8D0143_5111FC5402AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *525D2C8D0143_5111FC5402AA_impl*
end;//TddTextSegment.Create

procedure TddTextSegment.pm_SetCHP(aValue: TddCharacterProperty);
//#UC START# *525D2DB20127_5111FC5402AAset_var*
//#UC END# *525D2DB20127_5111FC5402AAset_var*
begin
//#UC START# *525D2DB20127_5111FC5402AAset_impl*
 !!! Needs to be implemented !!!
//#UC END# *525D2DB20127_5111FC5402AAset_impl*
end;//TddTextSegment.pm_SetCHP

procedure TddTextSegment.pm_SetData(aValue: TddDocumentAtom);
//#UC START# *525D2DF10141_5111FC5402AAset_var*
//#UC END# *525D2DF10141_5111FC5402AAset_var*
begin
//#UC START# *525D2DF10141_5111FC5402AAset_impl*
 !!! Needs to be implemented !!!
//#UC END# *525D2DF10141_5111FC5402AAset_impl*
end;//TddTextSegment.pm_SetData

function TddTextSegment.pm_GetIsHyperlink: Boolean;
//#UC START# *525D2F3B0193_5111FC5402AAget_var*
//#UC END# *525D2F3B0193_5111FC5402AAget_var*
begin
//#UC START# *525D2F3B0193_5111FC5402AAget_impl*
 !!! Needs to be implemented !!!
//#UC END# *525D2F3B0193_5111FC5402AAget_impl*
end;//TddTextSegment.pm_GetIsHyperlink

procedure TddTextSegment.pm_SetIsHyperlink(aValue: Boolean);
//#UC START# *525D2F3B0193_5111FC5402AAset_var*
//#UC END# *525D2F3B0193_5111FC5402AAset_var*
begin
//#UC START# *525D2F3B0193_5111FC5402AAset_impl*
 !!! Needs to be implemented !!!
//#UC END# *525D2F3B0193_5111FC5402AAset_impl*
end;//TddTextSegment.pm_SetIsHyperlink

procedure TddTextSegment.pm_SetURL(aValue: Tl3String);
//#UC START# *525D30780001_5111FC5402AAset_var*
//#UC END# *525D30780001_5111FC5402AAset_var*
begin
//#UC START# *525D30780001_5111FC5402AAset_impl*
 !!! Needs to be implemented !!!
//#UC END# *525D30780001_5111FC5402AAset_impl*
end;//TddTextSegment.pm_SetURL

function TddTextSegment.pm_GetTargets(anIndex: Integer): TddHyperlinkTarget;
//#UC START# *525D30CC02E9_5111FC5402AAget_var*
//#UC END# *525D30CC02E9_5111FC5402AAget_var*
begin
//#UC START# *525D30CC02E9_5111FC5402AAget_impl*
 !!! Needs to be implemented !!!
//#UC END# *525D30CC02E9_5111FC5402AAget_impl*
end;//TddTextSegment.pm_GetTargets

procedure TddTextSegment.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_5111FC5402AA_var*
//#UC END# *478CF34E02CE_5111FC5402AA_var*
begin
//#UC START# *478CF34E02CE_5111FC5402AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *478CF34E02CE_5111FC5402AA_impl*
end;//TddTextSegment.Assign

procedure TddTextSegment.Cleanup;
//#UC START# *479731C50290_5111FC5402AA_var*
//#UC END# *479731C50290_5111FC5402AA_var*
begin
//#UC START# *479731C50290_5111FC5402AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_5111FC5402AA_impl*
end;//TddTextSegment.Cleanup

end.