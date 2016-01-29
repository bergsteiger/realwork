unit nsDictListChild;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Diction"
// Автор: Тучнин Д.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Diction/nsDictListChild.pas"
// Начат: 2004/02/20 08:36:17
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Diction::Diction::Diction$Unit::TnsDictListChild
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
  DynamicTreeUnit,
  l3TreeInterfaces,
  nsINodeOneLevelWrap,
  bsTypes,
  l3Interfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsDictListChild = class(TnsINodeOneLevelWrap)
 private
 // private fields
   f_Language : TbsLanguage;
 protected
 // overridden protected methods
   function DoGetText: Tl3WString; override;
     {* Реализация функции получения текста узла }
 public
 // public methods
   constructor Create(const aNode: INodeBase;
    aLang: TbsLanguage); reintroduce;
   class function Make(const aNode: INodeBase;
    aLang: TbsLanguage): Il3SimpleNode; reintroduce;
 end;//TnsDictListChild
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  BaseTypesUnit,
  l3Chars
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsDictListChild

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
end;

function TnsDictListChild.DoGetText: Tl3WString;
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

{$IfEnd} //not Admin AND not Monitorings

end.