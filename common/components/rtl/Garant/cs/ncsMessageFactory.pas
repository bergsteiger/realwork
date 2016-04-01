unit ncsMessageFactory;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsMessageFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsMessageFactory" MUID: (54539F4702B1)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , ncsMessageClassList
 , ncsMessage
 , Classes
 , l3Variant
;

type
 TncsMessageFactory = class(Tl3ProtoObject)
  private
   f_List: TncsMessageClassList;
  private
   function Find(const aMessageTag: AnsiString): TncsMessageClass;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure Register(aClass: TncsMessageClass);
   procedure UnRegister(aClass: TncsMessageClass);
   class function MakeFromEVD(aStream: TStream): TncsMessage;
   class function MakeFromTaggedData(aData: Tl3Tag): TncsMessage;
   class function Instance: TncsMessageFactory;
    {* Метод получения экземпляра синглетона TncsMessageFactory }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TncsMessageFactory
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , l3Types
 , l3Base
;

var g_TncsMessageFactory: TncsMessageFactory = nil;
 {* Экземпляр синглетона TncsMessageFactory }

procedure TncsMessageFactoryFree;
 {* Метод освобождения экземпляра синглетона TncsMessageFactory }
begin
 l3Free(g_TncsMessageFactory);
end;//TncsMessageFactoryFree

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

class function TncsMessageFactory.Instance: TncsMessageFactory;
 {* Метод получения экземпляра синглетона TncsMessageFactory }
begin
 if (g_TncsMessageFactory = nil) then
 begin
  l3System.AddExitProc(TncsMessageFactoryFree);
  g_TncsMessageFactory := Create;
 end;
 Result := g_TncsMessageFactory;
end;//TncsMessageFactory.Instance

class function TncsMessageFactory.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TncsMessageFactory <> nil;
end;//TncsMessageFactory.Exists

procedure TncsMessageFactory.Cleanup;
 {* Функция очистки полей объекта. }
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
{$IfEnd} // NOT Defined(Nemesis)

end.
