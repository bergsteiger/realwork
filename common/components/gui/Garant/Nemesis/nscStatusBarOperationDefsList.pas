unit nscStatusBarOperationDefsList;

{$Include nscDefine.inc }

interface

// <no_string>

uses
  l3Interfaces,
  l3Base,
  l3ProtoDataContainer,
  l3Types,
  l3Core,
  l3Memory,

  nscInterfaces,
  nscNewInterfaces
  ;

type
  {$Define l3Items_IsProto}
  _ItemType_ = InscStatusBarItemDef;
  _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
  {$Include l3InterfaceRefList.imp.pas}
  TnscStatusBarOperationDefsList = class(_l3InterfaceRefList_, InscStatusBarItemDefsList)
  protected
   //InscStatusBarItemDefsList
   function InscStatusBarItemDefsList.pm_GetCount = InscStatusBarItemDefsList_Count;
   function InscStatusBarItemDefsList_Count: Integer;
   procedure InscStatusBarItemDefsList.Add = InscStatusBarItemDefsList_Add;
   procedure InscStatusBarItemDefsList_Add(const aDef: InscStatusBarItemDef);
  public
   class function MakeI: InscStatusBarItemDefsList;
  end;//TnscStatusBarOperationDefsList

implementation

uses
  SysUtils,
  Classes,
  RTLConsts,

  l3Except,
  l3MinMax
  ;

type _l3InterfaceRefList_R_ = TnscStatusBarOperationDefsList;
 _Instance_R_ = TnscStatusBarOperationDefsList;

{$Include l3InterfaceRefList.imp.pas}

procedure TnscStatusBarOperationDefsList.InscStatusBarItemDefsList_Add(
  const aDef: InscStatusBarItemDef);
begin
 Add(aDef);
end;

function TnscStatusBarOperationDefsList.InscStatusBarItemDefsList_Count: Integer;
begin
 Result := Count;
end;

class function TnscStatusBarOperationDefsList.MakeI: InscStatusBarItemDefsList;
var
 l_Instance: TnscStatusBarOperationDefsList;
begin
 l_Instance := TnscStatusBarOperationDefsList.Create;
 try
  Result := l_Instance;
 finally
  l3Free(l_Instance);
 end;
end;

end.
