# -*- coding: windows-1251 -*-

class XmlHelper:
    
    @staticmethod
    def get_element_value(element):
        return ''.join(node.nodeValue for node in element.childNodes if node.nodeType == node.TEXT_NODE).strip()