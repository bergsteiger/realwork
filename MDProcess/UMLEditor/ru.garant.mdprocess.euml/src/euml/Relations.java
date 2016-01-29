/**
 * <copyright>
 * </copyright>
 *
 * $Id: Relations.java,v 1.1 2009/02/25 06:20:00 pugin Exp $
 */
package euml;

import org.eclipse.emf.ecore.EObject;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Relations</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link euml.Relations#getTarget <em>Target</em>}</li>
 * </ul>
 * </p>
 *
 * @see euml.EumlPackage#getRelations()
 * @model abstract="true"
 * @generated
 */
public interface Relations extends EObject {
	/**
	 * Returns the value of the '<em><b>Target</b></em>' reference.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Target</em>' reference isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Target</em>' reference.
	 * @see #setTarget(NamedElement)
	 * @see euml.EumlPackage#getRelations_Target()
	 * @model
	 * @generated
	 */
	NamedElement getTarget();

	/**
	 * Sets the value of the '{@link euml.Relations#getTarget <em>Target</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Target</em>' reference.
	 * @see #getTarget()
	 * @generated
	 */
	void setTarget(NamedElement value);

} // Relations
