unit ddRTFState;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddRTFState.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd::RTFSupport::ddRTFState
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3ProtoObject,
  l3ProtoObjectRefList,
  ddBorder,
  ddCellProperty,
  ddRowProperty,
  RTFtypes,
  ddCharacterProperty,
  ddParagraphProperty,
  ddSectionProperty
  ;

type
 TddRTFState = class(Tl3ProtoObject)
 private
 // private fields
   f_BOP : TddBorder;
    {* Поле для свойства BOP}
   f_CEP : TddCellProperty;
    {* Поле для свойства CEP}
   f_CHP : TddCharacterProperty;
    {* Поле для свойства CHP}
   f_PAP : TddParagraphProperty;
    {* Поле для свойства PAP}
   f_RDS : TRDS;
    {* Поле для свойства RDS}
   f_SEP : TddSectionProperty;
    {* Поле для свойства SEP}
   f_TAP : TddRowProperty;
    {* Поле для свойства TAP}
   f_SkipGroup : Boolean;
    {* Поле для свойства SkipGroup}
   f_UC : Integer;
    {* Поле для свойства UC}
 protected
 // property methods
   procedure pm_SetBOP(aValue: TddBorder);
   procedure pm_SetCHP(aValue: TddCharacterProperty);
   procedure pm_SetPAP(aValue: TddParagraphProperty);
   procedure pm_SetSEP(aValue: TddSectionProperty);
   procedure pm_SetTAP(aValue: TddRowProperty);
   procedure pm_SetUC(aValue: Integer);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   function Clone: TddRTFState;
   constructor Create(anUC: Integer); reintroduce;
   procedure Assign(anObject: TddRTFState);
 public
 // public properties
   property BOP: TddBorder
     read f_BOP
     write pm_SetBOP;
   property CEP: TddCellProperty
     read f_CEP
     write f_CEP;
   property CHP: TddCharacterProperty
     read f_CHP
     write pm_SetCHP;
   property PAP: TddParagraphProperty
     read f_PAP
     write pm_SetPAP;
   property RDS: TRDS
     read f_RDS
     write f_RDS;
   property SEP: TddSectionProperty
     read f_SEP
     write pm_SetSEP;
   property TAP: TddRowProperty
     read f_TAP
     write pm_SetTAP;
   property SkipGroup: Boolean
     read f_SkipGroup
     write f_SkipGroup;
   property UC: Integer
     read f_UC
     write pm_SetUC;
     {* UC для текущего состояния. }
 end;//TddRTFState

 TrtfStateStack = class(Tl3ProtoObjectRefList)
 public
 // public methods
   function Peek: TddRTFState;
   function Pop: TddRTFState;
   procedure Push(anUC: Integer);
   function PeekPrev: TddRTFState;
 end;//TrtfStateStack

implementation

uses
  SysUtils,
  ddTypes
  ;

// start class TddRTFState

function TddRTFState.Clone: TddRTFState;
//#UC START# *51DBBF76006A_51D287250128_var*
//#UC END# *51DBBF76006A_51D287250128_var*
begin
//#UC START# *51DBBF76006A_51D287250128_impl*
 Result := TddRTFState.Create(UC);
 Result.Assign(Self);
 Result.PAP.anInherited := True;
//#UC END# *51DBBF76006A_51D287250128_impl*
end;//TddRTFState.Clone

constructor TddRTFState.Create(anUC: Integer);
//#UC START# *51DBBF960279_51D287250128_var*
//#UC END# *51DBBF960279_51D287250128_var*
begin
//#UC START# *51DBBF960279_51D287250128_impl*
 inherited Create;
 f_CHP := TddCharacterProperty.Create;
 f_CHP.Reset;
 f_PAP := TddParagraphProperty.Create;
 f_BOP := TddBorder.Create;
 f_BOP.IsFramed := False;
 f_TAP := TddRowProperty.Create;
 f_TAP.Border.isFramed := False;
 f_CEP := TddCellProperty.Create(dd_cbNeedFrame);
 f_SEP := TddSectionProperty.Create;
 f_SkipGroup := False;
 f_RDS := rdsNone;
 f_UC := anUC;
//#UC END# *51DBBF960279_51D287250128_impl*
end;//TddRTFState.Create

procedure TddRTFState.Assign(anObject: TddRTFState);
//#UC START# *52BAC3CD01BB_51D287250128_var*
//#UC END# *52BAC3CD01BB_51D287250128_var*
begin
//#UC START# *52BAC3CD01BB_51D287250128_impl*
 f_PAP.AssignFrom(anObject.PAP);
 f_CHP.Assignfrom(anObject.CHP);
 f_BOP.AssignFrom(anObject.BOP);
 f_TAP.AssignFrom(anObject.TAP);
 f_Cep.Assign(anObject.CEP);
 f_SkipGroup := anObject.SkipGroup;
 f_RDS := anObject.RDS;
 f_UC := anObject.f_UC;
 f_SEP.AssignFrom(anObject.SEP);
//#UC END# *52BAC3CD01BB_51D287250128_impl*
end;//TddRTFState.Assign

procedure TddRTFState.pm_SetBOP(aValue: TddBorder);
//#UC START# *51DBBCC90082_51D287250128set_var*
//#UC END# *51DBBCC90082_51D287250128set_var*
begin
//#UC START# *51DBBCC90082_51D287250128set_impl*
 f_BOP.AssignFrom(aValue);
//#UC END# *51DBBCC90082_51D287250128set_impl*
end;//TddRTFState.pm_SetBOP

procedure TddRTFState.pm_SetCHP(aValue: TddCharacterProperty);
//#UC START# *51DBBDAB0317_51D287250128set_var*
//#UC END# *51DBBDAB0317_51D287250128set_var*
begin
//#UC START# *51DBBDAB0317_51D287250128set_impl*
 f_CHP.AssignFrom(aValue);
//#UC END# *51DBBDAB0317_51D287250128set_impl*
end;//TddRTFState.pm_SetCHP

procedure TddRTFState.pm_SetPAP(aValue: TddParagraphProperty);
//#UC START# *51DBBDEB02B1_51D287250128set_var*
//#UC END# *51DBBDEB02B1_51D287250128set_var*
begin
//#UC START# *51DBBDEB02B1_51D287250128set_impl*
 f_PAP.AssignFrom(aValue);
//#UC END# *51DBBDEB02B1_51D287250128set_impl*
end;//TddRTFState.pm_SetPAP

procedure TddRTFState.pm_SetSEP(aValue: TddSectionProperty);
//#UC START# *51DBBEBC0085_51D287250128set_var*
//#UC END# *51DBBEBC0085_51D287250128set_var*
begin
//#UC START# *51DBBEBC0085_51D287250128set_impl*
 f_SEP.AssignFrom(aValue);
//#UC END# *51DBBEBC0085_51D287250128set_impl*
end;//TddRTFState.pm_SetSEP

procedure TddRTFState.pm_SetTAP(aValue: TddRowProperty);
//#UC START# *51DBBF08003A_51D287250128set_var*
//#UC END# *51DBBF08003A_51D287250128set_var*
begin
//#UC START# *51DBBF08003A_51D287250128set_impl*
 f_TAP.AssignFrom(aValue);
//#UC END# *51DBBF08003A_51D287250128set_impl*
end;//TddRTFState.pm_SetTAP

procedure TddRTFState.pm_SetUC(aValue: Integer);
//#UC START# *55E01E7E0013_51D287250128set_var*
//#UC END# *55E01E7E0013_51D287250128set_var*
begin
//#UC START# *55E01E7E0013_51D287250128set_impl*
 f_UC := aValue;
//#UC END# *55E01E7E0013_51D287250128set_impl*
end;//TddRTFState.pm_SetUC

procedure TddRTFState.Cleanup;
//#UC START# *479731C50290_51D287250128_var*
//#UC END# *479731C50290_51D287250128_var*
begin
//#UC START# *479731C50290_51D287250128_impl*
 FreeAndNil(f_CHP);
 FreeAndNil(f_PAP);
 FreeAndNil(f_BOP);
 FreeAndNil(f_TAP);
 FreeAndNil(f_CEP);
 FreeAndNil(f_SEP);
 inherited ;
//#UC END# *479731C50290_51D287250128_impl*
end;//TddRTFState.Cleanup
// start class TrtfStateStack

function TrtfStateStack.Peek: TddRTFState;
//#UC START# *51DBC0660357_51DBBFFD0351_var*
//#UC END# *51DBC0660357_51DBBFFD0351_var*
begin
//#UC START# *51DBC0660357_51DBBFFD0351_impl*
 if Count = 0 then
  Result := nil
 else
  Result := TddRTFState(Last);
//#UC END# *51DBC0660357_51DBBFFD0351_impl*
end;//TrtfStateStack.Peek

function TrtfStateStack.Pop: TddRTFState;
//#UC START# *51DBC08B031C_51DBBFFD0351_var*
//#UC END# *51DBC08B031C_51DBBFFD0351_var*
begin
//#UC START# *51DBC08B031C_51DBBFFD0351_impl*
 Result := Peek;
 DeleteLast;
//#UC END# *51DBC08B031C_51DBBFFD0351_impl*
end;//TrtfStateStack.Pop

procedure TrtfStateStack.Push(anUC: Integer);
//#UC START# *51DBC0AA0101_51DBBFFD0351_var*
var
 l_State: TddRTFState;
//#UC END# *51DBC0AA0101_51DBBFFD0351_var*
begin
//#UC START# *51DBC0AA0101_51DBBFFD0351_impl*
 if Count = 0 then
  l_State := TddRTFState.Create(anUC)
 else
  l_State := Peek.Clone;
 try
  Add(l_State);
 finally
  FreeAndNil(l_State);
 end;
//#UC END# *51DBC0AA0101_51DBBFFD0351_impl*
end;//TrtfStateStack.Push

function TrtfStateStack.PeekPrev: TddRTFState;
//#UC START# *51DD394E0093_51DBBFFD0351_var*
var
 l_Count: Integer;
//#UC END# *51DD394E0093_51DBBFFD0351_var*
begin
//#UC START# *51DD394E0093_51DBBFFD0351_impl*
 l_Count := Count;
 Dec(l_Count, 2);
 if l_Count < 0 then
  Result := nil
 else
  Result := TddRTFState(Items[l_Count]);
//#UC END# *51DD394E0093_51DBBFFD0351_impl*
end;//TrtfStateStack.PeekPrev

end.