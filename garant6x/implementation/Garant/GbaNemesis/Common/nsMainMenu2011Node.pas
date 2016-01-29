unit nsMainMenu2011Node;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsMainMenu2011Node.pas"
// Начат: 16.09.2011 12:38
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::MainMenu::TnsMainMenu2011Node
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces,
  l3Tree_TLB,
  nsNewCachableNode,
  MainMenuUnit,
  l3TreeInterfaces,
  l3IID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsMainMenu2011Node = class(TnsNewCachableNode)
 private
 // private fields
   f_SectionItem : ISectionItem;
   f_Caption : Il3CString;
 protected
 // overridden protected methods
   function GetAsPCharLen: Tl3WString; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aSectionItem: ISectionItem); reintroduce;
   class function Make(const aSectionItem: ISectionItem): Il3Node; reintroduce;
     {* Сигнатура фабрики TnsMainMenu2011Node.Make }
 end;//TnsMainMenu2011Node
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base,
  SysUtils,
  l3String,
  nsTypes,
  IOUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsMainMenu2011Node

constructor TnsMainMenu2011Node.Create(const aSectionItem: ISectionItem);
//#UC START# *4E730CD20352_4E730AE6014C_var*
//#UC END# *4E730CD20352_4E730AE6014C_var*
begin
//#UC START# *4E730CD20352_4E730AE6014C_impl*
 inherited Create(nil);
 Assert(aSectionItem <> nil);
 f_SectionItem := aSectionItem;
//#UC END# *4E730CD20352_4E730AE6014C_impl*
end;//TnsMainMenu2011Node.Create

class function TnsMainMenu2011Node.Make(const aSectionItem: ISectionItem): Il3Node;
var
 l_Inst : TnsMainMenu2011Node;
begin
 l_Inst := Create(aSectionItem);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsMainMenu2011Node.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_4E730AE6014C_var*
var
 l_S : IString;
//#UC END# *47A869BB02DE_4E730AE6014C_var*
begin
//#UC START# *47A869BB02DE_4E730AE6014C_impl*
 if (f_Caption = nil) then
 begin
  f_SectionItem.GetCaption(l_S);
  if (l_S = nil) then
   f_Caption := l3CStr('')
  else
   f_Caption := nsCStr(l_S); 
 end;//f_Caption = nil
 Result := l3PCharLen(f_Caption);
//#UC END# *47A869BB02DE_4E730AE6014C_impl*
end;//TnsMainMenu2011Node.GetAsPCharLen

function TnsMainMenu2011Node.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_4E730AE6014C_var*
//#UC END# *4A60B23E00C3_4E730AE6014C_var*
begin
//#UC START# *4A60B23E00C3_4E730AE6014C_impl*
 Result.SetOk;
 if IID.EQ(ISectionItem) then
  ISectionItem(Obj) := f_SectionItem
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_4E730AE6014C_impl*
end;//TnsMainMenu2011Node.COMQueryInterface

procedure TnsMainMenu2011Node.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_SectionItem := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Caption := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsMainMenu2011Node.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.