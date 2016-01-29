unit ncsMessageFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsMessageFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsMessageFactory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  Classes,
  l3ProtoObject,
  l3Variant,
  ncsMessage,
  ncsMessageClassList
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsMessageFactory = class(Tl3ProtoObject)
 private
 // private fields
   f_List : TncsMessageClassList;
 private
 // private methods
   function Find(const aMessageTag: AnsiString): TncsMessageClass;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // public methods
   procedure Register(aClass: TncsMessageClass);
   procedure UnRegister(aClass: TncsMessageClass);
   class function MakeFromEVD(aStream: TStream): TncsMessage;
   class function MakeFromTaggedData(aData: Tl3Tag): TncsMessage;
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TncsMessageFactory;
    {- возвращает экземпляр синглетона. }
 end;//TncsMessageFactory
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base {a},
  SysUtils,
  l3Types
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}


// start class TncsMessageFactory

var g_TncsMessageFactory : TncsMessageFactory = nil;

procedure TncsMessageFactoryFree;
begin
 l3Free(g_TncsMessageFactory);
end;

class function TncsMessageFactory.Instance: TncsMessageFactory;
begin
 if (g_TncsMessageFactory = nil) then
 begin
  l3System.AddExitProc(TncsMessageFactoryFree);
  g_TncsMessageFactory := Create;
 end;
 Result := g_TncsMessageFactory;
end;


procedure TncsMessageFactory.Register(aClass: TncsMessageClass);
//#UC START# *545A23D30081_54539F4702B1_var*
//#UC END# *545A23D30081_54539F4702B1_var*
begin
//#UC START# *545A23D30081_54539F4702B1_impl*
 f_List.Add(aClass);
//#UC END# *545A23D30081_54539F4702B1_impl*
end;//TncsMessageFactory.Register

procedure TncsMessageFactory.UnRegister(aClass: TncsMessageClass);
//#UC START# *545A23FB02E0_54539F4702B1_var*
//#UC END# *545A23FB02E0_54539F4702B1_var*
begin
//#UC START# *545A23FB02E0_54539F4702B1_impl*
 f_List.Remove(aClass);
//#UC END# *545A23FB02E0_54539F4702B1_impl*
end;//TncsMessageFactory.UnRegister

function TncsMessageFactory.Find(const aMessageTag: AnsiString): TncsMessageClass;
//#UC START# *545A24130098_54539F4702B1_var*
var
 l_IDX: Integer;
//#UC END# *545A24130098_54539F4702B1_var*
begin
//#UC START# *545A24130098_54539F4702B1_impl*
 Result := nil;
 for l_IDX := 0 to f_List.Count - 1 do
  if ANSISameText(aMessageTag, f_List[l_IDX].GetTaggedDataType.AsString) then
  begin
   Result := f_List[l_IDX];
   Break;
  end;
 if Result = nil then
 begin
  l3System.Msg2Log('Не найден класс обертки для (%s)!!', [aMessageTag]);
  Result := TncsInvalidMessage;
 end;
//#UC END# *545A24130098_54539F4702B1_impl*
end;//TncsMessageFactory.Find

class function TncsMessageFactory.MakeFromEVD(aStream: TStream): TncsMessage;
//#UC START# *54538B990208_54539F4702B1_var*
var
 l_Data : Tl3Tag;
//#UC END# *54538B990208_54539F4702B1_var*
begin
//#UC START# *54538B990208_54539F4702B1_impl*
 Result := nil;
 l_Data := TncsMessage.CreateTaggedDataFromEVD(aStream);
 try
  Result := MakeFromTaggedData(l_Data);
 finally
  FreeAndNil(l_Data);
 end;//try..finally
//#UC END# *54538B990208_54539F4702B1_impl*
end;//TncsMessageFactory.MakeFromEVD

class function TncsMessageFactory.MakeFromTaggedData(aData: Tl3Tag): TncsMessage;
//#UC START# *54538F64032E_54539F4702B1_var*
var
 l_ClassRef: TncsMessageClass;
//#UC END# *54538F64032E_54539F4702B1_var*
begin
//#UC START# *54538F64032E_54539F4702B1_impl*
 l_ClassRef := Instance.Find(aData.TagType.AsString);
 if Assigned(l_ClassRef) then
 begin
  Result := l_ClassRef.Create;
  try
   Result.SetTaggedData(aData);
  except
   FreeAndNil(Result);
   raise;
  end;
 end
 else
  Result := nil;
//#UC END# *54538F64032E_54539F4702B1_impl*
end;//TncsMessageFactory.MakeFromTaggedData

class function TncsMessageFactory.Exists: Boolean;
 {-}
begin
 Result := g_TncsMessageFactory <> nil;
end;//TncsMessageFactory.Exists

procedure TncsMessageFactory.Cleanup;
//#UC START# *479731C50290_54539F4702B1_var*
//#UC END# *479731C50290_54539F4702B1_var*
begin
//#UC START# *479731C50290_54539F4702B1_impl*
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_54539F4702B1_impl*
end;//TncsMessageFactory.Cleanup

procedure TncsMessageFactory.InitFields;
//#UC START# *47A042E100E2_54539F4702B1_var*
//#UC END# *47A042E100E2_54539F4702B1_var*
begin
//#UC START# *47A042E100E2_54539F4702B1_impl*
 inherited;
 f_List := TncsMessageClassList.MakeSorted(l3_dupIgnore);
//#UC END# *47A042E100E2_54539F4702B1_impl*
end;//TncsMessageFactory.InitFields

{$IfEnd} //not Nemesis

end.