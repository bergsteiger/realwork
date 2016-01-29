unit l3HugeMessageDlgWithWikiHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 Tl3WikiLinkClicked = procedure(const aLinkData: AnsiString) of object;
 
 (*
 Ml3HugeMessageDlgWithWikiHelper = interface
  {* Контракт сервиса Tl3HugeMessageDlgWithWikiHelper }
  procedure Say(const aText: AnsiString;
   aClickCallback: Tl3WikiLinkClicked);
  function FormatLink(const aLinkText: AnsiString;
   const aLinkData: AnsiString): AnsiString;
  function FormatCloak(const aCaption: AnsiString;
   const aText: AnsiString): AnsiString;
  function CanUseWiki: Boolean;
 end;//Ml3HugeMessageDlgWithWikiHelper
 *)
 
 Il3HugeMessageDlgWithWikiHelper = interface
  {* Интерфейс сервиса Tl3HugeMessageDlgWithWikiHelper }
  procedure Say(const aText: AnsiString;
   aClickCallback: Tl3WikiLinkClicked);
  function FormatLink(const aLinkText: AnsiString;
   const aLinkData: AnsiString): AnsiString;
  function FormatCloak(const aCaption: AnsiString;
   const aText: AnsiString): AnsiString;
  function CanUseWiki: Boolean;
 end;//Il3HugeMessageDlgWithWikiHelper
 
 Tl3HugeMessageDlgWithWikiHelper = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure Say(const aText: AnsiString;
   aClickCallback: Tl3WikiLinkClicked);
  function FormatCloak(const aCaption: AnsiString;
   const aText: AnsiString): AnsiString;
  function FormatLink(const aLinkText: AnsiString;
   const aLinkData: AnsiString): AnsiString;
  function CanUseWiki: Boolean;
 end;//Tl3HugeMessageDlgWithWikiHelper
 
implementation

uses
 l3ImplUses
 , Forms
 , Controls
 , SysUtils
 , StdCtrls
 , ExtCtrls
;

end.
