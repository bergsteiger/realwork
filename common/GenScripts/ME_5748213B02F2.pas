unit SectionImpl;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\SectionImpl.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "SectionImpl" MUID: (5748213B02F2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , MainMenuUnit
;

type
 SectionImpl = class
  private
   server_section: ;
  private
   procedure DestroyServerServants; virtual; stdcall;
  protected
   function GetCaption: IString; stdcall;
  public
   constructor Make(const server_section); reintroduce; overload; stdcall;
   function GetItems: ISectionItemList; virtual; stdcall;
   procedure ClearCache; virtual; stdcall;
   constructor Make(type: TSectionType); reintroduce; overload; stdcall;
   function GetSectionId: PAnsiChar; virtual; stdcall;
  public
   property Caption: IString
    read GetCaption;
 end;//SectionImpl

implementation

uses
 l3ImplUses
 , ApplicationHelper
;

function SectionImpl.GetCaption: IString;
//#UC START# *574D3DB3034F_5748213B02F2get_var*
//#UC END# *574D3DB3034F_5748213B02F2get_var*
begin
//#UC START# *574D3DB3034F_5748213B02F2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *574D3DB3034F_5748213B02F2get_impl*
end;//SectionImpl.GetCaption

constructor SectionImpl.Make(const server_section);
//#UC START# *5748214B008D_5748213B02F2_var*
//#UC END# *5748214B008D_5748213B02F2_var*
begin
//#UC START# *5748214B008D_5748213B02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *5748214B008D_5748213B02F2_impl*
end;//SectionImpl.Make

function SectionImpl.GetItems: ISectionItemList;
//#UC START# *574821A70373_5748213B02F2_var*
//#UC END# *574821A70373_5748213B02F2_var*
begin
//#UC START# *574821A70373_5748213B02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *574821A70373_5748213B02F2_impl*
end;//SectionImpl.GetItems

procedure SectionImpl.ClearCache;
//#UC START# *57482234032A_5748213B02F2_var*
//#UC END# *57482234032A_5748213B02F2_var*
begin
//#UC START# *57482234032A_5748213B02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *57482234032A_5748213B02F2_impl*
end;//SectionImpl.ClearCache

constructor SectionImpl.Make(type: TSectionType);
//#UC START# *5748258C020E_5748213B02F2_var*
//#UC END# *5748258C020E_5748213B02F2_var*
begin
//#UC START# *5748258C020E_5748213B02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *5748258C020E_5748213B02F2_impl*
end;//SectionImpl.Make

function SectionImpl.GetSectionId: PAnsiChar;
//#UC START# *574828C20279_5748213B02F2_var*
//#UC END# *574828C20279_5748213B02F2_var*
begin
//#UC START# *574828C20279_5748213B02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *574828C20279_5748213B02F2_impl*
end;//SectionImpl.GetSectionId

procedure SectionImpl.DestroyServerServants;
//#UC START# *574DA22000A6_5748213B02F2_var*
//#UC END# *574DA22000A6_5748213B02F2_var*
begin
//#UC START# *574DA22000A6_5748213B02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *574DA22000A6_5748213B02F2_impl*
end;//SectionImpl.DestroyServerServants

end.
