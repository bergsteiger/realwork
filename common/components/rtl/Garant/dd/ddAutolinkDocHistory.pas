unit ddAutolinkDocHistory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddAutolinkDocHistory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::Autolink::TddAutolinkDocHistory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  dt_Types,
  l3ProtoObject,
  ddAutolinkInterfaces,
  ddAutolinkDocEntryList
  ;

type
 TddAutolinkDocHistory = class(Tl3ProtoObject)
 private
 // private fields
   f_List : TddAutolinkDocEntryList;
   f_FZType : TDictID;
    {* тип документа "федеральный закон"}
   f_ZType : TDictID;
    {* тип документа "закон"}
 protected
 // property methods
   function pm_GetEntry(aIndex: Integer): IddAutolinkDocEntry;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aFZType: TDictID;
     aZType: TDictID); reintroduce;
   procedure AddEntry(const anEntry: IddAutolinkDocEntry);
   procedure Clear;
   function FindBySubEntry(const aSubEntry: IddAutolinkDocEntry): Integer;
   procedure MoveToTop(aIndex: Integer);
 public
 // public properties
   property Entry[aIndex: Integer]: IddAutolinkDocEntry
     read pm_GetEntry;
 end;//TddAutolinkDocHistory

implementation

uses
  SysUtils,
  l3String
  ;

// start class TddAutolinkDocHistory

constructor TddAutolinkDocHistory.Create(aFZType: TDictID;
  aZType: TDictID);
//#UC START# *4E95651B016A_4E955BA0010F_var*
//#UC END# *4E95651B016A_4E955BA0010F_var*
begin
//#UC START# *4E95651B016A_4E955BA0010F_impl*
 inherited Create;
 f_List := TddAutolinkDocEntryList.Make;
 f_FZType := aFZType;
 f_ZType  := aZType;
//#UC END# *4E95651B016A_4E955BA0010F_impl*
end;//TddAutolinkDocHistory.Create

procedure TddAutolinkDocHistory.AddEntry(const anEntry: IddAutolinkDocEntry);
//#UC START# *4E957E6602F7_4E955BA0010F_var*
//#UC END# *4E957E6602F7_4E955BA0010F_var*
begin
//#UC START# *4E957E6602F7_4E955BA0010F_impl*
 f_List.Add(anEntry);
//#UC END# *4E957E6602F7_4E955BA0010F_impl*
end;//TddAutolinkDocHistory.AddEntry

procedure TddAutolinkDocHistory.Clear;
//#UC START# *4E957F2B02B0_4E955BA0010F_var*
//#UC END# *4E957F2B02B0_4E955BA0010F_var*
begin
//#UC START# *4E957F2B02B0_4E955BA0010F_impl*
 f_List.Clear;
//#UC END# *4E957F2B02B0_4E955BA0010F_impl*
end;//TddAutolinkDocHistory.Clear

function TddAutolinkDocHistory.FindBySubEntry(const aSubEntry: IddAutolinkDocEntry): Integer;
//#UC START# *4E957FC000CC_4E955BA0010F_var*
var
 I         : Integer;
 l_CurEntry: IddAutolinkDocEntry;
 l_Found   : Boolean;
//#UC END# *4E957FC000CC_4E955BA0010F_var*
begin
//#UC START# *4E957FC000CC_4E955BA0010F_impl*
 Result := -1;
 if (f_List.Count > 0) and (aSubEntry <> nil) and (not aSubEntry.IsEmpty) then
  for I := f_List.Hi downto 0 do
  begin
   l_CurEntry := f_List[I];
   l_Found := ((aSubEntry.DocType = -1) or (aSubEntry.DocType = l_CurEntry.DocType) or

               // это такая заточка, "Закон" = "Федеральный закон", обратное неверно, кстати
               ((aSubEntry.DocType = f_ZType) and (l_CurEntry.DocType = f_FZType))) and
               
              ((aSubEntry.Date = 0) or (aSubEntry.Date = l_CurEntry.Date)) and
              (l3IsNil(aSubEntry.Num) or l3Same(aSubEntry.Num, l_CurEntry.Num, True)) and
              ((aSubEntry.SourceCount = 0) or aSubEntry.SourcesIdenticalTo(l_CurEntry));
   if l_Found then
   begin
    Result := I;
    Break;
   end;
  end;
//#UC END# *4E957FC000CC_4E955BA0010F_impl*
end;//TddAutolinkDocHistory.FindBySubEntry

procedure TddAutolinkDocHistory.MoveToTop(aIndex: Integer);
//#UC START# *4E95832702CC_4E955BA0010F_var*
//#UC END# *4E95832702CC_4E955BA0010F_var*
begin
//#UC START# *4E95832702CC_4E955BA0010F_impl*
 f_List.Move(aIndex, f_List.Hi);
//#UC END# *4E95832702CC_4E955BA0010F_impl*
end;//TddAutolinkDocHistory.MoveToTop

function TddAutolinkDocHistory.pm_GetEntry(aIndex: Integer): IddAutolinkDocEntry;
//#UC START# *4E95799B002F_4E955BA0010Fget_var*
//#UC END# *4E95799B002F_4E955BA0010Fget_var*
begin
//#UC START# *4E95799B002F_4E955BA0010Fget_impl*
 Result := f_List.Items[aIndex];
//#UC END# *4E95799B002F_4E955BA0010Fget_impl*
end;//TddAutolinkDocHistory.pm_GetEntry

procedure TddAutolinkDocHistory.Cleanup;
//#UC START# *479731C50290_4E955BA0010F_var*
//#UC END# *479731C50290_4E955BA0010F_var*
begin
//#UC START# *479731C50290_4E955BA0010F_impl*
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_4E955BA0010F_impl*
end;//TddAutolinkDocHistory.Cleanup

end.