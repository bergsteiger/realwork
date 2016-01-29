package euml.diagram.edit.policies;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import org.eclipse.gmf.runtime.diagram.ui.editpolicies.CanonicalEditPolicy;
import org.eclipse.gmf.runtime.notation.View;

import euml.EumlPackage;
import euml.diagram.edit.parts.AttributeEditPart;
import euml.diagram.part.UmlDiagramUpdater;
import euml.diagram.part.UmlNodeDescriptor;
import euml.diagram.part.UmlVisualIDRegistry;

/**
 * @generated
 */
public class ClassAttributesCanonicalEditPolicy extends CanonicalEditPolicy {

	/**
	 * @generated
	 */
	Set myFeaturesToSynchronize;

	/**
	 * @generated
	 */
	protected List getSemanticChildrenList() {
		View viewObject = (View) getHost().getModel();
		List result = new LinkedList();
		for (Iterator it = UmlDiagramUpdater
				.getClassAttributes_7001SemanticChildren(viewObject).iterator(); it
				.hasNext();) {
			result.add(((UmlNodeDescriptor) it.next()).getModelElement());
		}
		return result;
	}

	/**
	 * @generated
	 */
	protected boolean isOrphaned(Collection semanticChildren, final View view) {
		int visualID = UmlVisualIDRegistry.getVisualID(view);
		switch (visualID) {
		case AttributeEditPart.VISUAL_ID:
			if (!semanticChildren.contains(view.getElement())) {
				return true;
			}
		}
		return false;
	}

	/**
	 * @generated
	 */
	protected String getDefaultFactoryHint() {
		return null;
	}

	/**
	 * @generated
	 */
	protected Set getFeaturesToSynchronize() {
		if (myFeaturesToSynchronize == null) {
			myFeaturesToSynchronize = new HashSet();
			myFeaturesToSynchronize.add(EumlPackage.eINSTANCE
					.getClass_Attributes());
		}
		return myFeaturesToSynchronize;
	}

}
