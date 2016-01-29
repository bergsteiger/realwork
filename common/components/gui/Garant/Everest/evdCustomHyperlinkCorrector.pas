unit evdCustomHyperlinkCorrector;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evdCustomHyperlinkCorrector.pas"
// Начат: 18.06.2010 19:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Generators::TevdCustomHyperlinkCorrector
//
// Фильтр исправляющий адреса ссылок из F1
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2TagGen,
  evdInterfaces,
  evdLeafParaFilter,
  l3Variant,
  k2Base
  ;

type
 TevdCustomHyperlinkCorrector = class(TevdLeafParaFilter)
  {* Фильтр исправляющий адреса ссылок из F1 }
 private
 // private fields
   f_Converter : IevdExternalDocNumberToInternal;
   f_ExternalHandle : Integer;
    {* Внешний номер передаваемого документа для подставки в ссылку.}
 protected
 // overridden protected methods
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
   function ParaTypeForFiltering: Tk2Type; override;
     {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   procedure DoWritePara(aLeaf: Tl3Variant); override;
     {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   function IsNeedCorrection: Boolean; virtual;
   function DoCorrectDocID(const aDocID: Integer): Integer; virtual;
   function CheckDocIDBeforeCorrection(const aDocID: Integer): Boolean; virtual;
 public
 // public methods
   class function SetTo(var theGenerator: Tk2TagGenerator;
     const aConverter: IevdExternalDocNumberToInternal): Pointer;
 end;//TevdCustomHyperlinkCorrector

implementation

uses
  HyperLink_Const,
  k2Tags,
  evdTypes,
  Document_Const
  ;

// start class TevdCustomHyperlinkCorrector

class function TevdCustomHyperlinkCorrector.SetTo(var theGenerator: Tk2TagGenerator;
  const aConverter: IevdExternalDocNumberToInternal): Pointer;
//#UC START# *4C1B9990015E_4C1B8D2F039F_var*
//#UC END# *4C1B9990015E_4C1B8D2F039F_var*
begin
//#UC START# *4C1B9990015E_4C1B8D2F039F_impl*
 Result := inherited SetTo(theGenerator);
 (theGenerator As TevdCustomHyperlinkCorrector).f_Converter := aConverter;
//#UC END# *4C1B9990015E_4C1B8D2F039F_impl*
end;//TevdCustomHyperlinkCorrector.SetTo

function TevdCustomHyperlinkCorrector.IsNeedCorrection: Boolean;
//#UC START# *52E0B71902EC_4C1B8D2F039F_var*
//#UC END# *52E0B71902EC_4C1B8D2F039F_var*
begin
//#UC START# *52E0B71902EC_4C1B8D2F039F_impl*
 Result := True;
//#UC END# *52E0B71902EC_4C1B8D2F039F_impl*
end;//TevdCustomHyperlinkCorrector.IsNeedCorrection

function TevdCustomHyperlinkCorrector.DoCorrectDocID(const aDocID: Integer): Integer;
//#UC START# *52E0B7BF0023_4C1B8D2F039F_var*
//#UC END# *52E0B7BF0023_4C1B8D2F039F_var*
begin
//#UC START# *52E0B7BF0023_4C1B8D2F039F_impl*
 if (f_Converter <> nil) then
  Result := f_Converter.ConvertExternalDocNumberToInternal(aDocID)
 else
  Result := aDocID;
//#UC END# *52E0B7BF0023_4C1B8D2F039F_impl*
end;//TevdCustomHyperlinkCorrector.DoCorrectDocID

function TevdCustomHyperlinkCorrector.CheckDocIDBeforeCorrection(const aDocID: Integer): Boolean;
//#UC START# *52E0B83400F0_4C1B8D2F039F_var*
//#UC END# *52E0B83400F0_4C1B8D2F039F_var*
begin
//#UC START# *52E0B83400F0_4C1B8D2F039F_impl*
 Result := aDocID > 0;
//#UC END# *52E0B83400F0_4C1B8D2F039F_impl*
end;//TevdCustomHyperlinkCorrector.CheckDocIDBeforeCorrection

procedure TevdCustomHyperlinkCorrector.AddAtomEx(AtomIndex: Integer;
  const Value: Ik2Variant);
//#UC START# *4836D52400D9_4C1B8D2F039F_var*
//#UC END# *4836D52400D9_4C1B8D2F039F_var*
begin
//#UC START# *4836D52400D9_4C1B8D2F039F_impl*
 if (AtomIndex = k2_tiExternalHandle) AND
    CurrentType.IsKindOf(k2_typDocument) then
  f_ExternalHandle := VariantAsInteger(AtomIndex, Value);
 inherited;
//#UC END# *4836D52400D9_4C1B8D2F039F_impl*
end;//TevdCustomHyperlinkCorrector.AddAtomEx

function TevdCustomHyperlinkCorrector.ParaTypeForFiltering: Tk2Type;
//#UC START# *49E488070386_4C1B8D2F039F_var*
//#UC END# *49E488070386_4C1B8D2F039F_var*
begin
//#UC START# *49E488070386_4C1B8D2F039F_impl*
 Result := nil;
 if IsNeedCorrection then
  Result := k2_typHyperlink;
//#UC END# *49E488070386_4C1B8D2F039F_impl*
end;//TevdCustomHyperlinkCorrector.ParaTypeForFiltering

procedure TevdCustomHyperlinkCorrector.DoWritePara(aLeaf: Tl3Variant);
//#UC START# *49E4883E0176_4C1B8D2F039F_var*
var
 l_Index : Integer;
 l_DocID : Integer;
//#UC END# *49E4883E0176_4C1B8D2F039F_var*
begin
//#UC START# *49E4883E0176_4C1B8D2F039F_impl*
 if IsNeedCorrection then
 begin
  for l_Index := 0 to aLeaf.ChildrenCount - 1 do
   with aLeaf.Child[l_Index] do
   begin
    l_DocID := IntA[k2_tiRevision];
    if (l_DocID <= 0) then
     l_DocID := IntA[k2_tiDocID];
    if (l_DocID <= 0) then
     l_DocID := f_ExternalHandle;
    if CheckDocIDBeforeCorrection(l_DocID) then
     IntA[k2_tiDocID] := DoCorrectDocID(l_DocID);
   end;//with aLeaf.Child[l_Index]
 end;//CurrentVersion mod evFormatCurVersionStep = 1
 inherited;
//#UC END# *49E4883E0176_4C1B8D2F039F_impl*
end;//TevdCustomHyperlinkCorrector.DoWritePara

procedure TevdCustomHyperlinkCorrector.ClearFields;
 {-}
begin
 f_Converter := nil;
 inherited;
end;//TevdCustomHyperlinkCorrector.ClearFields

end.