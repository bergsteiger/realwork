unit nsMainMenu2011Node;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsMainMenu2011Node.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsNewCachableNode
 , MainMenuUnit
 , l3Interfaces
 , l3Tree_TLB
 , l3IID
;

type
 TnsMainMenu2011Node = class(TnsNewCachableNode)
  private
   f_SectionItem: ISectionItem;
   f_Caption: Il3CString;
  protected
   function GetAsPCharLen: Tl3WString; override;
   procedure ClearFields; override;
  public
   constructor Create(const aSectionItem: ISectionItem); reintroduce;
   class function Make(const aSectionItem: ISectionItem): Il3Node; reintroduce;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
 end;//TnsMainMenu2011Node
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Base
 , SysUtils
 , l3String
 , nsTypes
 , IOUnit
 {$If NOT Defined(NoScripts)}
 , InterfacedNodeWords
 {$IfEnd} // NOT Defined(NoScripts)
;

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
end;//TnsMainMenu2011Node.Make

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
 {* Реализация запроса интерфейса }
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
begin
 f_SectionItem := nil;
 f_Caption := nil;
 inherited;
end;//TnsMainMenu2011Node.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
