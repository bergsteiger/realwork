unit evMultiSelectionLocation;

interface

uses
 l3IntfUses
 , k2TagTool
 , nevTools
;

type
 TevMultiSelectionLocation = class(Tk2TagTool, InevLocation)
  function GetRange: InevRange;
  function GetFormatting: InevDataFormatting;
  function GetText: InevText;
  function Range: InevRange;
  function Formatting: InevDataFormatting;
  function Obj: PInevObject;
  function Text: InevText;
  function AsPoint: InevBasePoint;
 end;//TevMultiSelectionLocation
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
