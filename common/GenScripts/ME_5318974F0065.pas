unit k2FontManager;

interface

uses
 l3IntfUses
 , k2FontNameList
 , k2FontName
;

type
 Tk2FontManager = class(Tk2FontNameList)
  function FontByName(const aName: AnsiString): Tk2FontName;
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//Tk2FontManager
 
implementation

uses
 l3ImplUses
 , l3LogFont
 , l3FontManagerEx
 , SysUtils
;

end.
