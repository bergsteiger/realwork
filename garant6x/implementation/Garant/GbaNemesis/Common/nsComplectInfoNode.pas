unit nsComplectInfoNode;
 {* Узел дерева с информацией о комплекте }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsComplectInfoNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsComplectInfoNode" MUID: (4682778E0223)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsINodeWrapBase
 , l3Interfaces
 , DynamicTreeUnit
;

type
 TnsComplectInfoNode = class(TnsINodeWrapBase, Il3MultipartText)
  {* Узел дерева с информацией о комплекте }
  private
   fValue: Il3CString;
  protected
   function GetTextPart(aIndex: Integer): Tl3PCharLenPrim;
    {* Возвращает кусок текста по индексу. }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aNode: INodeBase); override;
    {* Создаёт экземпляр узла дерева }
 end;//TnsComplectInfoNode
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , ComplectUnit
 , l3String
 , nsTypes
 , IOUnit
 //#UC START# *4682778E0223impl_uses*
 //#UC END# *4682778E0223impl_uses*
;

function TnsComplectInfoNode.GetTextPart(aIndex: Integer): Tl3PCharLenPrim;
 {* Возвращает кусок текста по индексу. }
//#UC START# *46A6199402FB_4682778E0223_var*
//#UC END# *46A6199402FB_4682778E0223_var*
begin
//#UC START# *46A6199402FB_4682778E0223_impl*
 case aIndex of
  // Название
  0 : Result := Get_Text;
  // Значение
  1 : Result := nsWStr(fValue);
  else
  begin
   l3AssignNil(Result);
   Assert(false);
  end;//else
 end;//case aIndex
//#UC END# *46A6199402FB_4682778E0223_impl*
end;//TnsComplectInfoNode.GetTextPart

procedure TnsComplectInfoNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4682778E0223_var*
//#UC END# *479731C50290_4682778E0223_var*
begin
//#UC START# *479731C50290_4682778E0223_impl*
 fValue := nil;
 inherited;
//#UC END# *479731C50290_4682778E0223_impl*
end;//TnsComplectInfoNode.Cleanup

constructor TnsComplectInfoNode.Create(const aNode: INodeBase);
 {* Создаёт экземпляр узла дерева }
//#UC START# *490982310145_4682778E0223_var*
var
 l_CI  : IComplectInfoNode;
 l_Str : IString;
//#UC END# *490982310145_4682778E0223_var*
begin
//#UC START# *490982310145_4682778E0223_impl*
 inherited Create(aNode);
 if Supports(aNode, IComplectInfoNode, l_CI) then
 try
  l_CI.GetInfo(l_Str);
  try
   fValue := nsCStr(l_Str);
  finally
   l_CI := nil;
  end;//try..finally
 finally
  l_CI := nil;
 end;//try..finally
//#UC END# *490982310145_4682778E0223_impl*
end;//TnsComplectInfoNode.Create
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
