unit nsDictListChild;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsDictListChild.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsINodeOneLevelWrap
 , bsTypes
 , l3TreeInterfaces
 , DynamicTreeUnit
 , l3Interfaces
;

type
 TnsDictListChild = class(TnsINodeOneLevelWrap)
  private
   f_Language: TbsLanguage;
  protected
   function DoGetText: Tl3WString; override;
    {* Реализация функции получения текста узла }
  public
   constructor Create(const aNode: INodeBase;
    aLang: TbsLanguage); reintroduce;
   class function Make(const aNode: INodeBase;
    aLang: TbsLanguage): Il3SimpleNode; reintroduce;
 end;//TnsDictListChild
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , BaseTypesUnit
 , l3Chars
;

constructor TnsDictListChild.Create(const aNode: INodeBase;
 aLang: TbsLanguage);
//#UC START# *490825F40070_46836BEC0307_var*
//#UC END# *490825F40070_46836BEC0307_var*
begin
//#UC START# *490825F40070_46836BEC0307_impl*
 inherited Create(aNode);
 f_Language := aLang;
//#UC END# *490825F40070_46836BEC0307_impl*
end;//TnsDictListChild.Create

class function TnsDictListChild.Make(const aNode: INodeBase;
 aLang: TbsLanguage): Il3SimpleNode;
var
 l_Inst : TnsDictListChild;
begin
 l_Inst := Create(aNode, aLang);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsDictListChild.Make

function TnsDictListChild.DoGetText: Tl3WString;
 {* Реализация функции получения текста узла }
//#UC START# *490825370178_46836BEC0307_var*
//#UC END# *490825370178_46836BEC0307_var*
begin
//#UC START# *490825370178_46836BEC0307_impl*
 Result := inherited DoGetText;
 if (f_Language = LG_RUSSIAN) then
  Result.SCodePage := CP_RussianWin
 else
  Result.SCodePage := CP_WesternWin;
//#UC END# *490825370178_46836BEC0307_impl*
end;//TnsDictListChild.DoGetText
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
