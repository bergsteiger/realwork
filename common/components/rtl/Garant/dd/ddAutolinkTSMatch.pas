unit ddAutolinkTSMatch;

// Модуль: "w:\common\components\rtl\Garant\dd\ddAutolinkTSMatch.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddAutolinkTSMatch" MUID: (57E5172A02A0)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ddAutolinkInterfaces
;

type
 TddAutolinkTSMatch = class(Tl3ProtoObject, IddAutolinkTSMatch)
  private
   f_DocType: Integer;
   f_Source: Integer;
  protected
   function Get_DocType: Integer;
   function Get_Source: Integer;
   function IsMatch(aType: Integer;
    aSource: Integer): Boolean;
  public
   constructor Create(aDocType: Integer;
    aSource: Integer); reintroduce;
   class function Make(aDocType: Integer;
    aSource: Integer): IddAutolinkTSMatch; reintroduce;
 end;//TddAutolinkTSMatch

implementation

uses
 l3ImplUses
 //#UC START# *57E5172A02A0impl_uses*
 //#UC END# *57E5172A02A0impl_uses*
;

constructor TddAutolinkTSMatch.Create(aDocType: Integer;
 aSource: Integer);
//#UC START# *57E51847022C_57E5172A02A0_var*
//#UC END# *57E51847022C_57E5172A02A0_var*
begin
//#UC START# *57E51847022C_57E5172A02A0_impl*
 inherited Create;
 f_DocType := aDocType;
 f_Source  := aSource;
//#UC END# *57E51847022C_57E5172A02A0_impl*
end;//TddAutolinkTSMatch.Create

class function TddAutolinkTSMatch.Make(aDocType: Integer;
 aSource: Integer): IddAutolinkTSMatch;
var
 l_Inst : TddAutolinkTSMatch;
begin
 l_Inst := Create(aDocType, aSource);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TddAutolinkTSMatch.Make

function TddAutolinkTSMatch.Get_DocType: Integer;
//#UC START# *57E512F402FB_57E5172A02A0get_var*
//#UC END# *57E512F402FB_57E5172A02A0get_var*
begin
//#UC START# *57E512F402FB_57E5172A02A0get_impl*
 Result := f_DocType;
//#UC END# *57E512F402FB_57E5172A02A0get_impl*
end;//TddAutolinkTSMatch.Get_DocType

function TddAutolinkTSMatch.Get_Source: Integer;
//#UC START# *57E513170228_57E5172A02A0get_var*
//#UC END# *57E513170228_57E5172A02A0get_var*
begin
//#UC START# *57E513170228_57E5172A02A0get_impl*
 Result := f_Source;
//#UC END# *57E513170228_57E5172A02A0get_impl*
end;//TddAutolinkTSMatch.Get_Source

function TddAutolinkTSMatch.IsMatch(aType: Integer;
 aSource: Integer): Boolean;
//#UC START# *57E513F20358_57E5172A02A0_var*
//#UC END# *57E513F20358_57E5172A02A0_var*
begin
//#UC START# *57E513F20358_57E5172A02A0_impl*
 Result := (f_DocType < 0) or (aType = f_DocType);
 if Result then
  Result := (f_Source < 0) or (aSource = f_Source); 
//#UC END# *57E513F20358_57E5172A02A0_impl*
end;//TddAutolinkTSMatch.IsMatch

end.
