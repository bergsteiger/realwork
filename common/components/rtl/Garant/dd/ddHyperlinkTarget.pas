unit ddHyperlinkTarget;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddHyperlinkTarget.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddHyperlinkTarget
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  ddBaseObject,
  k2Interfaces,
  ddTypes
  ;

type
 TddHyperlinkTarget = class(TddBaseObject)
 private
 // private fields
   f_DocID : LongInt;
    {* Поле для свойства DocID}
   f_SubID : LongInt;
    {* Поле для свойства SubID}
   f_TypeID : LongInt;
    {* Поле для свойства TypeID}
 protected
 // realized methods
   procedure Write2Generator(const Generator: Ik2TagGenerator;
     aLiteVersion: TddLiteVersion); override;
 public
 // overridden public methods
   procedure Assign(anObject: TddBaseObject); override;
 public
 // public methods
   constructor Create(aTypeID: Integer;
     aDocID: Integer;
     aSubID: Integer); reintroduce;
 public
 // public properties
   property DocID: LongInt
     read f_DocID
     write f_DocID;
   property SubID: LongInt
     read f_SubID;
   property TypeID: LongInt
     read f_TypeID;
 end;//TddHyperlinkTarget

implementation

uses
  ddEVDTypesSupport,
  k2Tags
  ;

// start class TddHyperlinkTarget

constructor TddHyperlinkTarget.Create(aTypeID: Integer;
  aDocID: Integer;
  aSubID: Integer);
//#UC START# *542540630026_525D26AF0039_var*
//#UC END# *542540630026_525D26AF0039_var*
begin
//#UC START# *542540630026_525D26AF0039_impl*
 inherited Create;
 f_DocID := aDocID;
 f_SubID := aSubID;
 f_TypeID := aTypeID;
//#UC END# *542540630026_525D26AF0039_impl*
end;//TddHyperlinkTarget.Create

procedure TddHyperlinkTarget.Write2Generator(const Generator: Ik2TagGenerator;
  aLiteVersion: TddLiteVersion);
//#UC START# *54DC9795018B_525D26AF0039_var*
//#UC END# *54DC9795018B_525D26AF0039_var*
begin
//#UC START# *54DC9795018B_525D26AF0039_impl*
 if (DocID <> 0) or (SubID <> 0) then
 begin
  StartAddress(Generator);
  try
   Generator.AddIntegerAtom(k2_tiDocID, DocID);
   if (SubID <> 0) then
    Generator.AddIntegerAtom(k2_tiSubID, SubID);
  finally
   Generator.Finish;
  end; // idAddress
 end; // if (l_Target.DocID <> 0) or (l_Target.SubID <> 0) then
//#UC END# *54DC9795018B_525D26AF0039_impl*
end;//TddHyperlinkTarget.Write2Generator

procedure TddHyperlinkTarget.Assign(anObject: TddBaseObject);
//#UC START# *52BACF8A01A9_525D26AF0039_var*
//#UC END# *52BACF8A01A9_525D26AF0039_var*
begin
//#UC START# *52BACF8A01A9_525D26AF0039_impl*
 if anObject is TddHyperlinkTarget then
 begin
  f_DocID := TddHyperlinkTarget(anObject).DocID;
  f_SubID := TddHyperlinkTarget(anObject).SubID;
 end // if anObject is TddHyperlinkTarget then
 else
  inherited;
//#UC END# *52BACF8A01A9_525D26AF0039_impl*
end;//TddHyperlinkTarget.Assign

end.