package euml.diagram.navigator;

import org.eclipse.jface.viewers.ViewerSorter;

import euml.diagram.part.UmlVisualIDRegistry;

/**
 * @generated
 */
public class UmlNavigatorSorter extends ViewerSorter {

	/**
	 * @generated
	 */
	private static final int GROUP_CATEGORY = 7006;

	/**
	 * @generated
	 */
	public int category(Object element) {
		if (element instanceof UmlNavigatorItem) {
			UmlNavigatorItem item = (UmlNavigatorItem) element;
			return UmlVisualIDRegistry.getVisualID(item.getView());
		}
		return GROUP_CATEGORY;
	}

}
