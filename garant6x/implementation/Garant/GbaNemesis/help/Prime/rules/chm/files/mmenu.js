
var activeButton = null;

function buttonClick(menuId) {

 var button = event.srcElement;

 button.blur();

 if (!button.menu) {
   button.menu = document.getElementById(menuId);
   if (button.menu.isInitialized == null)
     menuInit(button.menu);
 }

 if (!button.onmouseout)
   button.onmouseout = buttonOrMenuMouseout;

 if (button==activeButton)
   return false;

 if (activeButton)
   resetButton(activeButton);

 if (button!=activeButton) {
   depressButton(button);
   activeButton = button;
 }
 else
   activeButton = null;

 return false;
}

function buttonMouseover(menuId) {

 if (activeButton == null) {
   buttonClick(menuId);
   return;
 }

 if (activeButton && activeButton != event.srcElement)
   buttonClick(menuId);
}

function depressButton(button) {

 var x, y;

 button.className += " mButtonActive";

 if (!button.onmouseout)
   button.onmouseout = buttonOrMenuMouseout;
 if (!button.menu.onmouseout)
   button.menu.onmouseout = buttonOrMenuMouseout;

 x = getPageOffsetLeft(button) + button.offsetParent.clientLeft;
 y = getPageOffsetTop(button) + button.offsetHeight + button.offsetParent.clientTop;

 button.menu.style.left = x + "px";
 button.menu.style.top  = y + "px";
 button.menu.style.visibility = "visible";
}

function resetButton(button) {

 removeClassName(button, "mButtonActive");

 if (button.menu) {
   closeSubMenu(button.menu);
   button.menu.style.visibility = "hidden";
 }
}

//----------------------------------------------------------------------------

function menuMouseover() {

 var menu = getContainerWith(window.event.srcElement, "DIV", "menu");

 if (menu.activeItem != null)
   closeSubMenu(menu);
}

function menuItemMouseover(menuId) {

 var x, y;

 var item = getContainerWith(window.event.srcElement, "A", "mItem");
 var menu = getContainerWith(item, "DIV", "menu");

 if (menu.activeItem) closeSubMenu(menu);

 menu.activeItem = item;

 item.className += " mItemHighlight";

 if (!item.subMenu) {
   item.subMenu = document.getElementById(menuId);
   if (!item.subMenu.isInitialized) menuInit(item.subMenu);
 }

 if (!item.subMenu.onmouseout)
   item.subMenu.onmouseout = buttonOrMenuMouseout;

 x = getPageOffsetLeft(item) + item.offsetWidth;
 y = getPageOffsetTop(item);

 item.subMenu.style.left = x + "px";
 item.subMenu.style.top  = y + "px";
 item.subMenu.style.visibility = "visible";

 event.cancelBubble = true;
}

function closeSubMenu(menu) {

 if (!menu || !menu.activeItem)
   return;

 if (menu.activeItem.subMenu != null) {
   closeSubMenu(menu.activeItem.subMenu);
   menu.activeItem.subMenu.style.visibility = "hidden";
   menu.activeItem.subMenu = null;
 }
 removeClassName(menu.activeItem, "mItemHighlight");
 menu.activeItem = null;
}

function buttonOrMenuMouseout() {
  if (!activeButton) return;

  var el = event.toElement;

  if (!getContainerWith(el, "DIV", "menu")) {
    resetButton(activeButton);
    activeButton = null;
  }
}

//----------------------------------------------------------------------------

function menuInit(menu) {

 var itemList, spanList;
 var textEl, arrowEl;
 var itemWidth;
 var w, dw;
 var i, j;

 menu.style.lineHeight = "2.5ex";
 spanList = menu.getElementsByTagName("SPAN");
 for (i = 0; i < spanList.length; i++)
   if (hasClassName(spanList[i], "mItemArrow")) {
     spanList[i].style.fontFamily = "Webdings";
     spanList[i].firstChild.nodeValue = "4";
   }

 itemList = menu.getElementsByTagName("A");
 if (itemList.length > 0)
   itemWidth = itemList[0].offsetWidth;
 else
   return;

 // For items with arrows, add padding to item text to make the
 // arrows flush right.

 for (i = 0; i < itemList.length; i++) {
   spanList = itemList[i].getElementsByTagName("SPAN");
   textEl  = null;
   arrowEl = null;
   for (j = 0; j < spanList.length; j++) {
     if (hasClassName(spanList[j], "mItemText"))
       textEl = spanList[j];
     if (hasClassName(spanList[j], "mItemArrow"))
       arrowEl = spanList[j];
   }
   if (textEl && arrowEl) {
     textEl.style.paddingRight = (itemWidth 
       - (textEl.offsetWidth + arrowEl.offsetWidth)) + "px";
   }
 }

 w = itemList[0].offsetWidth;
 itemList[0].style.width = w + "px";
 dw = itemList[0].offsetWidth - w;
 w -= dw;
 itemList[0].style.width = w + "px";

 menu.isInitialized = true;
}

//----------------------------------------------------------------------------

function getContainerWith(node, tagName, className) {
 while (node != null) {
   if (node.tagName != null && node.tagName == tagName &&
       hasClassName(node, className))
     return node;
   node = node.parentNode;
 }
 return node;
}

function hasClassName(el, name) {
  var i, list;

  list = el.className.split(" ");
  for (i = 0; i < list.length; i++)
    if (list[i] == name)
      return true;

  return false;
}

function removeClassName(el, name) {
  var i, curList, newList;

  if (el.className == null)
    return;

  newList = new Array();
  curList = el.className.split(" ");
  for (i = 0; i < curList.length; i++)
    if (curList[i] != name)
      newList[newList.length] = curList[i];
  el.className = newList.join(" ");
}

function getPageOffsetLeft(el) {
  var x = el.offsetLeft;
  if (el.offsetParent != null)
    x += getPageOffsetLeft(el.offsetParent);
  return x;
}

function getPageOffsetTop(el) {
  var y = el.offsetTop;
  if (el.offsetParent != null)
    y += getPageOffsetTop(el.offsetParent);
  return y;
}
