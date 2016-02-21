unit l3VCLStringsItems;

// Модуль: "w:\common\components\rtl\Garant\L3\l3VCLStringsItems.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3CastableStrings
 , l3PureMixIns
;

type
 _l3Unknown_Parent_ = Tl3CastableStrings;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 Tl3VCLStringsItems = class(_l3Unknown_)
  protected
   function Get(Index: Integer): String; override;
   procedure Put(Index: Integer;
    const S: String); override;
   function GetCount: Integer; override;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   function GetObject(Index: Integer): TObject; override;
   procedure PutObject(Index: Integer;
    AObject: TObject); override;
  public
   procedure Clear; override;
   procedure Insert(Index: Integer;
    const S: String); override;
 end;//Tl3VCLStringsItems

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

procedure Tl3VCLStringsItems.Clear;
//#UC START# *47E21AB50104_47E21D500381_var*
//#UC END# *47E21AB50104_47E21D500381_var*
begin
//#UC START# *47E21AB50104_47E21D500381_impl*
 Assert(false);
//#UC END# *47E21AB50104_47E21D500381_impl*
end;//Tl3VCLStringsItems.Clear

procedure Tl3VCLStringsItems.Insert(Index: Integer;
 const S: String);
//#UC START# *47E21AD40366_47E21D500381_var*
//#UC END# *47E21AD40366_47E21D500381_var*
begin
//#UC START# *47E21AD40366_47E21D500381_impl*
 Assert(false);
//#UC END# *47E21AD40366_47E21D500381_impl*
end;//Tl3VCLStringsItems.Insert

function Tl3VCLStringsItems.Get(Index: Integer): String;
//#UC START# *47E21AF20186_47E21D500381_var*
//#UC END# *47E21AF20186_47E21D500381_var*
begin
//#UC START# *47E21AF20186_47E21D500381_impl*
 Result := '';
 Assert(false);
//#UC END# *47E21AF20186_47E21D500381_impl*
end;//Tl3VCLStringsItems.Get

procedure Tl3VCLStringsItems.Put(Index: Integer;
 const S: String);
//#UC START# *47E21B0A0167_47E21D500381_var*
//#UC END# *47E21B0A0167_47E21D500381_var*
begin
//#UC START# *47E21B0A0167_47E21D500381_impl*
 Assert(false);
//#UC END# *47E21B0A0167_47E21D500381_impl*
end;//Tl3VCLStringsItems.Put

function Tl3VCLStringsItems.GetCount: Integer;
//#UC START# *47E21B2403D5_47E21D500381_var*
//#UC END# *47E21B2403D5_47E21D500381_var*
begin
//#UC START# *47E21B2403D5_47E21D500381_impl*
 Result := 0;
 Assert(false);
//#UC END# *47E21B2403D5_47E21D500381_impl*
end;//Tl3VCLStringsItems.GetCount

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3VCLStringsItems.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_47E21D500381_var*
//#UC END# *47A6FEE600FC_47E21D500381_var*
begin
//#UC START# *47A6FEE600FC_47E21D500381_impl*
 Result := true;
//#UC END# *47A6FEE600FC_47E21D500381_impl*
end;//Tl3VCLStringsItems.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

function Tl3VCLStringsItems.GetObject(Index: Integer): TObject;
//#UC START# *47E21BAA029A_47E21D500381_var*
//#UC END# *47E21BAA029A_47E21D500381_var*
begin
//#UC START# *47E21BAA029A_47E21D500381_impl*
 Result := nil;
 Assert(false);
//#UC END# *47E21BAA029A_47E21D500381_impl*
end;//Tl3VCLStringsItems.GetObject

procedure Tl3VCLStringsItems.PutObject(Index: Integer;
 AObject: TObject);
//#UC START# *47E21BC40258_47E21D500381_var*
//#UC END# *47E21BC40258_47E21D500381_var*
begin
//#UC START# *47E21BC40258_47E21D500381_impl*
 Assert(false);
//#UC END# *47E21BC40258_47E21D500381_impl*
end;//Tl3VCLStringsItems.PutObject

end.
