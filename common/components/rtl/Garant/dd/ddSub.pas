unit ddSub;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddSub.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddSub
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3Base,
  ddBaseObject,
  k2Interfaces,
  ddTypes
  ;

type
 TddSub = class(TddBaseObject)
 private
 // private fields
   f_IsRealName : Boolean;
    {* Поле для свойства IsRealName}
   f_ID : Integer;
    {* Поле для свойства ID}
   f_Name : Tl3String;
    {* Поле для свойства Name}
 protected
 // realized methods
   procedure Write2Generator(const Generator: Ik2TagGenerator;
     aLiteVersion: TddLiteVersion); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   procedure Assign(anObject: TddBaseObject); override;
   constructor Create; override;
     {* Сигнатура метода Create }
 public
 // public properties
   property IsRealName: Boolean
     read f_IsRealName
     write f_IsRealName;
   property ID: Integer
     read f_ID
     write f_ID;
   property Name: Tl3String
     read f_Name;
 end;//TddSub

implementation

uses
  ddEVDTypesSupport,
  k2Tags
  ;

// start class TddSub

procedure TddSub.Write2Generator(const Generator: Ik2TagGenerator;
  aLiteVersion: TddLiteVersion);
//#UC START# *54DC9795018B_5268E523030D_var*
//#UC END# *54DC9795018B_5268E523030D_var*
begin
//#UC START# *54DC9795018B_5268E523030D_impl*
 StartSub(Generator);
 try
  Generator.AddIntegerAtom(k2_tiHandle, ID);
  if not Name.Empty then
  begin
   if IsRealName then
    Generator.AddStringAtom(k2_tiShortName, Name.AsWStr)
   else
    Generator.AddStringAtom(k2_tiName, Name.AsWStr)
  end; // not l_Sub.Name.Empty
 finally
  Generator.Finish;
 end; 
//#UC END# *54DC9795018B_5268E523030D_impl*
end;//TddSub.Write2Generator

procedure TddSub.Cleanup;
//#UC START# *479731C50290_5268E523030D_var*
//#UC END# *479731C50290_5268E523030D_var*
begin
//#UC START# *479731C50290_5268E523030D_impl*
 l3Free(f_Name);
 inherited;
//#UC END# *479731C50290_5268E523030D_impl*
end;//TddSub.Cleanup

procedure TddSub.Assign(anObject: TddBaseObject);
//#UC START# *52BACF8A01A9_5268E523030D_var*
var
 l_Value: TddSub;
//#UC END# *52BACF8A01A9_5268E523030D_var*
begin
//#UC START# *52BACF8A01A9_5268E523030D_impl*
 inherited Assign(anObject);
 if (anObject Is TddSub) then
 begin
  l_Value := anObject as TddSub;
  f_Name.Assign(l_Value.Name);
  f_ID := l_Value.ID;
  f_IsRealName := l_Value.IsRealName;
 end;{aSource Is TddSub}
//#UC END# *52BACF8A01A9_5268E523030D_impl*
end;//TddSub.Assign

constructor TddSub.Create;
//#UC START# *52BACFBE00D9_5268E523030D_var*
//#UC END# *52BACFBE00D9_5268E523030D_var*
begin
//#UC START# *52BACFBE00D9_5268E523030D_impl*
 inherited;
 f_Name := Tl3String.Create;
 f_IsRealName := True;
 f_ID := 0;
//#UC END# *52BACFBE00D9_5268E523030D_impl*
end;//TddSub.Create

end.