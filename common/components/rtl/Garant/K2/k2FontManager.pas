unit k2FontManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2FontManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2FontManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2FontName,
  k2FontNameList
  ;

type
 Tk2FontManager = class(Tk2FontNameList)
 protected
 // overridden protected methods
   procedure InitFields; override;
 public
 // public methods
   function FontByName(const aName: AnsiString): Tk2FontName;
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: Tk2FontManager;
    {- возвращает экземпляр синглетона. }
 end;//Tk2FontManager

implementation

uses
  l3Base {a},
  l3LogFont,
  l3FontManagerEx,
  SysUtils
  ;


// start class Tk2FontManager

var g_Tk2FontManager : Tk2FontManager = nil;

procedure Tk2FontManagerFree;
begin
 l3Free(g_Tk2FontManager);
end;

class function Tk2FontManager.Instance: Tk2FontManager;
begin
 if (g_Tk2FontManager = nil) then
 begin
  l3System.AddExitProc(Tk2FontManagerFree);
  g_Tk2FontManager := Create;
 end;
 Result := g_Tk2FontManager;
end;


function Tk2FontManager.FontByName(const aName: AnsiString): Tk2FontName;
//#UC START# *53189C3D034E_5318974F0065_var*
var
 VT : Tl3FontManagerEx;
 FN : Tl3LogFont;
 l_Index : Integer;
 l_F : Tk2FontName;
//#UC END# *53189C3D034E_5318974F0065_var*
begin
//#UC START# *53189C3D034E_5318974F0065_impl*
 if (aName = '') then
  Result := nil
 else
 begin
  VT := Tl3FontManagerEx.Instance;
  if (VT <> nil) then
  begin
   FN := VT.DRByName[aName];
   if (FN <> nil) then
   begin
    if Self.FindData(FN, l_Index) then
     Result := Items[l_Index]
    else
    begin
      l_F := Tk2FontName.Create(FN);
      try
       Add(l_F);
       Result := l_F;
      finally
       FreeAndNil(l_F);
      end;//try..finally
    end;//Self.FindData(FN, l_Index)
    Exit;
   end;//FN <> nil
  end;//VT <> nil
  Assert(false);
  Result := nil;
  //ConvertError('String', AtomType.AsString);
 end;//aValue = EmptyStr
//#UC END# *53189C3D034E_5318974F0065_impl*
end;//Tk2FontManager.FontByName

class function Tk2FontManager.Exists: Boolean;
 {-}
begin
 Result := g_Tk2FontManager <> nil;
end;//Tk2FontManager.Exists

procedure Tk2FontManager.InitFields;
//#UC START# *47A042E100E2_5318974F0065_var*
//#UC END# *47A042E100E2_5318974F0065_var*
begin
//#UC START# *47A042E100E2_5318974F0065_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_5318974F0065_impl*
end;//Tk2FontManager.InitFields

end.