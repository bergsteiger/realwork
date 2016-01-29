unit DataAdapterRes;

interface
uses
 l3StringIDEx;

const
  // Локализуемая строка для сообщения о выходе области печати за границы бумажного листа
  // http://mdp.garant.ru/pages/viewpage.action?pageId=508825964
  str_warInvalidMargins : Tl3StringIDEx = (rS : -1; rLocalized : false;
   rKey : 'warInvalidMargins'; rValue : 'Область печати выходит за границы бумажного листа. '+
   'Отредактируйте настройки размера бумаги и колонтитулов и повторите попытку печати.');

implementation

initialization
 str_warInvalidMargins.Init;

end.
