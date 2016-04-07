unit ddSub;

// Модуль: "w:\common\components\rtl\Garant\dd\ddSub.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddSub" MUID: (5268E523030D)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddBaseObject
 , l3Base
 , k2Interfaces
 , ddTypes
;

type
 TddSub = class(TddBaseObject)
  private
   f_IsRealName: Boolean;
   f_ID: Integer;
   f_Name: Tl3String;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure Write2Generator(const Generator: Ik2TagGenerator;
    aLiteVersion: TddLiteVersion); override;
   procedure Assign(anObject: TddBaseObject); override;
   constructor Create; override;
  public
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
 l3ImplUses
 , ddEVDTypesSupport
 , k2Tags
;

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
 {* Функция очистки полей объекта. }
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
